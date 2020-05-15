# lua-mod

> Lua module to allow ip (or not) from granola sqlite3 decision DB.



# Install & Config

`git clone git clone https://github.com/crowdsecurity/cs-lua-lib.git`

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
 apt-get install lua-logging
```

### Deploy lua package to `/usr/local/lua/crowdsec/`
```
sudo make install
```

## Configuration

The configuration allow for the moment only 4 entry:

```
DB_PATH=/var/lib/crowdsec/data/crowdwatch.db  <-- Path to the sqlite DB created by crowdsec
LOG_FILE=/tmp/lua_mod.log                     <-- path to log file
CACHE_EXPIRATION=1                            <-- in seconds
CACHE_SIZE=1000                               <-- cache size
```
