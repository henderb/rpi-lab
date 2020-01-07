class apt_cache_ng::server {
    package { 'apt-cacher-ng':  ensure => 'installed' }
    package { 'avahi-daemon':   ensure => 'installed' }

    service { 'apt-cacher-ng':
        ensure  => 'running',
        enable  => true,
        require => Package['apt-cacher-ng'],
    }
}
