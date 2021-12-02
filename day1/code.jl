include("../utils.jl")

function day1_1(data)
    prev = typemax(Int)
    s = 0
    for dat in data
        s += dat>prev
        prev = dat
    end
    s
end

function day1_2(data)
    prevs = (typemax(Int),typemax(Int),typemax(Int))
    s = 0
    for dat in data
        s += dat>prevs[1]
        prevs = (prevs[2], prevs[3], dat)
    end
    s
end

function day1_2_naive(data)
    prev = typemax(Int)
    s = 0
    @inbounds for i in 1:(length(data)-2)
        sum3 = data[i]+data[i+1]+data[i+2]
        s += sum3>prev
        prev = sum3
    end
    s
end

day1_1_min(data) = foldl(
        (prev,now) -> (now, prev[2] + Int(now>prev[1])), # Save old in first element
        data, init=(typemax(Int),0))[2] # typemax to not count first, start sum at 0

day1_2_min(data) = foldl(
        (prev,now) -> (prev[2], prev[3], now, prev[4] + Int(now>prev[1])), # Save old in 3 first elements
        data, init=(typemax(Int),typemax(Int),typemax(Int),0))[4] # typemax to not count first, start sum at 0

data = readfile("day1/input.txt", Int)

t1 = @belapsed day1_1(data)
t1_min = @belapsed day1_1_min(data)
t2 = @belapsed day1_2(data)
t2_min = @belapsed day1_2_min(data)

println("Day 1:") 
println("  res   : ", day1_1(data), ", ", day1_2(data))
@printf "  time  : %.2e, %.2e\n" t1 t2
@printf "  t mini: %.2e, %.2e\n" t1_min t2_min