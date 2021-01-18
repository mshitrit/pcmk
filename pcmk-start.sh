#!/bin/bash

env | sort
set -x

# [ -e /etc/sysconfig/pacemaker ] &&. /etc/sysconfig/pacemaker
# [ -e /etc/sysconfig/sbd ] && . /etc/sysconfig/sbd
# [ -e /etc/sysconfig/pcsd ] && . /etc/sysconfig/pcsd

set -e

# : ${CLUSTER_NAME="redhat"}
# : ${CLUSTER_PASS="redhat"}
# : ${REMOTE_NODE=0}
COROSYNC_CONF=/etc/corosync/corosync.conf

# echo ${CLUSTER_PASS} | passwd --stdin hacluster

# export GEM_HOME=/usr/lib/pcsd/vendor/bundle/ruby
# /usr/lib/pcsd/pcsd &

# sleep 5

: ${SECRETS_DIR="/etc/secret-volume"}
: ${AUTHKEY_PATH="${SECRETS_DIR}/authkey"}

# NODE_ID=$(echo ${HOSTNAME} | sed s/.*-//)
# NODE_IP=$(grep ${HOSTNAME} /etc/hosts | cut -f1)
#
# if [ x$NODE_IP = x ]; then
#     # Hope it's resolvable
#     NODE_IP=$HOSTNAME
# fi

# if [ $REMOTE_NODE = 0 ]; then
    # if [ -e $COROSYNC_CONF ]; then
	# : Nothing to do
    # echo "nothing to do"
	
    # elif [ x${BOOTSTRAP_NODE} = x ]; then
	# pcs cluster auth ${NODE_IP} -u hacluster -p ${CLUSTER_PASS} --force
	# pcs cluster setup --local --name ${CLUSTER_NAME} ${NODE_IP} 
    #
    # else
    pcs host auth --token "$(cat $AUTHKEY_PATH)" $NODE1NAME addr=$NODE1ADDR $NODE2NAME addr=$NODE2ADDR
    pcs host accept_token "$(cat $AUTHKEY_PATH)"
    pcs cluster setup --corosync_conf $COROSYNC_CONF --force $CLUSTER_NAME $NODE1NAME $NODE2NAME
	# pcs cluster auth ${BOOTSTRAP_NODE} ${NODE_IP} -u hacluster -p ${CLUSTER_PASS} --force
	# if [ "x$(pcs cluster corosync ${BOOTSTRAP_NODE} | grep $NODE_IP)" = x ]; then
	#     pcs --debug --force cluster node add ${NODE_IP} --bootstrap-from ${BOOTSTRAP_NODE}
	# else
	#     : Rejoining an existing or pre-configured cluster
	#     pcs cluster corosync ${BOOTSTRAP_NODE} > /etc/corosync/corosync.conf
	# fi
	cat $COROSYNC_CONF
    # fi
# fi
