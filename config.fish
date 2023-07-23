if status is-interactive

function fish_prompt
    # Set color variables
    set color_cyan (set_color cyan)
    set color_blue (set_color blue)
    set color_white (set_color white)
    set color_red (set_color red)
    set color_normal (set_color normal)

    # Detect if the current directory is a git repository
    set git_branch (command git symbolic-ref --short HEAD 2> /dev/null)
    set git_dirty (command git diff --quiet --ignore-submodules HEAD 2> /dev/null; and echo "")

    # Display the prompt
    echo -n $color_white "Arch ➜ "
    echo -n $color_blue (prompt_pwd)
    echo -n $color_cyan
    if test $git_branch
        echo -n " g:($git_branch)"
        if test $git_dirty
            echo -n $color_red " ✗"
        end
    end
    echo -n $color_normal '$ '
end

function g
    git $argv
end

function francinette
    ~/francinette/tester.sh
end

begin; 
find /home/(whoami)/.vscode-server/extensions/*/bin/ -type f -name '*' -exec chmod +x {} \; 
or true
end

end
