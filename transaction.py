import oracledb
import getpass
from datetime import datetime

# Function to create a new account for a business
def create_business_account(connection, business_name, initial_balance):
    cursor = connection.cursor()
    
    # Inserting into BUSINESS and ACCOUNT tables
    cursor.execute("INSERT INTO BUSINESS (BUSINESSNAME) VALUES (:1)", (business_name,))
    cursor.execute("INSERT INTO ACCOUNT (BALANCE, LastAccessDate, AccType) VALUES (:1, :2, :3)",
                   (initial_balance, datetime.now(), 'Business'))

    # Commit the changes
    connection.commit()
    print(f"New account for {business_name} created successfully.")

# Function to create a new account for an individual with an initial deposit
def create_individual_account(connection, customer_name, initial_deposit):
    cursor = connection.cursor()

    # Inserting into CUSTOMER and ACCOUNT tables
    cursor.execute("INSERT INTO CUSTOMER (NAME) VALUES (:1)", (customer_name,))
    cursor.execute("INSERT INTO ACCOUNT (BALANCE, LastAccessDate, AccType, CID) VALUES (:1, :2, :3, (SELECT CID FROM CUSTOMER WHERE NAME = :4))",
                   (initial_deposit, datetime.now(), 'Individual', customer_name))

    # Commit the changes
    connection.commit()
    print(f"New account for {customer_name} created successfully.")

# Function to issue a loan from a branch to a specific customer from a specific city
def issue_loan(connection, loan_amount, branch_name, customer_name, city):
    cursor = connection.cursor()

    # Inserting into LOAN table
    cursor.execute("INSERT INTO LOAN (LOANAMOUNT, PAYMENTDATE, PAYMENTAMOUNT, LOANOFFICER) VALUES (:1, :2, :3, (SELECT SSN FROM EMPLOYEE WHERE BRANCHNAME = :4))",
                   (loan_amount, datetime.now(), 0, branch_name))

    # Inserting into HOLDSLOAN table
    cursor.execute("INSERT INTO HOLDSLOAN (CUSTOMERID, LOANNUMBER) VALUES ((SELECT CID FROM CUSTOMER WHERE NAME = :1), (SELECT LOANNUMBER FROM LOAN WHERE LOANAMOUNT = :2))",
                   (customer_name, loan_amount))

    # Commit the changes
    connection.commit()
    print(f"Loan of ${loan_amount} issued successfully to {customer_name} from {city} branch.")


oracledb.init_oracle_client(config_dir='/opt/oracle/client_19c/network/admin')

pw = getpass.getpass("Enter password: ")

connection = oracledb.connect(
    user="mxa7402",
    password=pw,
    dsn="PCSE1P")

print("Successfully connected to Oracle Database")

cursor = connection.cursor()




connection = oracledb.connect("your_username/your_password@your_host:your_port/your_service")


while True:
    print("\nOptions:")
    print("1. Create a new account for a business")
    print("2. Create a new account for an individual with an initial deposit")
    print("3. Issue a loan from a branch to a specific customer from a specific city")
    print("0. Exit")

    option = input("Enter your choice (0-3): ")
    if option == '1':
        create_business_account(connection, 'ABC Corp', 50000)
    elif option == '2':
        create_individual_account(connection, 'John Doe', 1000)
    elif option == '3':
        issue_loan(connection, 20000, 'Main Branch', 'Jane Smith', 'City1')
    
    elif option == '0':
        break
    else:
        print("Invalid option. Please enter a valid option.")




connection.close()
