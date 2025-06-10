import oracledb
import os

# 配置 Oracle Instant Client 路径 (可选，如果你已经配置了环境变量则无需)
# 如果没有配置环境变量，你可以在代码中指定 Instant Client 的路径
# oracledb.init_oracle_client(lib_dir=r"C:\oracle\instantclient_21_9") # Windows
# oracledb.init_oracle_client(lib_dir="/opt/oracle/instantclient_21_9") # Linux/macOS

# 数据库连接信息
# 方式一：使用 Easy Connect 字符串 (推荐)
# 格式：'hostname:port/service_name' 或 'hostname:port/sid'
# 例如：'localhost:1521/ORCLPDB1' (如果是PDB) 或 'localhost:1521/XE' (如果是XE)
# 如果是 Oracle Cloud Autonomous Database，连接字符串会更复杂，通常在服务控制台中提供
dsn = "localhost:1521/XEPDB1" # 替换为你的数据库连接字符串

# 方式二：使用 TNS 别名 (需要配置 tnsnames.ora 文件)
# tnsnames_alias = "MYDB" # 替换为你的 TNS 别名
# dsn = tnsnames_alias

username = "your_username"  # 替换为你的数据库用户名
password = "your_password"  # 替换为你的数据库密码

connection = None
cursor = None

try:
    # 建立数据库连接
    connection = oracledb.connect(user=username, password=password, dsn=dsn)
    print("成功连接到 Oracle 数据库！")

    # 创建游标对象
    cursor = connection.cursor()

    # 执行 SQL 查询
    # 例如：查询 SCOTT 用户的 EMP 表
    cursor.execute("SELECT empno, ename, job, sal FROM emp")

    # 获取所有查询结果
    rows = cursor.fetchall()

    # 打印查询结果
    print("\nEMP 表数据：")
    for row in rows:
        print(f"EMPNO: {row[0]}, ENAME: {row[1]}, JOB: {row[2]}, SAL: {row[3]}")

    # 示例：执行 DML (数据操作语言) - 插入数据
    # 注意：DML 操作需要提交事务
    # cursor.execute("INSERT INTO employees (id, name) VALUES (:1, :2)", [101, "Alice"])
    # connection.commit()
    # print("\n数据插入成功！")

except oracledb.Error as e:
    error_obj, = e.args
    print(f"数据库连接或操作出错：{error_obj.code} - {error_obj.message}")
    if connection:
        connection.rollback() # 回滚事务
except Exception as e:
    print(f"发生未知错误：{e}")
finally:
    # 关闭游标和连接
    if cursor:
        cursor.close()
        print("游标已关闭。")
    if connection:
        connection.close()
        print("数据库连接已关闭。")