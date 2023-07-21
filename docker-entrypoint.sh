#!/usr/bin/env bash

if [ "$PORT" ]; then
    export MB_JETTY_PORT="$PORT"
fi

/app/run_metabase.sh