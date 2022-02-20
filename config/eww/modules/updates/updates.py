from asyncio.subprocess import PIPE
import subprocess


def print_updates_count():
    updates_output = subprocess.run(["checkupdates"], stdout=subprocess.PIPE)
    updates_lines = str(updates_output.stdout).split(r"\n")
    nb_updates = len(updates_lines)
    nb_updates_str = '{0: >3}'.format(str(nb_updates))
    print(nb_updates_str, flush=True)


if __name__ == "__main__":
    print_updates_count()
