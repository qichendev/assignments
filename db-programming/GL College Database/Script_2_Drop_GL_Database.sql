-- DROP GL Database for Database Programming using SQL & PL/SQL -- 

BEGIN
  FOR i IN ( SELECT table_name
             FROM   user_tables
             WHERE table_name LIKE 'GL%' )
  LOOP
    EXECUTE IMMEDIATE 'DROP TABLE ' || i.table_name || ' CASCADE CONSTRAINTS';
  END LOOP;
  END;
  
  DBMS_OUTPUT.PUT_LINE ('All exercise tables dropped');  
END;