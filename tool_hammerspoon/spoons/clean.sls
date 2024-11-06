# vim: ft=sls

{%- set tplroot = tpldir.split("/")[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as hammerspoon with context %}

include:
  - {{ tplroot }}.package


{%- for user in hammerspoon.users | selectattr("hammerspoon.spoons", "defined") | selectattr("hammerspoon.spoons.wanted", "defined") %}

Custom spoons are absent for user '{{ user.name }}':
  file.absent:
    - names:
{%-   for spoon in user.hammerspoon.spoons.wanted %}
      - {{ user._hammerspoon.confdir | path_join(spoon) }}
{%-   endfor %}
{%- endfor %}
