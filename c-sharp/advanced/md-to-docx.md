# Markdown 转 Word (.docx) 笔记

## 目标

将包含图片的 Markdown 文件转换为 Word 文档，用于课程作业提交。

---

## 方法一：Pandoc（失败）

### 尝试 1 — 直接运行 Pandoc

系统没有安装 Pandoc，改用 Docker：

```bash
docker run --rm \
  -v /path/to/project:/data \
  pandoc/core \
  Assignment4_Report.md \
  -o Assignment4_Report.docx \
  --resource-path=/data
```

**结果：** 转换成功，文件生成。但截图在 Word 中显示非常模糊。

### 尝试 2 — 加 `--dpi=300` 参数

```bash
docker run --rm \
  -v /path/to/project:/data \
  pandoc/core \
  Assignment4_Report.md \
  -o Assignment4_Report.docx \
  --resource-path=/data \
  --dpi=300
```

**结果：** 文件大小和内容完全一样，`--dpi` 参数对该版本的 Pandoc 无效。

### 尝试 3 — 修改图片 DPI 元数据

用 macOS `sips` 工具将截图的 DPI 元数据从默认改为 144：

```bash
for f in screenshots/*.png; do
  sips -s dpiWidth 144 -s dpiHeight 144 "$f" --out "$f"
done
```

再重新用 Pandoc 转换，文件从 391K 增大到 431K，说明嵌入尺寸有变化。

**结果：** 仍然模糊。

### 根本原因分析

通过解包 docx（docx 本质是 zip）检查内部结构：

```bash
unzip Assignment4_Report.docx -d docx_inspect
sips -g pixelWidth -g pixelHeight docx_inspect/word/media/image1.png
# → pixelWidth: 1280，pixelHeight: 800（与原图一致）
```

**Pandoc 没有压缩图片像素**，问题出在图片的显示尺寸：

```bash
grep -o 'cx="[0-9]*" cy="[0-9]*"' docx_inspect/word/document.xml | head -3
# → cx="5334000" cy="3333749"
# → 5334000 EMU / 914400 = 5.83 英寸
```

Pandoc 将 1280×800 的图片设置为 5.83 英寸宽显示，Word 渲染时进行缩放插值，
导致视觉模糊。这是 **Pandoc 的已知限制**——无法精确控制 docx 中图片的显示尺寸。

---

## 方法二：python-docx（成功）

放弃 Pandoc，改用 `python-docx` 库直接生成 Word 文档，可以精确控制每张图片的显示宽度。

### 核心代码

```python
from docx import Document
from docx.shared import Inches

doc = Document()

# 设置页边距
for section in doc.sections:
    section.left_margin = Inches(1)
    section.right_margin = Inches(1)

# 插入图片，指定显示宽度为 6 英寸（填满可用页宽）
doc.add_picture("screenshots/02-movies-list.png", width=Inches(6))

doc.save("Assignment4_Report.docx")
```

### 用 Docker 运行（无需本地安装 Python）

```bash
docker run --rm \
  -v /path/to/project:/data \
  python:3.12-slim \
  bash -c "pip install python-docx -q && python /data/generate_report.py"
```

### 验证结果

解包检查生成的 docx：

```bash
unzip Assignment4_Report.docx -d docx_inspect
grep -o 'cx="[0-9]*"' word/document.xml | head -3
# → cx="5486400"
# → 5486400 / 914400 = 6.0 英寸 ✓
```

图片显示宽度精确为 6 英寸，像素仍为 1280×800，Word 几乎不需要缩放，截图清晰。

---

## 后续问题：特定图片在 Word 中显示 "Unable to load the picture"

python-docx 生成的文档中，第 7 张图片（`07-delete-confirm.png`）在 Word 里无法显示。

### 排查过程

**第一步：验证 docx 内部结构**

解包 docx，确认图片文件存在且像素完整：

```bash
unzip Assignment4_Report.docx -d docx_inspect
sips -g pixelWidth -g pixelHeight docx_inspect/word/media/image7.png
# → pixelWidth: 1280，pixelHeight: 800（与原图一致）
```

**第二步：验证 PNG 文件完整性（CRC 校验）**

```python
import struct, zlib

def check_png(path):
    with open(path, 'rb') as f:
        sig = f.read(8)
        if sig != b'\x89PNG\r\n\x1a\n':
            return 'Not a valid PNG'
        while True:
            data = f.read(8)
            if len(data) < 8: break
            length = struct.unpack('>I', data[:4])[0]
            chunk_type = data[4:8].decode('ascii', errors='replace')
            chunk_data = f.read(length)
            crc = struct.unpack('>I', f.read(4))[0]
            calc = zlib.crc32(data[4:8] + chunk_data) & 0xffffffff
            if crc != calc: return f'CRC error in {chunk_type}'
        return 'OK'
```

结果：所有 9 张图片 CRC 均通过，PNG 文件本身没有损坏。

**第三步：验证 Word 关系文件（.rels）**

```bash
grep -o 'Id="rId.*Target="media/image[0-9]*' word/_rels/document.xml.rels
```

结果：所有 9 张图片的 rId 映射正确，XML 引用无误。

### 根本原因

追溯到之前用 `sips` 修改 DPI 的步骤：

```bash
sips -s dpiWidth 144 -s dpiHeight 144 "07-delete-confirm.png"
```

`sips` 在 PNG 文件中写入了 `pHYs` 元数据块（物理像素密度，144 DPI ≈ 5669 pixels/meter）。
对于 `07-delete-confirm.png`，sips 与该文件原有的内部结构（色彩配置、ICC profile 等块的位置）
产生了冲突，导致写出的 PNG 技术上合法，但触发了 **Word PNG 解析器的边缘 bug**。

其他 8 张图片碰巧没有遇到这个问题（每张 PNG 内部结构略有不同）。

### 修复方案：用 Pillow 重新导出图片

在生成 docx 前，用 Pillow 将所有截图重新导出为干净的 PNG，剥离所有元数据：

```python
from PIL import Image
import tempfile, os

CLEAN_DIR = tempfile.mkdtemp()

for fname in sorted(os.listdir(SCREENSHOTS)):
    if fname.endswith('.png'):
        src = os.path.join(SCREENSHOTS, fname)
        dst = os.path.join(CLEAN_DIR, fname)
        Image.open(src).convert('RGB').save(dst, format='PNG')

SCREENSHOTS = CLEAN_DIR  # 使用干净的图片生成 docx
```

Pillow 只保留像素数据，从零写出最简 PNG（`IHDR` → `IDAT` → `IEND`），
不包含任何 `pHYs`、ICC profile、EXIF 等额外块，Word 可以无障碍解析。

### 教训

> 用 `sips` 修改图片元数据看似无害，但对某些 PNG 文件会写出 Word 无法解析的元数据结构。
> 嵌入 Word 的图片应先用 Pillow 重新导出，保证格式干净。

---

## 关键结论

| 方法 | 像素是否压缩 | 显示尺寸控制 | 结果 |
|------|------------|------------|------|
| Pandoc | 否 | 自动计算（约 5.83 英寸），无法精确控制 | 模糊 |
| python-docx | 否 | 精确指定（`Inches(6)`） | 清晰 |

**模糊的原因不是图片分辨率不足，而是 Pandoc 设置的显示尺寸偏小，导致 Word 缩放插值。**

---

## EMU 单位说明

Word 内部使用 EMU（English Metric Units）表示尺寸：

```
1 英寸 = 914400 EMU
6 英寸 = 5486400 EMU
```

`python-docx` 的 `Inches(6)` 会自动转换为正确的 EMU 值写入 docx。
