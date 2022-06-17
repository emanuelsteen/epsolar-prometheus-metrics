#!/bin/bash

pkill -f "python3 -m http.server"

python3 -m http.server >/dev/null 2>&1 &

