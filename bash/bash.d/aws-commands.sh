#!/bin/bash

AWS_CLI=`which aws`

if [ "$AWS_CLI" == "" ]; then
  echo "Error: 'aws' command not found."
  return 2
fi

# Determines (private) IP address from a hostname
aws-get-ip() {
  local hostname=$1
  $AWS_CLI ec2 describe-instances \
      --filters "Name=tag-value,Values=${hostname}" \
      | grep '"PrivateIpAddress"' \
      | head -n 1 \
      | grep -Eo "[\.0-9]{7,}"

  # We need to output something to keep ssh config valid
  test $? -eq 0 || echo "no-ip"
}

# Use this alias to connect to a server directly, without
# adding it to your aliases!
function aws-ssh() {
  if [ $# -lt 2 ]; then
    echo "Usage:   ssh-aws <nat-hostname> <target-hostname | target-IP> [any SSH parameters]"
    echo "Example: ssh-aws nat trk1 'ls /tmp'
    return 1
  fi
  local nat=$1
  shift
  local aws_host=$1
  shift
  local aws_ip=`echo $aws_host | grep -E "^([0-9]{1,3}[\.]){3}[0-9]{1,3}$"`
  if [ "$aws_ip" == "" ]; then
    aws_ip=`aws-get-ip $aws_host`
  fi
  echo "Connecting to $aws_ip"
  ssh -o "ProxyCommand ssh -W %h:%p $nat" $aws_ip $*
}
