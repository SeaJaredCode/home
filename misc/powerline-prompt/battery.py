from ..utils import BasicSegment
import subprocess
import re

LOW_BATTERY_THRESHOLD = 20
# See discussion in https://github.com/banga/powerline-shell/pull/204 regarding
# the directory where battery info is saved
DIR_OPTIONS = ["/sys/class/power_supply/BAT0",
               "/sys/class/power_supply/BAT1"]

CHARGING_ORIG = u'\u26a1'
CHARGING = u'\uf492'
BATTERY = [u'\uf244', u'\uf243', u'\uf242', u'\uf241', u'\uf240']


def parse_stats(status):
    info = re.search('(?P<percent>\d+)%[; ]*(?P<charge>[a-z]+)[; ]+'
                     '(?P<time>[\d:]*)', status)

    return info.groupdict() if info else None


def get_battery_stats():
    proc = subprocess.Popen(['pmset', '-g', 'batt'],
                            stdout=subprocess.PIPE,
                            stderr=subprocess.PIPE)
    data = proc.communicate()

    if proc.returncode != 0:
        return (None, None, None)

    stats = parse_stats(data[0])
    return stats['charge'], stats['percent'], stats['time']


class Segment(BasicSegment):
    def add_to_powerline(self):
        charge, percent, time = get_battery_stats()
        source = CHARGING if charge != "discharging" \
            else BATTERY[abs(int(percent) - 1) / 20]
        if int(percent) < LOW_BATTERY_THRESHOLD:
            bg = self.powerline.theme.BATTERY_LOW_BG
            fg = self.powerline.theme.BATTERY_LOW_FG
        else:
            bg = self.powerline.theme.BATTERY_NORMAL_BG
            fg = self.powerline.theme.BATTERY_NORMAL_FG
        self.powerline.append(" " + source + " " + percent + "%", fg, bg)
