#!/usr/bin/env bash
#########################
## Docker-wipe script ##
#########################
# @license: MIT
# @author Carsten König - carstenkoenig92@gmail.com
# @version 0.1.2
# @repo_url https://github.com/cars10/docker-wipe
#
# Script to cleanup your local docker installation - meaning your data, not the actual installation.
# Provides functions to delete all images, containers, networks volumes (use with care!) or all of it.
#
# Usage:
# ./docker-wipe.sh {containers|images|volumes|networks|all} {parameter}
# Commands:
#   containers   - delete all containers
#   images       - delete all images
#   volumes      - delete all volumes
#   networks     - delete all networks
#   all          - delete all containers, images, networks and volumes
# Parameter:
#   y - pass this to disable confirmation message and automatically destroy

#=== variables ===
# set to "y" if you want to disable the confirmation permamently
CONFIRM=$2

#=== functions  ===

# Removes all containers
function removeContainers {
  echo -n '# Looking for containers to remove... '
  # only delete if there are any containers
  if [[ $(docker ps -a -q) ]]; then
    echo "Found containers. Deleting..."
    stopContainers
    docker rm $(docker ps -a -q)   # delete all containers
    echo "# Deleted all containers."
    echo ''
  else
    echo "No containers found, nothing to delete!"
  fi
}

# stop all containers if any is running
function stopContainers {
  if [[ $(docker ps -a -q) ]]; then
    docker stop $(docker ps -a -q) # stop all containers
  fi
}

# Removes all images
function removeImages {
  echo -n '# Looking for images to remove... '
  # only delete if there are images
  if [[ $(docker images -q) ]]; then
    echo "Found images. Deleting..."
    stopContainers
    docker rmi -f $(docker images -q)
    # sometimes docker fails do delete images, even with the -f flag.
    # for this case we try to destroy again because that usally works.
    if [[ $? != 0 ]] && [[ $(docker images -q) ]]; then
      echo "# Could not delete all images, trying again..."
      docker rmi -f $(docker images -q)
      if [[ $? == 0 ]]; then
        echo "# Deleted all images."
      else
        echo "# Could not delete all images, please try to delete them manually."
      fi
    else
      echo "# Deleted all images."
    fi
    echo ''
  else
    echo "No images found, nothing to delete!"
  fi
}

# Removes all volumes
function removeVolumes {
  echo -n '# Looking for volumes to remove... '
  # only delete if there are volumes
  if [[ $(docker volume ls -q) ]]; then
    echo "Found volumes. Deleting..."
    stopContainers
    docker volume rm $(docker volume ls -q)
    echo "# Deleted all volumes."
    echo ''
  else
    echo "No volumes found, nothing to delete!"
  fi
}

# remove all networks
# we need to check the names: we cannot delete the predevined networks "bridge", "host" and "none"
function removeNetworks {
  echo -n '# Looking for networks to remove...'
  if [[ $(docker network ls -q) ]]; then
    echo "Found networks. Deleting..."
    IFS=$'\n' read -rd '' -a network_ids <<<"$(docker network ls -q)"
    stopContainers

    for id in "${network_ids[@]}"; do
      network_name=$(docker network inspect -f '{{json .Name}}' $id)
      if [[ $network_name != '"bridge"' ]] && [[ $network_name != '"host"' ]] && [[ $network_name != '"none"' ]]; then
        docker network rm $id
      fi
    done

    echo "# Deleted all networks."
    echo ''
  else
    echo "No networks found, nothing to delete!"
  fi
}

function removeAll {
  echo '## Removing everything.'
  echo ''
  removeImages
  removeContainers
  removeVolumes
  removeNetworks
}

#=== entry point ===
echo '## Docker-wipe script ###'
echo '## Version 0.1.2'

case "$1" in
  containers)
    if [[ $CONFIRM == 'y' ]]; then
      removeContainers
    else
      echo '# Delete all containers? [y/n]'
      read -n 1 AGREE
      if [[ $AGREE == 'y'  ]]; then
        echo ''
        removeContainers
      fi
    fi
    ;;
  images)
    if [[ $CONFIRM == 'y' ]]; then
      removeImages
    else
      echo '# Delete all images? [y/n]'
      read -n 1 AGREE
      if [[ $AGREE == 'y' ]]; then
        echo ''
        removeImages
      fi
    fi
    ;;
  volumes)
    if [[ $CONFIRM == 'y' ]]; then
      removeVolumes
    else
      echo '# Delete all volumes? [y/n]'
      read -n 1 AGREE
      if [[ $AGREE == 'y' ]]; then
        echo ''
        removeVolumes
      fi
    fi
    ;;
  networks)
    if [[ $CONFIRM == 'y' ]]; then
      removeNetworks
    else
      echo '# Delete all networks? [y/n]'
      read -n 1 AGREE
      if [[ $AGREE == 'y' ]]; then
        echo ''
        removeNetworks
      fi
    fi
    ;;
  all)
    if [[ $CONFIRM == 'y' ]]; then
      removeAll
    else
      echo '# Delete all containers, images and volumes? [y/n]'
      read -n 1 AGREE
      if [[ $AGREE == 'y' ]]; then
        echo ''
        removeAll
      fi
    fi
    ;;
  *)
    echo 'Wrong or missing parameter.'
    echo ''
    echo $"Usage: $0 {containers|images|volumes|all} {parameter}"
    echo 'Commands:'
    echo '  containers   - delete all containers'
    echo '  images       - delete all images'
    echo '  volumes      - delete all volumes'
    echo '  networks     - delete all networks'
    echo '  all          - delete all containers, images, networks and volumes'
    echo ''
    echo 'Parameter:'
    echo '  y - pass this to disable confirmation message and automatically destroy'
    echo ''
    echo 'Examples:'
    echo $"$0 containers    - delete all containers"
    echo $"$0 containers y  - delete all containers without confirmation"
    echo ''
    exit 1
esac

echo ''
echo '## Finished. ##'
echo ''
exit 0
