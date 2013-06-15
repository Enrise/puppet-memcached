class memcached::params {
  
  $package = 'memcached'
  
  $conf_prefix     = '/etc/memcached-'
  $init_script     = '/etc/init.d/memcached'
  
  $group           = 'memcache'
  $user            = 'memcache'
  
  $disable_default = false

}