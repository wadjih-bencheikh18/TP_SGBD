import json

# read json file
with open('Publis.json', 'r') as f:
    publications = json.load(f)

# create a new file to store the SQL statements
with open('insert_data.sql', 'w') as f:
    # insert data into publications table
    for publication in publications:
        # clone and remove title and ee fields and value from publication
        pub = publication.copy()
        pub.pop('author', None)
        pub.pop('ee', None)
        # replace author field with number field

        fields = ""
        values = ""
        for key, value in pub.items():
            if key == "author":
                continue
            if key == "ee":
                continue
            if key == "_id":
                key = "id"
                value = int(value)
            if key == "number":
                key = "num"
            if key == "title" and "#text" in value:
                value = value["#text"]
            else:
                value = value
            if isinstance(value, str):
                value = value.replace("'", '"')
            fields += key + ','
            values += (f"'{value}'" if isinstance(value,
                                                  str) else str(value)) + ','
        fields = fields[:-1]
        values = values[:-1]
        sql = f'INSERT INTO publications ({fields}) VALUES ({values});\n'
        f.write(sql)

    # insert data into authors table
    authors = []
    for publication in publications:
        if isinstance(publication['author'], list):
            for author in publication['author']:
                if author not in authors:
                    authors.append(author)
        else:
            if publication['author'] not in authors:
                authors.append(publication['author'])
    author_id = 1
    for author in authors:
        author = author.replace("'", '"')
        sql = f"INSERT INTO authors (id,name) VALUES ({author_id},'{author}');\n"
        f.write(sql)
        author_id += 1

    # insert data into ee table
    ee_id = 1
    for publication in publications:
        if 'ee' in publication:
            if isinstance(publication['ee'], list):
                for ee in publication['ee']:
                    sql = f"INSERT INTO ee (id, publication_id, url) VALUES ({ee_id}, {int(publication['_id'])},'{ee}');\n"
                    f.write(sql)
                    ee_id += 1
            else:
                sql = f"INSERT INTO ee (id, publication_id, url) VALUES ({ee_id}, {int(publication['_id'])},'{publication['ee']}');\n"
                f.write(sql)
                ee_id += 1

    # insert data into publication_authors table
    publication_authors_id = 1
    for publication in publications:
        if isinstance(publication['author'], list):
            for author in publication['author']:
                index = authors.index(author) + 1
                sql = f"INSERT INTO publication_authors (id, publication_id, author_id) VALUES ({publication_authors_id}, {int(publication['_id'])}, {index});\n"
                f.write(sql)
                publication_authors_id += 1
        else:
            author = publication['author']
            index = authors.index(author) + 1
            sql = f"INSERT INTO publication_authors (id, publication_id, author_id) VALUES ({publication_authors_id}, {int(publication['_id'])}, {index});\n"
            f.write(sql)
            publication_authors_id += 1


print("Done!")
