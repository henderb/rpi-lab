node /desktop\d+\./ {
    include 'apt-cache-ng::client'
    include 'ldap::client'
}
