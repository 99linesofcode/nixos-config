# Issue tracker: obsidian

This repository tracks its work in the Obsidian vault at `~/Documents/Obsidian`, in the vault project named after this repository's directory: the folder of that name under `Projecten/`.

## What lives there

- A **map** is the index of one effort: its Destination, Notes, Decisions so far, Not yet specified and Out of scope. It is a note `_<Effort>.md` in its own folder inside the project folder, or inside the folder of the map it nests in. Status: `open` or `resolved`.
- A **question** is one decision on a map, of type `research`, `prototype`, `grilling` or `task`. It is a note in its map's `issues/` folder, numbered `NN-slug.md`. Status: `open`, `claimed`, `resolved` or `out-of-scope`.
- An **issue** is any other item on the tracker. Every issue lives in the project's `issues/` folder, the backlog, numbered `NNNN-slug.md`. Its **type** is its `type/<type>` tag: a `spec` is what a cleared map hands off (the problem, the solution and the decisions to build), a `story` makes scenarios of its spec pass, built and merged on its own, a `task` is work only a human can do, a `bug` is something broken, and a `chore` is maintenance or technical work with no behaviour change. Status: a triage role (`needs-triage`, `needs-info`, `ready-for-agent`, `ready-for-human`) or none (an empty `status`, never triaged), then `wontfix` or `resolved`.
- A **comment** on an issue is a note of its own in the project's `comments/` folder, named after the issue and numbered from `1` (`0031-fix-sweep-1.md`). It has no status. The issue links its comments, oldest first, under a `## Comments` section at its end.

Every status is the note's `status` property, and every link is a wikilink to a note's name.

## Working with it

Agents create, read, list and change maps, questions and issues through the `tracker` skill, which holds the commands for this tracker. Humans open the project folder in Obsidian.
