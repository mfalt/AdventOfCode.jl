using DelimitedFiles, BenchmarkTools, Printf

# Parse no-op
Base.parse(::Type{T}, v::T) where T = v
# Load chop
readfile(file; delim='\n') = split(readchomp(file), delim)
# Load chop parse
readfile(file, T; delim='\n') = parse.(T, readfile(file; delim))
