class puppet_cron {
    include '::network'

    cron { 'puppet-apply':
        ensure  => 'present',
        user    => 'root',
        minute  => 0,
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
