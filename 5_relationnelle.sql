-- Liste de tous les livres (type "Book") :
DECLARE
    CURSOR BOOKS_CUR IS
        SELECT
            TITLE
        FROM
            PUBLICATIONS
        WHERE
            TYPE = 'Book';
BEGIN
    OPEN BOOKS_CUR;
    FETCH BOOKS_CUR INTO BOOK;
    DBMS_OUTPUT.PUT_LINE('Livres:');
    WHILE BOOKS_CUR%FOUND LOOP
        DBMS_OUTPUT.PUT_LINE(BOOK.TITLE);
        FETCH BOOKS_CUR INTO BOOK;
    END LOOP;
    CLOSE BOOKS_CUR;
END;
 -- -----------------------------------------------------
 -- LISTE DES JOURNAUX DEPUIS 2008 :
 --  -----------------------------------------------------
DECLARE
    CURSOR JORNAL_CUR IS
        SELECT
            TITLE
        FROM
            PUBLICATIONS
        WHERE
            TYPE = 'Journal'
            AND YEAR >= 2008;
BEGIN
    OPEN JORNAL_CUR;
    FETCH JORNAL_CUR INTO JORNAL;
    DBMS_OUTPUT.PUT_LINE('Journaux depuis 2008:');
    WHILE JORNAL_CUR%FOUND LOOP
        DBMS_OUTPUT.PUT_LINE(JORNAL.TITLE);
        FETCH JORNAL_CUR INTO JORNAL;
    END LOOP;
    CLOSE JORNAL_CUR;
END;
 --  -----------------------------------------------------
 -- Liste des publications de l’auteur « Yacine Mestoui » :
 --  -----------------------------------------------------
DECLARE
    CURSOR AUTHOR_CURSOR IS
        SELECT
            TITLE
        FROM
            PUBLICATIONS
            JOIN PUBLICATION_AUTHORS
            ON PUBLICATIONS.ID = PUBLICATION_AUTHORS.PUBLICATION_ID JOIN AUTHORS
            ON AUTHORS.ID = PUBLICATION_AUTHORS.AUTHOR_ID
        WHERE
            AUTHORS.NAME = 'Yacine Mestoui';
    PUBLICATION_TITLE PUBLICATIONS.TITLE%TYPE;
BEGIN
    OPEN AUTHOR_CURSOR;
    FETCH AUTHOR_CURSOR INTO PUBLICATION_TITLE;
    DBMS_OUTPUT.PUT_LINE('Publications de Yacine Mestoui:');
    WHILE AUTHOR_CURSOR%FOUND LOOP
        DBMS_OUTPUT.PUT_LINE(PUBLICATION_TITLE);
        FETCH AUTHOR_CURSOR INTO PUBLICATION_TITLE;
    END LOOP;
    CLOSE AUTHOR_CURSOR;
END;
 --  -----------------------------------------------------
 -- LISTE DE TOUS LES ARTICLES PUBLIÉS À DAWAK :
 --  -----------------------------------------------------
DECLARE
    CURSOR PUBLICATIONS_CURSOR IS
        SELECT
            TITLE,
            YEAR,
            BOOKTITLE
        FROM
            PUBLICATIONS
        WHERE
            BOOKTITLE = 'DaWaK';
BEGIN
    FOR PUBLICATION IN PUBLICATIONS_CURSOR LOOP
        DBMS_OUTPUT.PUT_LINE(PUBLICATION.TITLE
            || ' '
            || PUBLICATION.YEAR
            || ' '
            || PUBLICATION.BOOKTITLE);
    END LOOP;
END;
 --  -----------------------------------------------------
 -- LISTE DE TOUS LES AUTEURS DISTINCTS :
 --  -----------------------------------------------------
DECLARE
    CURSOR DISTINCT_AUTHORS IS
        SELECT
            DISTINCT NAME
        FROM
            AUTHORS;
BEGIN
    FOR EACH_AUTHOR IN DISTINCT_AUTHORS LOOP
        DBMS_OUTPUT.PUT_LINE(EACH_AUTHOR.NAME);
    END LOOP;
END;
 --  -----------------------------------------------------
 -- TRIER LES PUBLICATIONS DE « ALFREDO CUZZOCREA » PAR ANNÉE :
 --  -----------------------------------------------------
DECLARE
    CURSOR PUBLICATIONS_CURSOR IS
        SELECT
            P.*
        FROM
            PUBLICATIONS        P
            JOIN PUBLICATION_AUTHORS PA
            ON PA.PUBLICATION_ID = P.ID JOIN AUTHORS A
            ON A.ID = PA.AUTHOR_ID
        WHERE
            A.NAME = 'Alfredo Cuzzocrea'
        ORDER BY
            P.YEAR;
    PUBLICATION PUBLICATIONS%ROWTYPE;
BEGIN
    OPEN PUBLICATIONS_CURSOR;
    FETCH PUBLICATIONS_CURSOR INTO PUBLICATION;
    DBMS_OUTPUT.PUT_LINE('Auteur: Alfredo Cuzzocrea');
    DBMS_OUTPUT.PUT_LINE('Année - Titre');
    WHILE PUBLICATIONS_CURSOR%FOUND LOOP
        DBMS_OUTPUT.PUT_LINE(PUBLICATION.YEAR
            || ' - '
            || PUBLICATION.TITLE);
        FETCH PUBLICATIONS_CURSOR INTO PUBLICATION;
    END LOOP;
    CLOSE PUBLICATIONS_CURSOR;
END;
 --  -----------------------------------------------------
 --  CORRIGER LE NOM DE « CARLOS ORDONEZ 0001 » PAR « CARLOS ORDONEZ» :
 --  -----------------------------------------------------
 CREATE OR REPLACE FUNCTION CORRECT_AUTHOR_NAME ( P_AUTHOR_NAME IN VARCHAR2 ) RETURN VARCHAR2 AS CORRECTED_NAME VARCHAR2( 255 );
BEGIN
 -- utiliser une instruction CASE pour corriger le nom de l'auteur
    CASE P_AUTHOR_NAME
        WHEN 'Carlos Ordonez 0001' THEN
            CORRECTED_NAME := 'Carlos Ordonez'
 -- ajouter d'autres cas si nécessaire
        ELSE
            CORRECTED_NAME := P_AUTHOR_NAME;
    END CASE;
    RETURN CORRECTED_NAME;
END;
UPDATE AUTHORS
SET
    NAME = CORRECT_AUTHOR_NAME(
        NAME
    );
 --  -----------------------------------------------------
 -- Compter le nombre des publications de « Soumia Benkrid» :
 --  -----------------------------------------------------
DECLARE
    PUBLICATION_COUNT INT := 0;
BEGIN
    FOR I IN (
        SELECT
            *
        FROM
            PUBLICATIONS
    ) LOOP
        FOR J IN (
            SELECT
                *
            FROM
                PUBLICATION_AUTHORS
            WHERE
                PUBLICATION_ID = I.ID
        ) LOOP
            IF (
                SELECT
                    NAME
                FROM
                    AUTHORS
                WHERE
                    ID = J.AUTHOR_ID
            ) = 'Soumia Benkrid' THEN
                PUBLICATION_COUNT := PUBLICATION_COUNT + 1;
            END IF;
        END LOOP;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Number of publications by Soumia Benkrid: '
        || PUBLICATION_COUNT);
END;