# vim: ft=sls

{%- set tplroot = tpldir.split("/")[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as hammerspoon with context %}


Hammerspoon cli utility is not linked in homebrew prefix:
  file.absent:
    - name: {{ hammerspoon.lookup.brew_prefix }}/bin/hs

Hammerspoon man pages are not linked in homebrew prefix:
  file.absent:
    - name: {{ hammerspoon.lookup.brew_prefix }}/share/man/man1/hs.1
