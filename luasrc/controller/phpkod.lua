-- Copyright 2018-2020 Lienol <lawlienol@gmail.com>
module("luci.controller.phpkod", package.seeall)

local http = require "luci.http"
local uci=require"luci.model.uci".cursor()
function index()
    if not nixio.fs.access("/etc/config/phpkod") then return end
    entry({"admin", "nas"}, firstchild(), "NAS", 45).dependent = false
    entry({"admin", "nas", "phpkod"}, cbi("phpkod"), _("PHP-KodExplorer"), 1)
    entry({"admin", "nas", "phpkod", "status"}, call("get_pid")).leaf = true
    entry( {"admin", "nas", "phpkod", "startstop"}, post("startstop") ).leaf = true
end

function get_pid(from_lua)
	local php_stat = luci.sys.call("pgrep php-fpm >/dev/null")==0
    local nginx_stat = luci.sys.call("pgrep nginx >/dev/null")==0
	local status = {
		php_stat = php_stat,
		nginx_stat = nginx_stat,
		kodport=uci:get("phpkod","main","port"),
		kodomain=uci:get("phpkod","main","kodomain")
	}
	if from_lua then
		return php_stat
	else
		luci.http.prepare_content("application/json")
		luci.http.write_json(status)	
	end
end

-- called by XHR.get from detail_startstop.htm
function startstop()
	local pid = get_pid(true)
	if pid then
		luci.sys.call("/etc/init.d/php7-fpm stop")
	else
		luci.sys.call("/etc/init.d/php7-fpm start")
	end
	luci.http.write(tostring(pid))	-- HTTP needs string not number
end
