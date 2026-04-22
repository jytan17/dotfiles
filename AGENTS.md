# Agent Instructions

## Repository Structure

This is a dotfiles repository managed with [GNU Stow](https://www.gnu.org/software/stow/). Each top-level directory is a stow package representing a tool's configuration.

## Rules

### README Maintenance

- Every tool directory **must** have a `README.md` file documenting its configuration.
- Whenever a tool's configuration is changed, its `README.md` **must** be updated to reflect the changes in the same operation.
- READMEs should follow this structure (omit sections that don't apply to a given tool):

```markdown
# <Tool Name>

Brief description of the tool and how it's used.

## Setup

Stow command and any first-time setup steps.

## Dependencies / External Setup

Prerequisites, manual installs, or anything needed beyond `stow`.

## File Structure

Files included in the package and their purpose.

## Key Bindings

Table of custom key bindings.

| Keys | Action |
|------|--------|
| ...  | ...    |

## Plugins

List of plugins/extensions and what they do.

## Notable Settings

Important configuration choices and why they were made.

## Theme / Appearance

Visual theme, colors, status bar, fonts, etc.
```
