if [[ -z "$PGDATA" ]]; then
  export PGDATA=$HOME/.pgdata
fi
alias pgstart='pg_ctl -l $PGDATA/logfile start'
alias pgstop='pg_ctl stop -s -m fast'
