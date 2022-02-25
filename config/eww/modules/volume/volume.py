#!/bin/zsh

import subprocess
import re
import sys
import time


def remove_useless_lines(lines):
    return [line for line in lines if len(line.strip()) > 1]


def get_last_line(output):
    output_lines = str(output.stdout).split(r"\n")
    output_lines = remove_useless_lines(output_lines)
    return output_lines[len(output_lines) - 1]


def get_last_line_amixer():
    amixer_output = subprocess.run(
        ["amixer", "sget", "Master"], stdout=subprocess.PIPE)
    amixer_output_last_line = get_last_line(amixer_output)
    return amixer_output_last_line


def get_volume():
    amixer_output_last_line = get_last_line_amixer()
    volume_percentage = re.findall(
        r"\[[0-9]+%\]", amixer_output_last_line)[0]
    volume = int(re.search(r"[0-9]+", volume_percentage).group(0))
    return volume


def is_muted():
    amixer_output_last_line = get_last_line_amixer()
    return (re.search(r"\[off\]$", amixer_output_last_line) != None)


def print_volume():
    volume = get_volume()
    volume = str("{:>3}%".format(str(volume)))
    print(volume, flush=True)


def print_muted():
    muted = is_muted()
    if (muted):
        print("true", flush=True)
    else:
        print("false", flush=True)


def main():
    switch_action = {
        "--volume": print_volume,
        "--muted": print_muted
    }

    while True:
        switch_action[sys.argv[1]]()
        time.sleep(0.05)


if __name__ == "__main__":
    main()
