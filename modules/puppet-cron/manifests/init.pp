class puppet-cron {
    cron { 'puppet-apply':
        ensure  => 'present',
        user    => 'root',
        minute  => 60,
        command => '/usr/bin/puppet apply /etc/puppet/code --logdest syslog',
    }

    vcsrepo { '/etc/puppet/code':
        ensure   => 'present',
        provider => 'git',
        source   => 'https://github.com/henderb/rpi-lab.git',
        revision => 'master',
    }

    exec { 'puppet-apply':
	command     => '/usr/bin/puppet apply /etc/puppet/code --logdest syslog',
        refreshonly => true,
        user        => 'root',
        subscribe   => Vcsrepo['/etc/puppet/code'],
    }
}
