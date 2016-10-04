function fr(t)
    plot(cos, sin, linspace(0,2*pi,1000), bgcolor=RGB(.2,.2,.2), size=(500,500), xlims=(-2.2,2.2), ylims=(-2.2,2.2))
    plot!(x->x, x->tan(t*a)*x, linspace(0,cos(t*a),2))
    plot!(x->x, x->tan(t*b)*x, linspace(0,cos(t*b),2))
    f = u->(exp(a*im*u)+exp(b*im*u))
    plot!(x->x*real(f(t)), x->x*imag(f(t)), linspace(0,1,2))
    plot!(u->real(f(u)), u->imag(f(u)), linspace(0,t,ceil(1000*t)))
end

function lissajous(A,B,a,b,delta,t)
    liss_x = u->A*sin(a*u+delta)
    liss_y = u->B*sin(b*u)
    plot(liss_x, liss_y, linspace(0,t,ceil(1000*t)), bgcolor=RGB(.2,.2,.2), size=(900,900), xlims=(-3,3), ylims=(-3,3))
end
