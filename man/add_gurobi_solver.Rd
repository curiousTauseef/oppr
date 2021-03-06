% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/add_gurobi_solver.R
\name{add_gurobi_solver}
\alias{add_gurobi_solver}
\title{Add a \pkg{Gurobi} solver}
\usage{
add_gurobi_solver(
  x,
  gap = 0,
  number_solutions = 1,
  solution_pool_method = 2,
  time_limit = .Machine$integer.max,
  presolve = 2,
  threads = 1,
  first_feasible = 0,
  verbose = TRUE
)
}
\arguments{
\item{x}{\linkS4class{ProjectProblem} object.}

\item{gap}{\code{numeric} gap to optimality. This gap is relative when
solving problems using \pkg{gurobi}, and will cause the optimizer to
terminate when the difference between the upper and lower objective
function bounds is less than the gap times the upper bound. For example, a
value of 0.01 will result in the optimizer stopping when the difference
between the bounds is 1 percent of the upper bound. For
other solvers, this is the absolute gap, so if the optimal value for
a maximization problem is 10, a gap of 0.01 means that a solution between
10 and 10.01 is required. Defaults to 0, so that optimal solutions will be
returned.}

\item{number_solutions}{\code{integer} number of solutions desired.
Defaults to 1. Note that the number of returned solutions can sometimes
be less than the argument to \code{number_solutions} depending on the
argument to \code{solution_pool_method}, for example if 100
solutions are requested but only 10 unique solutions exist, then only 10
solutions will be returned.}

\item{solution_pool_method}{\code{numeric} search method identifier that
determines how multiple solutions should be generated. Available search
modes for generating a portfolio of solutions include: \code{0}
recording all solutions identified whilst trying to find
a solution that is within the specified optimality gap, \code{1} finding
one solution within the optimality gap and a number of additional
solutions that are of any level of quality (such that the total number of
solutions is equal to \code{number_solutions}), and \code{2} finding a
specified number of solutions that are nearest to optimality. For more
information, see the \emph{Gurobi} manual (i.e. \url{http://www.gurobi.com/documentation/8.0/refman/poolsearchmode.html#parameter:PoolSearchMode}). Defaults to 2.}

\item{time_limit}{\code{numeric} time limit in seconds to run the optimizer.
The solver will return the current best solution when this time limit is
exceeded.}

\item{presolve}{\code{integer} number indicating how intensively the
solver should try to simplify the problem before solving it. The default
value of 2 indicates to that the solver should be very aggressive in
trying to simplify the problem.}

\item{threads}{\code{integer} number of threads to use for the
optimization algorithm. The default value of 1 will result in only
one thread being used.}

\item{first_feasible}{\code{logical} should the first feasible solution be
be returned? If \code{first_feasible} is set to \code{TRUE}, the solver
will return the first solution it encounters that meets all the
constraints, regardless of solution quality. Note that the first feasible
solution is not an arbitrary solution, rather it is derived from the
relaxed solution, and is therefore often reasonably close to optimality.
Defaults to \code{FALSE}.}

\item{verbose}{\code{logical} should information be printed while solving
optimization problems?}
}
\value{
\linkS4class{ProjectProblem} object with the solver added
to it.
}
\description{
Specify that the \emph{Gurobi} software should be used to solve a
project prioritization \code{\link[=problem]{problem()}}. This function can also be
used to customize the behavior of the solver. In addition to the
\emph{Gurobi} software suite, it also requires the \pkg{gurobi} package to
be installed.
}
\details{
\href{http://gurobi.com}{\emph{Gurobi}} is a
state-of-the-art commercial optimization software with an R package
interface. It is by far the fastest of the solvers supported by this
package, however, it is also the only solver that is not freely
available. That said, licenses are available to academics at no cost. The
\pkg{gurobi} package is distributed with the \emph{Gurobi} software suite.
This solver uses the \pkg{gurobi} package to solve problems.

To install the \pkg{gurobi} package, the
\href{https://www.gurobi.com}{Gurobi} optimization suite will first need to
be installed (see instructions for \href{http://www.gurobi.com/documentation/8.1/quickstart_linux/software_installation_guid.html}{Linux},
\href{http://www.gurobi.com/documentation/8.1/quickstart_mac/software_installation_guid.html}{Mac OSX}, and
\href{http://www.gurobi.com/documentation/8.1/quickstart_windows/software_installation_guid.html}{Windows} operating systems). Although
\href{https://www.gurobi.com}{Gurobi} is a commercial software, academics
can obtain a
\href{https://www.gurobi.com/downloads/end-user-license-agreement-academic/}{special license for no cost}. After installing the
\href{https://www.gurobi.com}{Gurobi} optimization suite, the \pkg{gurobi}
package can then be installed (see instructions for \href{http://www.gurobi.com/documentation/8.1/quickstart_linux/r_installing_the_r_package.html}{Linux},
\href{http://www.gurobi.com/documentation/8.1/quickstart_mac/r_installing_the_r_package.html}{Mac OSX}, and
\href{http://www.gurobi.com/documentation/8.1/quickstart_windows/r_installing_the_r_package.html}{Windows} operating systems).
}
\examples{
\donttest{
# load data
data(sim_projects, sim_features, sim_actions)

# build problem
p1 <- problem(sim_projects, sim_actions, sim_features,
             "name", "success", "name", "cost", "name") \%>\%
     add_max_richness_objective(budget = 200) \%>\%
     add_binary_decisions()

# build another problem, and specify the Gurobi solver
p2 <- p1 \%>\%
      add_gurobi_solver()

# print problem
print(p2)

# solve problem
s2 <- solve(p2)

# print solution
print(s2)

# plot solution
plot(p2, s2)

# build another problem and obtain multiple solutions
# note that this problem doesn't have 100 unique solutions so
# the solver won't return 100 solutions
p3 <- p1 \%>\%
      add_gurobi_solver(number_solutions = 100)

# print problem
print(p3)

# solve problem
s3 <- solve(p3)

# print solutions
print(s3)
}
}
\seealso{
\link{solvers}.
}
