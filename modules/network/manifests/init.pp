class network {
    file { '/etc/hostname':
        ensure  => 'present',
        content => "${::fqdn}",
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
    }
}
