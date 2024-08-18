# Chapter 8: container snapshots

Throughout this chapter you will need to run commands as your unprivileged user ("lxdadmin" if you've been following along from the beginning of this book).

Container snapshots, along with a snapshot server (more on that later), are probably the most important aspect of running a production LXD server. Snapshots ensure quick recovery. It is a good idea to use them as a fail safe when updating the primary software that runs on a particular container. If something happens during the update that breaks that application, you just restore the snapshot and you are back up and running with only a few seconds worth of downtime.

The author used LXD containers for PowerDNS public facing servers, and the process of updating those applications became less worrisome, thanks to taking snapshots before every update.

You can even snapshot a container when it is running.

## The snapshot process

Start by getting a snapshot of the debian12-test container by using this command:

```
lxc snapshot debian12-test debian12-test-1
```{{exec}}

Here, you are calling the snapshot "debian12-test-1", but you can call it anything. To ensure that you have the snapshot, do an `lxc info` of the container:

```
lxc info debian12-test
```{{exec}}

You have looked at an info screen already. If you scroll to the bottom, you now see:

```
Snapshots:
  debian12-test-1 (taken at 2021/04/29 15:57 UTC) (stateless)
```

Success! Our snapshot is in place.

Get into the debian12-test container:

```
lxc shell debian12-test
```{{exec}}

Create an empty file with the _touch_ command, exit the container and list files in root.

```
touch this_file.txt
exit
lxc exec debian12-test ls
```{{exec}}

Before restoring the container how it was prior to creating the file, the safest way to restore a container, particularly if there have been many changes, is to stop it first:

```
lxc stop debian12-test
```{{exec}}

Restore it:

```
lxc restore debian12-test debian12-test-1
```{{exec}}

Start the container again:

```
lxc start debian12-test
```{{exec}}

If you get list the files once again, you will see that the file we created with _touch_ no longer exists.

```
lxc exec debian12-test ls
```{{exec}}

When you do not need a snapshot anymore you can delete it:

```
lxc delete debian12-test/debian12-test-1
```{{exec}}

**Warning**

You should always delete snapshots with the container running. Why? Well the _lxc delete_ command also works to delete the entire container. If we had accidentally hit enter after "debian12-test" in the command above, AND, if the container was stopped, the container would be deleted. No warning is given, it simply does what you ask.

If the container is running, however, you will get this message:

```
Error: The instance is currently running, stop it first or pass --force
```

So always delete snapshots with the container running.