import json

# read json file
with open('Publis.json', 'r') as f:
    publications = json.load(f)


with open('Publis.sql', 'w') as f:
    # generate sql insert statements
    for publication in publications:
        fields = ', '.join(
            [f'"{key if key!="_id" else "id"}"' for key in publication.keys()])
        values = ', '.join([f'"{value}"' if isinstance(
            value, str) else str(value) for value in publication.values()])
        sql = f'INSERT INTO PUBLICATIONS ({fields}) VALUES ({values});'
        f.write(sql + "\n")

print("SQL statements written to Publis.sql")
