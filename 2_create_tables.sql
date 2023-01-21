
-- Drop tables
DROP TABLE publication_authors;
DROP TABLE authors;
DROP TABLE ee;
DROP TABLE publications;

-- Create tables
CREATE TABLE publications (
  id INT PRIMARY KEY,
  type VARCHAR(255),
  title VARCHAR(255),
  pages VARCHAR(30),
  year INT,
  booktitle VARCHAR(255),
  crossref VARCHAR(255),
  school VARCHAR(255),
  volume INT,
  journal VARCHAR(255),
  num INT,
  url VARCHAR(255)
);

CREATE TABLE ee (
  id INT PRIMARY KEY,
  url VARCHAR(255),
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



-- Insert data

-- 