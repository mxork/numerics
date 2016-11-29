---
title: Math 578 Assignment 2
author: |
 Daniel Anderson
 260457325
date: Fall 2016
---

## Question 1.1

### Question 1.1.1 

Plug the exact solution into the scheme, expand out the Taylor series, cancel and collect terms.
Throughout, we denote $u^{n+k}_{j+i}$ as $u^k_i$, and $u^n_j$ as $u$. Let $\hat{u}$ be the exact solution.

\begin{align*}
  \text{LTE} &= |\hat{u}^{n+1} + u^{n+1} |  \\
  &= | u + u_t \Delta t + u_{tt} \frac{\Delta t}{2} + O(\Delta t^3) - [u + \Omega(1-\theta)(u_{xx}\Delta x^2 + O(\Delta x^4)) ) + \Omega \theta (u^{n+1}_{xx}\Delta x^2 + O(\Delta x^4)) ] ] | \\
\end{align*}

Now we apply $u_t = u_xx$, and Taylor expand the $u^{n+1}_xx$ with respect to time, to obtain:

\begin{align*}
  &= | (1- 2\theta)u_{tt}\frac{\Delta t^2}{2} + O(\Delta t^3) + O(\Delta t \Delta x^2)|
\end{align*}

Where we have folded some $\theta$ into the big-$O$ terms.

### Question 1.1.2

Let $u=e^{ikx}$, $\Omega = \frac{\Delta t}{\Delta x^2}$ sub into the scheme:

\begin{align*}
G -1 &= \Omega[(1-\theta)( e^{ikx} + e^{-ikx} -2 ) + \theta G( e^{ikx} + e^{-ikx} -2 )]  \\
G &= 1 + 2\Omega(1-\theta) + 2\Omega G \theta y 
\end{align*}

After letting $y= e^{ikx} + e^{-ikx} -2$. Solving for G gets us: 

\begin{align*}
G &= \frac{2\Omega(1-\theta)y}{1-2\Omega\theta y}
\end{align*}

And our stability restriction is $|G| \leq 1$, which does not have a convenient form
in terms of $\theta$, $\Delta x$, $\Delta t$.

### Question 1.1.3 

Picking $\theta=\frac{1}{2}$ is obvious: it gets us $max(O(\Delta t^3), \Delta t O(\Delta x^2))$ accuracy for no extra cost compared to any $\theta$ value not equal to 0. We are also guaranteed
stability.

Now, considering the balance of $\Delta t$ and $\Delta x$, we derive an expression for the product of 
computer runtime, $C = \Delta t \Delta x$, and global error, $E = \frac{\text{LTE}}{\Delta t}$, which seems to be as good a metric as any.

\begin{align*}
  CE &= (\Delta x \Delta t)\frac{\Delta t^3 + \Delta t \Delta x^2}{\Delta t} \\
      &= \Delta x(\Delta t^3 + \Delta t \Delta x^2) \\
      & = \Delta x \Delta t^3 + \Delta t \Delta x^3
\end{align*}

We wind up with $\theta=\frac{1}{2}$, and $\Delta t = (\Delta x)^2$

### Question 1.1.4

Let $f(x,t) = \sin{x}$. <!-- TODO is contant wrt t a cop out? --> Then, taking
the Fourier series of both sides gets us:

<!-- TODO double check exact solution -->

\begin{align*}
  d_t\hat{u}_n &= -n^2\hat{u}_n + \bf{1}_{n=1} \\
  d_t\hat{u}_n &= -n^2\hat{u}_n + \bf{1}_{n=1} 
\end{align*}

<!-- TODO efficency plot -->

So, assuming that $u_0 = 0$, we run the scheme to $t=1$. We wind up with a plot
of our "efficiency surface", (efficiency $= (CE)^{-1}$ ).

## Question 1.2

### Question 1.2.1

We need fourth derivative, so we need at least five points. Since
we are taking a centered difference, we pick up second-order at no
extra cost. Solve:

\begin{align*}
 \begin{pmatrix}
   1 & 1 & 1 & 1 & 1  \\
   -2h & -h & 0 & h & 2h  \\
   -2h^2 & -h^2 & 0 & h^2 & 2h^2  \\
   -2h^3 & -h^3 & 0 & h^3 & 2h^3  \\
   -2h^4 & -h^4 & 0 & h^4 & 2h^4
 \end{pmatrix}
 \begin{pmatrix}
   c_{-2} \\ c_{-1} \\ c_0 \\ c_1 \\ c_2
 \end{pmatrix}
 &=  
 \begin{pmatrix}
   0 \\ 0 \\ 0 \\ 0 \\ 1
 \end{pmatrix}
\end{align*}

And obtain:

\begin{align*}
 \begin{pmatrix}
   c_{-2} \\ c_{-1} \\ c_0 \\ c_1 \\ c_2
 \end{pmatrix}
 &= \frac{1}{24h^4} 
 \begin{pmatrix}
   1 \\ -4 \\ 6 \\ -4 \\ 1
 \end{pmatrix}
\end{align*}

### Question 1.2.2

