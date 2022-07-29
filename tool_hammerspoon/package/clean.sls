# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_clean = tplroot ~ '.config.clean' %}
{%- set sls_cli_clean = slsdotpath ~ '.cli.clean' %}
{%- from tplroot ~ "/map.jinja" import mapdata as hammerspoon with context %}

include:
  - {{ sls_config_clean }}
  - {{ sls_cli_clean }}


Hammerspoon is removed:
  pkg.removed:
    - name: {{ hammerspoon.lookup.pkg.name }}
    - require:
      - sls: {{ sls_config_clean }}
      - sls: {{ sls_cli_clean }}
