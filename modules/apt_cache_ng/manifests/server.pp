class apt_cache_ng::server {
    package { 'apt-cacher-ng':  ensure => 'installed' }
    package { 'avahi-daemon':   ensure => 'installed' }
}
