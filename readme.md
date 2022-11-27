## Bostrap script for kali on rpi

### make sure you finish apt update && apt upgrade before and restart

```shell
apt update #maybe already done
apt upgrade #maybe already done
chmod +x bootstrap.sh
./bootstrap.sh <hostname> <tailscale auth token>
```