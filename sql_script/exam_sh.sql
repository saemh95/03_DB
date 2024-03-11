--/* 연습문제 */
--/* 계정 'exam_이니셜' 로 생성 후 해당 계정에서 진행.
--
--
--테이블명 : MAJOR
--1. MAJOR_NO (학과번호) : NUMBER - PK
--2. MAJOR_NM (학과명) : VARCHAR2(100) - NOT NULL
--
--
--
--
--테이블명 : STUDENT
--1. STUDENT_ID (학번) : NUMBER - PK
--2. STUDENT_NAME (이름) : VARCHAR2(20) - NOT NULL
--3. GENDER (성별) : VARCHAR2(3) CHECK ('남' , '여')
--4. BIRTH (생년월일 : 'YYYY-MM-DD '형식으로 작성) : DATE
--5. MAJOR_NO (전공학과번호) : NUMBER - FK (부모키 삭제 시 자식키 NULL 로 변경)
--*/
--
--
---- 각 테이블마다 INSERT 5개 이상 
-- MAJOR_NM 학과명 MAJOR_NAME으로 변경해보기




CREATE TABLE MAJOR (
MAJOR_NO NUMBER CONSTRAINT MAJOR_NO_PK PRIMARY KEY,
MAJOR_NM VARCHAR2(100) CONSTRAINT MAJOR_NM_NN NOT NULL
);

SELECT * FROM MAJOR;
COMMENT ON COLUMN MAJOR.MAJOR_NO IS '학과번호';
COMMENT ON COLUMN MAJOR.MAJOR_NM IS '학과명';




CREATE TABLE STUDENT (
STUDENT_ID NUMBER CONSTRAINT STUDENT_ID_PK PRIMARY KEY,
STUDENT_NAME VARCHAR2(20) CONSTRAINT STUDENT_NAME_NN NOT NULL,
GENDER VARCHAR2(3) CONSTRAINT GENDER_CK CHECK(GENDER IN ('M', 'F')),
BIRTH DATE DEFAULT SYSDATE,
MAJOR_NO NUMBER CONSTRAINT MAJOR_NO_FK REFERENCES MAJOR
);

COMMENT ON COLUMN STUDENT.STUDENT_ID IS '학번';
COMMENT ON COLUMN STUDENT.STUDENT_NAME IS '학번';
COMMENT ON COLUMN STUDENT.GENDER IS '성별';
COMMENT ON COLUMN STUDENT.BIRTH IS '생년월일';
COMMENT ON COLUMN STUDENT.MAJOR_NO IS '전공학과번호';

INSERT INTO MAJOR VALUES (1, '건축학과');
INSERT INTO MAJOR VALUES (2, '사회학과');
INSERT INTO MAJOR VALUES (3, '무용학과');
INSERT INTO MAJOR VALUES (4, '생명공학과');
INSERT INTO MAJOR VALUES (5, '경제학과');

COMMIT;

INSERT INTO STUDENT VALUES (1305145, '정스퀴드', 'M', TO_DATE('1994-09-13', 'YYYY-MM-DD'), 1);
INSERT INTO STUDENT VALUES (1801334, '곽오징어', 'M', TO_DATE('1999-10-23', 'YYYY-MM-DD'), 2);
INSERT INTO STUDENT VALUES (2003456, '김문어', 'F', TO_DATE('2000-03-11', 'YYYY-MM-DD'), 3);
INSERT INTO STUDENT VALUES (2200135, '장상어', 'M', TO_DATE('2002-05-04', 'YYYY-MM-DD'), 4);
INSERT INTO STUDENT VALUES (1001566, '라갈치', 'F', TO_DATE('1988-11-16', 'YYYY-MM-DD'), 5);

SELECT * FROM STUDENT;

ALTER TABLE STUDENT ADD CONSTRAINT MAJOR_NO_FK
FOREIGN KEY(MAJOR_NO) REFERENCES MAJOR ON DELETE SET NULL;

ALTER TABLE STUDENT DROP CONSTRAINT MAJOR_NO_FK;

UPDATE STUDENT SET STUDENT_ID = 1 WHERE STUDENT_NAME = '정스퀴드';
UPDATE STUDENT SET STUDENT_ID = 2 WHERE STUDENT_NAME = '곽오징어';
UPDATE STUDENT SET STUDENT_ID = 3 WHERE STUDENT_NAME = '김문어';
UPDATE STUDENT SET STUDENT_ID = 4 WHERE STUDENT_NAME = '장상어';
UPDATE STUDENT SET STUDENT_ID = 5 WHERE STUDENT_NAME = '라갈치';

ALTER TABLE MAJOR RENAME COLUMN MAJOR_NM TO MAJOR_NAME;
COMMIT;