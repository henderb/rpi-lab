class ldap::client(
        String $ldap_base  = 'dc=ctmug,dc=net',
        String $ldap_uri   = 'ldap://rpi-server.ctmug.net',
    ){
    
    package { 'libpam-ldapd':   ensure => 'installed' }
    package { 'libnss-ldapd':   ensure => 'installed' }
    package { 'autofs-ldap':    ensure => 'installed' }

    file { '/etc/nsswitch.conf':
        ensure  => 'present',
        source  => 'puppet:///modules/ldap/nsswitch.conf',
        mode    => '0644',
        owner   => 'root',
        group   => 'root',
        require => Package['libpam-ldapd'],
    }

    file { '/etc/default/autofs':
        ensure  => 'present',
        content => template('ldap/autofs.erb'),
        mode    => '0644',
        owner   => 'root',
        group   => 'root',
        require => Package['autofs-ldap'],
    }

    file { '/etc/nslcd.conf':
        ensure  => 'present',
        content => template('ldap/nslcd.conf.erb'),
        mode    => '0640',
        owner   => 'root',
        group   => 'nslcd',
        require => Package['libnss-ldapd'],
    }

    file { '/etc/lightdm/lightdm.conf':
        ensure  => 'present',
        source  => 'puppet:///modules/ldap/lightdm.conf',
        mode    => '0644',
        owner   => 'root',
        group   => 'root',
    }
}
