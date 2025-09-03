#!/bin/bash

# Check if cmus is running
if ! cmus-remote -Q >/dev/null 2>&1; then
    echo " "
    exit 0
fi

# Get status
status=$(cmus-remote -Q | grep "status" | cut -d ' ' -f 2-)

# Show output based on status
if [[ "$status" == "playing" ]]; then
    # Normal output when playing
    echo "  $(cmus-remote -C "format_print '%a - %t (%{position}/%d)'")"
elif [[ "$status" == "paused" ]]; then
    # Add pause icon when paused
    echo "󰏤  $(cmus-remote -C "format_print '%a - %t (%{position}/%d)'")"
else
    # Nothing when stopped or no track loaded
    echo " "
fi
