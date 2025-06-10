import oracledb
import logging

# 配置详细日志
logging.basicConfig(level=logging.DEBUG, format='%(asctime)s - %(levelname)s - %(message)s')
oracledb.defaults.debug = True

# --- 配置 ---
db_user = "ADMIN"
db_password = "Nuttertools0@"  # 通过 SQL Developer Web 验证
db_dsn = "v6qvl411954iklbd_high"  # tnsnames.ora 别名
wallet_dir = "/Users/chenqi/Documents/GitHub/homework/relational-database-design/db-client/Wallet_V6QVL411954IKLBD"
wallet_password = "Nuttertools0@"

try:
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
        print("成功连接到 Oracle Autonomous Database！")
        with connection.cursor() as cursor:
            cursor.execute("SELECT SYSDATE FROM DUAL")
            row = cursor.fetchone()
            print(f"当前数据库时间: {row[0]}")

except oracledb.Error as e:
    print(f"数据库连接错误: {e}")
    if e.args:
        error_obj = e.args[0]
        print(f"错误代码: {error_obj.code}, 错误信息: {error_obj.message}")

except Exception as e:
    print(f"意外错误: {e}")