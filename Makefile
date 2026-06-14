# DCC Istio Bridge Makefile

all: build

build:
	@echo "Building Istio DCC Wasm Filter..."
	# Requires emscripten / wasm-sdk
	# emcc -O3 -s WASM=1 -s SIDE_MODULE=1 src/causal_filter.cc -o bin/causal_filter.wasm

test-integration:
	@echo "Running Logic Verification (Python)..."
	python3 tests/verify_mesh.py

.PHONY: all build test-integration
