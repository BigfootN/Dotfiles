#!/usr/bin/python
from shutil import copy
from pathlib import Path
import os

# atom file paths
ATOM_GIT_FOLDER_PATH = "atom"
ATOM_INSTALL_FOLDER_PATH = "~/.atom"
ATOM_FILE_NAMES = ["config.cson", "styles.less"]

# atom packages
ATOM_PKGS = [
    "beautifier", "linter-flake8", "linter-clang", "autocomplete-clang"
]

# Xresources file paths
XRESOURCES_GIT_FILE_PATH = os.path.realpath(__file__)
XRESOURCES_INSTALL_PATH = str(Path.home)
XRESOURCES_FILE_NAME = "Xresources"

# zsh file paths
ZSH_GIT_FILE_PATH = os.path.realpath(__file__)
ZSH_INSTALL_PATH = str(Path.home)
ZSH_FILE_NAME = "zshrc"


# ----
# ATOM
# ----
def install_atom_pkgs():
    for pkg in ATOM_PKGS:
        cmd = "apm install " + pkg
        os.system(cmd)


def install_atom_cfg():
    for curfileName in os.listdir(ATOM_GIT_FOLDER_PATH) in ATOM_FILE_NAMES:
        file = open(os.path.join(ATOM_GIT_FOLDER_PATH, curfileName), "r")
        copy(file, ATOM_INSTALL_FOLDER_PATH)


def install_atom():
    install_atom_cfg()
    install_atom_pkgs()


# ----------
# Xresources
# ----------
def install_xresources():
    file_src = os.path.join(XRESOURCES_GIT_FILE_PATH, XRESOURCES_FILE_NAME)
    file_dst = "." + XRESOURCES_INSTALL_PATH
    file_dst = os.path.join(XRESOURCES_INSTALL_PATH, file_dst)
    copy(file_src, file_dst)


# ---
# ZSH
# ---
def install_zsh():
    file_src = os.path.join(ZSH_GIT_FILE_PATH, ZSH_FILE_NAME)
    file_dst = "." + ZSH_FILE_NAME
    file_dst = os.path.join(ZSH_INSTALL_PATH, file_dst)
    copy(file_src, file_dst)


def main():
    install_xresources()
    install_atom()
    install_zsh()


if __name__ == "__main__":
    main()
