begin transaction;

INSERT INTO INSTACART.STG_USER(USER_ID)
SELECT DISTINCT S.USER_ID FROM INSTACART.STG_ORDER S; 
    

UPDATE INSTACART.STG_USER 
SET FIRST_NM =  INITCAP(TRANSLATE(USER_ID,  '1234567890', 'ABCDEFGHIJ')),
LAST_NM = INITCAP(TRANSLATE(USER_ID,  '1234567890', 'KLMNOPQRST')),
ADDRESS = CAST(CAST(RANDOM() * 100 AS INT) AS CHAR) + ' ' + INITCAP(TRANSLATE(USER_ID*123,  '1234567890', 'ASDFGHJKLP')),
PHONE = cast(RIGHT('123456789'+cast(cast(999999999*random() as bigint) as varchar(10)),10) as bigint), 
CITY = 'Manhattan',
STATE = 'NY'
--TRACK_HASH = FNV_HASH(ADDRESS+PHONE)
WHERE FIRST_NM IS NULL;

UPDATE INSTACART.STG_USER 
SET TRACK_HASH = FNV_HASH(ADDRESS+PHONE)
WHERE TRACK_HASH IS NULL;

commit transaction;

ALTER TABLE INSTACART.DIM_USER APPEND FROM INSTACART.STG_USER FILLTARGET;