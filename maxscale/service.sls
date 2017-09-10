{% from "maxscale/map.jinja" import maxscale as maxscale with context %}

include:
  - maxscale.install
  - maxscale.config

maxscale.service:
  service.running:
    - name: maxscale
    - enable: True
    - reload: False
    - require:
      - sls: maxscale.install
      - sls: maxscale.config
    - watch:
      - pkg: {{ maxscale.pkgname }}
      - file: maxscale_config_file