# Quickstart: DCC Causal Mesh for Istio

This guide provides a self-contained environment to verify the **Mesh-to-Kernel** causal synchronization logic for Istio/Envoy.

## Prerequisites
- **G++** (C++11 or later)
- **Linux** or **macOS**

## Step 1: Build the Mesh Proof
```bash
git clone https://github.com/LemonScripter/istio-causal-bridge.git
cd istio-causal-bridge
make build
```

## Step 2: Run the Automated Proof
Execute the reproduction script to see the "Causal Trace Synchronization" logic in action:
```bash
./reproduce.sh
```

## Step 3: Production Deployment
For live mesh enforcement, the Proxy-Wasm filter must be deployed as an `EnvoyFilter` or via Istio's WasmPlugin API. It will automatically synchronize inbound causal contexts with the local BioOS kernel state.

## Verification Scenarios
- **Synced:** Outbound traffic initiated by a verified inbound request is permitted.
- **Orphaned:** Autonomous outbound connections without a preceding mesh-level trigger are blocked at the kernel egress point.

---
*Production-Grade Research Prototype by MetaSpace BioOS Team*
