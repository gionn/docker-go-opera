#!/bin/ash
set -e

# automatically download the genesis file if not found
if [ -f "/genesis/${FANTOM_GENESIS}" ]; then
  echo "💼 found ${FANTOM_GENESIS}"
else
  echo "🌐 downloading genesis file ${FANTOM_GENESIS}"
  wget "https://${FANTOM_NETWORK}.fantom.network/${FANTOM_GENESIS}" -O "/genesis/${FANTOM_GENESIS}"
  echo "💼 using genesis file ${FANTOM_GENESIS}"
fi

# automatically download latest snapshot if chain data not found
if [ ! -d "/root/.opera/chaindata" ]; then
  echo "🌐 downloading snapshot tar from ${FANTOM_SNAPSHOT_URL}"
  cd /root/.opera
  wget ${FANTOM_SNAPSHOT_URL} -O - | tar xz -o --strip-components=1
fi

if [ "${STARTUP_ACTION}" = "prune" ]; then
  /usr/local/bin/opera --cache "${FANTOM_CACHE}" --genesis "/genesis/${FANTOM_GENESIS}" snapshot prune-state
fi

exec /usr/local/bin/opera \
  --http \
  --http.addr "0.0.0.0" \
  --http.api "${FANTOM_API}" \
  --http.corsdomain "*" \
  --http.vhosts "${FANTOM_HOSTNAME}" \
  --verbosity "${FANTOM_VERBOSITY}" \
  --cache "${FANTOM_CACHE}" \
  --genesis "/genesis/${FANTOM_GENESIS}"