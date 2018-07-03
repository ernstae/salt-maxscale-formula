## salt-maxscale-formula 
[![Build Status](https://travis-ci.org/ernstae/salt-maxscale-formula.svg?branch=master)](https://travis-ci.org/ernstae/salt-maxscale-formula) 
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Fernstae%2Fsalt-maxscale-formula.svg?type=shield)](https://app.fossa.io/projects/git%2Bgithub.com%2Fernstae%2Fsalt-maxscale-formula?ref=badge_shield)

Maintainer: Andrew Ernst <ernstae@github.com>

Overview
--
This is a saltstack formula for installing and configuring MariaDB MaxScale


Supported Platforms
--
This formula has been tested with Debian and RedHat os_family distributions.  At the time of writing, MariaDB supports rhel variants `> 5.0` and Ubuntu `trusty` and `xenial`

If installing on RHEL variants, and specifying pillar value `maxscale:version_hold: True`, a necessary dependency `yum-plugin-versionlock` will be installed to ensure the package can be held at a specific version.  

Configuration
--
For more information on configuration options please review the documentation https://mariadb.com/kb/en/mariadb-enterprise/mariadb-maxscale-21-mariadb-maxscale-configuration-usage-scenarios/#monitor-modules

This formula accepts arbitrary pillar data and with the exception of reserved keywords:

```
  - config
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


Example Pillar Data
--
The following pillar data is a large example of all the available options as of MaxScale 2.1.  

The pillar named `maxscale.config` is translated in the maxscale.cnf file as the `[maxscale]` section.  The other `server`, `service`, `listener`, `filter` sections are interpolated in the configuration file with the name of the dictionary map entry for the section.

For instance, pillar data as follows:
```
maxscale:
  config:
    threads: 2
  service:
    Demo Service:
      type: service
      servers:
        - server1
  server:
    server1:
      address: 1.1.1.1
      port: 3306
```
results in a maxscale.cnf file with the following contents:
```
[maxscale]
threads=2

[Demo Service]
type=service
servers=server1

[server1]
address=1.1.1.1
port=3306
```

A more complete pillar example is as follows:
```
maxscale:
  version_hold: true
  config:
    threads: auto
    auth_connect_timeout: 10
    auth_read_timeout: 10
    auto_write_timeout: 10
    ms_timestamp: 0
    skip_permission_checks: true
    syslog: 1
    maxlog: 1
    log_to_shm: 0
    log_warning: 0
    log_notice: 0
    log_info: 1
    log_debug: 0
    log_augmentation: 0
    log_throttling: "10, 1000, 10000"
    logdir: /var/log/maxscale
    datadir: /var/lib/maxscale/data
    libdir: /var/lib/maxscale/lib
    piddir: /var/run
    execdir: /usr/bin
    connector_plugindir: /usr/lib/plugin
    persistdir: /var/lib/maxscale/maxscale.cnf.d
    query_classifier: qc_sqlite
    query_classifier_args: "log_unrecognized_statements=1"
  service:
    Test Service:
      type: service
      router: readconnroute
      router_options: slave
      filters:
        - counter
        - QLA
      servers:
        - server1
        - server2
        - server3
      user: maxscale
      passwd: Mhu87p2D
      enable_root_user: false
      localhost_match_wildcard_host: 0
      version_string: 5.5.37-MariaDB-RWsplit
      weightby: serv_weight
      auth_all_servers: true
      strip_db_esc: true
      retry_on_failure: true
      lo_auth_warnings: true
      connection_timeout: 300
      max_connections: 100
  server:
    server1:
      address: 127.0.0.1
      port: 3066
      protocol: MySQLBackend
      monitoruser: mymonitoruser
      monitorpw: mymonitorpassword
      persistpoolmax: 0
      persistmaxtime: 300
      serv_weight: 1
      ssl: required
      ssl_version: TLSv10
      ssl_cert: /etc/pki/mariadb/maxscale/ssl/crt.pem
      ssl_key: /etc/pki/mariadb/maxscale/ssl/key.pem
      ssl_ca_cert: /etc/pki/mariadb/maxscale/ssl/crt.ca.pem
    server2:
      address: 127.0.1.1
      port: 3306
      protocol: MySQLBackend
      serv_weight: 1
  listener:
    type: listener
    service: Test Service
    protocol: MySQLClient
    address: 192.168.0.1
    port: 3306
    socket: /var/run/maxscale.socket
    authenticator: MySQL
    ssl: required
    ssl_version: TLSv10
    ssl_cert: /etc/pki/mariadb/maxscale/ssl/crt.pem
    ssl_key: /etc/pki/mariadb/maxscale/ssl/key.pem
    ssl_ca_cert: /etc/pki/mariadb/maxscale/ssl/crt.ca.pem
    ssl_cert_verify_depth: 9
  filter:
    MyLogFilter:
      type: filter
      module: qlafilter
    topfilter:
      type: filter
      module: topfilter

```


## License
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Fernstae%2Fsalt-maxscale-formula.svg?type=large)](https://app.fossa.io/projects/git%2Bgithub.com%2Fernstae%2Fsalt-maxscale-formula?ref=badge_large)