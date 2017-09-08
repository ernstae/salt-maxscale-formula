{% from "maxscale/map.jinja" import maxscale as maxscale with context %}

maxscale_config_file:
  file.managed:
    - name: "{{ maxscale.etcdir }}/maxscale.cnf"
    - source: salt://maxscale/templates/maxscale.cnf.jinja
    - template: jinja
    - user: root
    - mode: 644
    - watch_in:
      - service: maxscale_service
    - require:
      - pkg: maxscale