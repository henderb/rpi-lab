class network {
    file { '/etc/hostname':
        ensure  => 'present',
        content => "${::fqdn}",
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
    }

    file { '/etc/hosts':
        ensure  => 'present',
        content => template('network/hosts.erb'),
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
    }
}
