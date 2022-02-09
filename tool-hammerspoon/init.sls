{%- from 'tool-hammerspoon/map.jinja' import hammerspoon -%}

include:
  - .package
{%- if hammerspoon.users | rejectattr('xdg', 'sameas', False) | list %}
  - .xdg
{%- endif %}
  - .cli
{%- if hammerspoon.users | selectattr('dotconfig', 'defined') | selectattr('dotconfig') | list %}
  - .configsync
{%- endif %}
