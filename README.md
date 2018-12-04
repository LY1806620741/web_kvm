
## Webvirtmgr+KvmDockerfile

1. Install [Docker](https://www.docker.com/).
```
$ yum install docker
```

2. Pull the image from Docker Hub

```
$ docker pull jieshao/web_kvm
```

### Usage

```
$ docker run --name web -p 8080:8080 -p 6080:6080 jieshao/web_kvm:onlyweb
$ Ctrl + C
$ docker start web
$ docke exec -it web /bin/bash
$ ssh-keygen
$ ssh-copy-id username@hostip(like root@172.17.0.1)
$ Ctrl + P + Q
```
### Test

```
$ docker run --name web -p 8080:8080 -p -it 6080:6080 jieshao/web_kvm:onlyweb /bin/bash

```

### Open Browser
1. Url is Host:8080
2. User admin, pwd admin
3. Then add Connection by TCP or SSH(Host kvm libvirtd can config use TCP OR SSH)
4. Use it as you wish

### Reference resources
1. ianblenke/kvm
2. primiano/docker-webvirtmgr