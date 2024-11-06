# vim: ft=sls

{#-
    Manages the Hammerspoon package configuration by

    * recursively syncing from a dotfiles repo

    Has a dependency on `tool_hammerspoon.package`_.
#}

include:
  - .sync
