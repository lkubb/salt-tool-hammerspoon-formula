# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as hammerspoon with context %}

include:
  - {{ tplroot ~ '.package.install' }}


Hammerspoon cli utility is linked in homebrew prefix:
  file.symlink:
    - name: {{ hammerspoon.lookup.brew_prefix }}/bin/hs
    # this will fail if hammerspoon was not installed globally
    - target: /Applications/Hammerspoon.app/Contents/Frameworks/hs/hs
    - user: {{ hammerspoon.lookup.brew_user }}
    - group: admin
    - makedirs: true
    - require:
      - Hammerspoon is installed
    - require_in:
      - Hammerspoon setup is completed

Hammerspoon man pages are linked in homebrew prefix:
  file.symlink:
    - name: {{ hammerspoon.lookup.brew_prefix }}/share/man/man1/hs.1
    # this will fail if hammerspoon was not installed globally
    - target: /Applications/Hammerspoon.app/Contents/Resources/man/hs.man
    - user: {{ hammerspoon.lookup.brew_user }}
    - group: admin
    - makedirs: true
    - require:
      - Hammerspoon is installed
    - require_in:
      - Hammerspoon setup is completed
