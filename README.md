# DCC Causal Mesh for Istio / Envoy

## Overview
The **DCC Causal Mesh** is a professional WebAssembly (Wasm) extension for Envoy Proxy (Istio). It synchronizes **Service Mesh authorization** with **Kernel-level causality**, ensuring that application outbound traffic is strictly caused by verified inbound requests.

## The Problem: The Intra-Pod Gap
Istio provides robust L7 network security (mTLS, RBAC) between services. However, it cannot verify the *local execution* within the pod. If a rogue process or thread (exploit) inside an authorized pod initiates an outbound connection, Envoy allows it because the *Service Identity* is valid. This is an "orphaned" outbound request.

## The Solution: Mesh-to-Kernel Bridge
This bridge integrates **Digital Causal Closure (DCC)** into the mesh:
1. **Inbound Synchronization:** When a valid external request enters the pod through Envoy, the DCC Wasm Filter issues a temporary **Causal Token** to the local kernel.
2. **Outbound Enforcement:** The kernel eBPF module (DCC Driver) intercepts outbound syscalls (e.g., `connect`). It only allows the connection if it finds a valid token issued by the local Envoy proxy.
3. **Closure:** This ensures that every outbound network call is causally linked to an authorized inbound network event.

## Scientific Background
This integration is based on the following formal research:
- [The Causal Operating System: Digital Causal Closure for Autonomous Systems](https://doi.org/10.5281/zenodo.20384700)
- [BioOS Causal Constitution (PDF)](https://bioos.metaspace.bio/bioos_causal_constitution_en.pdf)

## Components
- **`causal_filter.cc`**: Envoy Proxy-Wasm filter (C++) for inbound causal synchronization.
- **`verify_mesh.py`**: Logic verification suite ensuring 100% causal chain integrity between mesh and kernel.

## Upstreaming Proposal
We propose the integration of Causal Mesh filters as a standard security enhancement for Istio deployments in zero-trust environments, closing the gap between network identity and local execution causality.

---
*Created by MetaSpace BioOS | [metaspace.bio](https://metaspace.bio) | [admin@metaspace.bio](mailto:admin@metaspace.bio)*
