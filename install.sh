#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
target_dir="${HOME}/.local/bin"
target_path="${target_dir}/pepcalc"

mkdir -p "${target_dir}"
ln -sfn "${script_dir}/pepcalc" "${target_path}"

if [[ ":${PATH}:" != *":${target_dir}:"* ]]; then
  echo "Installed to ${target_path}."
  echo "Add ${target_dir} to PATH to use 'pepcalc' globally."
  exit 0
fi

echo "Installed to ${target_path} and ready on PATH."
