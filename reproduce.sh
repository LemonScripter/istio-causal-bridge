#!/bin/bash
set -e

# DCC Istio Bridge: Automated Reproduction Script
# Validates the Mesh-to-Kernel causal synchronization logic.

echo "--- [1/3] Building Istio Causal Logic Proof ---"
mkdir -p bin
g++ -O2 src/reproduce_proof.cpp -o bin/istio-dcc-proof

echo "--- [2/3] Verifying Causal Logic (Demo Mode) ---"
./bin/istio-dcc-proof --demo

echo -e "\n--- [3/3] Deployment Architecture ---"
echo "In production, the Envoy Proxy-Wasm filter uses the SDK to"
echo "synchronize context with the host kernel eBPF map."

echo -e "\nSUCCESS: Istio Causal Mesh logic verified."
