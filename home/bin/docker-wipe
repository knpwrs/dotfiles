#!/usr/bin/env bash
# License: MIT
#########################
## Docker-wipe script ##
#########################
# Script to cleanup your local docker installation - meaning your data, not the actual installation.
# Provides functions to delete all images, containers, volumes (use with care!) or all of it.
# usage:
# ./docker-wipe.sh {containers|images|volumes|all} {parameter}
# Commands:
#   containers   - delete all containers
#   images       - delete all images
#   volumes      - delete all volumes
#   all          - delete all containers, images and volumes
# Parameter:
#   y - pass this to disable confirmation message and automatically destroy

#=== variables ===
# set to "y" if you want to disable the confirmation permamently
CONFIRM=$2

#=== functions  ===

# Removes all containers
function removeContainers {
  echo -n '# Looking for containers to remove... '
  if [[ $(docker ps -a -q) ]]; then
    echo "Found containers. Deleting..."
    docker stop $(docker ps -a -q)
    docker rm $(docker ps -a -q)
    echo "# Deleted all containers."
    echo ''
  else
    echo "No containers found, nothing to delete!"
  fi
}

# Removes all images
function removeImages {
  echo -n '# Looking for images to remove... '
  if [[ $(docker images -q) ]]; then
    echo "Found images. Deleting..."
    docker rmi -f $(docker images -q)
    echo "# Deleted all images."
    echo ''
  else
    echo "No images found, nothing to delete!"
  fi
}

# Removes all volumes
function removeVolumes {
  echo -n '# Looking for volumes to remove... '
  if [[ $(docker volume ls -q) ]]; then
    echo "Found volumes. Deleting..."
    docker volume rm $(docker volume ls -q)
    echo "# Deleted all volumes."
    echo ''
  else
    echo "No volumes found, nothing to delete!"
  fi
}

function removeAll {
  echo '## Removing everything.'
  echo ''
  removeImages
  removeContainers
  removeVolumes
}

#=== entry point ===
echo '## Docker-wipe script ###'

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
    echo '  all          - delete all containers, images and volumes'
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
