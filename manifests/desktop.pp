node /desktop\d+\./ {
    package { 'squid-deb-proxy-client':     ensure => 'installed' }

    include 'ldap::client'
}
