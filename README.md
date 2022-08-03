[![tests](https://github.com/lullabot/ddev-printenv/actions/workflows/tests.yml/badge.svg)](https://github.com/drud/ddev-ddev-printenv/actions/workflows/tests.yml) ![project is maintained](https://img.shields.io/maintenance/yes/2022.svg)

## What is ddev-printenv?

This command makes it easy to both retrieve and obfuscate environment variables for sharing and debugging.

```console
$ ddev get lullabot/ddev-printenv
$ ddev printenv --help
Print environment variables, optionally obfuscating them to their last four characters. (shell host container command)

Usage:
  ddev printenv [-o|--obfuscate] [-s|--service] [variable name...] [flags]

Examples:
  "ddev printenv" or "ddev printenv DDEV_DOCROOT" or "ddev printenv -s web -o BLACKFIRE_SERVER_TOKEN"

Flags:
  -h, --help   help for printenv

Global Flags:
  -j, --json-output   If true, user-oriented output will be in JSON format.
```

For example, to view all Blackfire environment variables in a manner suitable for sharing:

```console
$ ddev printenv --obfuscate | grep BLACKFIRE
BLACKFIRE_SERVER_TOKEN=e088
BLACKFIRE_SERVER_ID=235c
```
