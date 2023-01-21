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

-- Types des publications de l’an 2022 
DECLARE
    -- Declare a nested table type for holding publication types
    TYPE publication_types_ntt IS TABLE OF VARCHAR2(255);
    -- Declare a variable of the nested table type
    publication_types publication_types_ntt;
BEGIN
    -- Insert the unique types of publications from the year 2022 into the nested table variable
    SELECT DISTINCT type
    INTO publication_types
    FROM publications
    WHERE year = 2022;
    
    -- Print out the publication types
    FOR i IN 1 .. publication_types.COUNT
    LOOP
        DBMS_OUTPUT.PUT_LINE(publication_types(i));
    END LOOP;
END;

-- la liste des journaux depuis 2008
DECLARE
    TYPE journal_list IS TABLE OF publications.journal%TYPE;
    journals journal_list;
BEGIN
    SELECT DISTINCT journal
    INTO journals
    FROM publications
    WHERE year >= 2008;
    FOR i IN 1 .. journals.COUNT
    LOOP
        DBMS_OUTPUT.PUT_LINE(journals(i));
    END LOOP;
END;

-- Liste des publications de l’auteur « Yacine Mestoui »
DECLARE
  TYPE publication_list IS TABLE OF publications%ROWTYPE;
  publications_by_author publication_list;
BEGIN
  SELECT *
  BULK COLLECT INTO publications_by_author
  FROM publications
  JOIN publication_authors ON publications.id = publication_authors.publication_id
  JOIN authors ON publication_authors.author_id = authors.id
  WHERE authors.name = 'Yacine Mestoui';
  
  FOR i IN 1..publications_by_author.COUNT
  LOOP
    DBMS_OUTPUT.PUT_LINE(publications_by_author(i).title);
  END LOOP;
END;

-- Liste de tous les articles publiés à DaWaK
DECLARE
   TYPE publication_list IS TABLE OF publications%ROWTYPE;
   publications_da_wak publication_list;
BEGIN
   SELECT * BULK COLLECT INTO publications_da_wak
   FROM publications
   WHERE booktitle = 'DaWaK';

   FOR i IN 1..publications_da_wak.COUNT
   LOOP
      DBMS_OUTPUT.PUT_LINE(publications_da_wak(i).title);
   END LOOP;
END;

-- liste de tous les auteurs distincts
DECLARE
    TYPE author_list IS TABLE OF authors.name%TYPE;
    all_authors author_list;
BEGIN
    SELECT DISTINCT name
    BULK COLLECT INTO all_authors
    FROM authors;

    FOR i IN 1..all_authors.COUNT
    LOOP
        DBMS_OUTPUT.PUT_LINE(all_authors(i));
    END LOOP;
END;


-- Afficher les publications de « Alfredo Cuzzocrea » Trier  par année
DECLARE
  TYPE publications_t IS TABLE OF publications%ROWTYPE;
  publications_list publications_t;
BEGIN
  SELECT *
  BULK COLLECT INTO publications_by_author
  FROM publications
  JOIN publication_authors ON publications.id = publication_authors.publication_id
  JOIN authors ON publication_authors.author_id = authors.id
  WHERE name = 'Alfredo Cuzzocrea'
  ORDER BY year;

  -- Do something with the sorted list of publications
  FOR i IN 1..publications_list.COUNT LOOP
    -- access the i-th element of the list
    DBMS_OUTPUT.PUT_LINE(publications_list(i).year || ': ' || publications_list(i).title);
  END LOOP;
END;

-- Corriger le nom de « Carlos Ordonez 0001 » par « Carlos Ordonez»
CREATE OR REPLACE FUNCTION correct_author_name (p_author_name IN VARCHAR2)
RETURN VARCHAR2
AS
  corrected_name VARCHAR2(255);
BEGIN
  -- utiliser une instruction CASE pour corriger le nom de l'auteur
  CASE p_author_name
    WHEN 'Carlos Ordonez 0001' THEN corrected_name := 'Carlos Ordonez'
    -- ajouter d'autres cas si nécessaire
    ELSE corrected_name := p_author_name;
  END CASE;
  
  RETURN corrected_name;
END;
UPDATE authors
SET name = correct_author_name(name)

-- Compter le nombre des publications de « Soumia Benkrid»
CREATE OR REPLACE FUNCTION get_soumia_benkrid_publications_count
RETURN INTEGER
AS
   publications_count INTEGER;
BEGIN
   SELECT COUNT(*) INTO publications_count
   FROM publications p
   JOIN publication_authors pa ON p.id = pa.publication_id
   JOIN authors a ON pa.author_id = a.id
   WHERE a.name = 'Soumia Benkrid';

   RETURN publications_count;
END;
SELECT get_soumia_benkrid_publications_count() FROM DUAL;