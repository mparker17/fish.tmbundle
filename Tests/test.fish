#!/usr/local/bin/fish
#
# @file
# A test file
#
function lorem_ipsum
    set -l foo --exclusive 'bar,baz,biz' --exclusive 'fizz,buzz'
    set -a foo 'foo'
    argparse -n $cmd $foo -- $argv
    or return
    # TODO: This is a todo comment.
    if set -q _flag_foo
        echo 'foo'
        return 0
    else if set -q _flag_bar
        echo 'bar baz biz'
        return 0
    else
        builtin history search $argv
    end
    read --local --prompt "echo 'Lorem ipsum dolor? > '" choice
    for foo in $choice
        echo $foo
    end
end
function prompt_exit_status -d "Colored exit status."
  switch $status
    case 0
      # No-op.
    case 1
      echo "💥  [exited with error code $status: (invalid arguments?)]"
    case 124
      echo "💥  [exited with error code $status: (no glob matches?)]"
    case 125
      echo "💥  [exited with error code $status: (found and executable but could not execute?)]"
    case 126
      echo "💥  [exited with error code $status: (found but not executable?)]"
    case 127
      echo "💥  [exited with error code $status: (no function, builtin or command found?)]"
    case '*'
      echo "💥  [exited with error code $status]"
  end
end
function prompt_user -d "Colored username."
    set_color $fish_color_user
    echo -n (id -un)
    set_color normal
end
function prompt_host -d "Colored hostname."
    set_color $fish_color_host
    echo -n (hostname -s)
    set_color normal
end
function prompt_wd -d "Colored working directory, reduced."
    set_color $fish_color_cwd
    echo -n (prompt_pwd)
    set_color normal
end
function prompt_git -d "Wrapper for the fish git prompt."
    echo -n (__fish_git_prompt)
end

#
# Main function.
#
function fish_prompt -d "Message to display when the shell is ready for input."
    prompt_exit_status
    printf '%s@%s:%s %s %s' (prompt_user) (prompt_host) (prompt_wd) (prompt_git)
    echo
	printf '~> '
end
