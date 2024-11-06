# vim: ft=sls

{#-
    Removes Hammerspoon XDG compatibility crutches for all managed users.
#}

{%- set tplroot = tpldir.split("/")[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as hammerspoon with context %}


{%- for user in hammerspoon.users | rejectattr("xdg", "sameas", false) %}

{%-   set user_default_conf = user.home | path_join(hammerspoon.lookup.paths.confdir) %}
{%-   set user_xdg_confdir = user.xdg.config | path_join(hammerspoon.lookup.paths.xdg_dirname) %}

Hammerspoon configuration is cluttering $HOME for user '{{ user.name }}':
  file.rename:
    - name: {{ user_default_conf }}
    - source: {{ user_xdg_confdir }}

Hammerspoon is ignorant about XDG location for user '{{ user.name }}':
  macdefaults.absent:
    - name: MJConfigFile
    - domain: org.hammerspoon.Hammerspoon
    - user: {{ user.name }}
{%- endfor %}
