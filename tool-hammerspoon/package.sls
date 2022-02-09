{%- from 'tool-hammerspoon/map.jinja' import hammerspoon -%}

Hammerspoon is installed:
  pkg.installed:
    - name: homebrew/cask/hammerspoon

Hammerspoon setup is completed:
  test.nop:
    - name: Hooray, Hammerspoon setup has finished.
    - require:
      - pkg: homebrew/cask/hammerspoon
