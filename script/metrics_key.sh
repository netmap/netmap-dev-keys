#!/bin/sh

# Gets API key information from the metrics server.

set -o errexit  # Stop the script on the first error.
set -o nounset  # Catch un-initialized variables.

if [ "$#" -eq  0 ] ; then
  # Use the development ID and secret if no parameters are given.
  AID="123456789"
  AKEY="DevelopmentSecret-_-00"
  SERVER=http://netmap.local:8080
fi

if [ "$#" -eq  2 ] ; then
  # The first parameter is the app ID, the second parameter is the app server.
  AID="$1"
  AKEY="$2"
  SERVER=http://netmap-data.pwnb.us
fi

curl -f -H "Authorization: Bearer $AKEY" "$SERVER/apps/$AID" > metrics.json
