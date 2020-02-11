class desktop {
    file { '/etc/lightdm/pi-greeter.conf':
        ensure => 'present',
        source => 'puppet:///modules/desktop/pi-greeter.conf',
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
    }
}
