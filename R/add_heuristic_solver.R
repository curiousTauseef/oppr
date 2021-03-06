#' @include Solver-proto.R
NULL

#' Add a heuristic solver
#'
#' Specify that solutions should be generated using a backwards step-wise
#' heuristic algorithm (inspired by Cabeza *et al.* 2004,
#' Korte & Vygen 2000, Probert *et al.* 2016). Ideally,
#' solutions should be generated using exact algorithm solvers (e.g.
#' [add_rsymphony_solver()] or [add_gurobi_solver()])
#' because they are guaranteed to identify optimal solutions (Rodrigues & Gaston
#' 2002).
#'
#' @inheritParams add_gurobi_solver
#'
#' @param initial_sweep `logical` value indicating if projects and
#'   actions which exceed the budget should be automatically excluded
#'   prior to running the backwards heuristic. This step prevents
#'   projects which exceed the budget, and so would never be selected in
#'   the final solution, from biasing the cost-sharing calculations.
#'   However, previous algorithms for project prioritization have not
#'   used this step (e.g. Probert *et al.* 2016).
#'   Defaults to `TRUE`.
#
#' @details The heuristic algorithm used to generate solutions is described
#'  below. It is heavily inspired by the cost-sharing backwards heuristic
#'  algorithm conventionally used to guide the prioritization of species
#'  recovery projects (Probert *et al.* 2016).
#'
#'  \enumerate{
#'
#'  \item All actions and projects are initially selected for funding.
#'
#'  \item A set of rules are then used to deselect actions and projects
#'    based on locked constraints (if any). Specifically, (i) actions which are
#'    which are locked out are deselected, and (ii) projects which are
#'    associated with actions that are locked out are also deselected.
#'
#'  \item If the argument to `initial_sweep` is `TRUE`, then a set of
#'    rules are then used to deselect actions and projects
#'    based on budgetary constraints (if present). Specifically, (i) actions
#'    which exceed the budget are deselected, (ii) projects which are
#'    associated with a set of actions that exceed the budget are deselected,
#'    and (iii) actions which are not associated with any project (excepting
#'    locked in actions) are also deselected.
#'
#'  \item If the objective function is to maximize biodiversity subject
#'    to budgetary constraints (e.g. [add_max_richness_objective()])
#'    then go to step 5. Otherwise, if the objective is to minimize cost
#'    subject to biodiversity constraints (i.e.
#'    [add_min_set_objective()]) then go to step 7.
#'
#'  \item The next step is repeated until (i) the number of desired
#'    solutions is obtained, and (ii) the total cost of the remaining
#'    actions that are selected for funding is within the budget. After both of
#'    these conditions are met, the algorithm is terminated.
#'
#'  \item Each of the remaining projects that are currently selected for
#'    funding are evaluated according to how much the performance of the
#'    solution decreases when the project is deselected for funding, relative to
#'    the cost of the project not shared by other remaining projects. This can
#'    be expressed mathematically as:
#'
#'    \deqn{B_j = \frac{V(J) - V(J - j)}{C_j}}{B_j = (V(J) - V(J - j)) / C_j}
#'
#'    Where \eqn{J} is the set of remaining projects currently
#'    selected for funding (indexed by \eqn{j}), \eqn{B_j} is the benefit
#'    associated with funding project \eqn{j}, \eqn{V(J)} is the objective
#'    value associated with the solution where all remaining projects are
#'    funded, \eqn{V(J - j)} is the objective value associated with the
#'    solution where all remaining projects except for project \eqn{j} are
#'    funded, and \eqn{C_j} is the sum cost of all of the actions
#'    associated with project \eqn{j}---excluding locked in actions---with the
#'    cost of each action divided by the total number of remaining
#'    projects that share the action (e.g. if two projects both share a $100
#'    action, then this action contributes $50 to the overall cost of each
#'    project).
#'
#'    The project with the smallest benefit (i.e. \eqn{B_j} value) is then
#'    deselected for funding. In cases where multiple projects have
#'    the same benefit (\eqn{B_j}) value, the project with the greatest overall
#'    cost (including actions which are shared among multiple remaining
#'    projects) is deselected.
#'
#'  \item The next step is repeated until (i) the number of desired
#'    solutions is obtained or (ii) no action can be deselected for funding
#'    without the probability of any feature expecting to persist falling below
#'    its target probability of persistence. After one or both of
#'    these conditions are met, the algorithm is terminated.
#'
#'  \item Each of the remaining projects that are currently selected for
#'    funding are evaluated according to how much the performance of the
#'    solution decreases when the project is deselected for funding, relative to
#'    the cost of the project not shared by other remaining projects. This can
#'    be expressed mathematically as:
#'
#'    \deqn{B_j = \frac{\big(\sum_{f}^{F} P_f(J) - T_f \big) -
#'    \big( \sum_{f}^{F} P_f(J - j) - T_f \big)}{C_j}}{
#'    B_j = ((sum_f^F P_f(J) - T_f) - (sum_f^F P_f(J - j) - T_f)) / C_j}
#'
#'    Where \eqn{F} is the set of features (indexed by \eqn{f}),
#'    \eqn{T_f} is the target for feature \eqn{f}, \eqn{P} is the set of
#'    remaining projects that are selected for funding (indexed by \eqn{j}),
#'    \eqn{C_j} is the cost of all of the actions
#'    associated with project \eqn{j}---excluding locked in actions---and
#'    accounting for shared costs among remaining projects (e.g. if two
#'    projects both share a $100 action, then this action contributes $50 to
#'    the overall cost of each project), \eqn{B_p} is the benefit
#'    associated with funding project \eqn{p}, \eqn{P(J)} is probability
#'    that each feature is expected to persist when the remaining projects
#'    (\eqn{J}) are funded, and \eqn{P(J - j)} is the probability that
#'    each feature is expected to persist when all the remaining projects except
#'    for action \eqn{j} are funded.
#'
#'    The project with the smallest benefit (i.e. \eqn{B_j} value) is then
#'    deselected for funding. In cases where multiple projects have
#'    the same \eqn{B_j} value, the project with the greatest overall cost
#'    (including actions which are shared among multiple remaining projects)
#'    is deselected.
#'
#' }
#'
#' @inherit add_gurobi_solver seealso return
#'
#' @references
#' Rodrigues AS & Gaston KJ (2002) Optimisation in reserve selection
#' procedures---why not? *Biological Conservation*, **107**,
#' 123--129.
#'
#' Cabeza M, Araujo MB, Wilson RJ, Thomas CD, Cowley MJ & Moilanen A (2004)
#' Combining probabilities of occurrence with spatial reserve design.
#' *Journal of Applied Ecology*, **41**, 252--262.
#'
#' Korte B & Vygen J (2000)
#' *Combinatorial Optimization. Theory and Algorithms*. Springer-Verlag,
#' Berlin, Germany.
#'
#' Probert W, Maloney RF, Mellish B, and Joseph L (2016)
#' Project Prioritisation Protocol (PPP). Available at
#' <https://github.com/p-robot/ppp>.
#'
#' @examples
#' # load ggplot2 package for making plots
#' library(ggplot2)
#'
#' # load data
#' data(sim_projects, sim_features, sim_actions)
#'
#' # build problem with heuristic solver and $200
#' p1 <- problem(sim_projects, sim_actions, sim_features,
#'              "name", "success", "name", "cost", "name") %>%
#'      add_max_richness_objective(budget = 200) %>%
#'      add_binary_decisions() %>%
#'      add_heuristic_solver()
#'
#' # print problem
#' print(p1)
#'
#' \donttest{
#' # solve problem
#' s1 <- solve(p1)
#'
#' # print solution
#' print(s1)
#'
#' # plot solution
#' plot(p1, s1)
#' }
#' @name add_heuristic_solver
NULL

