# Add user noninteractively
https://forums.freebsd.org/threads/adding-root-level-users-non-interactively.30504/

```
echo 'vagrant' | pw useradd -n vagrant -s /bin/sh -m -g admins -d /home/vagrant -h -
```
