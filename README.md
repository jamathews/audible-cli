# audible-cli

**audible-cli** is a command line interface for the 
[Audible](https://github.com/mkb79/Audible) package. 
Both are written in Python language.

## Requirements

audible-cli needs at least *Python 3.7*.

## Installation

The preferred way to install this package is by using [pipx](https://pypa.github.io/pipx/):

```shell

pipx install audible-cli

```

If pipx is not available `pip` can be used instead:

```shell

pip install audible-cli

```

## Standalone executables

If `Python>=3.7` is not available on the machine, standalone binaries can be found 
below or on the [releases](https://github.com/mkb79/audible-cli/releases) page 
(including beta releases). At this moment Windows, Linux and macOS are supported.

### Links

1. Linux
    - [debian 11 onefile](https://github.com/mkb79/audible-cli/releases/latest/download/audible_linux_debian_11.zip)
    - [ubuntu latest onefile](https://github.com/mkb79/audible-cli/releases/latest/download/audible_linux_ubuntu_latest.zip)
    - [ubuntu 18.04 onefile](https://github.com/mkb79/audible-cli/releases/latest/download/audible_linux_ubuntu_18_04.zip)

2. macOS
    - [macOS latest onefile](https://github.com/mkb79/audible-cli/releases/latest/download/audible_mac.zip)
    - [macOS latest onedir](https://github.com/mkb79/audible-cli/releases/latest/download/audible_mac_dir.zip)

3. Windows
    - [Windows onefile](https://github.com/mkb79/audible-cli/releases/latest/download/audible_win.zip)
    - [Windows onedir](https://github.com/mkb79/audible-cli/releases/latest/download/audible_win_dir.zip)

> The code of onfile binaries is extracted on every execution. This can result in a long start 
> time, especially on Windows machines. Using the onedir binaries is the preferred way in that cases.


### Creating standalone binary

A standalone binary can be creates this way:

```shell

git clone https://github.com/mkb79/audible-cli.git
cd audible-cli
poetry install

# onefile output
poetry run pyinstaller --clean audible-filemode.spec

# onedir output
poetry run pyinstaller --clean audible-dirmode.spec

```

> There are some limitations when using plugins. The binary does not contain
> all the dependencies from your plugin script. 

## Getting started

A config and auth file must be created first before using the `audible` command. The easiest way 
is by using the interactive `audible-quickstart` or `audible quickstart` command.

> The quickstart command verifies that there are no config file already present. 
> So this command can only be run once.

To add another Audible account these steps have to be followed:

   1. add a new auth file: `audible manage auth-file add`
   2. add a new profile: `audible manage profile add`

> One auth file per Audible account is sufficient.
> A profile connects an existing auth file with a specific Audible marketplace.

To add another marketplace to an existing auth file the command `audible manage profile add` 
must be used.

## Tab Completion

Tab completion can be provided for commands, options and choice values. Bash, 
Zsh and Fish are supported. More information can be found 
[here](https://github.com/mkb79/audible-cli/tree/master/utils/code_completion).

## Basic information

### Way of working

This package simulate an iOS Audible device to interact with the non publicly Audible API. 
The information and credentials for each simulated device is stored in an (optionally encrypted) 
auth file. Devices, created this way, can be used for every available Audible marketplace. For 
this reason, one auth file per Audible account is sufficient. A profile connects an existing 
auth file with a specific Audible marketplace

### App dir

audible-cli use an app dir where it search for all necessary files.

If the ``AUDIBLE_CONFIG_DIR`` environment variable is set, it uses the value 
as config dir. Otherwise, it will use a folder depending on the operating 
system.

| OS       | Path                                      |
|----------|-------------------------------------------|
| Windows  | ``C:\Users\<user>\AppData\Local\audible`` |
| Unix     | ``~/.audible``                            |
| Mac OS X | ``~/.audible``                            |

### The config file

The config data will be stored in the [toml](https://github.com/toml-lang/toml) 
format as ``config.toml``.

It has a main section named ``APP`` and sections for each profile created 
named ``profile.<profile_name>``

### profiles

audible-cli make use of profiles. Each profile contains at least the name of the 
corresponding auth file and the country code for the audible marketplace. For 
using multiple marketplaces, a profile for each marketplace file must be created. 
In that case, the auth file entry can be the same.

In the main section of the config file, a primary profile is defined. 
This profile is used, if no other is specified. Another profile can be 
selected with `audible -P PROFILE_NAME`.

### auth files

Like the config file, auth files are stored in the app dir. 

For password protected auth files the password can be provided with 
`audible -p PASSWORD`. If the password is missed, a „hidden“ input field will
appear.

### Config options

A multi-word option in the config file is separated by an underline. In the CLI prompt,
a multi-word option must be entered with a hyphen.

#### APP section

The APP section supports the following options:

- primary_profile: The profile to use, if no other is specified
- filename_mode: When using the `download` command, a filename mode can be 
  specified here. If not present, "ascii" will be used as default. To override
  these option, you can provide a mode with the `filename-mode` option of the
  download command.

#### Profile section

- auth_file: The auth file for this profile
- country_code: The marketplace for this profile
- filename_mode: See APP section above. Will override the option in APP section.

## Commands

Call `audible -h` to show the help and a list of all available subcommands. You can show the help for each subcommand like so: `audible <subcommand> -h`. If a subcommand has another subcommands, you csn do it the same way.

At this time, there the following buildin subcommands: 

- `activation-bytes`
- `api`
- `download`
- `library`
    - `export`
    - `list`
- `manage`
    - `auth-file`
        - `add`
        - `remove`
    - `config`
        - `edit`
    - `profile`
        - `add`
        - `list`
        - `remove`
- `quickstart`
- `wishlist`
    - `export`
    - `list`
    - `add`
    - `remove`

## Verbosity option

There are 6 different verbosity levels:

- debug
- info
- warning
- error
- critical

By default, the verbosity level is set to `info`. You can provide another level like so: `audible -v <level> <subcommand> ...`.

If you use the `download` subcommand with the `--all` flag there will be a huge output. Best practise is to set the verbosity level to `error` with `audible -v error download --all ...`

## Plugins

### Plugin Folder

If the ``AUDIBLE_PLUGIN_DIR`` environment variable is set, it uses the value 
as location for the plugin dir. Otherwise, it will use a the `plugins` subdir 
of the app dir. Read above how Audible-cli searches the app dir.

### Custom Commands

You can provide own subcommands and execute them with `audible SUBCOMMAND`.
All plugin commands must be placed in the plugin folder. Every subcommand must 
have his own file. Every file have to be named ``cmd_{SUBCOMMAND}.py``. 
Each subcommand file must have a function called `cli` as entrypoint. 
This function has to be decorated with ``@click.group(name="GROUP_NAME")`` or  
``@click.command(name="GROUP_NAME")``.

Relative imports in the command files doesn't work. So you have to work with 
absolute imports. Please take care about this. If you have any issues with 
absolute imports please add your plugin path to the `PYTHONPATH` variable or 
add this lines of code to the beginning of your command script:

```python
import sys
import pathlib
sys.path.insert(0, str(pathlib.Path(__file__).parent))
```

Examples can be found 
[here](https://github.com/mkb79/audible-cli/tree/master/plugin_cmds).

If the plugin command imports a package which is not provided by this package 
it is recommended to install `audible-cli` with `pipx` and inject the additional 
package with `pipx inject audible_cli {PACKAGE}`.

## Own Plugin Packages

If you want to develop a complete plugin package for ``audible-cli`` you can
do this on an easy way. You only need to register your sub-commands or 
subgroups to an entry-point in your setup.py that is loaded by the core 
package.

Example for a setup.py

```python
from setuptools import setup

setup(
    name="yourscript",
    version="0.1",
    py_modules=["yourscript"],
    install_requires=[
        "click",
        "audible_cli"
    ],
    entry_points="""
        [audible.cli_plugins]
        cool_subcommand=yourscript.cli:cool_subcommand
        another_subcommand=yourscript.cli:another_subcommand
    """,
)
```

## Command priority order

Commands will be added in the following order:

1. plugin dir commands
2. plugin packages commands
3. build-in commands

If a command is added, all further commands with the same name will be ignored.
This enables you to "replace" build-in commands very easy.

## List of known add-ons for `audible-cli`

- [audible-cli-flask](https://github.com/mkb79/audible-cli-flask)
- [audible-series](https://pypi.org/project/audible-series/)

If you want to add information about your add-on please open a PR or a new issue!
