FROM alpine:latest

LABEL maintainer="az@gft.eu"

RUN apk upgrade && apk add --no-cache openssh tini && rm -rf /var/cache/apk/* /tmp/*

RUN sed -i s/#PermitRootLogin.*/PermitRootLogin\ no/ /etc/ssh/sshd_config && \
    sed -i s/#PasswordAuthentication.*/PasswordAuthentication\ no/ /etc/ssh/sshd_config && \
    mkdir -p /home/tunneluser && \
    adduser -D -h /home/tunneluser tunneluser && \
    printf "\nMatch User tunneluser" >> /etc/ssh/sshd_config && \
    printf "\n  X11Forwarding no" >> /etc/ssh/sshd_config && \
    printf "\n  AllowAgentForwarding no" >> /etc/ssh/sshd_config && \
    printf "\n  ForceCommand /bin/false" >> /etc/ssh/sshd_config

COPY start.sh /usr/local/bin

RUN chmod a+x /usr/local/bin/start.sh

ENTRYPOINT ["/sbin/tini", "--"]

CMD [ "/usr/local/bin/start.sh" ]