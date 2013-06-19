class memcached (
  $package         = params_lookup('package'),
  $user            = params_lookup('user'),
  $group           = params_lookup('group'),
  $disable_default = params_lookup('disable_default'),
) inherits memcached::params {
  
  $bool_disable_default = any2bool($disable_default)

  package { $package: }

  file { '/etc/init.d/memcached':
    content => template('memcached/init.sh'),
    mode    => 0551,
    owner   => root,
    group   => root,
  }

  file { '/var/run/memcached':
    ensure => directory,
    owner  => $user,
    group  => $group,
    mode   => 1771,
  }

  group { $group:
    system => true,
  }

  user { $user:
    system  => true,
  }

  file { '/usr/share/memcached/scripts/start-memcached':
    content => template('memcached/startscript.sh'),
    mode    => 755,
  }

  if ($bool_disable_default == true) {
    file { '/etc/memcached.conf': 
      ensure => absent
    }
  }

}
