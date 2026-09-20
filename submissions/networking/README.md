# Networking Fundamentals — Homework

## Task 1 — Practice the commands / repos shared in the DevOps-Hero GitHub repo

The instructor's networking reference repos are listed in
[`resources.md`](resources.md)
(Nency Ravaliya: `Networking`, `Network-Troubleshooting`, `OSI-Network-devices`, `Subnetting`,
`IP-quest`, `How-DHCP-Works`, `IPFIX-NETFLOW-NTP`). The command drills in Task 2 practise that
material live on this host.

## Task 2 — Commands + output + explanation in a Markdown file

Deliverable: **[`networking-commands.md`](networking-commands.md)** — 14 networking commands, each
with the **real output from this machine** and a short explanation of what it does and what I
understood from it.

Commands covered: `ip -brief addr`, `ip route`, `ip neigh`, `ss -tuln`, `cat /etc/resolv.conf`,
`ping`, `dig` (`+short` / answer section), `nslookup`, `host`, `tracepath`, `curl -I`, `curl` body,
`nc -zv`, `openssl s_client` — plus a table of modern replacements for `ifconfig`, `netstat`, `arp`,
`route` and `traceroute`.

### Scripts (reproduce the output)

| Script | Covers |
|---|---|
| [`net-interface.sh`](net-interface.sh) | addresses, routes, neighbours, listening ports, DNS config |
| [`net-dns.sh`](net-dns.sh) | ping, dig, nslookup, host |
| [`net-http.sh`](net-http.sh) | tracepath, curl headers/body, nc port check, TLS cert |

```bash
bash net-interface.sh
bash net-dns.sh
bash net-http.sh
```

### Screenshots

| Screenshot | Contents |
|---|---|
| [`screenshots/01-ip-addresses-routes.png`](screenshots/01-ip-addresses-routes.png) | interfaces, routing table, ARP, listening ports, resolv.conf |
| [`screenshots/02-ping-dns.png`](screenshots/02-ping-dns.png) | ping, dig, nslookup, host |
| [`screenshots/03-http-tls-ports.png`](screenshots/03-http-tls-ports.png) | tracepath, curl, netcat, openssl |
