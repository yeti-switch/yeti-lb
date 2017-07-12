#!subst "/GRP_ID/1/"

#!subst "/VER/YETI balancing node/"

listen=udp:{lb_addr}
listen=tcp:{lb_addr}

alias={lb_addr}

disable_tcp=no
auto_aliases=no
enable_tls=no
tcp_connection_lifetime=3605

children=4

#!define FR_INV_TIMER   120000
#!define FR_TIMER 100
#!define FR_INV_TIMER_REMOTE 120000
#!define FR_TIMER_REMOTE 300
#!define FR_TIMER_REMOTE_HIGH 2000

# BALANCE_ALG code meanings from dispatcher manual
# 0 - hash over callid
# 1 - hash over from URI.
# 2 - hash over to URI.
# 3 - hash over request-URI.
# 4 - round-robin (next destination).
# 5 - hash over authorization-username (Proxy-Authorization or "normal" authorization). If no username is found, round robin is used.
# 6 - random (using rand()).
# 7 - hash over the content of PVs string. Note: This works only when the parameter hash_pvar is set.
# 8 - use first destination (good for failover).
# 9 - use weight based load distribution. You have to set the attribute 'weight' per each address in destination set.
# 10 - use call load distribution. You have to set the attribute 'duid' (as an unique string id) per each address in destination set. Also, you must set parameters 'dstid_avp' and 'ds_hash_size'.

#!subst "/BALANCE_ALG/0/"

