# lua-mod

> Lua module to allow ip (or not) from granola sqlite3 decision DB.

# Requirements

```
 apt-get install nginx
 apt-get install lua5.3
 apt-get install libnginx-mod-http-lua
 apt-get install lua-sql-sqlite3
 apt-get install lua-logging
```

# Install & Config


1. Deploy lua package to `/usr/local/lua/crowdsec/`
```
$ sudo make install
$ cat /usr/local/lua/crowdsec/crowdsec.conf
DB_PATH=/tmp/test.db
API_HOST=127.0.0.1
API_PORT=8080
API_TOKEN=
LOG_FILE=/tmp/lua_mod.log
CACHE_EXPIRATION=1
CACHE_SIZE=1000
$ cp .../test.db /tmp/test.db #an actual cs sqlite database
```

2. Load in nginx

`/etc/nginx/sites-enabled/default` :

```nginx
# in the `http{}` context, load cs connector
lua_package_path '/usr/local/lua/crowdsec/?.lua;;';
init_by_lua_block { require "CrowdSec".init("/usr/local/lua/crowdsec/crowdsec.conf") }
...
server {
...
    location / {
      # In the application, allow/block user
      access_by_lua_file /usr/local/lua/crowdsec/access.lua;
      ...
      try_files $uri $uri/ =404;
...
```

3 - Auto magic nginx deploiement

```
sudo make nginx
```

:warning: `nginx` folder should be placed in `/etc/nginx/`

# Test it

```
$ curl 127.0.0.1/asd
...404...
$ ./cwcli ban add --ip 127.0.0.1 --reason 'why not' --duration 1h
$ curl 127.0.0.1/asd
...403...
$ ./cwcli ban delete --target 127.0.0.1
$ curl 127.0.0.1/asd
...404...
```


## Configuration

The configuration allow for the moment only 1 entry:

```
DB_PATH=/tmp/cs.db  <-- Path to the sqlite DB created by granola
```
