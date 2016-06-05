using DifferentialEquations, Plots, EllipsisNotation
srand(100)
prob = oval2ModelExample()

sol =solve(prob::SDEProblem,[0;10],Δt=1//2^(10),fullSave=true,alg="SRI",adaptiveAlg="RSwM3",adaptive=true,progressBar=true,saveSteps=1000,abstol=1e-6,reltol=1e-4)
evim = Any[sol.uFull[..,16];sol.uFull[..,17]]
p1 = plot(sol.tFull,sol.uFull[..,16],top_margin=50px,title="Ecad")
p2 = plot(sol.tFull,sol.uFull[..,17],top_margin=50px,title="Vim")
plot(p1,p2)
gui()
