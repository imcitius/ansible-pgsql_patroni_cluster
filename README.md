# ansible-pgsql_patroni_cluster
This is a Patroni based HA implementation of PostgreSQL 9.6 cluster with 3 nodes, async replication, and Haproxy/Keepalived.

This ansible config was created to publish a short article on Habrahabr website, <a href="https://habrahabr.ru/post/322036/">located here</a>.

Developed on Ansible 2.2.

You should explicitly set you VIP for keepalived in ansible's hosts variables.
Also virtual adapted for keepalived should be mentioned in keepalived.conf.j2.