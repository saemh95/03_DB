-- VIEW

CREATE OR REPLACE VIEW V_EMPLOYEE
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_NAME
     FROM EMPLOYEE
     LEFT JOIN DEPARTMENT ON(DEPT_ID = DEPT_CODE)
     LEFT JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
     LEFT JOIN "NATIONAL" USING(NATIONAL_CODE);

    
SELECT * FROM V_EMPLOYEE;

CREATE TABLE DEPT_COP
AS SELECT * FROM DEPARTMENT;

CREATE OR REPLACE VIEW V_DCOPY2
AS SELECT DEPT_ID, LOCATION_ID FROM DEPT_COP;

ALTER TABLE DEPT_COP RENAME TO DEPT_COPY;

INSERT INTO V_DCOPY2 VALUES ('D0', 'L3');

SELECT * FROM V_DCOPY2;
SELECT * FROM DEPT_COPY;

CREATE OR REPLACE VIEW V_DCOPY2
AS SELECT DEPT_ID, LOCATION_ID FROM DEPT_COPY
WITH READ ONLY;


