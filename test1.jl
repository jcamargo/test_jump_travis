import JuMP
import CPLEX

m = JuMP.Model()

# Add an integer variable to avoid error 3003 on CPLEX
JuMP.@variable(m, dummy, category=:Int)
JuMP.@variables m begin
    va[1:3] >= 0.0, Cont
end

JuMP.@objective(m, Max, 1*va[1] + 3*va[2] + 2*va[3])
JuMP.@constraint(m, sum(va[i] for i=1:3) == 1.0)
JuMP.setsolver(m, CplexSolver())

status = JuMP.solve(m)

println("Obj:", JuMP.getobjectivevalue(m))
println("x = ", JuMP.getvalue(va) )

α=1
β=3α
γ=α+β
