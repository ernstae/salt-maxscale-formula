{% from "maxscale/map.jinja" import maxscale as maxscale with context %}

mariadb_repo:
  pkgrepo.managed:
    - humanname: MariaDB Repository
    - name: "deb http://downloads.mariadb.com/MaxScale/2.1/ubuntu {{ salt['grains.get'](')}} main"
    - file: /etc/apt/sources.list.d/mariadb.list
