---
name: pull-request
description: Creates pull request with current changes
---

## Important
Always check if changes include tokens or keys that should not be publicly exposed, if you find something always ask before proceeding, even if you are unsure.

## Name convention
Available prefixes are `chore` - operational work, `fix` - bug fix and `feat` - new feature

### Branch
Format {prefix}/{description in kebab case (up to 3 words)} e.g. feat/pull-request-skill

### Commit
Format: `{prefix}: {description up to 1 sentence}` e.g. chore: Updated java image version

### Pull request title
Format: `{prefix}: {description up to 1 sentence}`. If there is only single commit use it as PR title, otherwise short title with same format describing primary goal of pull request.

# Pull request description
- Very short explanation of included changes (usually single line)
- For code changes include explanation how change was verified in separate section.

## Instructions
1. Explore changes compared to default branch
2. Check changes for secrets or tokens — stop and ask if found or unsure
3. Create branch if not on one already
4. Run lint and tests to verify changes
5. Commit changes with short descriptive message
6. Push changes
7. Create pull request using `gh pr create`
8. Print PR link to user
