import getpass
import oracledb
import pandas as pd


oracledb.init_oracle_client(config_dir='/opt/oracle/client_19c/network/admin')

pw = getpass.getpass("Enter password: ")


connection = oracledb.connect(
    user="mxa7402",
    password=pw,
    dsn="PCSE1P")

print("Successfully connected to Oracle Database")

cursor = connection.cursor()



files = ["data/bank.csv", "data/Employee.csv", "data/Dependants.csv", "data/customer.csv", "data/hascustomer.csv", "data/individual.csv", "data/business.csv","data/account.csv", "data/customerhasaccount.csv", "data/loan.csv", "data/loanpayment.csv", "data/holdspaymentnumber.csv" , "data/holdsloan.csv"]

for file in files:

    df = pd.read_csv(file)
    df = df.applymap(lambda x: x.strip() if isinstance(x, str) else x)

    table_name = file.split('/')[1].split(".")[0].upper()
    print(table_name)

    df.columns = [_.strip() for _ in df.columns]
    # print(rows[0])
    df = df.dropna(how='all')
    
    # print(len(df.columns))
    print(df.columns)
    if table_name == "EMPLOYEE":
        df["SSN"] = df["SSN"].astype(int)

    if table_name == "LOAN":
        df["LOANOFFICER"] = pd.to_numeric(df["LOANOFFICER"])

    if table_name == "DEPENDANTS":
        df['ESSN'] = df['ESSN'].astype(int)

    rows = df.to_dict('split')['data']

    columns = "("+', '.join([_.strip() for _ in df.columns]) + ")"
    values_holder =  "(:"+ ", :".join([str(_) for _ in list(range(1, len(df.columns) + 1))]) + ")"

    query = f"""insert into {table_name}{columns} values{values_holder}"""
    
    cursor.executemany(query, rows)

    connection.commit()



connection.close()