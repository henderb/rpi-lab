node /desktop\d+\./ {
    package { 'squid-deb-proxy-client':     ensure => 'installed' }


    package { 'libpam-ldapd':               ensure => 'installed' }
}
