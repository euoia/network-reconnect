# network-reconnect
For systemd and network-manager.

## Installation

Tested on `Raspbian GNU/Linux 8`.

```
sudo mkdir /var/log/network-reconnect
sudo cp network-reconnect.service /etc/systemd/system
sudo cp network-reconnect.timer /etc/systemd/system
sudo systemctl start network-reconnect.timer
sudo systemctl enable network-reconnect.timer
```

To see timers:

```
systemctl list-timers
```

