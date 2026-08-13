#!/usr/bin/env bash
set -euo pipefail

input_file=$1
shift

args=()

while IFS= read -r line || [[ -n $line ]]; do
    [[ -z $line || $line == \#* ]] && continue
    args+=(--input "$line")
done < "$input_file"

exec typst compile "${args[@]}" "$@"
