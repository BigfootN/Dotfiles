import subprocess
import re
import sys
import time


class Volume:
    @property
    def headphones(self):
        self.__update_stats()
        return self.__headphones

    @property
    def muted(self):
        self.__update_stats()
        return self.__muted

    @property
    def volume(self):
        self.__update_stats()
        return self.__volume_percentage

    def __update_stats(self):
        self.__update_headphone_state()
        self.__update_volume()

    def __update_headphone_state(self):
        amixer_output = subprocess.run(
            ['amixer', 'sget', 'Headphone', '-c', '0'], stdout=subprocess.PIPE)
        amixer_output_last_line = self.__get_output_last_line(amixer_output)
        self.__headphones = (
            amixer_output_last_line.find(r"\[on\]$") != -1)

    def __update_volume(self):
        amixer_output = subprocess.run(
            ['amixer', 'sget', 'Master'], stdout=subprocess.PIPE)
        amixer_output_last_line = self.__get_output_last_line(amixer_output)
        self.__set_volume(amixer_output_last_line)
        self.__muted = self.__is_muted(amixer_output_last_line)

    def __is_muted(self, amixer_output_last_line):
        return (re.search(r"\[off\]$", amixer_output_last_line) != None)

    def __set_volume(self, amixer_output_last_line):
        volume_percentage = re.findall(
            r"\[[0-9]+%\]", amixer_output_last_line)[0]
        self.__volume_percentage = int(
            re.search(r"[0-9]+", volume_percentage).group(0))

    def __get_output_last_line(self, output):
        output_lines = str(output.stdout).split(r"\n")
        output_lines = self.__remove_useless_lines(output_lines)
        return output_lines[len(output_lines) - 1]

    def __remove_useless_lines(self, lines):
        return [
            line for line in lines if len(line.strip()) > 1]


def __show_muted(volume: Volume):
    while (True):
        if (volume.muted):
            print('true', flush=True)
        else:
            print('false', flush=True)
        time.sleep(0.5)


def __show_volume(volume: Volume):
    while (True):
        print('{:>3}%'.format(volume.volume))
        time.sleep(0.5)


def __show_headphones_plugged(volume: Volume):
    while (True):
        if (volume.headphones):
            print('true', flush=True)
        else:
            print('false', flush=True)
        time.sleep(1)


def main():
    volume = Volume()

    switch_do = {
        "--volume": __show_volume,
        "--headphones": __show_headphones_plugged,
        "--muted": __show_muted
    }

    func = switch_do[sys.argv[1]]
    func(volume)


if __name__ == "__main__":
    main()
