#!/usr/bin/env bash
set -euo pipefail

SERVER_IP="192.168.56.110"
WORKER_IP="192.168.56.111"
TOKEN_FILE="/vagrant/node-token"

# Wait for server script to export the token
echo "[+] Waiting for server token at $TOKEN_FILE..."
while [ ! -f "$TOKEN_FILE" ]; do
  sleep 2
done

TOKEN=$(cat "$TOKEN_FILE")

# Detect interface name associated with worker IP
IFACE=$(ip -4 -o addr show to "$WORKER_IP" | awk '{print $2}' | head -n1)

if [ -z "$IFACE" ]; then
  echo "[-] Error: Could not determine interface for IP $WORKER_IP"
  exit 1
fi

echo "[+] Joining cluster at https://${SERVER_IP}:6443 via $IFACE..."

curl -sfL https://get.k3s.io | K3S_URL="https://${SERVER_IP}:6443" \
  K3S_TOKEN="${TOKEN}" \
  INSTALL_K3S_EXEC="agent \
    --node-ip=${WORKER_IP} \
    --flannel-iface=${IFACE}" sh -

echo "[+] Worker joined successfully."