Section A :
Relatioal databases support and are designed for schemas where tables follow a fixed strict structure. This creates a problem for our tables as different products have different attributes, ex: electronics products have specifications like RAM and processor whereas fashion has size and colour. Storing all these in a single table leads to many null values and increases the number of complex joins. Adding new product types would also require altering the table structure, which increases time and resources. Reviews naturally fit as nested data within products, but relational databases require separate tables and complex joins to retrieve them, which reduces performance and increases query complexity.
Hence relational systems struggle with schema flexibility, structural changes.




Section B:
Mongo DB is a document based NoSQL database that stores data in the form of key value pairs. It provides a flexible schema design, each product can be stored as a JSON document where different attributes can exist for different products, eg: Electronic products can have specification such as RAM and storage and fashion can have size and colour. It allows ebmedded documents which allows to store the customer reviews directly inside products documents. This reduces complex joins. It can store both semi-structured and unstrucutred data.





Section C: 
Mong DB offers flexibility but lacks constraints like foreign keys which might lead to inconsistency if not handled properly. It does not support complex joins as effectively as RDBMS. Managing and ensuring data integirty and maintaining multiple collections can be more complex compared to MySQL.

