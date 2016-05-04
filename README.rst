====================
New Bash Environment
====================

Step-by-step guide to setting up a completely new bash environment to my liking.

Your Bash
---------

Copy the file ``.mybashrc`` to your home directory and bind it into your
``.bash_profile`` (to be executed on login) or ``.bashrc`` (to be executed on
opening a terminal).

.. code-block:: bash

    cp .mybashrc ~/

.. code-block:: bash

    if [ -f ${HOME}.mybashrc ];then
        source ${HOME}/.mybashrc
    fi

This assumes that ``tmux``, `tmuxifier`_ are installed and that ``virtualenv`` and
``virtualenvwrapper`` are available for Python.

.. _`tmuxifier`: https://github.com/jimeh/tmuxifier

Python Virtualenv
-----------------

The file ``.mybashrc`` has the following lines in it:

.. code-block:: bash

    export WORKON_HOME="${HOME}/.virtualenvs"
    source virtualenvwrapper.sh

Change ``WORKON_HOME`` to your desired directory. Within that directory you will
find a number of files. Copy the files ``postmkvirtualenv`` and ``postactivate``
into there overwriting the existing (empty) files.

postmkvirtualenv
~~~~~~~~~~~~~~~~

When a new virtualenv is created, this script will first try to install updated
versions of a few packages which I find indispensable for all Python virtualenvs,
namely ``setuptools``, ``pip``, ``wheel``, ``flake8``, ``virtualenv``,
``virtualenvwrapper``. Then it will attempt to link the ``PyQt4`` system
components into the virtualenv. I find QT a pain in the neck to install and this
is easier.

postactivate
~~~~~~~~~~~~

Upon activation of a virtualenv, this script ensures that the newest commands
from ``virtualenvwrapper`` installed in the virtualenv are actually used.

Misc Configuration
------------------

Copy more configuration files, **first edit them to your specific needs**,
creating directories as necessary

.. code-block:: bash

    cp pip.conf ~/.pip/
    cp .tmux.conf ~/
    cp .gitconfig ~/

Colours
-------

A very nice colour scheme is Solarized_. If you look on that page or simply
search for *solarized + your program*, you will most likely find something. The
colour schemes I like to set up are:

Terminal
~~~~~~~~

One of:

* gnome-terminal_
* xfce4-terminal_
* KDE_

As a bonus, the KDE_ scheme also works for Kate and Kile.

Then I like to setup directory colours with the following scheme_.

.. _Solarized: http://ethanschoonover.com/solarized
.. _gnome-terminal: https://github.com/Anthony25/gnome-terminal-colors-solarized
.. _xfce4-terminal: https://github.com/sgerrand/xfce4-terminal-colors-solarized
.. _KDE: https://github.com/hayalci/kde-colors-solarized
.. _scheme: https://github.com/seebi/dircolors-solarized

Tmux
~~~~

https://github.com/seebi/tmux-colors-solarized

SSH
---

If you don't have one, generate an ssh key pair (private - public). You can
follow the `instructions on github`_.

.. _`instructions on github`: https://help.github.com/articles/generating-ssh-keys

Vim
---

Install one of the following plugin managers:

* pathogen_
* vundle_ (recommended for now?)
* NeoBundle_

.. code-block:: bash

    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

Additional plugins are already set in the .vimrc but I recommend:

* SrcExpl
* taglist
* Nerdtree
* syntastic
* vim-surround
* solarized

Launch ``vim`` and run ``:PluginInstall``.

.. _pathogen: https://github.com/tpope/vim-pathogen
.. _vundle: https://github.com/gmarik/Vundle.vim
.. _NeoBundle: https://github.com/Shougo/neobundle.vim



