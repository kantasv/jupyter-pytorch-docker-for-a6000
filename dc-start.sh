#!/bin/bash
set -ue
# GPU device(s)
# examples: ['0'], ['0', '2']
device_ids="['0', '1']"

conf_template="docker-compose.template.yaml"
conf_compiled="docker-compose.compiled.yaml"

echo "[1] Finding unused port in GPU machine..."
# https://qiita.com/piroor/items/2dd08a0b61e3ace0b7c6
available_port_range="$(cat /proc/sys/net/ipv4/ip_local_port_range | cut -f 1,2 --output-delimiter='-')"
while true
do
  port="$(shuf -i $available_port_range -n 1)"
  netstat -a -n |
    egrep ":$port .+LISTEN" 1>/dev/null 2>&1 ||
    break
done
echo "[i] Found the following port for jupyterlab:$port"
echo "[i] Compiling docker-compose configurations..."

sed -e "s/unused_port_on_gpu_machine/${port}/g" $conf_template > "$conf_compiled"
sed -i -e "s/device_ids_on_gpu_machie/${device_ids}/g" $conf_compiled


echo "[2] Making sure that container is down..."
# Makes sure that container is down
docker-compose -f $conf_compiled down
echo "[3] Making sure that container is latest..."
# Makes sure that container is latest
docker-compose -f $conf_compiled build
# Start container with detached mode
echo "[4] Starting the container..."
docker-compose -f $conf_compiled up -d
# Get in to the container
echo "[5] Attatching to the container (port on gpu: $port)"
docker-compose -f $conf_compiled exec min_pytorch \
	jupyter-lab --no-browser --port 8888 --ip=0.0.0.0 --allow-root --NotebookApp.token=''