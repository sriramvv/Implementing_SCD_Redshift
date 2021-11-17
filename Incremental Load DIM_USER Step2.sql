-- MERGE CHANGES TO DIM USER
BEGIN TRANSACTION;

-- CLOSE CURRENT TYPE 2 ACTIVE RECORD BASED OF STAGING DATA WHERE CHANGE INDICATOR IS 1
UPDATE INSTACART.DIM_USER D
SET END_TS = GETDATE() - INTERVAL '1 SECOND',
    ACTIVE_IND = 0,
    UPDATED_DT = CURRENT_TIMESTAMP 
FROM INSTACART.STG_USER S
WHERE D.USER_ID = S.USER_ID
AND D.END_TS = '2999-12-31'
AND D.ACTIVE_IND = 1
AND D.TRACK_HASH <> S.TRACK_HASH;

-- CREATE LATEST VERSION TYPE 2 ACTIVE RECORD FROM STAGING DATA
INSERT INTO INSTACART.DIM_USER (USER_ID, FIRST_NM, LAST_NM, ADDRESS, PHONE, CITY, STATE, TRACK_HASH, ACTIVE_IND, START_TS, END_TS )
SELECT S.USER_ID, S.FIRST_NM, S.LAST_NM, S.ADDRESS, S.PHONE, S.CITY, S.STATE, S.TRACK_HASH, S.ACTIVE_IND,  CURRENT_TIMESTAMP, '2999-12-31' AS END_TS
FROM   INSTACART.STG_USER S INNER JOIN INSTACART.DIM_USER D ON D.USER_ID = S.USER_ID
WHERE  D.TRACK_HASH <> S.TRACK_HASH;

-- NEW RECORDS
INSERT INTO INSTACART.DIM_USER (USER_ID, FIRST_NM, LAST_NM, ADDRESS, PHONE, CITY, STATE, TRACK_HASH, ACTIVE_IND, START_TS, END_TS )
SELECT S.USER_ID, S.FIRST_NM, S.LAST_NM, S.ADDRESS, S.PHONE, S.CITY, S.STATE, S.TRACK_HASH, S.ACTIVE_IND, CURRENT_TIMESTAMP, '2999-12-31' AS END_TS
FROM INSTACART.STG_USER S WHERE S.USER_ID NOT IN (SELECT D.USER_ID FROM INSTACART.DIM_USER D);

-- UPDATE TYPE 1 CURRENT ACTIVE RECORDS FOR NON-TRACKING ATTRIBUTES
UPDATE INSTACART.DIM_USER D
SET FIRST_NM =  S.FIRST_NM, 
	LAST_NM = S.LAST_NM, 
    ADDRESS = S.ADDRESS, 
    UPDATED_DT = CURRENT_TIMESTAMP 
FROM INSTACART.STG_USER S
WHERE D.USER_ID = S.USER_ID
AND D.END_TS = '2999-12-31'
AND D.ACTIVE_IND = 1
AND D.TRACK_HASH = S.TRACK_HASH;

-- END MERGE OPERATION
COMMIT TRANSACTION;