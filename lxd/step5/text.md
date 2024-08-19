# Snapshot server

As noted at the beginning, the snapshot server for LXD must be a mirror of the production server in every way possible. The reason is that you might need to take it to production if the hardware fails on your primary server, and having backups, and a quick way to restart production containers, keeps those system administrator panic telephone calls and text messages to a minimum. THAT is ALWAYS good!

The process of building the snapshot server is exactly like the production server. To fully emulate our production server set up, do all of Chapters 1-4 again on the snapshot server, and when completed, return to this spot.

## The snapshot process

Setting up the firewall.

