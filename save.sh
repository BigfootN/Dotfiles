#!/bin/zsh

. config_files.sh

save_files() {
    for git_path in ${(k)CONFIG_FILES}
    do
        local_path=${CONFIG_FILES[$git_path]}
        cp $local_path $git_path
    done

    dconf dump /org/gnome/terminal > config/gnome-terminal/settings.txt
    code --list-extensions > config/code/extensions.list
}

commit_changes() {
    git add *
    git commit -am "updates"
    git push
}

save_files
commit_changes