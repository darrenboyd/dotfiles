alias pgstart='pg_ctl -l $PGDATA/logfile start'
alias pgstop='pg_ctl stop -s -m fast'

alias pg_setup_user="psql -U postgres -c 'CREATE USER darren WITH SUPERUSER;' -c 'CREATE DATABASE darren OWNER darren;'"

