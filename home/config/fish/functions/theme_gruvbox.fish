# Gruvbox theme for fish shell
# Dark hard variant optimized for readability and aesthetics

function theme_gruvbox --description 'Apply gruvbox theme'
    set -l mode dark
    if test (count $argv) -gt 0
        set mode $argv[1]
    end

    set -g contrast hard
    if test (count $argv) -gt 1
        set contrast $argv[2]
    end

    switch $contrast
        case soft medium hard
            # Valid contrast levels
        case '*'
            set_color red
            echo "Error: Unknown contrast '$contrast'. Choose: soft, medium, or hard"
            set_color normal
            return 1
    end

    switch $mode
        case light
            __theme_gruvbox_base
            __theme_gruvbox_light
        case dark
            __theme_gruvbox_base
            __theme_gruvbox_dark
        case '*'
            set_color red
            echo "Error: Unknown mode '$mode'. Choose: light or dark"
            set_color normal
            return 1
    end
    
    __theme_gruvbox_palette
    __theme_gruvbox_fish_colors $mode
    return 0
end

function __theme_gruvbox_fish_colors
    set -l mode $argv[1]

    if test "$mode" = dark
        # Syntax highlighting colors
        set -g fish_color_normal ebdbb2              # Default text (fg0)
        set -g fish_color_command b8bb26             # Commands (bright green)
        set -g fish_color_keyword fe8019             # Keywords like if/end (bright orange)
        set -g fish_color_quote fabd2f               # Quoted strings (bright yellow)
        set -g fish_color_redirection 83a598         # Redirections like > (bright blue)
        set -g fish_color_end fb4934                 # Process separators like ; (bright red)
        set -g fish_color_error fb4934 --bold        # Syntax errors (bright red, bold)
        set -g fish_color_param d5c4a1               # Regular parameters (fg2)
        set -g fish_color_option 8ec07c              # Options like -h (bright aqua)
        set -g fish_color_comment 665c54 --italics   # Comments (gray, italics)
        set -g fish_color_selection --background=504945  # Selected text (bg2)
        set -g fish_color_search_match --background=fabd2f --foreground=1d2021  # Search matches
        
        # Operators and special characters
        set -g fish_color_operator 8ec07c            # Operators like * (bright aqua)
        set -g fish_color_escape d3869b              # Escape sequences (bright purple)
        set -g fish_color_autosuggestion 665c54     # Autosuggestions (gray)
        set -g fish_color_cancel fb4934              # Cancel (bright red)
        
        # Completions pager
        set -g fish_pager_color_progress a89984 --background=3c3836  # Progress bar
        set -g fish_pager_color_prefix 8ec07c --bold  # Matching prefix (bright aqua)
        set -g fish_pager_color_completion d5c4a1     # Completion text (fg2)
        set -g fish_pager_color_description 928374    # Description text (gray)
        set -g fish_pager_color_selected_background --background=504945  # Selected item
        set -g fish_pager_color_selected_prefix fe8019 --bold  # Selected prefix (orange)
        set -g fish_pager_color_selected_completion ebdbb2     # Selected text (fg0)
        set -g fish_pager_color_selected_description b8bb26    # Selected description (green)
        set -g fish_pager_color_secondary_background           # Alternating row color
        set -g fish_pager_color_secondary_prefix               # Secondary prefix
        set -g fish_pager_color_secondary_completion           # Secondary completion
        set -g fish_pager_color_secondary_description          # Secondary description
        
        # Git prompt colors (if using fish_git_prompt)
        set -g __fish_git_prompt_color_branch b8bb26
        set -g __fish_git_prompt_color_dirtystate fe8019
        set -g __fish_git_prompt_color_invalidstate fb4934
        set -g __fish_git_prompt_color_merging d3869b
        set -g __fish_git_prompt_color_stagedstate fabd2f
        set -g __fish_git_prompt_color_untrackedfiles 83a598
        set -g __fish_git_prompt_color_upstream 8ec07c
        
    else
        # Light mode colors
        set -g fish_color_normal 3c3836              # Default text
        set -g fish_color_command 79740e             # Commands (green)
        set -g fish_color_keyword af3a03             # Keywords (orange)
        set -g fish_color_quote b57614               # Quoted strings (yellow)
        set -g fish_color_redirection 076678         # Redirections (blue)
        set -g fish_color_end 9d0006                 # Process separators (red)
        set -g fish_color_error 9d0006 --bold        # Syntax errors (red, bold)
        set -g fish_color_param 504945               # Regular parameters
        set -g fish_color_option 427b58              # Options (aqua)
        set -g fish_color_comment a89984 --italics   # Comments (gray, italics)
        set -g fish_color_selection --background=d5c4a1  # Selected text
        set -g fish_color_search_match --background=b57614 --foreground=f9f5d7  # Search matches
        
        # Operators and special characters
        set -g fish_color_operator 427b58            # Operators (aqua)
        set -g fish_color_escape 8f3f71              # Escape sequences (purple)
        set -g fish_color_autosuggestion a89984      # Autosuggestions (gray)
        set -g fish_color_cancel 9d0006              # Cancel (red)
        
        # Completions pager
        set -g fish_pager_color_progress 7c6f64 --background=ebdbb2
        set -g fish_pager_color_prefix 427b58 --bold
        set -g fish_pager_color_completion 504945
        set -g fish_pager_color_description 928374
        set -g fish_pager_color_selected_background --background=d5c4a1
        set -g fish_pager_color_selected_prefix af3a03 --bold
        set -g fish_pager_color_selected_completion 3c3836
        set -g fish_pager_color_selected_description 79740e
        set -g fish_pager_color_secondary_background
        set -g fish_pager_color_secondary_prefix
        set -g fish_pager_color_secondary_completion
        set -g fish_pager_color_secondary_description
        
        # Git prompt colors
        set -g __fish_git_prompt_color_branch 79740e
        set -g __fish_git_prompt_color_dirtystate af3a03
        set -g __fish_git_prompt_color_invalidstate 9d0006
        set -g __fish_git_prompt_color_merging 8f3f71
        set -g __fish_git_prompt_color_stagedstate b57614
        set -g __fish_git_prompt_color_untrackedfiles 076678
        set -g __fish_git_prompt_color_upstream 427b58
    end
