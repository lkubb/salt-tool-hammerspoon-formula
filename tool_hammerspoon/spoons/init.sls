# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as hammerspoon with context %}

include:
  - {{ tplroot }}.package


{%- for user in hammerspoon.users | selectattr('hammerspoon.spoons', 'defined') | selectattr('hammerspoon.spoons') %}
{%-   set mode = 'latest' if user.hammerspoon.spoons.get('update_auto', false) else 'cloned' %}

Hammerspoon config directory exists for spoon cloning for user '{{ user.name }}':
  file.directory:
    - name: {{ user._hammerspoon.confdir }}
    - user: {{ user.name }}
    - group: {{ user.group }}
    - mode: '0700'
    - makedirs: true

{%-   if user.hammerspoon.spoons.get('absent') %}

Unwanted spoons are absent for user '{{ user.name }}':
  file.absent:
    - names:
{%-     for spoon in user.hammerspoon.spoons.absent %}
      - {{ user._hammerspoon.confdir | path_join(spoon) }}
{%-     endfor %}
{%-   endif %}

{%-   if user.hammerspoon.spoons.get('wanted') %}

Custom spoons are available for user '{{ user.name }}':
  git.{{ mode }}:
    - names:
{%-     for spoon in user.hammerspoon.spoons.wanted %}
{%-       set branch = spoon.values() | first if spoon is mapping else False %}
{%-       set spoon = spoon.keys() | first if spoon is mapping else spoon %}
{%-       set spoon_name = spoon.split('/') | last %}
        - {{ spoon }}:
            - target: {{ user._hammerspoon.confdir | path_join(spoon_name) }}
{%-       if branch %}
            - branch: {{ branch }}
{%-       endif %}
{%-     endfor %}
    - user: {{ user.name }}
{%-   endif %}
{%- endfor %}
