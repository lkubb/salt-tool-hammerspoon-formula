{%- from 'tool-hammerspoon/map.jinja' import hammerspoon -%}

include:
  - .package

Hammerspoon cli utility is linked in homebrew prefix:
  file.symlink:
    - name: {{ hammerspoon._brew_prefix }}/bin/hs
    # this will fail if hammerspoon was not installed globally
    - target: /Applications/Hammerspoon.app/Contents/Frameworks/hs/hs
    - user: {{ hammerspoon._console_user }}
    - group: admin
    - makedirs: true
    - require:
      - Hammerspoon setup is completed

Hammerspoon man pages are linked in homebrew prefix:
  file.symlink:
    - name: {{ hammerspoon._brew_prefix }}/share/man/man1/hs.1
    # this will fail if hammerspoon was not installed globally
    - target: /Applications/Hammerspoon.app/Contents/Resources/man/hs.man
    - user: {{ hammerspoon._console_user }}
    - group: admin
    - makedirs: true
    - require:
      - Hammerspoon setup is completed
