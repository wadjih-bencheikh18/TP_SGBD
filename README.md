## Comparaison

Les modèles de données NoSQL, Objet-Relationnel et Relationnel sont tous utilisés pour stocker et gérer les données, mais ils ont des différences importantes en termes de structure de données, de performance et d'utilisation.

NoSQL: Les bases de données NoSQL (Not Only SQL) sont conçues pour stocker des données non structurées ou semi-structurées, telles que les documents, les graphes et les données de série temporelle. Elles sont souvent utilisées pour les applications de grande échelle qui nécessitent une scalabilité horizontale et une flexibilité de schéma. Les bases de données NoSQL ne sont pas soumises aux contraintes de normalisation et de schéma des bases de données relationnelles.

Objet-Relationnel: Les bases de données Objet-Relationnelles (ORDBMS) combinent les avantages des bases de données relationnelles et des bases de données orientées objet. Elles permettent de stocker des données sous forme de objets et de les manipuler en utilisant les avantages de la programmation orientée objet. Les ORDBMS supportent la normalisation et les contraintes de clé étrangère, mais peuvent également stocker des données non structurées.

Relationnel: Les bases de données relationnelles sont les plus couramment utilisées pour stocker des données structurées organisées en tables. Elles utilisent des relations entre les tables pour organiser les données et permettent des requêtes SQL pour extraire des informations. Les bases de données relationnelles sont soumises à des contraintes de normalisation et de schéma pour garantir l'intégrité des données.

En résumé, le choix du modèle de données dépend des besoins de l'application en termes de performance, de flexibilité, de scalabilité et de sécurité.

Notons aussi qu'avec le SQL (relationnel et Objet relationnel) on peut exiger des contraintes pour vérifier l'unicité de l'ID, ainsi préservons la cohérence de la bdd.
à titre d'exemple, le fichier `Publis.json` contient deux publications avec le meme `ID = 1` (meme qu'il est de type string ou l'un est de valeur '1' et l'autre '01') le SQL permet de détecter cette erreur à l'insertion.
