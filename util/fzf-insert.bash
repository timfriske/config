# Insert Fzf output into command line
# ===================================
# Tim Friske <me@tifr.de>
#
# The _Fzf-insert_ _Bash_ script's `fzf_insert` function when invoked
# evaluates a given command string and inserts its output into the
# command line editing buffer at the cursor's current position.  This
# function is meant to be used with commands whose output is piped
# through _Fzf_ for the user to fuzzy-find and select the records s/he
# is interested in.  Once the user made her/his selection the function
# inserts those records into the editing buffer.
#
# For _Fzf-insert_ to work it must have direct access to the user's
# _Bash_ shell.  Therefore this script must be sourced by _Bash_ such
# that its definitions become part of the shell.  For example by adding
# the following code to _Bash's_ startup file for interactive shells:
#
# .Example: Try to find script in `$PATH` and source it
# ----
# source fzf-insert.bash &> /dev/null
# ----
#
# Dependencies::
#   _Bash_

function fzf_insert {
  local selected="$(eval "$cmd")"

  local rl="$READLINE_LINE" rp="$READLINE_POINT"
  READLINE_LINE="${rl:0:$rp}$selected${rl:$rp}"
  READLINE_POINT=$(( rp + ${#selected} ))
}
