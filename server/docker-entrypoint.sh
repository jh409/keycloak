#!/bin/bash

# Add admin user
if [ $KEYCLOAK_USER ] && [ $KEYCLOAK_PASSWORD ]; then
    keycloak/bin/add-user-keycloak.sh --user $KEYCLOAK_USER --password $KEYCLOAK_PASSWORD
fi

export DB_VENDOR="h2"
DB_NAME="embedded H2"

# Configure DB

echo "========================================================================="
echo ""
echo "  Using $DB_NAME database"
echo ""
echo "========================================================================="
echo ""

echo "STARTING KEYCLOAK"
# Start Keycloak
exec /opt/jboss/keycloak/bin/standalone.sh -Dkeycloak.migration.action=import -Dkeycloak.migration.provider=singleFile -Dkeycloak.migration.file=/opt/realm-export.json -Dkeycloak.migration.strategy=OVERWRITE_EXISTING  $@
exit $?
