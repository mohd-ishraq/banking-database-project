-- # 2.  Generate a report listing all branches with their customers, 
-- their account details and the loaned amount if there is. 


SELECT
    B.Name AS BranchName,
    C.CID AS CustomerID,
    C.NAME AS CustomerName,
    A.ACCOUNTNUMBER,
    A.BALANCE,
    L.LOANAMOUNT
FROM
    Bank B
LEFT JOIN
    HASCUSTOMER HC ON B.Name = HC.BNAME
LEFT JOIN
    CUSTOMER C ON HC.CID = C.CID
LEFT JOIN
    CUSTOMERHASACCOUNT CA ON C.CID = CA.CID
LEFT JOIN
    ACCOUNT A ON CA.ACCOUNTNUMBER = A.ACCOUNTNUMBER
LEFT JOIN
    HOLDSLOAN HL ON C.CID = HL.CID
LEFT JOIN
    LOAN L ON HL.LOANNUMBER = L.LOANNUMBER;



-- 3.	Report showing top 5 personal bankers who has have customers who holds highest account balance. 


SELECT
    E.NAME AS PersonalBanker,
    COUNT(DISTINCT C.CID) AS NumberOfCustomers,
    SUM(A.BALANCE) AS TotalAccountBalance
FROM
    EMPLOYEE E
JOIN
    CUSTOMER C ON E.SSN = C.CID
LEFT JOIN
    CUSTOMERHASACCOUNT CA ON C.CID = CA.CID
LEFT JOIN
    ACCOUNT A ON CA.ACCOUNTNUMBER = A.ACCOUNTNUMBER
GROUP BY
    E.NAME
ORDER BY
    TotalAccountBalance DESC
FETCH FIRST 5 ROWS ONLY;



-- 4.	Report showing top 5 accounts that owes 
-- (difference of loaned amount and sum of all payment amounts) 
-- the most to the bank with their corresponding branches that loaned that amount.


WITH AccountOwedAmount AS (
    SELECT
        L.LOANNUMBER,
        L.LOANAMOUNT - NVL(SUM(LP.PAYMENTAMOUNT), 0) AS OWED_AMOUNT
    FROM
        LOAN L
    LEFT JOIN
        LOANPAYMENT LP ON L.LOANNUMBER = LP.LOANNUMBER
    GROUP BY
        L.LOANNUMBER, L.LOANAMOUNT
)

SELECT
    AO.LOANNUMBER,
    AO.OWED_AMOUNT,
    B.Name AS BranchName
FROM
    AccountOwedAmount AO
JOIN
    LOAN L ON AO.LOANNUMBER = L.LOANNUMBER
JOIN
    EMPLOYEE E ON L.LOANOFFICER = E.SSN
JOIN
    Bank B ON E.BRANCHNAME = B.Name
ORDER BY
    AO.OWED_AMOUNT DESC
FETCH FIRST 5 ROWS ONLY;


###