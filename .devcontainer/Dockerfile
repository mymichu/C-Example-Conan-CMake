FROM ubuntu:16.04

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Configure apt and install packages
RUN apt-get update \
    && apt-get -y install --no-install-recommends apt-utils dialog 2>&1 \
    # 
    # Verify git, process tools, lsb-release (useful for CLI installs) installed
    && apt-get -y install git iproute2 procps lsb-release \
    #
    # Install C++ tools
    && apt-get install -y \
    python3-pip \
	git \
    clang \
    cmake \
    #
    && git clone https://github.com/mymichu/uscxml.git /opt/uscxml \
	&& cd /opt/uscxml \
	&& git checkout 06d5ecab3af673811146ad8c4cbf0d6f9bf5c0f4 \
    && cd /opt/uscxml \
    && mkdir build-docker-release && cd build-docker-release \
    && cmake -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_BUILD_TYPE=release .. \
    && cmake --build . \
    && mkdir -p /opt/uscxml \
    && ln -s bin/uscxml-browser /usr/bin/uscxml-browser \
    && ln -s bin/uscxml-transform /usr/bin/uscxml-transform \
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

# Switch back to dialog for any ad-hoc use of apt-get
ENV DEBIAN_FRONTEND=dialog