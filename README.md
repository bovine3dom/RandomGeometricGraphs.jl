# RandomGeometricGraphs.jl

A small package for the generation of [random geometric graphs](https://en.wikipedia.org/wiki/Random_geometric_graph) in Julia. The package is heavily inspired by the generator used in NetworkX.

It's about 10-15x faster than `LightGraphs.euclidean_graph` because it uses KDTrees from `NearestNeighbors`. It's also about 10x faster than the generator in NetworkX because, y'know, Julia.

## Usage

```julia
using Pkg
Pkg.add(PackageSpec(url="https://github.com/bovine3dom/RandomGeometricGraphs.jl",rev="master"))

using RandomGeometricGraphs
nodes = 1000
radius = 0.2
random_geometric_graph(nodes,radius; dim=2)
```

## Contributing

PRs and issues welcomed.
