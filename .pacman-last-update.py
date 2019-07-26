#!/usr/bin/env python3
import pathlib
import re
from datetime import datetime

LOG_PATH = pathlib.Path("/var/log/pacman.log")

def get_log():
    with LOG_PATH.open() as fp:
        log_text = fp.read()

    return log_text

def parse_pacman_line(line):
    if len(line) > 0:
        date_str = line[:18]
        pacman_indicator = line[19:27]
        message = line[28:]

        if pacman_indicator == "[PACMAN]":
            parsed_date = datetime.strptime(date_str,
                                            "[%Y-%m-%d %H:%M]")
            return {"date": parsed_date,
                    "message": message}

    return None

def get_last_sync(log_text):
    last_sync = None
    for line in log_text.split("\n"):
        
        parsed_line = parse_pacman_line(line)
        if parsed_line is None:
            continue
        else:
            if parsed_line["message"] == "synchronizing package lists":
                last_sync = parsed_line["date"]

    return last_sync

def get_last_system_upgrade(log_text):
    last_upgrade = None
    for line in log_text.split("\n"):        
        parsed_line = parse_pacman_line(line)
        if parsed_line is None:
            continue
        else:
            if parsed_line["message"] == "starting full system upgrade":
                last_upgrade = parsed_line["date"]

    return last_upgrade

def get_diffs(t):
    now = datetime.now()
    diff = now - t

    if diff.days != 0:
        return "{}d".format(diff.days)
    elif diff.seconds > 3600:
        return "{}h".format(diff.seconds // 3600)
    else:
        return "{}m".format(diff.seconds // 60)

if __name__ == "__main__":
    text = get_log()
    #last_sync = get_last_sync(text)
    last_upgrade = get_last_system_upgrade(text)
    #last_sync_diff = get_diffs(last_sync)
    last_upgrade_diff = get_diffs(last_upgrade)

    print("{}".format(last_upgrade_diff))
