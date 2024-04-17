CREATE TABLE NOTIFICATION_LOG (
  NOTIFICATION_ID NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  ACCOUNT_NUMBER  NUMBER,
  MESSAGE         VARCHAR2(100),
  NOTIFICATION_DATE DATE
);

CREATE TABLE Bank(
    Name VARCHAR2(100) PRIMARY KEY,
    City VARCHAR2(100),
    Assets NUMBER
);

CREATE TABLE EMPLOYEE(
    SSN NUMBER PRIMARY KEY,
    STARTDATE DATE,
    TELEPHONE NUMBER,
    NAME VARCHAR2(100),
    ADDRESS VARCHAR2(500),
    MANAGER NUMBER,
    BRANCHNAME VARCHAR2(100),
    LENGTHOFEMPLOYMENT NUMBER,
    FOREIGN KEY (BRANCHNAME) REFERENCES Bank(Name)
);

CREATE TABLE DEPENDANTS(
    NAME VARCHAR2(100),
    ESSN NUMBER,
    FOREIGN KEY (ESSN) REFERENCES EMPLOYEE(SSN)
);


CREATE TABLE CUSTOMER(
    CID VARCHAR2(100) PRIMARY KEY,
    ADDRESS VARCHAR2(200),
    NAME VARCHAR2(300)
);

CREATE TABLE HASCUSTOMER(
    BNAME VARCHAR2(100),
    CID VARCHAR2(100),
    PRIMARY KEY (BNAME, CID),
    FOREIGN KEY(BNAME) REFERENCES Bank(Name),
    FOREIGN KEY(CID) REFERENCES CUSTOMER(CID)
);

CREATE TABLE INDIVIDUAL(
    SSN VARCHAR2(100) PRIMARY KEY,
    FOREIGN KEY(SSN) REFERENCES CUSTOMER(CID)
);

CREATE TABLE NAME(
    BUSINESSNAME VARCHAR2(100) PRIMARY KEY,
    FOREIGN KEY(BUSINESSNAME) REFERENCES CUSTOMER(CID)
);

CREATE TABLE ACCOUNT(
    ACCOUNTNUMBER NUMBER PRIMARY KEY,
    BALANCE NUMBER(15, 2),
    LastAccessDate DATE,
    AccType VARCHAR2(10),
    InterestRate NUMBER(2, 2),
    OverDraft NUMBER(15,2)
);

CREATE TABLE CUSTOMERHASACCOUNT(
    ACCOUNTNUMBER NUMBER,
    CID VARCHAR2(100),
    PRIMARY KEY (AAccouCCOUNTNUMBER, CID),
    FOREIGN KEY(ACCOUNTNUMBER) REFERENCES ACCOUNT(ACCOUNTNUMBER),
    FOREIGN KEY(CID) REFERENCES CUSTOMER(CID)
);

CREATE TABLE LOAN(
    LOANNUMBER NUMBER PRIMARY KEY,
    LOANAMOUNT NUMBER(15,2),
    PAYMENTDATE DATE,
    PAYMENTAMOUNT NUMBER(15,2),
    LOANOFFICER NUMBER,
    FOREIGN KEY(LOANOFFICER) REFERENCES EMPLOYEE(SSN)
);


CREATE TABLE LOANPAYMENT(
    PAYMENTNUMBER NUMBER PRIMARY KEY,
    PAYMENTDATE DATE,
    PAYMENTAMOUNT NUMBER(15,2)
);

CREATE TABLE HOLDSPAYMENTNUMBER(
    LOANNUMBER NUMBER PRIMARY KEY,
    PAYMENTNUMBER NUMBER,
    FOREIGN KEY(LOANNUMBER) REFERENCES LOAN(LOANNUMBER),
    FOREIGN KEY(PAYMENTNUMBER) REFERENCES LOANPAYMENT(PAYMENTNUMBER)
);

CREATE TABLE HOLDSLOAN(
    CID VARCHAR2(100),
    LOANNUMBER NUMBER,
    PRIMARY KEY (CID, LOANNUMBER),
    FOREIGN KEY(LOANNUMBER) REFERENCES LOAN(LOANNUMBER),
    FOREIGN KEY(CID) REFERENCES CUSTOMER(CID)
);