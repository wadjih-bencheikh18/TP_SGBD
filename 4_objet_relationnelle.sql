-- Liste de tous les livres (type "Book") :
SELECT
    *
FROM
    PUBLICATIONS
WHERE
    TYPE = 'Book';

-- Types des publications de l’an 2022 :
SELECT
    TYPE,
    COUNT(*)
FROM
    PUBLICATIONS
WHERE
    YEAR = 2022
GROUP BY
    TYPE;

-- Liste des journaux depuis 2008 :
SELECT
    *
FROM
    PUBLICATIONS
WHERE
    TYPE = 'Journal'
    AND YEAR >= 2008;

-- Liste des publications de l’auteur « Yacine Mestoui » :
SELECT
    P.*
FROM
    PUBLICATIONS        P
    INNER JOIN PUBLICATION_AUTHORS PA
    ON P.ID = PA.PUBLICATION_ID
    INNER JOIN AUTHORS A
    ON PA.AUTHOR_ID = A.ID
WHERE
    A.NAME = 'Yacine Mestoui';

-- Liste de tous les articles publiés à DaWaK :
SELECT
    *
FROM
    PUBLICATIONS
WHERE
    BOOKTITLE = 'DaWaK';

-- Liste de tous les auteurs distincts :
SELECT
    DISTINCT NAME
FROM
    AUTHORS;

-- Trier les publications de « Alfredo Cuzzocrea » par année :
SELECT
    P.*
FROM
    PUBLICATIONS        P
    INNER JOIN PUBLICATION_AUTHORS PA
    ON P.ID = PA.PUBLICATION_ID
    INNER JOIN AUTHORS A
    ON PA.AUTHOR_ID = A.ID
WHERE
    A.NAME = 'Alfredo Cuzzocrea'
ORDER BY
    P.YEAR;

-- Corriger le nom de « Carlos Ordonez 0001 » par « Carlos Ordonez» :
UPDATE AUTHORS
SET
    NAME = 'Carlos Ordonez'
WHERE
    NAME = 'Carlos Ordonez 0001';

-- Compter le nombre des publications de « Soumia Benkrid» :
SELECT
    COUNT(*)
FROM
    PUBLICATION_AUTHORS PA
    INNER JOIN AUTHORS A
    ON PA.AUTHOR_ID = A.ID
WHERE
    A.NAME = 'Soumia Benkrid';