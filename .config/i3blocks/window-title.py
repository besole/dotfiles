#!/usr/bin/python3

import i3ipc
import sys

MAXCHARS = 35

def on_window_focus(i3, e):
    focused = i3.get_tree().find_focused()
    text = "%s" % (focused.name)
    if len(text) > MAXCHARS:
        text = text[:MAXCHARS - 3] + "..."
    print(text)
    sys.stdout.flush()

def on_window_close(i3, e):
    focused = i3.get_tree().find_focused()
    if focused == focused.workspace():
        print("")
        sys.stdout.flush()

def on_workspace(i3, e):
    if not i3.get_tree().find_focused().window:
        print("")
        sys.stdout.flush()

def colorOutput(text):
    print('<span background="#CCCCCC" foreground="#000000"> %s </span>' % text)

def main():
    i3 = i3ipc.Connection()
    i3.on("window::focus", on_window_focus)
    i3.on("window::title", on_window_focus)
    i3.on("window::close", on_window_close)
    i3.on("workspace", on_workspace)

    # Start listening to events
    i3.main()



main()
