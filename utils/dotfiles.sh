#!/bin/zsh

copy_from_to() {
	local path_from=$1
	local path_to=$2

	if [[ -f "$path_from" ]]; then
		local dir=$(dirname $(readlink -fm "$path_to"))

		mkdir "$dir"
		cp -f "$path_from" "$path_to"
	elif [[ -d "$path_from" ]]; then
		mkdir -p "$path_to"
		cp -rf "$path_from"/* "$path_to"
	fi
}

dotfiles_save() {
	local script_path=$0:A
	local idx=0
	local path_from=$(cat "$script_path"/config_files.json | jq -r '.config_files.paths['"$idx"'].local_path')
	local path_to=$(cat "$script_path"/config_files.json | jq -r '.config_files.paths['"$idx"'].git_path')

	while [[ (! "$path_from" = "null") && (! "$path_to" = "null") ]]; do
		copy_from_to "$local_path" "$script_path"/"$local_path"

		((idx++))
		path_from=$(cat "$script_path"/config_files.json | jq -r '.config_files.paths['"$idx"'].local_path')
		path_to=$(cat "$script_path"/config_files.json | jq -r '.config_files.paths['"$idx"'].git_path')
	done
}

dotfiles_deploy() {
	local script_path=$0:A
	local idx=0
	local path_from=$(cat "$script_path"/config_files.json | jq -r '.config_files.paths['"$idx"'].git_path')
	local path_to=$(cat "$script_path"/config_files.json | jq -r '.config_files.paths['"$idx"'].local_path')

	while [[ (! "$path_from" = "null") && (! "$path_to" = "null") ]]; do
		copy_from_to "$local_path" "$script_path"/"$local_path"

		((idx++))
		path_from=$(cat "$script_path"/config_files.json | jq -r '.config_files.paths['"$idx"'].git_path')
		path_to=$(cat "$script_path"/config_files.json | jq -r '.config_files.paths['"$idx"'].local_path')
	done
}

unfunction copy_from_to
