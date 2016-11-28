# Ansible Role: NTP

A simple role that both installs and configures ntp.

[![Build Status](https://travis-ci.org/arc-ts/ansible-role-ntp.svg?branch=master)](https://travis-ci.org/arc-ts/ansible-role-ntp)

Index
----------
* [Requirements](#requirements)
* [Dependencies](#dependencies)
* [Usage](#usage)
* [Role Variables](#role-variables)
  * [Execution Control](#execution-control)
  * [Key File](#key-file)
  * [Leap File](#leap-file)
  * [Config](#config)
* [Example Playbook](#example-playbook)
* [Testing and Contributing](#testing-and-contributing)
* [License](#license)
* [Author Information](#author-information)


Requirements
----------

None



Dependencies
----------

None



Usage
----------

The ntp role has two small components in addition to the base install and config capabilities. These include managing the ntp keys file and managing the ntp leapsecond file. Execution of these two components is handled via the variables `ntp_manage_keys` and `ntp_manage_leapfile`. Both the keyfile and leapfile have other additional configuration options that may be tuned for the environment, please see them below in the [Role Variables](#role-variables) section.

The majority of the role configuration options if not a single type, are managed via hashes; even those that may not have need for key/value pairs.

**single depth hash example:**
```
ntp_config_discard:
  minimum: 2
  average: 3
```
Will result in this config:
`ntp_config_discard minimum 2 average 3`

**nested hash example**
```
ntp_config_filegen:
      loopstats:
        file: loopstats
        type: day
        enable:
      peerstats:
        file: peerstats
        type: day
        enable:
```

Will result in this config:
```
filegen loopstats file loopstats type day enable
filegen peerstats file peerstats type day enable
```

Role Variables
----------

### Execution Control

|     Variable Name     | Default |                     Description                    |
|:---------------------:|:-------:|:--------------------------------------------------:|
|  `ntp_manage_keyfile` |  false  |  Enables or disables management of the NTP keyfile |
| `ntp_manage_leapfile` |   true  | Enables or disables management of the NTP leapfile |
|     `ntp_version`     |    -    |         The version of NTP to be installed         |

### Key File

|     Variable Name     |    Default    |                                 Description                                 |
|:---------------------:|:-------------:|:---------------------------------------------------------------------------:|
|     `ntp_keys_ids`    |       -       | A nested hash in the form of  ` <key id>: {type: <key type>,  key: <key> }` |
|  `ntp_keys_file_file` | `os specific` |     The path to the keyfile. Will populate `ntp_config_keys` correctly.     |
| `ntp_keys_file_owner` |     `root`    |                          The owner for the keyfile                          |
| `ntp_keys_file_group` |     `root`    |                          The group for the keyfile                          |
|  `ntp_keys_file_mode` |     `0600`    |                           The mode for the keyfile                          |

### Leap File

|        Variable Name        |                         Default                         |                                                  Description                                                 |
|:---------------------------:|:-------------------------------------------------------:|:------------------------------------------------------------------------------------------------------------:|
|      `ntp_leapfile_src`     |                            -                            | The path to the ntp leapfile on the master to be copied to the target. **NOTE:** will be preferred over uri. |
|      `ntp_leapfile_uri`     | `https://www.ietf.org/timezones/data/leap-seconds.list` |                            The URI to the leapfile to be downloaded by the target                            |
|  `ntp_leapfile_uri_timeout` |                           `60`                          |                             The timeout for downloading the leapfile from the URI                            |
|   `ntp_leapfile_uri_user`   |                            -                            |                            Optional user credentials to use when accessing the URI                           |
| `ntp_leapfile_uri_password` |                            -                            |                         Optional password associated with the `ntp_leapfile_uri_user`                        |
|     `ntp_leapfile_file`     |               `/etc/ntp/leapfile-seconds`               |                                     Path where the leapfile will be saved                                    |
|  `ntp_leapfile_file_owner`  |                          `ntp`                          |                                          The owner for the leapfile                                          |
|  `ntp_leapfile_file_group`  |                          `ntp`                          |                                          The group for the leapfile                                          |
|   `ntp_leapfile_file_mode`  |                          `0644`                         |                                           The mode for the leapfile                                          |

### Config

|         Variable Name        |                   Default                  |    Type    |
|:----------------------------:|:------------------------------------------:|:----------:|
|     `ntp_config_discard`     |                      -                     |  `<hash>`  |
|     `ntp_config_restrict`    | see [defaults/main.yml](defaults/main.yml) |  `<hash>`  |
|     `ntp_config_automax`     |                      -                     |   `<int>`  |
|    `ntp_config_controlkey`   |                      -                     |   `<int>`  |
|      `ntp_config_crypto`     |                      -                     |  `<hash>`  |
|       `ntp_config_keys`      |                      -                     |  `string`  |
|     `ntp_config_keysdir`     |                      -                     |  `string`  |
|    `ntp_config_requestkey`   |                      -                     |   `<int>`  |
|      `ntp_config_revoke`     |                      -                     |   `<int>`  |
|    `ntp_config_trustedkey`   |                      -                     |  `<hash>`  |
|     `ntp_config_filegen`     |                      -                     |  `<hash>`  |
|     `ntp_config_statsdir`    |                      -                     |  `<hash>`  |
|    `ntp_config_broadcast`    |                      -                     |  `<hash>`  |
| `ntp_config_broadcastclient` |                      -                     |  `<hash>`  |
|  `ntp_config_manycastclient` |                      -                     |  `<hash>`  |
|  `ntp_config_manycastserver` |                      -                     |  `<hash>`  |
| `ntp_config_multicastclient` |                      -                     |  `<hash>`  |
|       `ntp_config_peer`      |                      -                     |  `<hash>`  |
|       `ntp_config_pool`      |                      -                     |  `<hash>`  |
|      `ntp_config_server`     | see [defaults/main.yml](defaults/main.yml) |  `<hash>`  |
|      `ntp_config_fudge`      |                      -                     |  `<hash>`  |
|  `ntp_config_broadcastdelay` |                      -                     |   `<int>`  |
|     `ntp_config_driftfile`   |                 OS specific                | `<string>` |
|     `ntp_config_disable`     |                      -                     |  `<hash>`  |
|      `ntp_config_enable`     |                      -                     |  `<hash>`  |
|    `ntp_config_interface`    |                      -                     |  `<hash>`  |
|     `ntp_config_leapfile`    |                      -                     | `<string>` |
|    `ntp_config_logconfig`    |                      -                     | `<string>` |
|     `ntp_config_logfile`     |                      -                     | `<string>` |
|      `ntp_config_tinker`     |               `{ panic: 0 }`               |  `<hash>`  |
|       `ntp_config_trap`      |                      -                     |  `<hash>`  |
|      `<ntp_config_ttl>`      |                      -                     |  `<hash>`  |

Example Playbook
----------

```
---
- hosts: localhost
  remote_user: root
  roles:
    - ntp
  vars:
    ntp_version: '2.4.6'
    ntp_manage_keys: true
    ntp_keys_ids:
      1:
        type: M
        key: TestKey
      22:
        type: M
        key: TestKey2
    ntp_config_discard:
      minimum: 2
      average: 3
    ntp_config_statsdir: /var/log/ntpstats
    ntp_config_filegen:
      loopstats:
        file: loopstats
        type: day
        enable:
      peerstats:
        file: peerstats
        type: day
        enable:
      clockstats:
        file: clockstats
        type: day
        enable:
```
Testing and Contributing
----------

Please see the [CONTRIBUTING.md](CONTRIBUTING.md) document in the repo for information regarding testing and contributing.



License
----------

MIT



Author Information
----------

Created by Bob Killen, maintained by the Department of [Advanced Research Computing and Technical Services](http://arc-ts.umich.edu/) at the University of Michigan.
