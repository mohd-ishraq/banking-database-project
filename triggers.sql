
-- 6.1	To notify a member about the interest rate change due to balance falling below
--  certain amount, say $1000


CREATE OR REPLACE TRIGGER notify_interest_rate_change
BEFORE UPDATE ON ACCOUNT
FOR EACH ROW
DECLARE
    v_balance_threshold NUMBER := 1000;
BEGIN
    IF :NEW.BALANCE < v_balance_threshold AND :OLD.BALANCE >= v_balance_threshold THEN

        INSERT INTO NOTIFICATION (ACCOUNTNUMBER, MESSAGE, NOTIFICATION_DATE)
        VALUES (:NEW.ACCOUNTNUMBER, 'Your balance has fallen below $1000. Interest rate change may apply.', SYSDATE);

    END IF;
END;
/


-- 6.2	Updating the manager details (manager SSN) in the event of a new manager 
-- replacing one existing one.


CREATE OR REPLACE TRIGGER update_manager_details
BEFORE UPDATE ON EMPLOYEE
FOR EACH ROW
BEGIN
    IF :NEW.MANAGER IS NOT NULL AND :NEW.MANAGER <> :OLD.MANAGER THEN
        UPDATE EMPLOYEE SET MANAGER = NULL WHERE SSN = :NEW.MANAGER;

        UPDATE EMPLOYEE SET MANAGER = :NEW.MANAGER WHERE BRANCHNAME = :NEW.BRANCHNAME AND SSN <> :NEW.SSN;
    END IF;
END;
/





