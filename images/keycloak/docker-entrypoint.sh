#!/bin/sh

# Enables signals getting passed from startup script to JVM
# ensuring clean shutdown when container is stopped.
export LAUNCH_JBOSS_IN_BACKGROUND=1
BIND_ADDRESS=$(ip -o -4 addr list ${KEYCLOAK_BIND_INTERFACE} | head -n1 | awk '{print $4}' | cut -d/ -f1)

# Binding to specific interface if available
KEYCLOAK_BIND=
if [ -n "${KEYCLOAK_BIND_INTERFACE}" ]; then
  if [ -z "${BIND_ADDRESS}" ]; then
    echo "Could not find IP for interface '${KEYCLOAK_BIND_INTERFACE}', exiting"
    exit 1
  fi

  KEYCLOAK_BIND="-b ${BIND_ADDRESS}"
  echo "==> Found address '${BIND_ADDRESS}' for interface '${KEYCLOAK_BIND_INTERFACE}', setting bind option..."
fi

# Can download initial configuration from S3 location
KEYCLOAK_CONFIG=
if [ -n "${KEYCLOAK_S3_CONFIG}" ]; then
  /usr/local/bin/aws s3 cp ${KEYCLOAK_S3_CONFIG} /keycloak/keycloak.properties
  KEYCLOAK_CONFIG="-P /keycloak/keycloak.properties"
  echo "==> Using S3 configuration '${KEYCLOAK_S3_CONFIG}'"
fi

# bind all defaults to address Docker container uses
exec /keycloak/bin/standalone.sh \
    -Djava.net.preferIPv4Stack=true \
    -Djboss.bind.address.management=${BIND_ADDRESS} \
    -Djboss.bind.address.private=${BIND_ADDRESS} \
    ${KEYCLOAK_BIND} ${KEYCLOAK_CONFIG} $@
exit $?
