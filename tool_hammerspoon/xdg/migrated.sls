# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as hammerspoon with context %}

include:
  - {{ tplroot }}.package


{%- for user in hammerspoon.users | rejectattr('xdg', 'sameas', false) %}

{%-   set user_default_conf = user.home | path_join(hammerspoon.lookup.paths.confdir) %}
{%-   set user_xdg_confdir = user.xdg.config | path_join(hammerspoon.lookup.paths.xdg_dirname) %}
{%-   set user_xdg_conffile = user_xdg_confdir | path_join(hammerspoon.lookup.paths.xdg_conffile) %}

# workaround for file.rename not supporting user/group/mode for makedirs
XDG_CONFIG_HOME exists for Hammerspoon for user '{{ user.name }}':
  file.directory:
    - name: {{ user.xdg.config }}
    - user: {{ user.name }}
    - group: {{ user.group }}
    - mode: '0700'
    - makedirs: true
    - onlyif:
      - test -e '{{ user_default_conf }}'

Existing Hammerspoon configuration is migrated for user '{{ user.name }}':
  file.rename:
    - name: {{ user_xdg_confdir }}
    - source: {{ user_default_conf }}
    - require:
      - XDG_CONFIG_HOME exists for Hammerspoon for user '{{ user.name }}'
    - require_in:
      - Hammerspoon setup is completed

Hammerspoon has its config file in XDG_CONFIG_HOME for user '{{ user.name }}':
  file.managed:
    - name: {{ user_xdg_conffile }}
    - user: {{ user.name }}
    - group: {{ user.group }}
    - replace: false
    - makedirs: true
    - mode: '0600'
    - dir_mode: '0700'
    - require:
      - Existing Hammerspoon configuration is migrated for user '{{ user.name }}'
    - require_in:
      - Hammerspoon setup is completed

Hammerspoon knows about XDG location for user '{{ user.name }}':
  macdefaults.write:
    - name: MJConfigFile
    - domain: org.hammerspoon.Hammerspoon
    - value: {{ user_xdg_conffile }}
    - vtype: string
    - user: {{ user.name }}
{%- endfor %}
