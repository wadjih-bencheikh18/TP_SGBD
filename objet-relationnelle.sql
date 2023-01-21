
-- Drop tables
DROP TABLE IF EXISTS publication_authors;
DROP TABLE IF EXISTS authors;
DROP TABLE IF EXISTS ee;
DROP TABLE IF EXISTS publications;

-- Create tables
CREATE TABLE publications (
  id INT PRIMARY KEY,
  type VARCHAR(255),
  title VARCHAR(255),
  pages INT,
  year INT,
  booktitle VARCHAR(255),
  volume INT,
  journal VARCHAR(255),
  num INT,
  url VARCHAR(255)
);

CREATE TABLE ee (
  id INT PRIMARY KEY,
  url VARCHAR(255) UNIQUE,
  publication_id INT,
  FOREIGN KEY (publication_id) REFERENCES publications(id)
);

CREATE TABLE authors (
  id INT PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE publication_authors (
  id INT PRIMARY KEY,
  publication_id INT,
  author_id INT,
  FOREIGN KEY (publication_id) REFERENCES publications(id),
  FOREIGN KEY (author_id) REFERENCES authors(id)
);


-- Request

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
SELECT COUNT(*) FROM publications p
INNER JOIN publication_authors pa ON p.id = pa.publication_id
INNER JOIN authors a ON pa.author_id = a.id
WHERE a.name = 'Soumia Benkrid';