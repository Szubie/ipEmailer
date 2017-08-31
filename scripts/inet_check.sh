#!/bin/bash

is_online() {
    wget -q --tries=10 --timeout=20 -O - http://google.com > /dev/null
    if [[ $? -eq 0 ]]; then
            echo "true"
    else
            echo "false"
    fi
}
