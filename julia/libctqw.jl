function omega(n,l)
    # get lth eigenvalue/frequency
    2*cos(2*pi*l/n)
end

function U_naive(n,j)
    # calculate (j,1) entry of transition matrix naively
    t->expm(im*t*adj_cycle(n))[j,1]

function U_oddcyc(n,j)
    t->(1/n)*(exp(2*im*t)+2*sum([cos(2*pi*l*(j-1)/n)*exp(im*omega(n,l)*t) for l in 1:div(n-1,2)]))
end

function roots(n,j)
    [exp(2*pi*im*l*j/n) for l in 0:(n-1)]
end

function omegas(n)
    [omega(n,l) for l in 0:(n-1)]
end

function adj_cycle(n)
    # adjacency matrix of cycle
    ent = (i,j)->(abs(i-j) % n in [1, n-1] ? 1 : 0)
    A = [ent(i,j) for i in 0:(n-1), j in 0:(n-1)]
    Array{Complex{Float64}}(A)
end

function U_evencyc(n,j)
    half_n = div(n,2)
    upperbound = half_n - 1
    mfreqs = omegas(n)
    mroots = roots(n,j)
    if (iseven(j))
        # suboptimal; there is an extra symmetry to be exploited here (only need ~n/4 cosines)
        return t->( (1/half_n) * sum([(mroots[l+1])*cos(mfreqs[l+1]*t) for l in 0:upperbound]) )
    else
        println("Warning: odd j not implemented")
        return t->0
    end
end
