using PyPlot

# QUESTION 3
function question31()
    ωs = map(x -> 2.0^x, 0:6)
    Es = q31error.(ωs)

    clf()
    loglog(ωs, Es)
    xlabel("log-\$\\omega\$")
    ylabel("log-error")
    savefig("question31errorVw.png")
end

# constant β. error decreases with omega cause
# sampling hits the peaks better.
function q31error(ω)
    N = 128
    X = (1:N) *2*pi/N
    Y = X
    G = [(x,y) for x in X, y in X]

    # beta
    β = (x,y) -> 1
    B = [β(x,y) for x in X, y in Y]

    # exact
    η = (x, y) -> -ω^(-2)*sin(ω*x)cos(ω*y)/2
    Ex = [η(x,y) for x in X, y in Y]

    # f
    f = (x, y) -> sin(ω*x)cos(ω*y)
    F = [f(x,y) for x in X,  y in Y]

    # ikx,iky, from God. Better way would be to iterate over rows... TODO
    ikx = 1.0im*ones(1,N)'*( mod((1:N)-ceil(N/2+1), N) - floor(N/2))'
    iky = 1.0im*( mod((1:N)'-ceil(N/2+1), N) - floor(N/2))'*ones(1,N)

    # antidiffing; this is a little "write-once, read-never" TODO
    antidx = fft(F) |> Fhat -> ikx.\Fhat |> F -> (F[:, 1] = 0; F) |> ifft |> real
    antidy = fft(F) |> Fhat -> iky.\Fhat |> F -> (F[1, :] = 0; F) |> ifft |> real

    antilaplace = x -> fft(x) |> Fhat -> (ikx.^2 + iky.^2).\Fhat |> F -> (F[1,1] = 0; F) |> ifft |> real

    Ans = F |> antilaplace

    return maximum(abs(Ans - Ex))
end

# ce ne marche pas
function question32()
    
end

question31()
