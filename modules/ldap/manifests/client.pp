class ldap::client {
    
    package { 'libpam-ldapd':   ensure => 'installed' }

    file { '/etc/nsswitch.conf':
        ensure  => 'present',
        source  => 'puppet:///modules/ldap/nsswitch.conf',
        mode    => '0644',
        owner   => 'root',
        group   => 'root',
    }
}
