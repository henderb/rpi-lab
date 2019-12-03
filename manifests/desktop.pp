node /desktop\d+\./ {
    include 'apt_cache_ng::client'
    include 'ldap::client'
}
