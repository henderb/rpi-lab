node 'rpi-server.ctmug.net' {
    include 'apt_cache_ng::client'
    include 'ldap::client'
}
