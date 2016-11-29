using PyPlot

# question 1.1.4; little miffed.
function question11()
    Xs = [2.0^p for p in -10:-2]
    Ts = [2.0^p for p in -10:-2]
    Ths = [x for x in (0:4)/4.0]

    timer = function (dx::Float64, dt::Float64)
        tic();
        err = q11error(dx,dt,1/2)
        t = toc()
        return err*t
    end

    EffErr = reshape( pmap( tuple -> timer(tuple...), [ (dx, dt) for dx in Xs, dt in Ts]), size(Xs * Ts') )

    clf()
    contourf( log.([dx for dx in Xs, dt in Ts]), log.([dt for dx in Xs, dt in Ts]), log.(EffErr), cmap=ColorMap("inferno") )      
    xlabel("log delta-x")
    ylabel("log delta-t")
end

# obsoleted
@everywhere function gcn(u::Array{Float64,1}, dx::Float64, dt::Float64, theta::Float64)
    # V = u^n+1
    # Av = Bu
    omega = dt/(dx^2)
    N = length(u)

    # return argument mod N, guaranteed to be in [0,N-1]
    function wrapmod(i::Int64)
        x = i%N
        if x >= 0
            return x
        else
            return x+( (-div(x, N)+1)*N)
        end
    end

    # the spatial stencil
    stencil = function(i,j)
        k = wrapmod(i-j)
        if k==0
            return -2
        elseif k==1 || k==N-1
            return 1
        else
            return 0
        end
    end

    # d2 matrix
    Dxx = [stencil(i,j) for i in 0:(N-1), j in 0:(N-1)]

    A = eye(N) - theta*omega*Dxx
    B = eye(N) + (1-theta)*omega*Dxx

    # solve and return
    v = A\(B*u)
end

@everywhere function q11error(Δx::Float64, Δt::Float64, θ::Float64)
    N = round(Int, 1/Δt)
    M = round(Int, 2*pi/Δx)
    omega = Ω = Δt / (Δx)^2
    theta = θ

    X = (1:M)*Δx

    u0 = sin(X)
    η = (x,t) -> sin(x)*exp(-t) 
    Ex = η(X, 1)

    u = u0

    function wrapmod(i::Int64)
        x = i%M
        if x >= 0
            return x
        else
            return x+( (-div(x, M)+1)*M)
        end
    end

    # the spatial stencil
    stencil = function(i,j)
        k = wrapmod(i-j)
        if k==0
            return -2
        elseif k==1 || k==M-1
            return 1
        else
            return 0
        end
    end


    # d2 matrix
    Dxx = [stencil(i,j) for i in 0:(M-1), j in 0:(M-1)]

    A = eye(M) - theta*omega*Dxx
    B = eye(M) + (1-theta)*omega*Dxx

    C = A\B

    for i = 1:N
        u = C*u
    end

    Ans = u

    return maximum( abs(Ans - Ex) )
end

# weird scheme for advection
function question12()

end

function q12error()

end

question11()
