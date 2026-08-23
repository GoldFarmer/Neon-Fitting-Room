# Agent Instructions

## Shared knowledge

The canonical reusable knowledge base, relative to this project's root, is:

`..\Knowledge\.kiro\steering`

Use project-relative paths for all references between this project and the Knowledge repository. Do not record machine-specific absolute paths.

Before creating or modifying requirements, design, tasks, implementation, or validation plans:

1. Read the applicable general guidance:
   - `specification-best-practices.md`
   - `naming-conventions-best-practices.md`
   - `code-comment-best-practices.md`
   - `logging-best-practices.md`
2. Search the entire shared steering tree for documents related to:
   - technologies and languages used by the work;
   - game or host systems involved;
   - dependencies and mods involved;
   - the feature or integration being changed.
3. Read the relevant documents before making architectural assumptions or selecting hooks, APIs, lifecycle behavior, or validation criteria.

## Knowledge ownership

Keep these concerns separate:

- Reusable engineering guidance belongs in the shared steering root.
- Technology and domain findings belong in their shared domain folder.
- Dependency behavior belongs in that dependency's folder.
- Feature research belongs beneath its owning technology or dependency.
- Project architecture, naming prefixes, implementation choices, acceptance criteria, build procedures, and validation decisions remain in this project.

Do not copy reusable research into project specifications. Reference its shared location and record only the project's resulting decision.

## Research updates

When work produces a verified reusable finding:

1. Search the shared steering tree for an existing document covering it.
2. Merge the finding into that document instead of creating a duplicate.
3. Record evidence, applicable versions, prerequisites, and lifecycle context.
4. Remove project names, fixed local paths, and consuming-project decisions.
5. Update affected links and indexes.

When evidence conflicts, prefer newer or directly verified evidence and retain useful version context.

## Specification workflow

Every requirements, design, or task change must:

- identify the shared knowledge consulted;
- distinguish verified behavior from assumptions;
- keep dependency facts separate from project decisions;
- convert relevant constraints into explicit acceptance or validation criteria;
- update shared knowledge when reusable findings were verified.

Before completing work, verify whether any new information belongs in the shared knowledge tree and update it when appropriate.

## Completion report

Report:

- shared knowledge consulted;
- shared knowledge added or updated;
- project-specific decisions kept local;
- validation performed;
- unresolved assumptions or version-sensitive findings.
