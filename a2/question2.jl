using PyPlot

# QUESTION 2

## Should be almost zero from beginning
function question21()
    Ns = 2.^(2:12)
    Hs = map( x -> 1/x, Ns)
    Es = map( q21error,  Ns)

    println("Question 2.1 errors")
    println(Es)

    clf()
    loglog(Hs, Es)
    xlabel("log-h")
    ylabel("log-error")
    savefig("question21errorVh.png")
end

function q21error(N)
    start = 0
    finish = 2*pi

    L = finish-start
    X = (1:N)*2*pi/N

    set_constant_zero = A -> begin
        A[1] = 0
        A
    end

    ik_maker = (N, L) -> 1.0im*(mod((1:N)-ceil(N/2+1), N)-floor(N/2))*L/(2*pi)
    ik = ik_maker(N, L)

    take_dx =  x -> ik .* fft(x) |>  ifft |> real
    take_antidx = x -> ik .\ fft(x) |> set_constant_zero |> ifft |> real

    beta = 2 + sin(X)
    f = x -> cos(2*x) - 2*sin(x)
    exact = x -> sin(x)

    ans = X |> f |> take_antidx |> x -> beta.\x |> take_antidx

    return maximum(abs(ans - exact(X)) )
end

function question22()
    Ns = 2.^(2:12)
    Hs = map( x -> 1/x, Ns)
    Es = map( q22error,  Ns)

    println("Question 2.2 errors")
    println(Es)

    clf()
    loglog(Hs, Es)
    xlabel("log-h")
    ylabel("log-error")
    savefig("question22errorVh.png")
end

## discontinuous coefficients - error should approach constatn
## because of Gibbs'
function q22error(N)
    start = 0
    finish = 2*pi

    L = finish-start
    X = (1:N)*2*pi/N

    set_constant_zero = A -> begin
        A[1] = 0
        A
    end

    ik_maker = (N, L) -> 1.0im*(mod((1:N)-ceil(N/2+1), N)-floor(N/2))*L/(2*pi)
    ik = ik_maker(N, L)
    take_dx =  x -> ik .* fft(x) |>  ifft |> real
    take_antidx = x -> ik .\ fft(x) |> set_constant_zero |> ifft |> real

    # beta
    β = function (x)
        if x<pi/2 || x>=3*pi/2
            return 1
        end

        return 2
    end

    B = map(β, X)

    #exact
    η = function (x)
        if x<pi/2 || x>=3*pi/2
            return -(1/2)*sin(x)
        end

        return -sin(x)
    end

    Ex = map(η, X)
    Ans = X |> sin |> take_antidx |> x -> B.\x |> take_antidx

    return maximum( abs(Ans - Ex) )
end

question21()
question22()
