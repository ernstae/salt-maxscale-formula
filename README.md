salt-maxscale-formula
====
Author: Andrew Ernst <ernstae@github.com>

Overview
--
This is a saltstack formula for installing and configuring MariaDB MaxScale

Warning
--
This is currently a work in progress and should not be employed in a production environment.

Supported Platforms
--
This formula has been tested with Debian and RedHat os_family distributions.  At the time of writing, MariaDB supports rhel variants `> 5.0` and Ubuntu `trusty` and `xenial`

If installing on RHEL variants, and specifying pillar value `maxscale:version_hold: True`, a necessary dependency `yum-plugin-versionlock` will be installed to ensure the package can be held at a specific version.  

Configuration
--
For more information on configuration options please review the documentation https://mariadb.com/kb/en/mariadb-enterprise/mariadb-maxscale-21-mariadb-maxscale-configuration-usage-scenarios/#monitor-modules

This formula accepts arbitrary pillar data and with the exception of reserved keywords:

```
  - settings
  - service
  - server
  - listener
  - filter
```


Testing
--
This formula uses Test Kitchen and kitchen-salt along with kitchen-docker as a driver.  Currently, this is tested against the following configurations:

* Ubuntu 14.04
* Ubuntu 16.04
* CentOS 7.3

To run the tests, ensure you have `Docker`, `test-kitchen`, `kitchen-salt`, `kitchen-docker` installed in your environment.  That is mostly accomplished by having Ruby installed and then running `gem install`

To perform testing, go to the root directory of this salt formula and run `kitchen test`