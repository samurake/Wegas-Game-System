CREATE OR REPLACE PACKAGE exceptionhandler
AS
  insert_null_into_notnull EXCEPTION;
  PRAGMA EXCEPTION_INIT(insert_null_into_notnull, -1400);

  update_null_to_notnull EXCEPTION;
  PRAGMA EXCEPTION_INIT(update_null_to_notnull, -1407);
END exceptionhandler;