end

function __theme_gruvbox_base
    # Base ANSI colors (1-6)
    __printf_color 1 cc/24/1d  # Red
    __printf_color 2 98/97/1a  # Green
    __printf_color 3 d7/99/21  # Yellow
    __printf_color 4 45/85/88  # Blue
    __printf_color 5 b1/62/86  # Purple
    __printf_color 6 68/9d/6a  # Aqua
end

function __theme_gruvbox_light
    # Background color based on contrast
    set -l bg fb/f1/c7  # Light medium
    switch $contrast
        case soft
            set bg f2/e5/bc
        case hard
            set bg f9/f5/d7
    end
    command printf "\033]11;rgb:$bg\007"

    # Foreground color
    set -l fg 3c/38/36
    command printf "\033]10;rgb:$fg\007"

    # ANSI colors
    __printf_color 0 $bg                # Black (background)
    __printf_color 7 7c/6f/64           # White (fg4)
    __printf_color 8 92/83/74           # Bright black (gray)
    __printf_color 9 9d/00/06           # Bright red
    __printf_color 10 79/74/0e          # Bright green
    __printf_color 11 b5/76/14          # Bright yellow
    __printf_color 12 07/66/78          # Bright blue
    __printf_color 13 8f/3f/71          # Bright purple
    __printf_color 14 42/7b/58          # Bright aqua
    __printf_color 15 $fg               # Bright white (foreground)
end

function __theme_gruvbox_dark
    # Background color based on contrast
    set -l bg 28/28/28  # Dark medium
    switch $contrast
        case soft
            set bg 32/30/2f
        case hard
            set bg 1d/20/21  # Hard contrast - darkest background
    end
    command printf "\033]11;rgb:$bg\007"

    # Foreground color
    set -l fg eb/db/b2
    command printf "\033]10;rgb:$fg\007"

    # ANSI colors
    __printf_color 0 $bg                # Black (background)
    __printf_color 7 a8/99/84           # White (fg4)
    __printf_color 8 92/83/74           # Bright black (gray)
    __printf_color 9 fb/49/34           # Bright red
    __printf_color 10 b8/bb/26          # Bright green
    __printf_color 11 fa/bd/2f          # Bright yellow
    __printf_color 12 83/a5/98          # Bright blue
    __printf_color 13 d3/86/9b          # Bright purple
    __printf_color 14 8e/c0/7c          # Bright aqua
    __printf_color 15 $fg               # Bright white (foreground)
end

function __theme_gruvbox_palette
    # Extended 256-color palette
    
    # Dark backgrounds
    __printf_color 236 32/30/2f  # bg0_s (soft)
    __printf_color 234 1d/20/21  # bg0_h (hard)
    __printf_color 235 28/28/28  # bg0 (medium)
    __printf_color 237 3c/38/36  # bg1
    __printf_color 239 50/49/45  # bg2
    __printf_color 241 66/5c/54  # bg3
    __printf_color 243 7c/6f/64  # bg4
    
    # Gray
    __printf_color 244 92/83/74  # gray_245
    __printf_color 245 92/83/74  # gray_244
    
    # Light backgrounds
    __printf_color 228 f2/e5/bc  # bg0_s (soft)
    __printf_color 230 f9/f5/d7  # bg0_h (hard)
    __printf_color 229 fb/f1/c7  # bg0 (medium)
    
    # Dark foregrounds
    __printf_color 223 eb/db/b2  # fg0
    __printf_color 250 d5/c4/a1  # fg1
    __printf_color 248 bd/ae/93  # fg2
    __printf_color 246 a8/99/84  # fg3
    
    # Bright colors
    __printf_color 167 fb/49/34  # bright_red
    __printf_color 142 b8/bb/26  # bright_green
    __printf_color 214 fa/bd/2f  # bright_yellow
    __printf_color 109 83/a5/98  # bright_blue
    __printf_color 175 d3/86/9b  # bright_purple
    __printf_color 108 8e/c0/7c  # bright_aqua
    __printf_color 208 fe/80/19  # bright_orange
    
    # Faded colors
    __printf_color 88 9d/00/06   # faded_red
    __printf_color 100 79/74/0e  # faded_green
    __printf_color 136 b5/76/14  # faded_yellow
    __printf_color 24 07/66/78   # faded_blue
    __printf_color 96 8f/3f/71   # faded_purple
    __printf_color 66 42/7b/58   # faded_aqua
    __printf_color 130 af/3a/03  # faded_orange
end

function __printf_color
    command printf "\033]4;$argv[1];rgb:$argv[2]\007"
end

# Convenience function for quick dark hard theme application
function theme_gruvbox_dark_hard --description 'Apply gruvbox dark hard theme'
    theme_gruvbox dark hard
end
