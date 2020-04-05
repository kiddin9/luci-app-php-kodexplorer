m = Map("phpkod", translate("PHP && KodExplorer"), translate(
            "KodExplorer is a fast and efficient private cloud and online document management system that provides secure, controllable, easy-to-use and highly customizable private cloud products for personal websites, enterprise private cloud deployment, network storage, online document management, and online office. With Windows style interface and operation habits, it can be used quickly without adaptation. It supports online preview of hundreds of common file formats and is extensible and easy to customize."))
m:append(Template("phpkod/status"))

s = m:section(TypedSection, "phpkod", translate("Global Settings"))
s.anonymous = true
s.addremove = false

o = s:option(Flag, "enable", translate("Enable PHP"))
o.rmempty = false

o = s:option(Value, "port", translate("KodExplorer Port"))
o.datatype = "port"
o.placeholder = "8081"
o.default = "8081"
o.rmempty = false

o = s:option(Value, "kodomain", translate("KodExplorer Bind Domain"))
o.placeholder = "kod.xx.com"
o.rmempty = true

o = s:option(Value, "memory_limit", translate("Maximum memory usage"),
             translate(
                 "If your device has a lot of memory, you can increase it."))
o.default = "100M"
o.rmempty = false

o = s:option(Value, "upload_max_filesize",
             translate("Maximum size for uploading files"))
o.default = "200M"
o.rmempty = false

o = s:option(Value, "storage_device_path", translate("Storage device path"),
             translate(
                 "It is recommended to insert a usb flash drive or hard disk and enter the path. For example, /mnt/sda1/"))
o.default = "/mnt/sda1/"
o.placeholder = "/mnt/sda1/"
o.rmempty = false

s:append(Template("phpkod/version"))

return m
