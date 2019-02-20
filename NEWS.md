# oppr 0.0.0.13

- Fix bug in `project_cost_effectiveness` reporting incorrect costs, and
  cost-effectiveness values.

# oppr 0.0.0.12

- Assorted documentation tweaks.

# oppr 0.0.0.11

- Update `add_heuristic_solver` algorithm so that all actions and projects which
  exceed the budget are automatically removed prior to the iterative action
  removal.
- Update `add_random_solver` algorithms so that projects are selected instead
  of individual actions. This means that solutions from this solver are (i)
  similar to those in previous project prioritization studies and (ii) more
  likely to deliver better solutions (#13).

# oppr 0.0.0.10

- Rename package to _oppr_ since _ppr_ is already on CRAN.
- Fix issue with `replacement_costs` yielding incorrect results for baseline
  projects when used with SYMPHONY solvers.

# oppr 0.0.0.9

- Add new `project_cost_effectiveness` function to calculate the
  cost-effectiveness for each conservation project in a problem.

# oppr 0.0.0.8

- Fix typos in documentation (#8).
- The `solution_statistics` function outputs which projects are completely
  funded in each solution (#9).
- Add example for saving tabular data to vignette (#10).
- Add examples to vignette for working with the solution output (#11).

# oppr 0.0.0.7

- Fix annoying "`Found more than one class "tbl_df" in cache; using the first, from namespace 'tibble'`" text.

# oppr 0.0.0.6

- Actually fix bug when solving problems with a phylogenetic objective and
  branches that have a constant probability of persistence (#6).
- Fix bug in `add_max_phylo_div_objective` yielding incorrect solutions
  when features are ordered differently in the phylogenetic and tabular input
  data.
- Fix bug in `solution_statistics` yielding objective values for
  phylogenetic problems when features are ordered differently in the
  phylogenetic and tabular input data.
- Fix bug when handling phylogenetic data when a species is associated with
  two tip branches. Although such data probably indicate errors in the
  phylogenetic data, this functionality could be useful when combining
  multiple datasets.

# oppr 0.0.0.5

- Add `return_data` argument to `plot_feature_persistence` and
  `plot_phylo_persistence` so that plotting data can be obtained
  for creating custom plots.

# oppr 0.0.0.4

- Fix bug in `add_relative_targets` and `add_manual_targets` (when relative
  targets supplied) calculations. This result in incorrect calculations.
- Fix issue with expected persistence probabilities not accounting for the
  "do nothing" scenario (#7).

# oppr 0.0.0.3

- The gurobi solver (i.e. `add_gurobi_solver` function) now uses
  `NumericFocus=3` to help avoid numerical issues.
- The `compile` function now throws a warning if problems are likely to
  have numerical issues.

# oppr 0.0.0.2

- Fix bug when solving problems with a phylogenetic objective and branches that
  have a constant probability of persistence (#6). Hindsight shows this attempt
  did not cover all edge cases.
- Add additional data sanity checks to `problem`. It will now throw
  descriptive error messages if features are missing baseline probabilities, or
  are associated with baseline probabilities below 1e-11.
- Fix unit test for `simulate_ptm_data` that had a very small chance of failing
  due to simulating a data set where an action is not associated with any
  project.
- Feature columns in simulated data produced using `simulate_ppp_data` and
  `simulate_ptm_data` are now sorted.

# oppr 0.0.0.1

- Initial commit.
