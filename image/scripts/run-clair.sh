#!/bin/bash

# set up env variables
if [ -z "$POSTGRES_USERNAME" ]
then
  export POSTGRES_USERNAME="postgres";
fi

if [ -z "$POSTGRES_PASSWORD" ]
then
  export POSTGRES_PASSWORD="password";
fi

if [ -z "$POSTGRES_IP" ]
then
  export POSTGRES_IP="postgres-clair";
fi

if [ -z "$POSTGRES_PORT" ]
then
  export POSTGRES_PORT=5432;
fi

if [ -z "$POSTGRES_DATABASE" ]
then
  export POSTGRES_DATABASE="postgres-clair";
fi

# set up CLAIR_HOME directory
if [ -d "/clair" ];
then
  export CLAIR_HOME="/clair";
else
  echo "Clair home directory doesn't exist... Something went wrong during the build.";
  exit 1;
fi

# substitute env variables in the application config
envsubst < $CLAIR_HOME/config/config.yaml.template > $CLAIR_HOME/config/config.yaml

# Start Clair
if [ -f "$CLAIR_HOME/bin/clair" ]
then
  $CLAIR_HOME/bin/clair -config=$CLAIR_HOME/config/config.yaml
else
  echo "clair binary doesn't exist... Something went wrong during the build.";
  exit 1;
fi

