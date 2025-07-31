#!/bin/bash

echo "=== Linux Install Date Estimation (Generic) ==="
echo

# 1. Root filesystem creation time (EXT2/3/4 only)
ROOT_DEV=$(df / | awk 'END{print $1}')
FS_CREATED=""
if command -v tune2fs >/dev/null 2>&1 && sudo tune2fs -l "$ROOT_DEV" 2>/dev/null | grep -q 'Filesystem created'; then
    FS_CREATED=$(sudo tune2fs -l "$ROOT_DEV" 2>/dev/null | grep 'Filesystem created' | cut -d: -f2-)
    echo "1. Root filesystem created: $FS_CREATED"
else
    echo "1. Root filesystem created: [Not available or non-ext FS]"
fi

# 2. /etc/machine-id timestamp
if [ -e /etc/machine-id ]; then
    MACHINE_ID_TIME=$(stat -c %W /etc/machine-id 2>/dev/null)
    if [ "$MACHINE_ID_TIME" -gt 0 ] 2>/dev/null; then
        MACHINE_ID_HUMAN=$(date -d @"$MACHINE_ID_TIME" 2>/dev/null)
    else
        MACHINE_ID_HUMAN=$(stat -c %y /etc/machine-id 2>/dev/null)
    fi
    echo "2. /etc/machine-id created: $MACHINE_ID_HUMAN"
else
    echo "2. /etc/machine-id created: [Not found]"
fi

# 3. Oldest file in /var/log
OLDEST_LOG=$(find /var/log -type f -printf '%T@ %Tc %p\n' 2>/dev/null | sort -n | head -n 1)
if [ -n "$OLDEST_LOG" ]; then
    echo "3. Oldest /var/log file   : $OLDEST_LOG"
else
    echo "3. Oldest /var/log file   : [No log files found or unsupported find]"
fi

# 4. Oldest plausible file in /etc (exclude dates before year 2000)
OLDEST_ETC=$(find /etc -type f -printf '%T@ %Tc %p\n' 2>/dev/null | awk '$1 > 946684800' | sort -n | head -n 1)
if [ -n "$OLDEST_ETC" ]; then
    echo "4. Oldest /etc file       : $OLDEST_ETC"
else
    echo "4. Oldest /etc file       : [No plausible files found]"
fi

echo
echo "Best estimate: likely near the root filesystem creation or earliest log activity."

