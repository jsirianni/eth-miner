# eth-miner cookbook
Configures an Ethereum miner with Chef.

Supported OS:
  - Ubuntu 16.04 LTS

Supported GPU:
  - AMD R9 300 series
  - AMD RX 400 series
  - AMD RX 500 series

Stack:
  - Claymore: https://github.com/nanopool/Claymore-Dual-Miner/releases
  - AMD Pro Drivers
  - Rsyslog


## Usage
Override the following attributes with a role.
```
{
"miner": {
    "address": "0xA481BE575cA10e1555F6512E507b85F42509db134"
    "claymore" {
      "pool": "us1.ethermine.org:4444"
    }
  }
}
```

The cookbook will do the following:
- Install packages `(wget, lm-sensors, rsyslog)`
- Download and install the AMD GPU driver
- Download and install Claymore
- Configure Claymore to run with systemd
- Configure remote logging with rsyslog (Template must be edited before use! See the `Future` section)

## Manage
This cookbook can be run on a schedule with `chef-client` as it is entirely
idempotent. An attribute is set after installing the AMD driver to prevent
future installation attempts.

The miner configuration lies within a Systemd unit file for the Claymore mining service. The rendered
unit file will look something like this:
```
# Managed by Chef. Do not edit by hand
# Claymore must run as root in order to manage
# GPU fan speed properly

[Unit]
Description=Claymore Etherium Mining Service
After=network.target

# Send standard out to syslog
# Run GPU's at 100%
# Address and worker name are pulled in via attributes
[Service]
Type=simple
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=
User=root
Group=root
Environment=GPU_MAX_ALLOC_PERCENT=100
ExecStart=/usr/local/claymore95/ethdcrminer64 \
      -epool us1.ethermine.org:4444 \
      -ewal 0xA481BE575cA10e187F6512E507a45F42509db139.miner-1 \
      -epsw x -mode 1 \
      -tt 68 \
      -allpools 1

# restart claymore if it crashes
Restart=on-failure
RestartSec=30

[Install]
WantedBy=multi-user.target
```

## Monitoring
To monitor the miner activity, watch syslog with `sudo tail -F /var/log/syslog`

Additional insight into your mining environment can be configured by utilizing Netdata,
Promethious, Grafana and remote syslog.
- https://github.com/jmadureira/netdata-cookbook
- https://github.com/jsirianni/prometheus


## Testing
#### Test Kitchen
Test this cookbook with `Test Kitchen`

It should be noted that the Claymore service will fail to start due to OpenCL issues
with the virtual environment. Testing with real hardware graphics cards will yield
the best results.
```
kitchen converge  // Builds an Ubuntu 16.04 VM and runs the cookbook
kitchen verify    // Runs a series of tests
kitchen destroy   // Destroys the test VM

kitchen test      // Performs all three of the previous steps
```

## Future
#### Remote logging
Currently this cookbook will install a rsyslog config file for remote logging.
The config is disabled (commented) but will dynamically pull in a remote server
and port. Centralized logging is possible if the template is uncommented. Future
versions of this cookbook will allow this feature to be enabled / disabled with
attributes.

To make use of this feature now, override `default[:miner][:log][:socket]` with
a `hostname` and `port`.
```
default[:miner][:log][:socket] = 'logserver.domain:514'
```

#### Chef Spec Unit Tests
Unit tests are on the road map. Currently only `inspec` tests are available.
