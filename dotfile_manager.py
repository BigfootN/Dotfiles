import sys
import os
import argparse
import json
from shutil import copyfile

def init_argument_parser():
    parser = argparse.ArgumentParser()
    parser.add_argument('--operation', action='store', choices=['save', 'deploy'], required=True)
    parser.add_argument('config_file', nargs='?', default="dotfile_manager_config.json")
    return parser

def save_files(config_files_dict):
    for git_path, local_path in config_files_dict.items():
        if os.path.isfile(local_path):
            git_dir = os.path.dirname(git_path)
            if not os.path.exists(git_dir):
                os.makedirs(git_dir)
            copyfile(local_path, git_path)
        else:
            print("File " + local_path + " not found!", file = sys.stderr)

def deploy_files(config_files_dict):
    for git_path, local_path in config_files_dict.items():
        if os.path.isfile(git_path):
            local_dir = os.path.dirname(git_path)
            if not os.path.exists(local_dir):
                os.makedirs(local_dir)
            copyfile(git_path, local_path)
        else:
            print("File " + git_path + " not found!", file = sys.stderr)

def iterate_through_json_data(json_data, path = os.path.dirname(os.path.realpath(__file__))):
    ret = dict()
    for key in json_data:
        if type(json_data[key]) is dict:
            ret.update(iterate_through_json_data(json_data[key], path + "/" + key))
        elif type(json_data[key]) is str:
            abs_local_path = os.path.expanduser(json_data[key])
            ret[path + "/" + key] = abs_local_path
    return ret

def parse_arguments():
    parser = init_argument_parser()
    args = parser.parse_args()

    return args

def run(args):
    config_file = args.config_file

    with open(config_file) as f:
        data = json.load(f)
        
    json_dict = iterate_through_json_data(data)

    if args.operation == "save":
        save_files(json_dict)
    elif args.operation == "deploy":
        deploy_files(json_dict)

def main():
    args = parse_arguments()
    run(args)

if __name__ == "__main__":
    main()