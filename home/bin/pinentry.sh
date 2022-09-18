#!/bin/sh
# pinentry wrapper script to run the preferred tool based on criteria.
# This is specified in ~/.gnupg/gpg-agent.conf

pinentry_order="
/usr/local/bin/pinentry-mac
/usr/bin/pinentry-gnome3
/usr/bin/pinentry
"

for p in $pinentry_order; do
  if [ -f "$p" ]; then
    exec $p $@
    break
  fi
done

