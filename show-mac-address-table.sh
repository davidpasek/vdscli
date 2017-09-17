#!/bin/sh

# set env variables
. ./sh-wrapper-env.sh

./vdscli.pl --server=$VDSCLI_VSPHERE_VCENTER --username $VDSCLI_VSPHERE_USERNAME --password $VDSCLI_VSPHERE_PASSWORD --cmd show-mac-address-table

