# Container configuration options

Throughout this chapter you will need to run commands as your unprivileged user ("lxdadmin" if you've been following from the beginning of this book).

There are a wealth of options for configuring the container after installation. Before seeing those, however, let us examine the `info` command for a container. In this example, you will use the debian12-test container:

```
lxc info debian12-test
```{{exec}}

There is much good information there, from the profiles applied, to the memory in use, disk space in use, and more.

## A word about configuration and some options

By default, LXD will assign the required system memory, disk space, CPU cores, and other resources, to the container. But what if you want to be more specific? That is totally possible.

There are trade-offs to doing this, though. For instance, if you assign system memory and the container does not use it all, you have kept it from another container that might actually need it. The reverse, though, can happen. If a wants to use more than its share of memory, it can keep other containers from getting enough, thereby pinching their performance.

Just remember that every action you make to configure a container _can_ have negative effects somewhere else.

```
lxc config set debian12-test limits.memory 2GB
```{{exec}}

That says that if the memory is available to use, for example there is 2GB of memory available, then the container can actually use no more than 2GB if it is available. It is a hard limit, for example.

```
lxc config set debian12-test limits.memory.enforce soft
```{{exec}}

That says that the container can use more than 2GB of memory, whether it is currently available or not. In this case it is a soft limit.

```
lxc config set debian12-test limits.cpu 2
```{{exec}}

That says to limit the number of CPU cores that the container can use to 2.

```
lxc config set debian12-test boot.autostart yes
```{{exec}}

To automatically start the container at startup.

```
lxc storage list
```{{exec}}

```
lxc storage show storage
```{{exec}}

To view storage details

This shows the following:

```
config: {}
description: ""
name: local
driver: zfs
used_by:
- /1.0/images/5a214c0e7663e3a87158882575f607bfe4f3443a5d5e382add67bc7ec6860f7d
- /1.0/images/70f0e3221694e51a490d93ba0f8a3da6db1027c8f1ef7ada6447f78b24107631
- /1.0/instances/debian12-test
- /1.0/instances/rockylinux-test-9
- /1.0/profiles/default
status: Created
locations:
- ubuntu
```

This shows that all of our containers use our dir storage pool. When using ZFS, you can also set a disk quota on a container. Here is what that command looks like, setting a 2GB disk quota on the debian12-test container:

```
lxc config device override debian12-test root size=2GB
```{{exec}}

As stated earlier, use configuration options sparingly, unless you have got a container that wants to use way more than its share of resources. LXD, for the most part, will manage the environment well on its own.

Many more options exist that might be of interest to some people. Doing your own research will help you to find out if any of those are of value in your environment.

Detailed Documentation for configuration options:

https://documentation.ubuntu.com/lxd/en/latest/reference/instance_options/