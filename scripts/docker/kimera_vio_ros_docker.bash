#!/bin/bash

# Allow X server connection
xhost +local:root
docker run -it \
    --network=host \
    --env="DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --volume="/media/lumen/CC897434BA39D0961/dataset:/data/datasets/Euroc:rw" \
    --volume="/home/lumen/workspace:/home/lumen/workspace:rw" \
    --volume="/home/lumen/.ssh:/root/.ssh:rw" \
    --name kimera_vio_ros kimera_vio_ros
# Disallow X server connection
xhost -local:root
