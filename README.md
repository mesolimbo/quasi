# quasi

**One path through a quasicrystal.**

An exact-arithmetic implementation of Singh, Lloyd & Flicker, *"Hamiltonian Cycles
on Ammann–Beenker Tilings,"* [PRX 14, 031005 (2024)](https://journals.aps.org/prx/abstract/10.1103/PhysRevX.14.031005).

The code constructs a single [Hamiltonian cycle](https://en.wikipedia.org/wiki/Hamiltonian_path)
— one closed loop that visits **every vertex exactly once** — on a patch of the
[Ammann–Beenker tiling](https://en.wikipedia.org/wiki/Ammann%E2%80%93Beenker_tiling),
an eightfold-symmetric quasicrystal whose pattern never repeats. Following the
paper's recursive method, the loop is grown alongside the tiling itself and
rendered as a piece of generative art.

👉 **[Explore the interactive walkthrough](https://mesolimbo.github.io/quasi/)** to see the construction built up step by step.

## Repository contents

| Path | What it is |
| --- | --- |
| `python/quasicrystal_hamiltonian.py` | Self-contained script that builds the tiling, constructs the Hamiltonian cycle, and renders it to SVG. |
| `docs/index.html` | An interactive, self-contained walkthrough of the mathematics and the algorithm, from "vertices are integers" through the final folded-star trick. Published via GitHub Pages. |

**Live walkthrough:** https://mesolimbo.github.io/quasi/

## How it works

Every step uses **exact arithmetic** — plain integers and elements of the ring
`Q(√2)`, represented as `p + q·√2` — so the construction is provably correct and
free of floating-point error. The pipeline:

1. **Substitution.** An 8-rhombus rosette is inflated three times
   (8 → 248 → 8,648 → 295,352 tiles) using the deterministic decomposition rule,
   which is embedded as data extracted from a reference tiling.
2. **Canonical decoration (e₀).** A fully-packed-loop decoration is applied per
   supertile class, plus an edge-strip rule, with a small forced matching to
   complete the patch fringe.
3. **Rewiring (e₁).** Alternating paths run along the rings of supertile edges,
   merging every loop they cross and threading the eight-fold vertices.
4. **The final trick.** A 16-edge star at the top level with one corner folded
   inward through the central vertex, then descent back to the base tiling.
5. **Rendering.** Edges are colored by the size class ("generation") of their
   canonical loop over a black background and written as raw SVG.

## Running it

Requires **Python 3.13**, [`pipenv`](https://pipenv.pypa.io/), and `make`. The
`Pipfile`/`Pipfile.lock` in `python/` pin [`networkx`](https://networkx.org/), so
installing needs no package name.

The simplest path is the `Makefile` in the repo root:

```bash
make run      # install pinned deps if needed, then generate the SVG
```

Run `make` (or `make help`) to list all targets. Other targets: `make install`
(set up the virtualenv only) and `make clean` (remove generated output).

Or run `pipenv` directly from `python/`:

```bash
cd python
pipenv install
pipenv run python quasicrystal_hamiltonian.py
```

This writes `ab_hamiltonian_rainbow_wide_glow.svg` to the working directory. You
can pass an alternate output filename as the first argument:

```bash
pipenv run python quasicrystal_hamiltonian.py my_output.svg
```

Runtime is a few minutes with a peak memory footprint of roughly 2 GB.

## Reference

Singh, Lloyd & Flicker, "Hamiltonian Cycles on Ammann–Beenker Tilings,"
*Physical Review X* **14**, 031005 (2024).
<https://journals.aps.org/prx/abstract/10.1103/PhysRevX.14.031005>
