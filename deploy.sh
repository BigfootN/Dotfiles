#!/bin/zsh

. config_files.sh

deploy() {
	for git_path local_path in ${(kv)CONFIG_FILES}
	do
		cp -r $local_path $git_path
	done
}

deploy
