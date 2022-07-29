# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as hammerspoon with context %}

include:
  - {{ slsdotpath }}.cli


Hammerspoon is installed:
  pkg.installed:
    - name: {{ hammerspoon.lookup.pkg.name }}

Hammerspoon setup is completed:
  test.nop:
    - name: Hooray, Hammerspoon setup has finished.
    - require:
      - pkg: {{ hammerspoon.lookup.pkg.name }}
