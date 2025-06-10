import oracledb
import logging
import os
from tabulate import tabulate

# 配置详细日志
logging.basicConfig(level=logging.DEBUG, format='%(asctime)s - %(levelname)s - %(message)s')
oracledb.defaults.debug = True

# --- 配置 ---
db_user = "ADMIN"
db_password = "Nuttertools0@"  # 通过 SQL Developer Web 验证
db_dsn = "v6qvl411954iklbd_high"  # tnsnames.ora 别名
wallet_dir = "/Users/chenqi/Documents/GitHub/homework/relational-database-design/db-client/Wallet_V6QVL411954IKLBD"
wallet_password = "Nuttertools0@"

def print_query_results(cursor):
    """打印查询结果"""
    try:
        # 获取列名
        columns = [col[0] for col in cursor.description]
        # 获取所有行
        rows = cursor.fetchall()
        
        if not rows:
            print("查询结果为空")
            return
            
        # 使用tabulate打印表格
        print("\n查询结果:")
        print(tabulate(rows, headers=columns, tablefmt='grid'))
        print(f"共 {len(rows)} 行数据")
    except Exception as e:
        print(f"打印结果时出错: {e}")

def run(script_path):
    try:
        if not os.path.exists(script_path):
            raise FileNotFoundError(f"SQL文件不存在: {script_path}")
            
        if not script_path.lower().endswith('.sql'):
            raise ValueError("文件必须是SQL文件(.sql)")

        print(f"oracledb 版本: {oracledb.__version__}")
        logging.info(f"连接 DSN: {db_dsn}, 钱包: {wallet_dir}")
        
        with oracledb.connect(
            user=db_user,
            password=db_password,
            dsn=db_dsn,
            config_dir=wallet_dir,
            wallet_location=wallet_dir,
            wallet_password=wallet_password
        ) as connection:
            print("成功连接到 Oracle Autonomous Database!")
            
            # 读取SQL文件内容
            with open(script_path, 'r', encoding='utf-8') as sql_file:
                sql_script = sql_file.read()
            
            # 分割SQL语句（按分号分割）
            sql_commands = [cmd.strip() for cmd in sql_script.split(';') if cmd.strip()]
            
            with connection.cursor() as cursor:
                error_count = 0
                for i, command in enumerate(sql_commands, 1):
                    try:
                        print(f"\n执行第 {i} 条SQL命令:")
                        print("-" * 50)
                        print(command)
                        print("-" * 50)
                        
                        # 执行命令
                        cursor.execute(command)
                        
                        # 检查是否是SELECT查询
                        if command.strip().upper().startswith('SELECT'):
                            print_query_results(cursor)
                        else:
                            # 对于非SELECT语句，显示影响的行数
                            if cursor.rowcount > 0:
                                print(f"✓ 命令执行成功，影响 {cursor.rowcount} 行")
                            else:
                                print(f"✓ 命令执行成功")
                        
                    except oracledb.Error as e:
                        error_count += 1
                        print(f"✗ 执行SQL命令时出错:")
                        print(f"错误信息: {e}")
                        print("继续执行下一条命令...")
                        continue
                
                # 提交事务
                connection.commit()
                print(f"\n所有SQL命令执行完成")
                if error_count > 0:
                    print(f"注意: 有 {error_count} 条命令执行失败")

    except oracledb.Error as e:
        print(f"数据库连接错误: {e}")
        if e.args:
            error_obj = e.args[0]
            print(f"错误代码: {error_obj.code}, 错误信息: {error_obj.message}")

    except Exception as e:
        print(f"意外错误: {e}")