{%- from "maxscale/map.jinja" import maxscale as maxscale with context %}
{%- set os_family = salt['grains.get']('os_family', 'Debian') %}

mariadb_repo:
  pkgrepo.managed:
{%- if os_family == 'Debian' %}
    - humanname: MariaDB Repository
    - name: "{{ maxscale.repo_url|replace("[[osfullname]]",salt['grains.get']('osfullname', 'ubuntu')|lower)|replace("[[oscodename]]", salt['grains.get']('oscodename', trusty)) }}"
    - file: /etc/apt/sources.list.d/mariadb.list
    - gpgkey: C74CD1D8
{%- elif os_family == 'RedHat' %}
    - humanname: {{ maxscale.humanname }}
    - baseurl: {{ maxscale.baseurl }}
    - name: {{ maxscale.name }}
    - enabled: True
{%- endif %}

mariadb_pkg:
  pkg.installed:
    - name: {{ maxscale.pkgname }}
    - require:
      pkgrepo: mariadb_repo
