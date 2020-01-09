FROM ubuntu:16.04

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Configure apt and install packages
RUN apt-get update \
    && apt-get -y install software-properties-common \
    && apt-get -y install apt-transport-https ca-certificates gnupg software-properties-common wget \
    && wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | apt-key add - \
    && add-apt-repository 'deb https://apt.kitware.com/ubuntu/ xenial main' \
    && wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key| apt-key add - \
    && add-apt-repository 'deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-9 main' \
    && apt-get update \
    && apt-get -y install --no-install-recommends apt-utils dialog 2>&1 \
    # 
    # Verify git, process tools, lsb-release (useful for CLI installs) installed
    && apt-get -y install git iproute2 procps lsb-release \
    #
    # Install C++ tools
    && apt-get install -y \
    python3-pip \
	git \
    clang-9 \
    cmake \
    #
    && ln -s /usr/bin/clang-9 /usr/bin/clang \
    && ln -s /usr/bin/clang++-9 /usr/bin/clang++ \
    && ln -s /usr/bin/lldb-9 /usr/bin/lldb \
    #
    && git clone https://github.com/mymichu/uscxml.git /opt/uscxml \
	&& cd /opt/uscxml \
	&& git checkout 06d5ecab3af673811146ad8c4cbf0d6f9bf5c0f4 \
    && cd /opt/uscxml \
    && mkdir build-docker-release && cd build-docker-release \
    && cmake -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_BUILD_TYPE=release .. \
    && cmake --build . \
    && mkdir -p /opt/uscxml \
    && ln -s /opt/uscxml/build-docker-release/bin/uscxml-browser /usr/bin/uscxml-browser \
    && ln -s /opt/uscxml/build-docker-release/bin/uscxml-transform /usr/bin/uscxml-transform \
    #
    # Create a non-root user to use if preferred - see https://aka.ms/vscode-remote/containers/non-root-user.
    && groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    # [Optional] Add sudo support for the non-root user
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME\
    && chmod 0440 /etc/sudoers.d/$USERNAME \
    #
    # Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install conan

# Switch back to dialog for any ad-hoc use of apt-get
ENV DEBIAN_FRONTEND=dialog