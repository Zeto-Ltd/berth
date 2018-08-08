# Berth

Home to all Docker builds publically available on Docker Hub and any other
virtualised test systems.

# Prerequisites

Vagrant (tested: 1.7.2, 1.8.1, 1.9.1)
Virtualbox (tested: 5.0.40)
Docker (tested: 18.06.0-ce)

## Android

A Vagrant box is available for testing Android apps:

    vagrant up android

By default, the box used is configured for a French keyboard so change
to your preferred layout on first initialisation.
Additionally, for this VM to access internal services the `/etc/hosts` file
needs to be modified manually.

    vagrant ssh android <-- password=vagrant
    vi /system/etc/hosts <-- 172.16.166.100   zeto.devbox frontend.zeto.devbox

Once up, the VM may be registered with adb for deployments:

    adb connect localhost:5051
