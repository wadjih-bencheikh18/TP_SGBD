
-- Liste de tous les livres (type "Book") :
SELECT * FROM publications WHERE type = 'Book';

-- Types des publications de l’an 2022 :
SELECT type, COUNT(*) FROM publications WHERE year = 2022 GROUP BY type;

-- Liste des journaux depuis 2008 :
SELECT * FROM publications WHERE type = 'Journal' AND year >= 2008;

-- Liste des publications de l’auteur « Yacine Mestoui » :
SELECT p.* FROM publications p
INNER JOIN publication_authors pa ON p.id = pa.publication_id
INNER JOIN authors a ON pa.author_id = a.id
WHERE a.name = 'Yacine Mestoui';

-- Liste de tous les articles publiés à DaWaK :
SELECT * FROM publications WHERE booktitle = 'DaWaK';

-- Liste de tous les auteurs distincts :
SELECT DISTINCT name FROM authors;

-- Trier les publications de « Alfredo Cuzzocrea » par année :
SELECT p.* FROM publications p
INNER JOIN publication_authors pa ON p.id = pa.publication_id
INNER JOIN authors a ON pa.author_id = a.id
WHERE a.name = 'Alfredo Cuzzocrea'
ORDER BY p.year;

-- Corriger le nom de « Carlos Ordonez 0001 » par « Carlos Ordonez» :
UPDATE authors SET name = 'Carlos Ordonez' WHERE name = 'Carlos Ordonez 0001';

-- Compter le nombre des publications de « Soumia Benkrid» :
SELECT COUNT(*) FROM publication_authors pa
INNER JOIN authors a ON pa.author_id = a.id
WHERE a.name = 'Soumia Benkrid';