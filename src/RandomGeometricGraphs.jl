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
        for (source, neighbours) in enumerate(NearestNeighbors.inrange(tree, positions,radius))
            for n in neighbours
                if source != n
                    MetaGraphs.add_edge!(g,source,n)
                end
            end
        end
    end

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
