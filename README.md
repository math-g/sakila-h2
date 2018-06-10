## Sakila-H2

This is the database found at https://github.com/maxandersen/sakila-h2

Use for now with H2 1.4.196, as 197 has issues with foreign keys (got org.h2.jdbc.JdbcSQLException: Unique index or primary key violation - starting with foreign keys on FILM_ACTOR table).
See https://github.com/h2database/h2database/issues/1073

I also retrieved the script that was missing.

I use it for unit testing in different projects, and found that the setup was not explicit in the H2 docs so I share it here. Examples are in groovy.

`build.gradle` :
```
compile 'com.h2database:h2:1.4.196'
```

- **Server mode** :
Prefered mode when using the whole database as it has a quick startup.
Only absolute path is supported for `-baseDir` option.

```groovy
import org.h2.tools.Server

Server server = Server.createTcpServer("-ifExists", "-baseDir", "/path/to/folder/containing/.db/file").start()
Sql sql = Sql.newInstance( "jdbc:h2:tcp://localhost/./sakila", "sa", "", "org.h2.Driver")
```

- **Embedded mode** :
Slow setup and can use a lot of CPU when inserting all the data but could be useful when using only small samples
Assuming `src/test/resources` is in the classpath.

```groovy
import java.nio.file.Files
import java.nio.file.Paths

Sql sql = Sql.newInstance( "jdbc:h2:mem:sakila", "org.h2.Driver")
sql.execute(new String(Files.readAllBytes(Paths.get("src/test/resources/sakila-script.sql")), "UTF-8"))
```	

You can also use the database with the H2 Console, running `run_sakila-h2.sh` script (Windows 10 users should use the Ubuntu app, install java and cd to /mnt/c/path/to/db/file).
Go to http://localhost:8082
You can then for instance use the embedded mode, JDBC URL : jdbc:h2:./sakila, password : sa