#!/usr/bin/env bash
set -euo pipefail

case "$(uname -s)" in
  MINGW*|MSYS*|CYGWIN*)
    exec py -3 -m unittest discover -s tests -v
    ;;
  *)
    exec python3 -m unittest discover -s tests -v
    ;;
esac
