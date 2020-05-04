local config = {}

function config.file_exists(file)
    local f = io.open(file, "rb")
    if f then 
        f:close() 
    end
    return f ~= nil
end

  function split(s, delimiter)
    result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter.."(.-)") do
        table.insert(result, match);
    end
    return result;
end

function config.loadConfig(file)
    if not config.file_exists(file) then
        return nil, "File".. file .." doesn't exist"
    end
    local conf = {}
    for line in io.lines(file) do 
        local s = split(line, "=")
        local isOk = false
        for k, v in pairs(s) do
            if v == "DB_PATH" then
                local n = next(s, k)
                if not config.file_exists(s[n]) then 
                    return nil, "SQlite DB file".. s[n] .." doesn't exist"
                end
                conf["DB_PATH"] = s[n]
                break
            elseif v == "API_HOST" then
                local n = next(s, k)
                conf["API_HOST"] = s[n]
                break
            elseif v == "API_PORT" then
                local n = next(s, k)
                conf["API_PORT"] = s[n]
                break
            elseif v == "API_TOKEN" then
                local n = next(s, k)
                conf["API_TOKEN"] = s[n]            
                break
            elseif v == "LOG_FILE" then
                local n = next(s, k)
                conf["LOG_FILE"] = s[n]            
                break
            elseif v == "CACHE_EXPIRATION" then
                local n = next(s, k)
                conf["CACHE_EXPIRATION"] = tonumber(s[n])
                break
            elseif v == "CACHE_SIZE" then
                local n = next(s, k)
                conf["CACHE_SIZE"] = tonumber(s[n])
                break
            else
                print("unsupported configuration '" .. v .. "'")
            end
        end
    end
    return conf, nil
end

return config