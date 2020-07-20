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
print("# TEST 1 - Test 1.2.3.4 IP (should be blocked)")
ok, err = cs.allowIp("1.2.3.4")
if ok == nil then
    print(err)
    os.exit()
end
if ok then
    print("[-] FAILING TEST #1")
    print("[-] IP 1.2.3.4 should be blocked.")
    os.exit(1)
end
print("# TEST 1 OK")

-- TEST
print("# TEST 2 - Test 1.2.3.5 IP (simulation mode, should not blocked)")
ok, err = cs.allowIp("80.236.16.6")
if ok == nil then
    print(err)
    os.exit()
end
if not ok then
    print("[-] FAILING TEST #2")
    print("[-] IP 1.2.3.4 should not be blocked.")
    os.exit(1)
end
print("# TEST 2 OK")

-- TEST
print("# TEST 3 - Test 1.2.3.6 IP (should not be blocked)")
ok, err = cs.allowIp("80.236.16.6")
if ok == nil then
    print(err)
    os.exit()
end
if not ok then
    print("[-] FAILING TEST #3")
    print("[-] IP 1.2.3.4 should not be blocked.")
    os.exit(1)
end
print("# TEST 3 OK")


-- TEST END

cs.close()

print("ALL TEST ARE OK")