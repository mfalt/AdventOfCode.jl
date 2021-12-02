include("../utils.jl")

day2_1(data) = mapreduce(
    v-> split(v) |> v -> (v[1], parse(Int,v[2])) |>
    v-> (v[1] == "forward" ? (v[2],0) : v[1] == "down" ? (0,v[2]) : (0,-v[2])),
    .+, data, init=(0,0)) |> prod

day2_2(data) = mapfoldl(
    v-> split(v) |> v -> (v[1], parse(Int,v[2])) |>
    v-> (v[1] == "forward" ? (v[2],0) : v[1] == "down" ? (0,v[2]) : (0,-v[2])),
    (prev, new) -> (
        prev[1] + new[1],         # Add to horizontal
        prev[2] + new[1]*prev[3], # Add to vertical
        prev[3] + new[2]),        # Add to aim
    data, init=(0,0,0)) |> v-> v[1]*v[2]
        
data = readfile("day2/input.txt")

t1 = @belapsed day2_1(data)
t2 = @belapsed day2_2(data)

println("Day 1:") 
println("  res   : ", day2_1(data), ", ", day2_2(data))
@printf "  time  : %.2e, %.2e\n" t1 t2