if status is-interactive
    theme_gruvbox dark hard
    direnv hook fish | source
end

set -g fish_greeting

set -x ELECTRON_OZONE_PLATFORM_HINT wayland

set -Ux EDITOR hx
set -Ux VISUAL hx
set -Ux SUDO_EDITOR

set -gx PATH /home/tor/.cargo/bin $PATH
set -gx PATH /home/tor/go/bin $PATH
