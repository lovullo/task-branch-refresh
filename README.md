# Git Branch Refresh
Resets a development or topic branch *T* to upstream and re-merges all branches
merged into *T* within the given timeframe. All re-merged branches are merged
referencing the same commit that was last merged into *T*.

This script is most useful for branches that serve as a test bed for the
integration of various features; various topic branches are merged into
*T*&mdash;possibly at regular intervals&mdash;and the features may be at any
point abandoned, leaving *T* in a senseless state.


## License
This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
more details.

