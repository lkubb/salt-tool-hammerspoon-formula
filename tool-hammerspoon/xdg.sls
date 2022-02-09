{%- from 'tool-hammerspoon/map.jinja' import hammerspoon -%}

include:
  - .package

{%- for user in hammerspoon.users | rejectattr('xdg', 'sameas', False) | list %}

Existing Hammerspoon configuration is migrated for user '{{ user.name }}':
  file.rename:
    - name: {{ user.xdg.config }}/hammerspoon
    - source: {{ user.home }}/.hammerspoon
    - onlyif:
      - test -e {{ user.home }}/.hammerspoon
    - makedirs: true
    - require_in:
      - Hammerspoon setup is completed

Hammerspoon has its config file in XDG_CONFIG_HOME for user '{{ user.name }}':
  file.managed:
    - name: {{ user.xdg.config }}/hammerspoon/init.lua
    - user: {{ user.name }}
    - group: {{ user.group }}
    - replace: False
    - makedirs: True
    - mode: '0600'
    - dir_mode: '0700'
    - require_in:
      - Hammerspoon setup is completed

Hammerspoon uses XDG dirs:
  macosdefaults.write:
    - name: MJConfigFile
    - domain: org.hammerspoon.Hammerspoon
    - value: {{ user.xdg.config }}/hammerspoon/init.lua
    - vtype: string
    - user: {{ user.name }}
{%- endfor %}
