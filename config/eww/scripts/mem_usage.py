import time
import re
import subprocess


class Memory:
    def __init__(self):
        self.update_mem_stats()

    def update_mem_stats(self):
        free_w_output = subprocess.run(
            ['free', '-w'], stdout=subprocess.PIPE)
        free_w_output = str(free_w_output.stdout).split(r'\n')[1]
        self.__mem_stats = re.findall(r"[0-9]+", free_w_output)
        self.__update_used()
        self.__update_total()

    @property
    def used(self):
        return self.__used

    @property
    def total(self):
        return self.__total

    @property
    def percentage_used(self):
        self.update_mem_stats()
        return (self.__used*100/self.__total)

    def __update_used(self):
        self.__used = int(self.__mem_stats[1])

    def __update_total(self):
        self.__total = int(self.__mem_stats[0])


def main():
    mem = Memory()

    while (True):
        percentage_used = mem.percentage_used
        percentage_used = round(percentage_used, 2)
        print('{:>6}%'.format('{:.2f}'.format(percentage_used)), flush=True)

        time.sleep(1)


if __name__ == "__main__":
    main()
