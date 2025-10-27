FROM ubuntu:24.04

# Prevent any interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Fix repositories and install SSH properly
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends openssh-server sudo systemctl && \
    mkdir -p /var/run/sshd && \
    useradd -m openclassrooms -s /bin/bash && \
    echo "openclassrooms:openclassrooms" | chpasswd && \
    usermod -aG sudo openclassrooms && \
    echo "root:root" | chpasswd && \
    mkdir -p /home/openclassrooms/.ssh && \
    chown -R openclassrooms:openclassrooms /home/openclassrooms && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Allow password auth (needed for exercise SSH login)
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]