\begin{align*}
  \text{LTE} &= |\hat{u}^{n+1} + u^{n+1} |  \\
  &= | u_t\Delta t + u_{tt}\frac{\Delta t^2}{2} + O(\Delta t^3) 
    - \frac{\Delta t}{2\Delta x}(u_{j+1} - u_{j-1}) - \theta \Delta t [ u_{xxxx} + O(\Delta x^2)] | \\
  &= | u_t\Delta t + u_{tt}\frac{\Delta t^2}{2} + O(\Delta t^3) 
    - \Delta t [u_t + u_{xx}\Delta x + u_{xxx}\Delta x^2 + u_{xxxx}\Delta x^3 + O(\Delta x^4)] 
    - \theta \Delta t [ u_{xxxx} + O(\Delta x^2)] | \\
  &= |  u_{tt}\frac{\Delta t^2}{2} + O(\Delta t^3) 
    - \Delta t [u_{xx}\Delta x + u_{xxx}\Delta x^2 + u_{xxxx}\Delta x^3 + O(\Delta x^4)] 
    - \theta \Delta t [ u_{xxxx} + O(\Delta x^2)] |
\end{align*}

And we choose $\theta$ to match the coefficent of $u_{xxxx}$ from the first derivative stencil,
so $\theta = -1$. However, this will not do much to change the asymptotic behaviour, since 
$\Delta x^5$ was pretty darn small already.

### Question 1.2.3

<!-- TODO stability -->

\begin{align*}
  G-1 &=  \\
\end{align*}


### Question 1.2.4

Scheme cannot be second order and stable, because linear schemes can't be. (Godunov)

<!-- TODO modified equation approach? -->


## Question 1.3
  
## Question 1.3.1

Assume periodic conditions. Derive a nice expression for $u^{n+1}_{j+1} - u^{n+1}$.
Then, summing over all spatial indices, we have glorious cancellation and TVD. 

We use the same index convention as the first question: 
we denote $u^{n+k}_{j+i}$ as $u^k_i$, and $u^n_j$ as $u$.

Begin by rearranging the scheme:

\begin{align*}
  u^{n+1} &= u + D^-(u_{j-1}-u) + D^+(u_{j+1} - u) \\
\end{align*}

Where we have defined $D^i \equiv \Delta t C^i$.

Now, consider $u^{n+1}_{j+1} - u^{n+1}$

\begin{align*}
  u^{n+1}_{j+1} - u^{n+1} &=  u_{j+1} + D^-(u_{j}-u_{j+1}) + D^+(u_{j+2} - u_{j+1}) - [u + D^-(u_{j-1}-u) + D^+(u_{j+1} - u)] \\
                          &=  (1-D^- - D^+)(u_{j+1} - u) + D^+(u_{j+2} - u_{j+1}) +D^-(u - u_{j-1}) \\
|u^{n+1}_{j+1} - u^{n+1}| &\leq (1-D^- - D^+)|u_{j+1} - u| + D^+|u_{j+2} - u_{j+1}| +D^-|u - u_{j-1}| 
\end{align*}

If we now sum over all $j$, the $D$ terms cancel with the preceding and proceding terms, leaving the inequality:

\begin{align*}
 \sum_j |u^{n+1}_{j+1} - u^{n+1}| &  \leq \sum_j |u_{j+1} - u|
\end{align*}


## Question 1.3.2

This follows almost immediately from the linearity of the TV norm. We consider
the case of only two terms; the extension is easy. Let $v^{n+1} \equiv C^-(u_{j-1}-u) + C^+(u_{j+1}-u)$
$w^{n+1} \equiv D^-(u_{j-1}-u) + D^+(u_{j+1}-u)$, $u = \theta v + (1 - \theta) w$.

\begin{align*}
  TV(u^{n+1}) &= \theta TV(v^{n+1}) + (1 - \theta)TV(w^{n+1}) \\
  TV(u^{n+1}) &\leq \theta \max{TV(v^{n+1}), TV(w^{n+1})} + (1 - \theta)\max{TV(v^{n+1}), TV(w^{n+1})} \\
  TV(u^{n+1}) &\leq \max{TV(v^{n+1}), TV(w^{n+1})}  \\
  TV(u^{n+1}) &\leq TV(u)
\end{align*}

## Question 1.3.3

Is it a convex combination of Euler steps? Yes. So, yes.

# Question 2

## Question 2.1

Let $u=\sin{x}$. Then, $f(x)=\cos{2x}-2\sin{x}$.

Does $sin(x)$ count as trivial? Maybe. Regardless, the error is nearly 0 from the get go, since
a sine wave is well-represented by a truncated Fourier series.

![Question 2.1, $L^\infty$ error vs. h](question21errorVh.png)

## Question 2.2

Gibbs phenomenon: the $L^\infty$ error approaches a finite, non-zero amount when attempting
to represent an discontinous function with a truncated Fourier series.

![Question 2.2  $L^\infty$ error vs. h](question22errorVh.png)

# Question 3

## Question 3.1

$u = -\omega^2 sin(\omega x)cos(\omega y)$

The error is small since the frequency of our input function $f$ is below the Nyquist limit.

![Question 3.1 $L^\infty error$ vs. $\omega$](question31errorVw.png)

## Question 3.2

Damned if I know. been bashing my head against this one for a while.

## Question 3.3

Similarly.
