using PyPlot

# question 1.1.4; little miffed.
function question11()
    Xs = [2.0^p for p in -7:-2]
    Ts = [2.0^p for p in -7:-2]
    Ths = [x for x in (0:4)/4.0]

    timer = function (dx, dt)
        tic();
        err = q11error(dx,dt,1/2)
        t = toc()
        return err*t
    end

    EffErr = reshape( pmap( tuple -> timer(tuple...), [ (dx, dt) for dx in Xs, dt in Ts]), size(Xs * Ts') )

    clf()
    contourf( log.([dx for dx in Xs, dt in Ts]), log.([dt for dx in Xs, dt in Ts]), log.(EffErr))
    xlabel("log delta-x")
    ylabel("log delta-t")
end


@everywhere function gcn(u, dx, dt, theta)
    # V = u^n+1
    # Av = Bu
    omega = dt/(dx^2)
    N = length(u)

    # return argument mod N, guaranteed to be in [0,N-1]
    function wrapmod(i)
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

@everywhere function q11error(Δx,Δt,θ)
    N = round(Int, 1/Δt)
    M = round(Int, 2*pi/Δx)
    Ω = Δt / (Δx)^2

    X = (1:M)*Δx

    u0 = sin(X)
    η = (x,t) -> sin(x)*exp(-t) 
    Ex = η(X, 1)

    u = u0

    for i = 1:N
        u = gcn(u,Δx,Δt,θ)
    end

    Ans = u

    return maximum( abs(Ans - Ex) )
end

# weird scheme for advection
function question12()

end

function q12error()

end
