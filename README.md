#Sakila-H2

This is the database found at https://github.com/maxandersen/sakila-h2
for which I retrieved the script that was missing.

I use it in unit tests and found that the setup was not explicit in the H2 docs so I share it here. Examples are in groovy.

- **Server mode** :
Prefered mode when using the whole database as it has a quick startup.
Only absolute path is supported for `-baseDir` option.

```groovy
import org.h2.tools.Server

Server server = Server.createTcpServer("-ifExists", "-baseDir", "/path/to/folder/containing/.db/file").start()
Sql sql = Sql.newInstance( "jdbc:h2:tcp://localhost/sakila", "sa", "", "org.h2.Driver")
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