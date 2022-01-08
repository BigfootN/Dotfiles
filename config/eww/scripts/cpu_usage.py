import re
import time


class Cpu:
    def __init__(self):
        self.__work_jeffies_before = 0
        self.__total_jeffies_before = 0
        self.__update_cpu_values()
        self.__save_jeffies()

    @property
    def usage(self):
        return self.__usage

    def update_usage(self):
        time.sleep(1.5)
        self.__update_cpu_values()
        delta_work_jeffies = self.__work_jeffies_now - self.__work_jeffies_before
        delta_total_jeffies = self.__total_jeffies_now - self.__total_jeffies_before
        self.__usage = (delta_work_jeffies/delta_total_jeffies)*100

        self.__save_jeffies()

    def __update_cpu_values(self):
        self.__open_proc_stat_file()
        self.__update_proc_stat_values()
        self.__update_total_jeffies()
        self.__update_work_jeffies()

    def __update_proc_stat_values(self):
        self.__update_proc_stat_line()
        self.__proc_stat_line = re.sub(r'^cpu\s*', "", self.__proc_stat_line)
        self.__proc_stat_values = self.__proc_stat_line.split(" ")

    def __update_total_jeffies(self):
        self.__total_jeffies_now = 0
        for value in self.__proc_stat_values:
            self.__total_jeffies_now += int(value)

    def __update_work_jeffies(self):
        self.__work_jeffies_now = 0
        for index in range(0, 2):
            self.__work_jeffies_now += int(self.__proc_stat_values[index])

    def __open_proc_stat_file(self):
        self.__proc_stat_file = open("/proc/stat")

    def __update_proc_stat_line(self):
        self.__proc_stat_line = self.__proc_stat_file.readline().rstrip()

    def __save_jeffies(self):
        self.__work_jeffies_before = self.__work_jeffies_now
        self.__total_jeffies_before = self.__total_jeffies_now


def main():
    cpu = Cpu()

    while (True):
        cpu.update_usage()
        cpu_usage = cpu.usage
        cpu_usage = round(cpu_usage, 2)
        print('{:>6}%'.format('{:.2f}'.format(cpu_usage)), flush=True)


if __name__ == "__main__":
    main()
