-- Create table

CREATE TABLE PUBLICATIONS (
    _ID NUMBER,
    TYPE VARCHAR2(20),
    AUTHOR VARCHAR2(200),
    TITLE VARCHAR2(500),
    PAGES NUMBER,
    YEAR NUMBER,
    VOLUME NUMBER,
    JOURNAL VARCHAR2(50),
    EE VARCHAR2(500),
    URL VARCHAR2(500)
);


-- Load data

LOAD DATA
INFILE 'Publis.json'
INTO TABLE PUBLICATIONS
FIELDS TERMINATED BY ','
(
    _ID,
    TYPE,
    AUTHOR,
    TITLE,
    PAGES,
    YEAR,
    VOLUME,
    JOURNAL,
    EE,
    URL
)


-- Les requêtes

-- Liste de tous les livres (type « Book ») :
SELECT * FROM PUBLICATIONS WHERE TYPE = 'Book';
-- Types des publications de l’an 2022 :
SELECT TYPE FROM PUBLICATIONS WHERE YEAR = 2022;

-- Liste des journaux depuis 2008 :
SELECT * FROM PUBLICATIONS WHERE TYPE = 'Journal' AND YEAR >= 2008;

-- Liste des publications de l’auteur « Yacine Mestoui » :
SELECT * FROM PUBLICATIONS WHERE AUTHOR = 'Yacine Mestoui';

-- Liste de tous les articles publiés à DaWaK :
SELECT * FROM PUBLICATIONS WHERE BOOKTITLE = 'DaWaK';

-- Liste de tous les auteurs distincts :
SELECT DISTINCT AUTHOR FROM PUBLICATIONS;

-- Trier les publications de « Alfredo Cuzzocrea » par année :
SELECT * FROM PUBLICATIONS WHERE AUTHOR = 'Alfredo Cuzzocrea' ORDER BY YEAR;

-- Corriger le nom de « Carlos Ordonez 0001 » par « Carlos Ordonez» :
UPDATE PUBLICATIONS SET AUTHOR = 'Carlos Ordonez' WHERE AUTHOR = 'Carlos Ordonez 0001';

-- Compter le nombre des publications de « Soumia Benkrid» :
SELECT COUNT(*) FROM PUBLICATIONS WHERE AUTHOR = 'Soumia Benkrid';