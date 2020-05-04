cs = require "lib.CrowdSec"

configFile = "./tests/crowdsec.conf"

-- INIT CONF
ok, err = cs.init(configFile)
if ok == nil then
    print(err)
    os.exit()
end
-- END CONF INIT

-- TEST
ok, err = cs.allowIp("80.236.16.6")
if ok == nil then
    print(err)
    os.exit()
end
if ok then
    print("80.236.16.6 is allowed")
else
    print("80.236.16.6 is not allowed")
end

-- TEST
ok, err = cs.allowIp("80.236.16.6")
if ok == nil then
    print(err)
    os.exit()
end
if ok then
    print("80.236.16.6 is allowed")
else
    print("80.236.16.6 is not allowed")
end

-- TEST
ok, err = cs.allowIp("80.236.16.6")
if ok == nil then
    print(err)
    os.exit()
end
if ok then
    print("80.236.16.6 is allowed")
else
    print("80.236.16.6 is not allowed")
end


ok, err = cs.allowIp("127.0.0.1")
if ok == nil then
    print(err)
    os.exit()
end
if ok then
    print("127.0.0.1 is allowed")
else
    print("127.0.0.1 is not allowed")
end

ok, err = cs.allowIp("127.0.0.1")
if ok == nil then
    print(err)
    os.exit()
end
if ok then
    print("127.0.0.1 is allowed")
else
    print("127.0.0.1 is not allowed")
end
ok, err = cs.allowIp("127.0.0.1")
if ok == nil then
    print(err)
    os.exit()
end
if ok then
    print("127.0.0.1 is allowed")
else
    print("127.0.0.1 is not allowed")
end

-- TEST END

cs.close()