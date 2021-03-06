% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ProjectProblem-proto.R
\name{ProjectProblem-class}
\alias{ProjectProblem-class}
\alias{ProjectProblem}
\title{Project problem class}
\description{
Project problem class
}
\section{Description}{

This class is used to represent project prioritization problems. A
project prioritization problem has actions, projects,
and features. Features are the biological entities that need to
be conserved (e.g. species, populations, ecosystems). Actions are
real-world management actions that can be implemented for conservation
purposes (e.g. habitat restoration, monitoring, pest eradication). Each
action should have a known cost, and this usually means that each
action should have a defined spatial extent and time period (though this
is not necessary). Conservation projects are groups of management actions
(they can also comprise a singular action too), and each project is
associated with a probability of success if all of its associated actions
are funded. To determine which projects should be funded, each project is
associated with an probability of persistence for the
features that they benefit. These values should indicate the
probability that each feature will persist if only that project funded
and not the additional benefit relative to the baseline project. Missing
(\code{NA}) values should be used to indicate which projects do not
enhance the probability of certain features.

Given these data, a project prioritization problem involves making a
decision about which actions should be funded or not---and in turn, which
projects should be funded or not---to maximize or minimize a specific
objective whilst meeting specific constraints. The objective for a project
prioritization problem will \emph{always} pertain to the probability that
features are expected to persist. For example, an objective for a project
prioritization problem could be to maximize the maximize the total amount of
species that are expected to persist, or minimize the total cost of the
funded actions subject to constraints which ensure that each feature meets a
target level of persistence. The constraints in a project prioritization
problem can be used to specify additional requirements (e.g. certain
actions must be funded). Finally, a project prioritization problem---unlike
an optimization problem---also requires a method to solve the problem.
\strong{This class represents a planning problem, to actually build and then
solve a planning problem, use the \code{\link[=problem]{problem()}} function. Only
experts should use this class directly.}
}

\section{Fields}{

\describe{

\item{$data}{\code{list} object containing data.}

\item{$objective}{\linkS4class{Objective} object used to represent how
the targets relate to the solution.}

\item{$decisions}{\linkS4class{Decision} object used to represent the
type of decision made on planning units.}

\item{$targets}{\linkS4class{Target} object used to represent
representation targets for features.}

\item{$weights}{\linkS4class{Weight} object used to represent
feature weights.}

\item{$constraints}{\linkS4class{Collection} object used to represent
additional \link{constraints} that the problem is subject to.}

\item{$solver}{\linkS4class{Solver} object used to solve the problem.}

}
}

\section{Usage}{


\code{x$print()}

\code{x$show()}

\code{x$repr()}

\code{x$get_data(name)}

\code{x$set_data(name, value)}

\code{number_of_actions()}

\code{number_of_projects()}

\code{number_of_features()}

\code{action_names()}

\code{project_names()}

\code{feature_names()}

\code{feature_weights()}

\code{feature_phylogeny()}

\code{action_costs()}

\code{project_costs()}

\code{project_success_probabilities()}

\code{pf_matrix()}

\code{epf_matrix()}

\code{pa_matrix()}

\code{x$add_objective(obj)}

\code{x$add_decisions(dec)}

\code{x$add_constraint(con)}

\code{x$add_solver(sol)}

\code{x$add_targets(targ)}

\code{x$add_weights(wt)}

\code{x$get_constraint_parameter(id)}

\code{x$set_constraint_parameter(id, value)}

\code{x$render_constraint_parameter(id)}

\code{x$render_all_constraint_parameters()}

\code{x$get_objective_parameter(id)}

\code{x$set_objective_parameter(id, value)}

\code{x$render_objective_parameter(id)}

\code{x$render_all_objective_parameters()}

\code{x$get_solver_parameter(id)}

\code{x$set_solver_parameter(id, value)}

\code{x$render_solver_parameter(id)}

\code{x$render_all_solver_parameters()}
}

\section{Arguments}{


\describe{

\item{name}{\code{character} name for object.}

\item{value}{an object.}

\item{obj}{\linkS4class{Objective} object.}

\item{wt}{\linkS4class{Weight} object.}

\item{dec}{\linkS4class{Decision} object.}

\item{con}{\linkS4class{Constraint} object.}

\item{sol}{\linkS4class{Solver} object.}

\item{targ}{\linkS4class{Target} object.}

\item{wt}{\linkS4class{Weight} object.}

\item{id}{\code{Id} object that refers to a specific parameter.}

\item{value}{object that the parameter value should become.}

}
}

