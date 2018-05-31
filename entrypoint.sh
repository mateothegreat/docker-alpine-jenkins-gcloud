#!/bin/bash

if [ ! -z $GCLOUD_KEY_FILE ]; then 

    echo "*** Setting gcloud service account to: $GCLOUD_KEY_FILE"
    gcloud auth activate-service-account --key-file=$GCLOUD_KEY_FILE

    if [ ! -z $GCLOUD_PROJECT ]; then

        echo "*** Setting gcloud project: $GCLOUD_PROJECT"
        gcloud config set project $GCLOUD_PROJECT

    fi

    if [ ! -z $GCLOUD_ZONE ]; then

        echo "*** Setting gcloud compute/zone: $GCLOUD_ZONE"
        gcloud config set compute/zone $GCLOUD_ZONE

    fi

    gcloud compute instances list

fi

/sbin/tini -- /usr/local/bin/jenkins.sh
