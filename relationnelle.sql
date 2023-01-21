-- Create the nested table type for publications
CREATE TYPE publications_ntt AS TABLE OF publications%ROWTYPE;

-- Declare a variable of the nested table type
DECLARE
  publications_nt publications_ntt;
BEGIN
  -- Select all books into the nested table variable
  SELECT * BULK COLLECT INTO publications_nt
  FROM publications
  WHERE type = 'Book';
  
  -- Iterate through the nested table and print the data
  FOR i IN 1..publications_nt.COUNT LOOP
    DBMS_OUTPUT.PUT_LINE(publications_nt(i).id || ' ' || publications_nt(i).title);
  END LOOP;
END;