# Simple metrics endpoint for Prometheus integration

Depends on https://github.com/emanuelsteen/epsolar-tracer and assumes it is
checked out in the parent folder. Uses `info.py`.

To start run:

```
$ ./start_web_server.sh
$ ./start_update_metrics.sh
```

Metrics can then be accessed at http://IP:8000/metrics.

It will look something like:

```
output_voltage 13.17
output_current 0.0
output_power 0.0
input_voltage 14.1
input_current 0.0
input_power 0.0
load_voltage 13.17
load_current 0.17
load_power 1.97
soc 55
generated_energy_today 0.76
generated_energy_month 8.93
generated_energy_year 67.27
generated_energy_total 119.01
charging_mode 2
battery_status 0
charging_equipment_status 11
battery_temperature 24.68
```
