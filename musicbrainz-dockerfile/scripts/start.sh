#!/bin/sh

eval $( perl -Mlocal::lib )

if [[ $ENABLE_REPLICATION ]]; then
  cron -f &
fi

nginx
/start_mb_renderer.pl
start_server --port=55901 -- plackup -I lib -s Starlet -E deployment --nproc 10 --pid fcgi.pid
