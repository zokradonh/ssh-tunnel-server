# SSH tunnel server

SSH server side of a tunnel. Companion for zokradonh/ssh-tunnel-client.
Perfect for use between two docker hosts that are not in swarm environment but need encrypted container to container connection.

docker-compose.yml
=======

```YAML
version: '2'

services:
  tunnel:
    image: zokradonh/ssh-tunnel-server
    restart: always
    networks:
      - othercontainernet
    volumes:
      - ./id_ed25519.pub:/home/tunneluser/.ssh/authorized_keys
    ports:
      - "222:22"


networks:
  othercontainernet:
    external:
      name: othercontainer_default
```
Replace `id_ed25519.pub` with filename of your public key.

Replace `othercontainer_default` with the name of the network that your target container is connected to.

Do not change `othercontainernet` or change both occurences.