# Puppet module: memcached

This is a Puppet module for memcached.
It manages its installation, configuration and service. It allows to run several instances
independently of one another.

The blueprint of this module is from http://github.com/Example42-templates/

Released under the terms of 2-clause BSD license (see the License file for further details).


## USAGE - Basic management

* Install memcached with default settings (package installed, service started, default configuration files)

        class { 'memcached': }

* Set up an instance of Memcached for one specific user:

        class { 'memcached':
          disable_default => true,
        }

        memcached::instance { $user:
          user            => $user,
          group           => $user,
          socket_path     => "/var/run/memcached/${user}-projectname.sock"
        }

     By default this will add the specified user to the group $memcached::group. This can only
     be done if the specified user is defined using a virtual resource.
