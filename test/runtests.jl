using RandomGeometricGraphs, LightGraphs, Test, Statistics

@testset "Boundaries" begin
    nodes = 100
    @test random_geometric_graph(nodes,0) |> edges |> length == 0
    @test random_geometric_graph(nodes,2) |> edges |> length ≈ nodes * (nodes - 1) / 2 atol=0.6
end

@testset "Equivalence to LightGraphs" begin
    nodes = 100
    dimensions = 2
    radius = 0.2
    lg_edges = [euclidean_graph(nodes,dimensions,cutoff=radius)[1] |> edges |> length for _ in 1:1000]
    rgg_edges = [random_geometric_graph(nodes,radius;dim=dimensions) |> edges |> length for _ in 1:1000]
    
    # This is an abuse of statistics
    @test mean(lg_edges) ≈ mean(rgg_edges) atol=std(lg_edges)
end

