{%- from 'tool-hammerspoon/map.jinja' import hammerspoon -%}

{%- for user in hammerspoon.users | selectattr('dotconfig', 'defined') | selectattr('dotconfig') | list %}

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
    - file_mode: keep
    - dir_mode: '0700'
    - makedirs: True
{%- endfor %}
