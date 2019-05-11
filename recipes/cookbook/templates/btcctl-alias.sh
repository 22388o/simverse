#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")"

source _lib.sh

cd ".."

SIMVERSE_VERBOSE_ALIASES=${SIMVERSE_VERBOSE_ALIASES}

if [[ -n "$SIMVERSE_VERBOSE_ALIASES" ]]; then
  [[ -t 1 ]] && echo ">" "$(basename "$0")" "$@"
fi

DC_EXEC_EXTRA_ARGS=""
if [[ ! -t 1 ]]; then
  # do not allocate pseudo TTY when not running under terminal
  DC_EXEC_EXTRA_ARGS+=" -T"
fi

exec docker-compose exec ${DC_EXEC_EXTRA_ARGS} "$$NAME" btcctl.sh "$@" | beautify_if_needed
