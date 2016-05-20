######
##FEM Heat Δt Convergence Tests
######
using DifferentialEquations

#Convergences estimate has not converged in this range
#Should decrease Δx/Δt for better estimate
N = 2 #Number of different Δt to solve at, 2 for test speed
topΔt = 5 # 1//2^(topΔt-1) is the max Δt. Small for test speed
prob = heatProblemExample_moving() #also try heatProblemExample_pure() or heatProblemExample_diffuse()
Δts = 1.//2.^(topΔt-1:-1:N)
Δxs = 1//2^(5) * ones(Δts) #Run at 2^-7 for best plot


alg = "Euler"; println(alg) #Unstable due to μ
convsim = testConvergence(Δts::AbstractArray,Δxs::AbstractArray,prob::HeatProblem;alg=alg)

alg = "ImplicitEuler"; println(alg)
convsim2 = testConvergence(Δts::AbstractArray,Δxs::AbstractArray,prob::HeatProblem;alg=alg)

alg = "CrankNicholson"; println(alg) #Bound by spatial discretization error at low Δt, decrease Δx for full convergence
convsim3 = testConvergence(Δts::AbstractArray,Δxs::AbstractArray,prob::HeatProblem;alg=alg)

convplot_fullΔt(convsim3,titleStr="Crank-Nicholson Convergence Plots")
#Note: Stabilizes in H1 due to high Δx-error, reduce Δx and it converges further.

#Returns true if ImplicitEuler converges like Δt and
#CN convergeces like >Δt^2 (approaches Δt^2 as Δt and Δx is smaller
minimum([abs(convsim2.𝒪est["L2"]-1)<.3 convsim3.𝒪est["L2"]>2])
