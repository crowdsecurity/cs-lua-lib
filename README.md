# lua-mod

> Lua module to allow ip (or not) from granola sqlite3 decision DB.



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

The configuration allow for the moment only 4 entry:

```
DB_PATH=/var/lib/crowdsec/data/crowdwatch.db  <-- Path to the sqlite DB created by crowdsec
LOG_FILE=/tmp/lua_mod.log                     <-- path to log file
CACHE_EXPIRATION=1                            <-- in seconds
CACHE_SIZE=1000                               <-- cache size
```
