# lua-mod

> Lua module to allow ip (or not) from crowdsec decision DB.



# Install & Config

`git clone https://github.com/crowdsecurity/cs-lua-lib.git`

## Install script

```
sudo ./install.sh
```
:warning: the installation script works only on Debian/Ubuntu

## From source

### Requirements

```
 apt-get install lua5.3
 apt-get install lua-sql-sqlite3
 apt-get install lua-sql-mysql
 apt-get install lua-sql-odbc
 apt-get install lua-logging
```

### With make
```
sudo make install
```

### Manually

- Create folder `/usr/local/lua/crowdsec/`:
```
mkdir -p /usr/local/lua/crowdsec/
```

- Copy the `cs-lua-lib/lib/*.lua` into `/usr/local/lua/crowdsec/`:
```
cp ./cs-lua-lib/lib/*.lua /usr/local/lua/crowdsec
```

- Copy the `cs-lua-lib/template.conf` into `/usr/local/lua/crowdsec/crowdsec.conf`:
```
cp ./cs-lua-lib/template.conf /usr/local/lua/crowdsec/crowdsec.conf
```

## Configuration
### supported databases
* sqlite3
* mysql

The configuration params:

```
TYPE=sqlite3                                  <-- supported SGBDR (sqlite3, mysql)
DB_PATH=/var/lib/crowdsec/data/crowdsec.db    <-- the database path (for sqlite3)
DB_NAME=crowdsec                              <-- the database name (for mysql)
DB_HOST=                                      <-- db hostname (for mysql)
DB_PORT=                                      <-- db port (for mysql)
DB_USERNAME=                                  <-- username (for mysql)
DB_PASSWORD=                                  <-- password (for mysql)
API_HOST=127.0.0.1                            <-- 
API_PORT=8080                                 <-- 
API_TOKEN=                                    <-- 
LOG_FILE=/tmp/lua_mod.log                     <-- path to log file
CACHE_EXPIRATION=1                            <-- in seconds
CACHE_SIZE=1000                               <-- cache size
```
