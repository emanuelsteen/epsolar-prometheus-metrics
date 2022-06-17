#!/bin/bash

pkill update_metrics

./update_metrics.sh >/dev/null 2>&1 &

