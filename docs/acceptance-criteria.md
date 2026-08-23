# Acceptance Criteria

The first-release behaviors below were validated in game against the versions in
[dependency-matrix.md](dependency-matrix.md). Package checks remain build-verifiable rather than
visual claims.

| Criterion | Evidence | Status |
| --- | --- | --- |
| Outfit cards and Equipment-EX selector remain synchronized | Repeated V Photo Mode tests | Accepted |
| Clothing cards, arrows, toggle, replacement, and `NONE` mutate only the preview | Repeated V and NPC tests | Accepted |
| Outfit changes resynchronize lazily and eagerly constructed Clothing controls | Re-entry and selection-order tests | Accepted |
| Clear and Reset preserve their documented preview-only semantics | Current, No Outfit, and saved-outfit tests | Accepted |
| Native Category, Pose, Facial Expression, and NPC Appearance adapters remain synchronized | V and multi-NPC tests | Accepted |
| Search, tooltips, icon collages, card density, accordion layout, and anchored expansion work across browsers | V and NPC UI tests | Accepted |
| Controls-region wheel input scrolls without camera zoom; outside input still zooms | V and NPC viewport tests | Accepted |
| Per-NPC clothing and appearance-component state survives active-NPC switching | Two-NPC switching tests | Accepted |
| Photo Mode re-entry does not leak prior-session UI or preview state | Repeated lifecycle tests | Accepted |
| Experimental NPC Clothing is hidden for zero-slot targets and documents slot eligibility sources separately from fit limitations | Bulk record census, supported/unsupported NPC tests, and release documentation | Accepted |
| Release package contains Release profile, release-safe logging backend, scripts, and Ink archive | Package validation | Accepted |
| Required and optional dependencies are accurately documented | Dependency matrix and release metadata | Accepted |
