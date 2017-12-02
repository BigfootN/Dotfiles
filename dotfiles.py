#!/usr/bin/python
from shutil import copy
from pathlib import Path
import os
import sys

# atom file paths
ATOM_GIT_FOLDER_PATH = "atom"
ATOM_INSTALL_FOLDER_PATH = "~/.atom"
ATOM_FILE_NAMES = ["config.cson", "styles.less"]

# atom packages
ATOM_PKGS = [
    "beautifier", "linter-flake8", "linter-clang", "autocomplete-clang",
    "dockblockr"
]

# Xresources file paths
XRESOURCES_GIT_FILE_PATH = os.path.realpath(__file__)
XRESOURCES_INSTALL_PATH = str(Path.home)
XRESOURCES_FILE_NAME = "Xresources"

# zsh file paths
ZSH_GIT_FILE_PATH = os.path.realpath(__file__)
ZSH_INSTALL_PATH = str(Path.home)
ZSH_FILE_NAME = "zshrc"

# ----------------
# helper functions
# ----------------


def copyDotfile(dir_src, dir_dst, file_src, file_dst=None):
    if file_dst is None:
        file_dst = file_src

    full_path_src = os.path.join(dir_src, file_src)
    full_path_dst = os.path.join(dir_dst, file_dst)
    copy(full_path_src, full_path_dst)


# ----
# ATOM
# ----
def install_atom_pkgs():
    for pkg in ATOM_PKGS:
        cmd = "apm install " + pkg
        os.system(cmd)


def install_atom_cfg():
    for curfileName in os.listdir(ATOM_GIT_FOLDER_PATH) in ATOM_FILE_NAMES:
        copyDotfile(ATOM_GIT_FOLDER_PATH, ATOM_INSTALL_FOLDER_PATH,
                    curfileName)


def install_atom():
    install_atom_cfg()
    install_atom_pkgs()


# ----------
# Xresources
# ----------
def install_xresources():
    copyDotfile(XRESOURCES_GIT_FILE_PATH, XRESOURCES_INSTALL_PATH,
                XRESOURCES_FILE_NAME, "." + XRESOURCES_FILE_NAME)


def backup_xresources():
    return


# ---
# ZSH
# ---
def install_zsh():
    copyDotfile(ZSH_GIT_FILE_PATH, ZSH_INSTALL_PATH, ZSH_FILE_NAME,
                "." + ZSH_FILE_NAME)


def deploy():
    install_xresources()
    install_atom()
    install_zsh()


def backup():
    return


if __name__ == "__main__":
    args = str(sys.argv)
    first_arg = args[0]
    if len(args) == 0:
        exit(0)
    if str(first_arg) == "install":
        deploy()
    elif str(first_arg) == "backup":
        backup()
