# eth-miner cookbook

Configures Etherium Miner's with Chef. 

Supported OS:
  - Ubuntu 16.04 LTS

Stack:
  - Claymore: https://github.com/nanopool/Claymore-Dual-Miner/releases
  - AMD Pro Drivers
  - Rsyslog


## Usage

Override the following attributes with a role.
```
node[:miner][:address] = "0xA481BE575cA10e1555F6512E507b85F42509db134"
```

The cookbook will do the following:
- Install packages `(wget, lm-sensors, rsyslog)`
- Download and install the AMD GPU driver
- Download and install claymore
- Configure's claymore to run with systemd
- Configure remote logging with rsyslog (Template must be edited before use!)





