# Stack: Data Science (Python)

Defaults for analysis, modeling, and data pipelines. Edit the sections marked **[edit]**. Overrides `core/` where they conflict.

## Tooling defaults **[edit]**
- Python 3.12+, `uv` for environments, lockfile committed.
- Data: pandas or polars. Arrays: numpy. Models: scikit-learn (or PyTorch).
- Lint/format: ruff. Types: mypy on `src/` (relaxed for notebooks).
- Tests: pytest. Notebooks: Jupyter, with `nbstripout` to strip outputs on commit.
- Data validation: pandera or pydantic. Experiment tracking: MLflow or Weights & Biases (pick one).

## Code
- Notebooks are for exploration and reporting. Reusable logic moves into `src/` as functions with tests and is imported by notebooks.
- Notebooks run top to bottom from a clean kernel. Commit them with outputs cleared.
- Pure functions on dataframes: take data in, return new data. No mutation of inputs, no hidden globals.
- Type hints and docstrings on all functions in `src/`. State expected columns and dtypes.
- Seed every source of randomness (`random_state`, numpy generator, torch) and record seeds with results.
- No hard-coded absolute paths. Paths come from config.

## Data handling
- Raw data is immutable. Write derived data to a separate directory. Every derived file is reproducible by a script.
- Never commit large or sensitive data. Use DVC, object storage, or git-lfs, and document how to fetch it.
- Validate data at the boundary: schema, nulls, ranges, duplicates. Fail loudly.
- No personal data in notebooks, logs, or fixtures. Anonymize or sample.
- Split train/validation/test before any fitting or feature selection. No leakage.

## Reproducibility
- One command reproduces the results from a clean clone (`make reproduce` or equivalent).
- Record dataset version, code commit, parameters, and metrics for every reported result.
- Pin library versions. Report the metric and the baseline it is compared against.

## Testing
- Unit-test transformation functions with tiny hand-written dataframes.
- Test data contracts (schema checks) and that the pipeline runs end to end on a small sample.
- Do not unit-test model accuracy. Track it as a metric with a threshold in CI.

## Structure
```
data/
  raw/          # immutable, not committed
  processed/    # derived, not committed
notebooks/
src/            # reusable code
tests/
configs/
reports/
```

## Definition of done (additions to `review-checklist.md`)
- [ ] Notebook runs from a clean kernel; outputs stripped
- [ ] Seeds set; result is reproducible
- [ ] No data leakage; no raw or personal data committed
