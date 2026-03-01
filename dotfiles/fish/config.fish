# Vi key bindings as default
set -g fish_key_bindings fish_vi_key_bindings

# Make potential errors boldface red (default: just red)
set fish_color_error red --bold

# Set the cursor shapes for the different vi modes.
set fish_cursor_default     block      blink
set fish_cursor_insert      line       blink
set fish_cursor_replace_one underscore blink
set fish_cursor_visual      block

if type -q any-nix-shell
		# Start nix-shell in in fish 
		# and list packages to the the right in nix-shell
		any-nix-shell fish --info-right | source
end

# Don't save history in Claude Code agent sessions
if set -q CLAUDE_CODE
	set -g fish_private_mode 1
end
