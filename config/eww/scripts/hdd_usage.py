import re
import subprocess
import time


class HDD:
    @property
    def percentage_used(self):
        percentage_used_output = subprocess.run(
            ['df', '--output=pcent', '/home'], stdout=subprocess.PIPE)
        percentage_used_output = str(
            percentage_used_output.stdout).split(r"\n")[1]
        percentage_used = re.search(r"[0-9]+", percentage_used_output)
        return int(percentage_used.group(0))


def main():
    hdd = HDD()
    while True:
        percentage_used = hdd.percentage_used
        print('{:>4}'.format('{}%'.format(percentage_used)), flush=True)

        time.sleep(120)


if __name__ == "__main__":
    main()
