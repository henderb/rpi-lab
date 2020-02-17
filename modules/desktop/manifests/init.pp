class desktop {
    file { '/etc/lightdm/pi-greeter.conf':
        ensure => 'present',
        source => 'puppet:///modules/desktop/pi-greeter.conf',
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
    }

    file { '/etc/chromium-browser/policies/recommended/master_preferences':
        ensure => 'present',
        source => 'puppet:///modules/desktop/master_preferences',
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
    }

    cron { 'autofs-bandaid':
        ensure  => 'present',
        user    => 'root',
        special => 'reboot',
        command => '/bin/bash -c \'/bin/sleep 2m; /bin/systemctl restart autofs\'',
	require => Vcsrepo['/etc/puppet/code'],
    }

}
