#!/usr/bin/env bash


url="$1"

buku=$(command -v buku)
tags="newsboat"

if [ -n "$buku" ]; then
  buku --nostdin -a "$url" "$tags"  >/dev/null
else
  echo "buku not found"
fi
