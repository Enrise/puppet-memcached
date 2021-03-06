define memcached::instance (
  $socket_path     = undef,
  $user            = 'root',
  $group           = 'root',
  $template_config = 'memcached/instance-config.conf',
  $log_path        = '/var/log/memcached.log',
  $configure_user  = true,
) {

  $bool_configure_user = true

  include memcached

  file { "${::memcached::conf_prefix}${name}.conf":
    ensure   => file,
    content => template($template_config),
    notify  => Service["memcached-${name}"],
  }

  file { "${::memcached::init_script}-${name}":
    ensure   => link,
    target   => $memcached::init_script,
    before   => Service ["memcached-${name}"]
  }

  service { "memcached-${name}":
    hasstatus => true,
    ensure    => running,
  }

  if ($bool_configure_user == true) {
    # Make sure the user is member of the memcached group
    User <| title == $user |> { groups +> $::memcached::group }
    realize User[$user]
    Group[$::memcached::group] -> User[$user]
  }
}
