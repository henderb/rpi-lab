class time {

    package { 'openntpd': ensure => 'installed', }

    file { '/etc/openntpd/ntpd.conf':
        ensure  => 'present',
        source  => 'puppet:///modules/time/ntpd.conf',
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        notify  => Service['openntpd'],
        require => Package['openntpd'],
    }

    service { 'openntpd':
        ensure => 'running',
        enable => true,
    }

    file { '/etc/timezone':
        ensure  => 'present',
        content => 'Africa/Kampala',
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
    }

    
}
