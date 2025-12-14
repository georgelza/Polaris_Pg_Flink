#
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
#

set -e

apk add --no-cache jq

polarishost=${1:-"polaris"}

realm=${2:-"POLARIS"}

catalog=${3:-"icebergcat"}

BASEDIR=$(dirname $0)

echo
echo create-catalog Params
echo "Polaris Host:          ${polarishost}"
echo "Realm:                 ${realm}"
echo "Catalog:               ${catalog}"
echo "Properties:            ${PROPERTIES}"

if [ -z "$token" ]; then
  source $BASEDIR/obtain-token.sh ${realm}
fi

echo
echo "Obtained access token: $token"

STORAGE_TYPE="FILE"
if [ -z "${STORAGE_LOCATION}" ]; then
    echo "STORAGE_LOCATION is not set, using FILE storage type"
    STORAGE_LOCATION="file:///var/tmp/icebergcat/"

else
    echo "STORAGE_LOCATION is set to '$STORAGE_LOCATION'"

    if [[ "$STORAGE_LOCATION" == s3* ]]; then
        STORAGE_TYPE="S3"

    elif [[ "$STORAGE_LOCATION" == gs* ]]; then
        STORAGE_TYPE="GCS"
    
    else
        STORAGE_TYPE="AZURE"
    fi
    echo "Using StorageType: $STORAGE_TYPE"
fi

if [ -z "${STORAGE_CONFIG_INFO}" ]; then
    STORAGE_CONFIG_INFO="{\"storageType\": \"$STORAGE_TYPE\", \"allowedLocations\": [\"$STORAGE_LOCATION\"]}"

    if [[ "$STORAGE_TYPE" == "S3" ]]; then
        STORAGE_CONFIG_INFO=$(echo "$STORAGE_CONFIG_INFO" | jq --arg roleArn "$AWS_ROLE_ARN" '. + {roleArn: $roleArn}')

    
    elif [[ "$STORAGE_TYPE" == "AZURE" ]]; then
        STORAGE_CONFIG_INFO=$(echo "$STORAGE_CONFIG_INFO" | jq --arg tenantId "$AZURE_TENANT_ID" '. + {tenantId: $tenantId}')
    fi
fi

# PAYLOAD='{
#    "catalog": {
#      "name": "'$catalog'",
#      "type": "INTERNAL",
#      "readOnly": false,
#      "properties": {
#        "default-base-location": "'$STORAGE_LOCATION'"
#      },
#      "storageConfigInfo": '$STORAGE_CONFIG_INFO'
#    }
#  }'


PAYLOAD='{
   "catalog": {
     "name": "'$catalog'",
     "type": "INTERNAL",
     "readOnly": false,
     "properties": '$PROPERTIES',
     "storageConfigInfo": '$STORAGE_CONFIG_INFO'
   }
 }'

echo
echo Payload:               $PAYLOAD

echo
echo Creating a catalog named $catalog in realm $realm...
# 1. Creating a catalog named <> in realme <>
curl -X POST http://$polarishost:8181/api/management/v1/catalogs \
   -H "Authorization: Bearer $token" \
   -H 'Content-Type: application/json' \
   -H 'Accept: application/json' \
   -H "Polaris-Realm: $realm" \
   -d "$PAYLOAD" | jq   

echo 
echo Created a catalog named $catalog in realm $realm...

echo 
echo Assigning Extra grants...;
# 2. Create a catalog admin role
curl -X PUT http://$polarishost:8181/api/management/v1/catalogs/$catalog/catalog-roles/catalog_admin/grants \
    -H "Authorization: Bearer $token" \
    -H 'Content-Type: application/json' \
    -H 'Accept: application/json' \
    -H "Polaris-Realm: $realm" \
    -d '{
        "grant":{
            "type":"catalog", 
            "privilege": "CATALOG_MANAGE_CONTENT"
        }
}' | jq

echo
echo Assigned CATALOG_MANAGE_CONTENT

# 3. Create a data engineer role
echo Creating a data engineer role;
curl -X POST http://$polarishost:8181/api/management/v1/principal-roles \
    -H "Authorization: Bearer $token" \
    -H 'Content-Type: application/json' \
    -H 'Accept: application/json' \
    -H "Polaris-Realm: $realm" \
    -d '{
        "principalRole":{
            "name":"DataEngineer"
        }
}' | jq

echo
echo Created a data engineer role

# 4. Connect the roles
echo Connecting the roles;
curl -X PUT http://$polarishost:8181/api/management/v1/principal-roles/DataEngineer/catalog-roles/$catalog \
    -H "Authorization: Bearer $token" \
    -H 'Content-Type: application/json' \
    -H 'Accept: application/json' \
    -H "Polaris-Realm: $realm" \
    -d '{
        "catalogRole":{
            "name":"catalog_admin"
        }
}' | jq

echo
echo Connected the roles

# 5.Give root the data engineer role
echo Giving root the data engineer role
curl -X PUT http://$polarishost:8181/api/management/v1/principals/root/principal-roles \
    -H "Authorization: Bearer $token" \
    -H 'Content-Type: application/json' \
    -H 'Accept: application/json' \
    -H "Polaris-Realm: $realm" \
    -d '{
        "principalRole": {
            "name":"DataEngineer"
        }
}' | jq

echo
echo Gave root the data engineer role

echo
echo Done - create-catalog
