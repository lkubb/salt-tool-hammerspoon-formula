{%- from 'tool-hammerspoon/map.jinja' import hammerspoon -%}

{%- set mode = 'latest' if hammerspoon.get('update_auto', True) else 'cloned' %}

{%- for user in hammerspoon.users | selectattr('hammerspoon.spoons', 'defined') | selectattr('hammerspoon.spoons') %}

Hammerspoon config directory exists for spoon cloning for user '{{ user.name }}':
  file.directory:
    - name: {{ user._hammerspoon.confdir }}
    - user: {{ user.name }}
    - group: {{ user.group }}
    - mode: '0700'
    - makedirs: True

Custom spoons are available for user '{{ user.name }}':
  git.{{ mode }}:
    - names:
  {%- for spoon in user.hammerspoon.spoons %}
    {%- set branch = spoon.values() | first if spoon is mapping else False %}
    {%- set spoon = spoon.keys() | first if spoon is mapping else spoon %}
    {%- set spoon_name = spoon.split('/') | last %}
        - {{ spoon }}:
            - target: {{ user._hammerspoon.confdir }}/{{ spoon_name }}
    {%- if branch %}
            - branch: {{ branch }}
    {%- endif %}
  {%- endfor %}
    - user: {{ user.name }}
{%- endfor %}
