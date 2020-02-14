class puppet_cron {
    include '::network'

    cron { 'puppet-apply':
        ensure  => 'present',
        user    => 'root',
        minute  => 0,
        command => '/bin/bash -c \'date -u; /bin/sleep ${RANDOM:0:3}s; date -u; cd /etc/puppet/code; git pull; /usr/bin/puppet apply /etc/puppet/code\' > /root/puppet.log',
	require => Vcsrepo['/etc/puppet/code'],
    }

    vcsrepo { '/etc/puppet/code':
        ensure   => 'present',
        provider => 'git',
        source   => 'https://github.com/henderb/rpi-lab.git',
        revision => 'master',
    }
}
