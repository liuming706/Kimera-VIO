#!/bin/bash

# Allow X server connection
xhost +local:root
docker run -it --rm \
    --network=host \
    --env="DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --volume="/media/lumen/CC897434BA39D0961/dataset:/data/datasets/Euroc:rw" \
    --volume="~/workspace:~/workspace:rw" \
    kimera_vio  kimera_vio
# Disallow X server connection
xhost -local:root
