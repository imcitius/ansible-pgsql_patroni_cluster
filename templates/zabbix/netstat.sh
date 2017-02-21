#!/usr/bin/bash
HOST=`hostname`
/usr/sbin/ss -ant | awk "{if (NR>1) {state[\$1]++}} END {host = \"${HOST}\"; \
for (i in state) {s=i; \
sub (/ESTAB/, \"ESTABLISHED\", s); sub (/LAST-ACK/, \"LAST_ACK\", s); sub (/SYN-SENT/, \"SYN_SENT\", s);  \
sub (/SYN-RECV/, \"SYN_RECV\", s); sub (/FIN-WAIT-1/, \"FIN_WAIT_1\", s); sub (/FIN-WAIT-2/, \"FIN_WAIT_2\", s); \
sub (/CLOSE-WAIT/, \"closew\", s); sub (/TIME-WAIT/, \"TIME_WAIT\", s); print host, \"tcp.\"s, state[i]}}"\ | grep $2 | awk '{print $3}'
