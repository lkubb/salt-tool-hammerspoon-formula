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
{%- if hammerspoon.users | selectattr('hammerspoon.spoons', 'defined') | selectattr('hammerspoon.spoons') | list %}
  - .spoons
{%- endif %}
