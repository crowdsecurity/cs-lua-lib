package.path = package.path .. ";./lib/?.lua"

local driver = require "luasql.sqlite3"
local config = require "config"
local lrucache = require "lrucache"
local logging = require "logging"
local log_file = require "logging.file"

-- contain runtime = {}
local runtime = {}


function ipToInt( str )
	local num = 0
	if str and type(str)=="string" then
		local o1,o2,o3,o4 = str:match("(%d+)%.(%d+)%.(%d+)%.(%d+)" )
		num = 2^24*o1 + 2^16*o2 + 2^8*o3 + o4
	end
    return num
end


local csmod = {}

-- init function
function csmod.init(configFile)
  local conf, err = config.loadConfig(configFile)
  if conf == nil then
    return nil, err
  end
  runtime.conf = conf
  runtime.env = driver.sqlite3()
  runtime.db = runtime.env:connect(conf["DB_PATH"])

  local logger = log_file(conf["LOG_FILE"])
  runtime.logger = logger

  local c, err = lrucache.new(conf["CACHE_SIZE"])
  if not c then
    error("failed to create the cache: " .. (err or "unknown"))
  end
  runtime.cache = c
  return true, nil
end


function csmod.allowIp(ip)
  if runtime.conf == nil then
    return nil, "Configuration is bad, cannot run properly"
  end
  local resp = runtime.cache:get(ip)
  if resp == nil then
    runtime.logger:debug("'" .. ip .. "' not in cache")
    local ip_int = ipToInt(ip)
    local sqlQuery = "SELECT ip_text from ban_applications WHERE deleted_at is NULL AND strftime('%s', until) >= strftime('%s', 'now') AND start_ip >= '" .. ip_int .. "' AND end_ip <= '" .. ip_int .. "'"
    runtime.logger:debug(" query " .. sqlQuery)
    local results = runtime.db:execute(sqlQuery)
    local ok = results:fetch()
    results:close()
    if ok == nil then
      runtime.logger:debug("'" .. ip .. "' = " .. ip_int .. " -> no results")
      runtime.cache:set(ip, true,runtime.conf["CACHE_EXPIRATION"])
      return true, nil
    else
      runtime.logger:debug("'" .. ip .. "' = " .. ip_int .. " -> found entry !")
      runtime.cache:set(ip, false,runtime.conf["CACHE_EXPIRATION"])
      return false, nil
    end
  end
  runtime.logger:debug("'" .. ip .. "' is in cache")
  return resp == true, nil

end


-- Use it if you are able to close at shuttime
function csmod.close()
  runtime.db:close()
  runtime.env:close()
end

return csmod