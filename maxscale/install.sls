{%- from "maxscale/map.jinja" import maxscale as maxscale with context %}
{%- set os_family = salt['grains.get']('os_family', 'Debian') %}

mariadb_repo:
  pkgrepo.managed:
{%- if os_family == 'Debian' %}
    - humanname: MariaDB Repository
    - name: "{{ maxscale.repo_url|replace("[[osfullname]]",salt['grains.get']('osfullname', 'ubuntu')|lower)|replace("[[oscodename]]", salt['grains.get']('oscodename', trusty)) }}"
    - file: /etc/apt/sources.list.d/mariadb.list
    - keyid: 1BB943DB
    - keyserver: keyserver.ubuntu.com
{%- elif os_family == 'RedHat' %}
    - humanname: {{ maxscale.humanname }}
    - baseurl: {{ maxscale.baseurl }}
    - name: {{ maxscale.name }}
    - enabled: True
    - gpgkey: {{ maxscale.gpg_key }}
{%- endif %}
    - require_in:
      - pkg: maxscale.pkg

# install yum-plugin-versionlock on RHEL if maxscale.version_hold: True
{%- if (os_family == 'RedHat') and (maxscale.get('version_hold', False)) %}
{%- set version_hold = True %}
maxscale_extra_pkg:
  pkg.installed:
    - pkgs:
      - yum-plugin-versionlock
{%- endif %}

maxscale.pkg:
  pkg.installed:
    - name: {{ maxscale.pkgname }}
{%- if version_hold %}
    - hold: {{True}}
{%- endif %}