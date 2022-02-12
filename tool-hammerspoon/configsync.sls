{%- from 'tool-hammerspoon/map.jinja' import hammerspoon -%}

{%- for user in hammerspoon.users | selectattr('dotconfig', 'defined') | selectattr('dotconfig') | list %}
  {%- set dotconfig = user.dotconfig if dotconfig is mapping else {} %}

Hammerspoon configuration is synced for user '{{ user.name }}':
  file.recurse:
    - name: {{ user._hammerspoon.confdir }}
    - source:
      - salt://dotconfig/{{ user.name }}/hammerspoon
      - salt://dotconfig/hammerspoon
    - context:
        user: {{ user }}
    - template: jinja
    - user: {{ user.name }}
    - group: {{ user.group }}
  {%- if dotconfig.get('file_mode') %}
    - file_mode: '{{ dotconfig.file_mode }}'
  {%- endif %}
    - dir_mode: '{{ dotconfig.get('dir_mode', '0700') }}'
    - clean: {{ dotconfig.get('clean', False) | to_bool }}
    - makedirs: True
{%- endfor %}
