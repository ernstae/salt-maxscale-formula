salt-maxscale-formula
====
Author: Andrew Ernst <ernstae@github.com>

Overview
--
This is a saltstack formula for installing and configuring MariaDB MaxScale

Warning
--
This is currently a work in progress and should not be employed in a production environment.

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