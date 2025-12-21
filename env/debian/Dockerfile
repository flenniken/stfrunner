# Create a build and test environment for stfrunner.

FROM debian:12

# Define the coder_env environment variable used to detect when we are
# running in the docker container.
ENV coder_env=debian

# Install the needed apps and libraries.

RUN apt update \
  && apt -qy install curl libssl-dev build-essential gcc \
  less git man sudo tree

# Create a linux user called coder with sudo permissions and no
# password.
RUN mkdir -p /etc/sudoers.d \
  && echo "coder ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/coder \
  && chmod 440 /etc/sudoers.d/coder \
  && adduser --disabled-password --gecos '' coder \
  && usermod -aG sudo coder \
  && echo 'coder:devenv' | chpasswd

# Correct the coder home folder permissions.
RUN chown coder:coder /home/coder

# Switch to coder user for following commands.
USER coder
WORKDIR /home/coder/
ENV stfrunner=/home/coder/stfrunner/bin/debian/stfrunner

# Get nim source for manually building nim.
RUN git clone https://github.com/nim-lang/Nim.git
ARG nim_version=v2.2.4
RUN cd Nim \
  && git checkout $nim_version \
  && git switch -c $nim_version

# Install bashrc for the prompt and some aliases.
COPY --chown=coder:coder bashrc .bashrc

# Start in the project directory.
WORKDIR /home/coder/stfrunner
CMD ["/bin/bash"]
