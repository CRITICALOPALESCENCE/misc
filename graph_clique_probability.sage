def prob_dist(G,depth=0):
    prefix = "~" * depth
    N = G.num_verts()
    if N == 0:
        return {0: 1}
    else:
    if G.is_vertex_transitive():
        print prefix + "Graph on %s vertices is VX transitive" % N
        der_G = G.subgraph(G.neighbors(G.vertices()[0]))
        if not G.is_connected():
            print prefix + "  ... but not connected!"
            G.show(); sleep(10)

        result = prob_dist(der_G,depth+1)
        return {k+1: result[k] for k in result}
    print prefix + "Graph on %s vertices is not VX transitive %s" % (N, "" if G.is_connected() else "\n" + prefix + "  ... and not connected!" )
    G.show(); sleep(10)
    grfs = map(lambda vx: (vx,G.subgraph(G.neighbors(vx))), G.vertices())
    dists = map(lambda H: prob_dist(H[1], depth+1), grfs)
    retval = {}
    for d in dists:
        for k in d:
            if not retval.has_key(k+1): retval[k+1] = 0
            retval[k+1] += d[k]*float(1/N)
    return retval

### Test
def predicate(S,l):
    return (lambda T: S.intersection(T).cardinality() == l)

def G(n,k,l):
    subs = list(Subsets(n,k))
    d = {S : filter(predicate(S,l), subs) for S in subs}
    return Graph(d)

def test():
    print "Testing on generalized Johnson graph G(11,5,2)."
    print "Wait..."
    sleep(1)
    print prob_dist(G(11,5,2))

#test()
