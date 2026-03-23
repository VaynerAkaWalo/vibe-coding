---
name: pull-request
description: Creates pull request to default branch
---

Create pull request with changes changes included in current branch. Always check if there is some github issue satisfied by current branch if so, add `closes` to request description.

## Pull request description
Every pull request must have a short description of the included changes. It could contain 2 or 3 sections:

#### Problem (optional)
- Included only for bug fixes.
- Up to 3 lines of compact description, small changes usually require only single sentence.

#### Solution / Changes
- A Short explanation of changes included, preferably as bullet points.
- 'Solution' if bug fix, 'changes' otherwise.

#### Validation
- 1 or 2 lines of description how changes were validated.
