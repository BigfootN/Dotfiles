#!/bin/zsh

copy_from_to() {
	local path_from=$1
	local path_to=$2

	path_to=$(echo $path_to | sed 's@^\~@'"$HOME"'@')

	if [[ -f "$path_from" ]]; then
		local dir=$(dirname $(readlink -fm "$path_to"))

		mkdir "$dir"
		echo "Copying $path_from to $path_to..."
		cp -f "$path_from" "$path_to"

	elif [[ -d "$path_from" ]]; then
		set -o magicequalsubst
		mkdir -p "$path_to"
		echo "Copying all files from $path_from to $path_to..."
		cp -rf "$path_from"/* "$path_to"
	fi
}

dotfiles_save() {
	local script_path=${0:a:h}
	local idx=0
	local path_from=$(cat "$script_path"/dotfiles.json | jq -r '.config_files.paths['"$idx"'].local_path')
	local path_to=$(cat "$script_path"/dotfiles.json | jq -r '.config_files.paths['"$idx"'].git_path')

	while [[ (! "$path_from" = "null") && (! "$path_to" = "null") ]]; do
		copy_from_to "$path_from" "$script_path"/"$path_to"

		((idx++))
		path_from=$(cat "$script_path"/dotfiles.json | jq -r '.config_files.paths['"$idx"'].local_path')
		path_to=$(cat "$script_path"/dotfiles.json | jq -r '.config_files.paths['"$idx"'].git_path')
	done
}

dotfiles_deploy() {
	local script_path=${0:a:h}
	local idx=0
	local path_from=$(cat "$script_path"/dotfiles.json | jq -r '.config_files.paths['"$idx"'].git_path')
	local path_to=$(cat "$script_path"/dotfiles.json | jq -r '.config_files.paths['"$idx"'].local_path')

	while [[ (! "$path_from" = "null") && (! "$path_to" = "null") ]]; do
		copy_from_to "$script_path"/"$path_from" "$path_to"

		((idx++))
		path_from=$(cat "$script_path"/dotfiles.json | jq -r '.config_files.paths['"$idx"'].git_path')
		path_to=$(cat "$script_path"/dotfiles.json | jq -r '.config_files.paths['"$idx"'].local_path')
	done
}

dotfiles_deploy()
