if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -g fish_greeting

theme_gruvbox dark hard

set -x ELECTRON_OZONE_PLATFORM_HINT wayland

set -Ux EDITOR hx
set -Ux VISUAL hx
set -Ux SUDO_EDITOR

direnv hook fish | source
