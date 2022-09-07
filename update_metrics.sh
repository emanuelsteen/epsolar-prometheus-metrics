#!/bin/bash

while true; do

	python3 ../epsolar-tracer.git/info.py > 2.txt
	cp 2.txt 1.txt

	> metrics.new

	echo "output_voltage $(grep "Charging equipment output voltage =" 1.txt | awk '{print $6}' | sed 's/[a-zA-Z]//g')" >> metrics.new
	echo "output_current $(grep "Charging equipment output current =" 1.txt | awk '{print $6}' | sed 's/[a-zA-Z]//g')" >> metrics.new
	echo "output_power $(grep "Charging equipment output power =" 1.txt | awk '{print $6}' | sed 's/[a-zA-Z]//g')" >> metrics.new

	echo "input_voltage $(grep "Charging equipment input voltage =" 1.txt | awk '{print $6}' | sed 's/[a-zA-Z]//g')" >> metrics.new
	echo "input_current $(grep "Charging equipment input current =" 1.txt | awk '{print $6}' | sed 's/[a-zA-Z]//g')" >> metrics.new
	echo "input_power $(grep "Charging equipment input power =" 1.txt | awk '{print $6}' | sed 's/[a-zA-Z]//g')" >> metrics.new

	echo "load_voltage $(grep "Discharging equipment output voltage =" 1.txt | awk '{print $6}' | sed 's/[a-zA-Z]//g')" >> metrics.new
	echo "load_current $(grep "Discharging equipment output current =" 1.txt | awk '{print $6}' | sed 's/[a-zA-Z]//g')" >> metrics.new
	echo "load_power $(grep "Discharging equipment output power =" 1.txt | awk '{print $6}' | sed 's/[a-zA-Z]//g')" >> metrics.new

	echo "soc $(grep "Battery SOC =" 1.txt | awk '{print $4}' | sed 's/[a-zA-Z%]//g')" >> metrics.new

	echo "generated_energy_today $(grep "Generated energy today =" 1.txt | awk '{print $5}' | sed 's/[a-zA-Z]//g')" >> metrics.new
	echo "generated_energy_month $(grep "Generated energy this month =" 1.txt | awk '{print $6}' | sed 's/[a-zA-Z]//g')" >> metrics.new
	echo "generated_energy_year $(grep "Generated energy this year =" 1.txt | awk '{print $6}' | sed 's/[a-zA-Z]//g')" >> metrics.new
	echo "generated_energy_total $(grep "Total generated energy =" 1.txt | awk '{print $5}' | sed 's/[a-zA-Z]//g')" >> metrics.new

	echo "charging_mode $(grep "Charging mode =" 1.txt | awk '{print $4}' | sed 's/[a-zA-Z]//g')" >> metrics.new
	echo "battery_status $(grep "Battery status =" 1.txt | awk '{print $4}' | sed 's/[a-zA-Z]//g')" >> metrics.new

	charging_equipment_status=$(grep "Charging equipment status =" 1.txt | awk '{print $5}' | sed 's/[a-zA-Z]//g')
	echo "charging_equipment_status $charging_equipment_status" >> metrics.new

	charging_equipment_status_bin=$(echo "obase=2; $charging_equipment_status" | bc | awk '{printf "%016d", $0}')
	echo "charging_equipment_status_bin $charging_equipment_status_bin" >> metrics.new

	running=$(echo "$charging_equipment_status_bin" | cut -c 16-16)
	echo "running $running" >> metrics.new

	fault=$(echo "$charging_equipment_status_bin" | cut -c 15-15)
	echo "fault $fault" >> metrics.new

	charing_status_bin=$(echo "$charging_equipment_status_bin" | cut -c 13-14)

	if [[ "$charing_status_bin" = "01" ]]; then
		float="1"
	else
		float="0"
	fi
	echo "float $float" >> metrics.new

	if [[ "$charing_status_bin" = "10" ]]; then
		boost="1"
	else
		boost="0"
	fi
	echo "boost $boost" >> metrics.new

	if [[ "$charing_status_bin" = "11" ]]; then
		equalization="1"
	else
		equalization="0"
	fi
	echo "equalization $equalization" >> metrics.new

	echo "battery_temperature $(grep "Battery Temperature =" 1.txt | awk '{print $4}' | sed 's/[a-zA-Z°]//g')" >> metrics.new

	battery_voltage=$(grep "Battery Voltage =" 1.txt | awk '{print $4}' | sed 's/[a-zA-Z]//g')
	echo "battery_voltage $battery_voltage" >> metrics.new

	volt_soc=0
	if (( $(echo "$battery_voltage >= 12" | bc ) )); then
		volt_soc=9
	fi
	if (( $(echo "$battery_voltage >= 12.5" | bc ) )); then
		volt_soc=14
	fi
	if (( $(echo "$battery_voltage >= 12.8" | bc ) )); then
		volt_soc=17
	fi
	if (( $(echo "$battery_voltage >= 12.9" | bc ) )); then
		volt_soc=20
	fi
	if (( $(echo "$battery_voltage >= 13.0" | bc ) )); then
		volt_soc=30
	fi
	if (( $(echo "$battery_voltage >= 13.1" | bc ) )); then
		volt_soc=40
	fi
	if (( $(echo "$battery_voltage >= 13.2" | bc ) )); then
		volt_soc=70
	fi
	if (( $(echo "$battery_voltage >= 13.225" | bc ) )); then
		volt_soc=75
	fi
	if (( $(echo "$battery_voltage >= 13.25" | bc ) )); then
		volt_soc=80
	fi
	if (( $(echo "$battery_voltage >= 13.275" | bc ) )); then
		volt_soc=85
	fi
	if (( $(echo "$battery_voltage >= 13.3" | bc ) )); then
		volt_soc=90
	fi
	if (( $(echo "$battery_voltage >= 13.35" | bc ) )); then
		volt_soc=95
	fi
	if (( $(echo "$battery_voltage >= 13.4" | bc ) )); then
		volt_soc=99
	fi
	if (( $(echo "$battery_voltage >= 13.6" | bc ) )); then
		volt_soc=100
	fi

	echo "volt_soc $volt_soc" >> metrics.new

	cp metrics.new metrics

	sleep 10
done

