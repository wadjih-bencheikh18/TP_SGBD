DECLARE
    TYPE BOOK_TYPE IS
        TABLE OF PUBLICATIONS%ROWTYPE;
    BOOK_LIST BOOK_TYPE;
BEGIN
    SELECT
        * BULK COLLECT INTO BOOK_LIST
    FROM
        PUBLICATIONS
    WHERE
        TYPE = 'Book';
    FOR I IN BOOK_LIST.FIRST..BOOK_LIST.LAST LOOP
        DBMS_OUTPUT.PUT_LINE(BOOK_LIST(I).TITLE);
    END LOOP;
END;