ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE ;
-- ctrl + enter : 1line execute

CREATE USER kh_sh IDENTIFIED BY kh1234;

GRANT RESOURCE, CONNECT TO kh_sh;

ALTER USER kh_sh DEFAULT TABLESPACE SYSTEM QUOTA UNLIMITED ON SYSTEM;