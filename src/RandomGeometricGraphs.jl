"""
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
"""
module RandomGeometricGraphs

    # Todo: 
    # test that random_geometric_graph(n,r,dim=dim) ≈ LightGraphs.euclidean_graph(n,dim,cutoff=r)
    # provide seed
    # if positions matrix is not given, read from node attributes
    # consider typing?

    
    export random_geometric_graph

    import LightGraphs, NearestNeighbors, MetaGraphs 

    getpos(g::T,n) where T <: MetaGraphs.AbstractMetaGraph = MetaGraphs.get_prop(g,n,:position)

    function addedgesinradius!(g::T,radius,positions=[]) where T <: MetaGraphs.AbstractMetaGraph
        tree = NearestNeighbors.KDTree(positions)
        for (source, neighbours) in enumerate(NearestNeighbors.inrange(tree, positions, radius))
            for n in neighbours
                if source != n
                    MetaGraphs.add_edge!(g,source,n)
                end
            end
        end
    end

    """
        random_geometric_graph(n,radius;dim=2)

    Generate a random geometric graph on the unit hypercube of dimension `dim` with `n` nodes and links added between nodes who are less than `radius` apart under the euclidean metric.

    """
    function random_geometric_graph(n,radius;dim=2)
        g = MetaGraphs.MetaGraph(n)
        positions = rand(dim,n)
        for i in 1:n
            MetaGraphs.set_prop!(g,i,:position,positions[:,i])
        end
        addedgesinradius!(g,radius,positions)
        g
    end

end
