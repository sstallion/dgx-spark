#!/bin/sh

set -o errexit

# Alpine will return 127.0.0.1 when calling `hostname -i`, even when running
# in host networking mode. To work around this issue, we get the default
# interface address from the routing table.
export SPARK_HOME_BIND=$(ip route get 1.1.1.1 | awk '{print $7}')

# If a domain name has not been configured, append '.local' in order to
# support mDNS hostnames:
export SPARK_HOME_FQDN=$(hostname -f)
if ! echo $SPARK_HOME_FQDN | grep -q '\.'; then
    SPARK_HOME_FQDN="${SPARK_HOME_FQDN}.local"
fi

# Substitute environment variables in configuration:
export SPARK_HOME_CONFIG="/srv/assets/config.yml"
envsubst <"${SPARK_HOME_CONFIG}.in" >"${SPARK_HOME_CONFIG}"

exec "$@"
