#!/bin/bash
# Branch refreshing
#
#  Copyright (C) 2014 LoVullo Associates, Inc.
#
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <http://www.gnu.org/licenses/>.
##


get-branch-name()
{
  local -r ref="$( git symbolic-ref HEAD 2>/dev/null )"
  echo "${ref#refs/heads/*}"
}


create-backup-ref()
{
  local -r branch="$1"
  local -r oldref="$branch-old"

  git branch -f "$oldref" "$branch" &>/dev/null \
    && echo "$oldref"
}


create-guard-commit()
{
  local -r branch="$1"

  git commit --allow-empty \
    -m "Guard commit to prevent accidental push of old $branch"
}


do-refresh()
{
  local -r upstream="$1"
  local -r timespec="$2"
  local -r branch="$( get-branch-name )"

  test -n "$branch" || {
    echo "error: not on any branch" >&2
    return 1
  }

  local oldref
  oldref="$( create-backup-ref "$branch" )" || return
  readonly oldref

  echo "Created '$oldref' referencing current state of '$branch'" >&2

  # re-merge will take place only if a timespec is provided
  git reset --hard "$upstream" >&2 \
    && create-guard-commit "$branch" >&2 \
    && if [ -n "$timespec" ]; then \
         git remerge "$oldref" "$timespec"; \
       fi
}

