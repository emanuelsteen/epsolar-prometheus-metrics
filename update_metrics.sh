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
	echo "charging_equipment_status $(grep "Charging equipment status =" 1.txt | awk '{print $5}' | sed 's/[a-zA-Z]//g')" >> metrics.new

	echo "battery_temperature $(grep "Battery Temperature =" 1.txt | awk '{print $4}' | sed 's/[a-zA-Z°]//g')" >> metrics.new

	cp metrics.new metrics

	sleep 10
done

