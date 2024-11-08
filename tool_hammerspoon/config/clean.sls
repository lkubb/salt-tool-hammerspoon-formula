# vim: ft=sls

{#-
    Removes the configuration of the Hammerspoon package.
#}

{%- set tplroot = tpldir.split("/")[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as hammerspoon with context %}


{%- for user in hammerspoon.users %}

Hammerspoon config file is cleaned for user '{{ user.name }}':
  file.absent:
    - name: {{ user["_hammerspoon"].conffile }}

{%-   if user.xdg %}

Hammerspoon config dir is absent for user '{{ user.name }}':
  file.absent:
    - name: {{ user["_hammerspoon"].confdir }}
{%-   endif %}
{%- endfor %}
