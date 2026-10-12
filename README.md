# Memory BIST

Open-source implementation of March C memory module with CI/CD ready workflows.

## Quick Overview
- SRAM memory (SystemVerilog)
- Optional DRAM (NGSPICE + IHP PDK netlist)
- Auto-verifiable testbenches (Verilator)
- Memory BIST module (March C)
- Full sign-off flow via Librelane
- Scan chain insertion (Diffeto)
- Area/timing analysis (yosys + OpenSTA)

## CI/CD Requirements
All tests must pass in CI before merge:
- Verilator testbenches (auto-verifiable)
- yosys area & timing analysis
- Diffeto scan chain validation
- Librelane sign-off generation

CI pipeline (open-source tools):
- Runs on GitHub Actions (or self-hosted)
- Uses yosys, OpenSTA, Diffeto, Verilator, Librelane
- Checks test results automatically
- Triggers CD only after CI success

CD pipeline (open-source):
- Deploys runner (if needed) using oss-cad-suite tools
- Generates final sign-off netlists via Librelane
- Publishes reports (timing, area, BIST) to artifact store
- (Optional) Auto-deploy to test environment via CI hooks

## How to Contribute
1. Fork repo → create branch
2. Run CI locally (matches CI config):  
   ```bash
   make test          # Verilator tests
   make analyze       # yosys/OpenSTA analysis
   make bist-check    # Diffeto scan + BIST validation
   make signoff       # Librelane sign-off flow
   ```
3. Push changes → PR triggers GitHub Actions CI
4. CI passes → automatically deploys to CD environment (if configured)

> All CI/CD steps are defined in `.github/workflows/*.yml` (open-source templates). No manual runner setup required beyond standard OSS tools.

## Documentation
- Implementation details: `docs/IMPLEMENTATION.md`
- CI/CD workflow: `docs/CI_CD.md`
- Build & test: `docs/BUILD.md`

## License
MIT
