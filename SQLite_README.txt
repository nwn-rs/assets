===============================
SQLite support
===============================

This subsystem provides access to various sqlite databases that can be found
within the game.

Use of this subsystem requires at least basic knowledge of SQL.

The following databases can be accessed:
---------------------------------------

- Campaign: Access to all campaign databases is provided; however, the system
            will not let you write to the builtin tables used by the campaignDB
            system. (You can still read them, though no guarantee on data format
            stability is given.)
            This data is written to the database/ directory in the player's user
            home, so it persists even if the user quits the game without saving,
            or runs a different module.
- Module:   Each running module has a sqlite database attached to it, that
            gets persisted to savegames. This data is lost unless the player
            saves the game.
- Player:   Each player character has a database attached that gets saved
            to the character .bic file when saving to a vault (local/server),
            or exporting the character in singleplayer.
            It also gets saved to savegames.

The functions to run queries models after the sqlite C API.

Basics:
-------

Any query you run is encapsulated into a `sqlquery` type variable. This variable
can be obtained by "preparing a statement" against a specific database.
  -> SqlPrepareQueryObject(), SqlPrepareQueryCampaign()

Note: This example, and the following, assume the presented tables with appropriate
      columns exist. By default, none of the databases provided will have any DDL
      defined. You need to create all tables, views, triggers, etc. yourself.

Example:

  sqlquery myquery = SqlPrepareQueryObject(GetModule(),
                       "select data, y from vectors where x > @x and name = @name");

There are currently two functions to prepare queries (and thus gain access to a
database).
SqlPrepareQueryObject() can be called with GetModule() as the first parameter to
access the module database. It can also be called with a player character object,
to access the player-specific database. All other objects will error out, and no query
will be prepared.
SqlPrepareQueryCampaign() can be called with any valid campaign database name.

Once you have a prepared statement (that did not error out, which you can check via
 -> SqlGetError()), you can optionally bind parameters to it.
Parameter binding is the sane and modern way to inject variables into a query.
 -> SqlBindInt(), SqlBindString(), ..

REALLY IMPORTANT NOTE:
- Parameter binding ensures that no injection of unwanted content can happen, as
  the bound variables are properly escaped for you.
- Don't roll your own escape function.
- Always use binds, NEVER concatenate values directly into your SQL query.
  Especially not strings, and especially especially not user-supplied strings.

Example:

  SqlBindFloat(myquery, "@x", 5.0f);
  SqlBindString(myquery, "@name", GetName(oPlayer));

The name of the bound parameter is up to you, as long as it starts with @ or :
and is a simple identifier (no special characters).

Once you have bound all parameters, you can execute the query. This is done via
  -> SqlStep().
SqlStep() will return TRUE, as long as your query is returning rows for you to read.

Note: Even for queries you don't expect to return rows (for example, INSERT); you
      need to call SqlStep once to actually execute the query. In this case, SqlStep
      will return FALSE (since there is no row data).

Example:
  while (SqlStep(x))
  {
    SendMessageToPC(oPlayer, "Your data: " + SqlGetString(x, 0));
    SendMessageToPC(oPlayer, "Your y offset: " + FloatToString(SqlGetFloat(x, 0)));
  }

As you can see, you can get data out of your row result via -> SqlGet*().

Once you are done with your sqlquery, simply let it go out of scope (exit the function,
end the script, etc.). No further cleanup is necessary.

You CAN pass sqlqueries into other functions, and you can even pass them into closures -
DelayCommand(), AssignCommand(); but queries passed this way will NOT BE SAVED TO SAVEGAMES.
Any pending closures loaded from a savegame that reference a SQLQuery will fail.

For this reason, it is strongly discouraged for singleplayer modules to pass sqlquery
variables into DelayCommand().

Transactions:
-------------

You can use transactions in your code, but care needs to be taken to properly
finalise them; otherwise, your database connection might become stuck in an aborted
transaction. Specifically scripting/logic errors that result in "Too many instructions"
are a pitfall to be aware of.

Limitations:
------------

- Databases stored to the module savegame (accessed via SqlPrepareQueryObject(GetModule(), ...)
  should be kept to a reasonable size, as the data stored this way goes into the savegame.
  A few megabytes is fine; but storing hundreds is going to give you grief.

- Player-bound databases should be kept as minimal as possible, as the database is embedded
  into the player character file.

Custom SQLite functions:
------------------------

nwbufcompress(MAGIC, BINARY) -> BINARY
  Compresses the given BINARY into a NWCompressedBuf blob.
  You cannot emit this blob to NWScript, as it contains non-printable bytes; including nullbytes,
  which the NWScript-native string type cannot hold. You can, however, insert it into a table.
  MAGIC will be the magic header to write out. MAGIC needs to be a string of exactly 4 bytes.

nwbufdecompress(MAGIC,  BINARY) -> BINARY
  Decompresses the given BINARY out of a NWCompressedBuf blob.
  Will error out if MAGIC mismatches.  MAGIC needs to be a string of exactly 4 bytes.

base64encode(BINARY) -> STRING
  Encodes the given BINARY into a base64 string representation.
  Will return "" for empty payloads.

base64decode(STRING) -> BINARY
  decodes the given STRING base64 representation.
  Will return "" for empty payloads, and error out on decode failures.

sha1(BINARY) -> STRING
  Checksums the given BINARY into a sha1.
  Empty and NULL values are considered equivalent to "".

xxh32(BINARY) -> INT32
  Hashes BINARY with XXH32.
  Empty and NULL values are considered equivalent to "".

xxh64(BINARY) -> INT64
  Hashes BINARY with XXH64.
  Empty and NULL values are considered equivalent to "".
