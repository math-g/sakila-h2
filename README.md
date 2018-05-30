#Sakila-H2

This is the database found at [https://github.com/maxandersen/sakila-h2]
for which I retrieved the script that was missing.

I use it in unit tests and found that the setup was not explicit in the H2 docs so I share it here. Examples are in groovy.

- **Server mode** :
Prefered mode when using the whole database as it has a quick startup 

```groovy
Server server = Server.createTcpServer("-ifExists", "-baseDir", "/path/to/folder/containing/db/file").start()
Sql sql = Sql.newInstance( "jdbc:h2:tcp://localhost/sakila", "sa", "", "org.h2.Driver")
```

- **Embedded mode** :
Slow setup and can use a lot of CPU when inserting all the data but could be useful when using only small samples

```groovy
Sql sql = Sql.newInstance( "jdbc:h2:mem:sakila", "org.h2.Driver")
sql.execute(new String(Files.readAllBytes(Paths.get("src/test/resources/sakila-script.sql")), "UTF-8"))
```		