#!/bin/bash

# check qwiki backup mtime, compare with current date - N
# if backup is older than N, warning
# if backup is older than 2N, error

# returns (STDOUT)
# 0 OK
# 1 WARN
# 2 ERROR
# 3 CRITICAL-CANTFIND
# 4 CRITICAL-FUTUREDATE


