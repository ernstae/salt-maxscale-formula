{% from "maxscale/map.jinja" import maxscale as maxscale with context %}

mariadb_repo:
  pkgrepo.managed:
    - humanname: MariaDB Repository
    - name: "{{ maxscale.repo_url|replace("[[osfullname]]",salt['grains.get']('osfullname', 'ubuntu')|lower)|replace("[[oscodename]]", salt['grains.get']('oscodename', trusty)) }}"
    - file: /etc/apt/sources.list.d/mariadb.list
    - gpgkey: C74CD1D8