\section{Details}{

\describe{

\item{print}{print the object.}

\item{show}{show the object.}

\item{repr}{return \code{character} representation of the object.}

\item{get_data}{return an object stored in the \code{data} field with
the corresponding \code{name}. If the object is not present in the
\code{data} field, a \code{waiver} object is returned.}

\item{set_data}{store an object stored in the \code{data} field with
the corresponding name. If an object with that name already
exists then the object is overwritten.}

\item{number_of_actions}{\code{integer} number of actions.}

\item{number_of_projects}{\code{integer} number of projects.}

\item{number_of_features}{\code{integer} number of features.}

\item{action_names}{\code{character} names of actions in the problem.}

\item{project_names}{\code{character} names of projects in the problem.}

\item{feature_names}{\code{character} names of features in the problem.}

\item{feature_weights}{\code{character} feature weights.}

\item{feature_phylogeny}{\code{\link[ape:read.tree]{ape::phylo()}} phylogenetic tree object.}

\item{action_costs}{\code{numeric} costs for each action.}

\item{project_costs}{\code{numeric} costs for each project.}

\item{project_success_probabilities}{\code{numeric} probability that
each project will succeed.}

\item{pf_matrix}{
\link[Matrix:dgCMatrix-class]{Matrix::dgCMatrix} object denoting the enhanced
probability that features will persist if different projects are funded.}

\item{epf_matrix}{
\link[Matrix:dgCMatrix-class]{Matrix::dgCMatrix} object denoting the enhanced
probability that features is expected to persist if different projects are
funded. This is calculated as the \code{pf_matrix} multiplied by the
project success probabilities.}

\item{pa_matrix}{
\link[Matrix:dgCMatrix-class]{Matrix::dgCMatrix} object indicating which actions are
associated with which projects.}

\item{feature_targets}{\code{\link[tibble:tibble]{tibble::tibble()}} with feature targets.}

\item{add_objective}{return a new  \linkS4class{ProjectProblem}
with the objective added to it.}

\item{add_decisions}{return a new \linkS4class{ProjectProblem}
object with the decision added to it.}

\item{add_solver}{return a new \linkS4class{ProjectProblem} object
with the solver added to it.}

\item{add_constraint}{return a new \linkS4class{ProjectProblem}
object with the constraint added to it.}

\item{add_targets}{return a copy with the targets added to the problem.}

\item{get_constraint_parameter}{get the value of a parameter (specified by
argument \code{id}) used in one of the constraints in the object.}

\item{set_constraint_parameter}{set the value of a parameter (specified by
argument \code{id}) used in one of the constraints in the object to
\code{value}.}

\item{render_constraint_parameter}{generate a \emph{shiny} widget to modify
the value of a parameter (specified by argument \code{id}).}

\item{render_all_constraint_parameters}{generate a \emph{shiny} \code{div}
containing all the parameters' widgets.}

\item{get_objective_parameter}{get the value of a parameter (specified by
argument \code{id}) used in the object's objective.}

\item{set_objective_parameter}{set the value of a parameter (specified by
argument \code{id}) used in the object's objective to \code{value}.}

\item{render_objective_parameter}{generate a \emph{shiny} widget to modify
the value of a parameter (specified by argument \code{id}).}

\item{render_all_objective_parameters}{generate a \emph{shiny} \code{div}
containing all the parameters' widgets.}

\item{get_weight_parameter}{get the value of a parameter (specified by
argument \code{id}) used in the object's weights.}

\item{set_weight_parameter}{set the value of a parameter (specified by
argument \code{id}) used in the object's weights to \code{value}.}

\item{render_weight_parameter}{generate a \emph{shiny} widget to modify
the value of a parameter (specified by argument \code{id}).}

\item{render_all_weight_parameters}{generate a \emph{shiny} \code{div}
containing all the parameters' widgets.}

\item{get_solver_parameter}{get the value of a parameter (specified by
argument \code{id}) used in the object's solver.}

\item{set_solver_parameter}{set the value of a parameter (specified by
argument \code{id}) used in the object's solver to \code{value}.}

\item{render_solver_parameter}{generate a \emph{shiny} widget to modify
the value of a parameter (specified by argument \code{id}).}

\item{render_all_solver_parameters}{generate a \emph{shiny} \code{div}
containing all the parameters' widgets.}

}
}

