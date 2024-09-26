# Setup with head node and nodes on private network.

The Goal here is to as seamlessly as possible set up a head node on a "public" (for very small value of public, 10.x.y.x inside condenser) IP with some other nodes on a private range that communicate through it as a gateway.

This is a work in progress.

Challenges: IP discovery on the worker nodes if we have multiple additions. We can't rely on DHCP because of how things are presently set up.

Investigatory work.

Having set up two instances, one as a gateway and one as a test, a lot of swearing has learned that on the two types of nodes we need to:

## Gateway:

```shell
nmcli con mod "System eth0" +ipv4.addresses 192.168.67.1/24  # adds a new IP on default interface.
nmcli con down "System eth0" && nmcli con up "System eth0" # reload state
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
sysctl -p
dnf install -y firewalld
systemctl enable --now firewalld
firewall-cmd --zone=public --add-forward
firewall-cmd --zone=public --add-rich-rule='rule family=ipv4 source address=192.168.67.0/24 masquerade'
```

## Clients

```shell
nmcli con mod "System eth0" +ipv4.addresses 192.168.67.2/24
nmcli con mod "System eth0" ipv4.gateway 192.168.67.1
nmcli con mod "System eth0" ipv4.method manual
nmcli con mod "System eth0" ipv4.dns "10.134.10.1" 
nmcli con mod "System eth0" -ipv4.addresses 10.134.10.10 # not clear if we need this as manual may remove it?
nmcli con down "System eth0" && nmcli con up "System eth0"
```