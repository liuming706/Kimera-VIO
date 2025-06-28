FROM ros:noetic
LABEL maintainer="mabate@mit.edu"

# To avoid tzdata asking for geographic location...
ENV DEBIAN_FRONTEND=noninteractive
# 替换为清华镜像（适配国内）
RUN sed -i 's/archive.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list && \
    sed -i 's/security.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list
# 添加 ROS Noetic 源
RUN apt-get install -y curl gnupg2 lsb-release && \
    curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add - && \
    echo "deb https://mirrors.tuna.tsinghua.edu.cn/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list 
    
ENV DIRPATH /root/
WORKDIR $DIRPATH

RUN apt-get update && apt-get install -y --no-install-recommends apt-utils
RUN apt-get update && \
      apt-get install -y \
      build-essential \
      cmake \
      gfortran \
      git \
      libatlas-base-dev \
      libboost-all-dev \
      libeigen3-dev \
      libgflags-dev \
      libgoogle-glog-dev \
      libmetis-dev \
      libopencv-dev \
      libopencv-contrib-dev \
      libtbb-dev \
      pkg-config \
      xvfb \
      python3 \
      python3-dev \
      python3-pip \
      python3-tk && \
      apt-get clean && \
      rm -rf /var/lib/apt/lists/*
      
RUN git config --global url."https://ghfast.top/https://github.com/".insteadOf "https://github.com/"
RUN git clone https://github.com/borglab/gtsam.git 
RUN cd gtsam && \
      git checkout 4.2 && \
      mkdir build && \
      cd build && \
      cmake -DCMAKE_INSTALL_PREFIX=/usr/local \
      -DGTSAM_BUILD_WITH_MARCH_NATIVE=OFF \
      -DGTSAM_BUILD_TESTS=OFF \
      -DGTSAM_BUILD_EXAMPLES_ALWAYS=OFF \
      -DCMAKE_BUILD_TYPE=Release \
      -DGTSAM_BUILD_UNSTABLE=ON \
      -DGTSAM_POSE3_EXPMAP=ON \
      -DGTSAM_ROT3_EXPMAP=ON \
      -DGTSAM_TANGENT_PREINTEGRATION=OFF \
      -DGTSAM_USE_SYSTEM_EIGEN=ON \
      -DGTSAM_USE_SYSTEM_METIS=ON \
      .. && \
      make -j$(nproc) install

# Install Open_GV
RUN git clone https://github.com/marcusabate/opengv && \
      cd opengv && \
      git apply march_native_disable.patch && \
      mkdir build && \
      cd build && \
      cmake -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_PREFIX=/usr/local \
      .. && \
      make -j$(nproc) install

# Install DBoW2
COPY .patches/fix_vocab.patch dbow2.patch
RUN git clone https://github.com/dorian3d/DBoW2.git
RUN cd DBoW2 && \
      git apply ../dbow2.patch && \
      mkdir build && \
      cd build && \
      cmake .. && \
      make -j$(nproc) install

# Install RobustPGO
ADD https://api.github.com/repos/MIT-SPARK/Kimera-RPGO/git/refs/heads/master version.json
RUN git clone https://github.com/MIT-SPARK/Kimera-RPGO.git
RUN cd Kimera-RPGO && \
      mkdir build && \
      cd build && \
      cmake .. && \
      make -j$(nproc) install

# Install Kimera-VIO
#RUN git clone https://github.com/MIT-SPARK/Kimera-VIO.git
#RUN cd Kimera-VIO && mkdir build && cd build && cmake .. && make -j$(nproc)