#' @export
#' @rdname Solver-class
methods::setClass("HeuristicSolver", contains = "Solver")

#' @rdname add_heuristic_solver
#' @export
add_heuristic_solver <- function(x, number_solutions = 1,
                                 initial_sweep = TRUE, verbose = TRUE) {
  # assert that arguments are valid
  assertthat::assert_that(inherits(x, "ProjectProblem"),
                          assertthat::is.count(number_solutions),
                          assertthat::noNA(number_solutions),
                          assertthat::is.flag(initial_sweep),
                          assertthat::noNA(initial_sweep),
                          assertthat::is.flag(verbose),
                          assertthat::noNA(verbose))
  # add solver
  x$add_solver(pproto(
    "HeuristicSolver",
    Solver,
    name = "Heuristic",
    parameters = parameters(
      integer_parameter("number_solutions", number_solutions, lower_limit = 0L,
                        upper_limit = as.integer(.Machine$integer.max)),
      binary_parameter("initial_sweep", initial_sweep),
      binary_parameter("verbose", verbose)),
    solve = function(self, x, ...) {
      # extract data
      locked_in <- which(x$lb()[seq_len(x$number_of_actions())] > 0.5)
      locked_out <- which(x$ub()[seq_len(x$number_of_actions())] < 0.5)
      # preliminary data calculations
      fp <- x$data$feature_phylogeny()
      bm <- branch_matrix(fp, FALSE)
      bo <- rcpp_branch_order(bm)
      if (!is.Waiver(x$data$targets)) {
        targets <- x$data$targets$output()$value
      } else {
        targets <- rep(0, length(fp$tip.label))
      }
      if (inherits(x$data$objective, "MinimumSetObjective")) {
        budget <- Inf
      } else {
        budget <- x$data$objective$parameters$get("budget")
      }
      # generate solutions
      runtime <- system.time({
        s <- rcpp_heuristic_solution(
          x$data$action_costs(),
          x$data$pa_matrix(),
          x$data$epf_matrix()[, fp$tip.label, drop = FALSE],
          bm[, bo, drop = FALSE],
          fp$edge.length[bo],
          targets, x$data$feature_weights()[fp$tip.label], budget,
          locked_in, locked_out,
          self$parameters$get("number_solutions"),
          as.logical(self$parameters$get("initial_sweep")),
          as.logical(self$parameters$get("verbose")),
          class(x$data$objective)[1])
      })
      # subset s if more solutions returned then desired
      if (nrow(s) > self$parameters$get("number_solutions"))
        s <- s[seq_len(self$parameters$get("number_solutions")), , drop = FALSE]
      # convert s to integers
      s <- round(s)
      # format solution data
      lapply(seq_len(nrow(s)), function(i) {
        list(x = s[i, , drop = TRUE], objective = NA_real_,
             status = NA_character_, runtime = runtime)
      })
    }))
}
