# Setting up and managing images

## Creating and Listing images

You probably can not wait to get started with a container. There are many container operating system possibilities. To get a feel for how many possibilities, enter this command:

```
lxc image list images: | more
```{{exec}}

Enter the space bar to page through the list. This list of containers and virtual machines continues to grow.

The **last** thing you want to do is to page through looking for a container image to install, particularly if you know the image that you want to create. Change the command to show only Rocky Linux install options:

```
lxc image list images: | grep rocky
```{{exec}}

This brings up a much more manageable list:

```
| rockylinux/8 (3 more)                    | 0ed2f148f7c6 | yes    | Rockylinux 8 amd64 (20220805_02:06)          | x86_64       | CONTAINER       | 128.68MB  | Aug 5, 2022 at 12:00am (UTC)  |
| rockylinux/8 (3 more)                    | 6411a033fdf1 | yes    | Rockylinux 8 amd64 (20220805_02:06)          | x86_64       | VIRTUAL-MACHINE | 643.15MB  | Aug 5, 2022 at 12:00am (UTC)  |
| rockylinux/8/arm64 (1 more)              | e677777306cf | yes    | Rockylinux 8 arm64 (20220805_02:29)          | aarch64      | CONTAINER       | 124.06MB  | Aug 5, 2022 at 12:00am (UTC)  |
| rockylinux/8/cloud (1 more)              | 3d2fe303afd3 | yes    | Rockylinux 8 amd64 (20220805_02:06)          | x86_64       | CONTAINER       | 147.04MB  | Aug 5, 2022 at 12:00am (UTC)  |
| rockylinux/8/cloud (1 more)              | 7b37619bf333 | yes    | Rockylinux 8 amd64 (20220805_02:06)          | x86_64       | VIRTUAL-MACHINE | 659.58MB  | Aug 5, 2022 at 12:00am (UTC)  |
| rockylinux/8/cloud/arm64                 | 21c930b2ce7d | yes    | Rockylinux 8 arm64 (20220805_02:06)          | aarch64      | CONTAINER       | 143.17MB  | Aug 5, 2022 at 12:00am (UTC)  |
| rockylinux/9 (3 more)                    | 61b0171b7eca | yes    | Rockylinux 9 amd64 (20220805_02:07)          | x86_64       | VIRTUAL-MACHINE | 526.38MB  | Aug 5, 2022 at 12:00am (UTC)  |
| rockylinux/9 (3 more)                    | e7738a0e2923 | yes    | Rockylinux 9 amd64 (20220805_02:07)          | x86_64       | CONTAINER       | 107.80MB  | Aug 5, 2022 at 12:00am (UTC)  |
| rockylinux/9/arm64 (1 more)              | 917b92a54032 | yes    | Rockylinux 9 arm64 (20220805_02:06)          | aarch64      | CONTAINER       | 103.81MB  | Aug 5, 2022 at 12:00am (UTC)  |
| rockylinux/9/cloud (1 more)              | 16d3f18f2abb | yes    | Rockylinux 9 amd64 (20220805_02:06)          | x86_64       | CONTAINER       | 123.52MB  | Aug 5, 2022 at 12:00am (UTC)  |
| rockylinux/9/cloud (1 more)              | 605eadf1c512 | yes    | Rockylinux 9 amd64 (20220805_02:06)          | x86_64       | VIRTUAL-MACHINE | 547.39MB  | Aug 5, 2022 at 12:00am (UTC)  |
| rockylinux/9/cloud/arm64                 | db3ce70718e3 | yes    | Rockylinux 9 arm64 (20220805_02:06)          | aarch64      | CONTAINER       | 119.27MB  | Aug 5, 2022 at 12:00am (UTC)  |
```

## Installing, renaming, and listing images

For the first container, you are going to use "rockylinux/8". To install it, you _might_ use:

```
lxc launch images:rockylinux/8 rockylinux-mv-8
```{{exec}}

That will create a Rocky Linux-based container named "rockylinux-test-8". You can rename a container after creating it, but you first need to stop the container, which starts automatically when created.

To Rename the image first stop the container:

```
lxc stop rockylinux-mv-8
```{{exec}}

Use the `move` command to change the container's name:

```
lxc move rockylinux-mv-8 rockylinux-test-8
```{{exec}}

Use the `start` command to start the container once again:

```
lxc start rockylinux-test-8
```{{exec}}

If you followed this instruction anyway, stop the container and move it back to the original name to continue to follow along.

For the purposes of this guide, go ahead and install two more images for now:

```
lxc launch images:rockylinux/9 rockylinux-test-9
lxc launch images:debian/12 debian12-test
```{{exec}}

Examine what you have by listing your images:

```
lxc list
```{{exec}}