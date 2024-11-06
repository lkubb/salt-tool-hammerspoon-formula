Available states
----------------

The following states are found in this formula:

.. contents::
   :local:


``tool_hammerspoon``
~~~~~~~~~~~~~~~~~~~~
*Meta-state*.

Performs all operations described in this formula according to the specified configuration.


``tool_hammerspoon.package``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Installs the Hammerspoon package only.


``tool_hammerspoon.package.cli``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



``tool_hammerspoon.xdg``
~~~~~~~~~~~~~~~~~~~~~~~~
Ensures Hammerspoon adheres to the XDG spec
as best as possible for all managed users.
Has a dependency on `tool_hammerspoon.package`_.


``tool_hammerspoon.config``
~~~~~~~~~~~~~~~~~~~~~~~~~~~
Manages the Hammerspoon package configuration by

* recursively syncing from a dotfiles repo

Has a dependency on `tool_hammerspoon.package`_.


``tool_hammerspoon.spoons``
~~~~~~~~~~~~~~~~~~~~~~~~~~~



``tool_hammerspoon.clean``
~~~~~~~~~~~~~~~~~~~~~~~~~~
*Meta-state*.

Undoes everything performed in the ``tool_hammerspoon`` meta-state
in reverse order.


``tool_hammerspoon.package.clean``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



``tool_hammerspoon.package.cli.clean``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



``tool_hammerspoon.xdg.clean``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Removes Hammerspoon XDG compatibility crutches for all managed users.


``tool_hammerspoon.config.clean``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Removes the configuration of the Hammerspoon package.


``tool_hammerspoon.spoons.clean``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



