#!/bin/bash

# # Authenticate
# RUN gcloud auth activate-service-account --key-file=${GCLOUD_KEY_FILE}
# RUN gcloud config set compute/zone ${GCLOUD_ZONE}
# RUN gcloud config set project ${GCLOUD_PROJECT}
# RUN gcloud compute instances list

if [ ! -z $GCLOUD_KEY_FILE ]; then 

    echo "Setting gcloud service account to: $GCLOUD_KEY_FILE"

    gcloud auth activate-service-account --key-file=$GCLOUD_KEY_FILE

    gcloud compute instances list

fi

/sbin/tini -- /usr/local/bin/jenkins.sh bash
