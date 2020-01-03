from i3ipc import Connection, Event
import sys

i3 = Connection()
workspace_focused = i3.get_tree().find_focused().workspace()
workspace_focused_numer = workspace_focused.num

def move_container_next_workspace():
    i3.command("move container workspace " + str(workspace_focused_numer + 1))
    i3.command("workspace " + str(workspace_focused_numer + 1))

def move_container_prev_workspace():
    if workspace_focused_numer > 1:
        i3.command("move container workspace " + str(workspace_focused_numer - 1))
        i3.command("workspace " + str(workspace_focused_numer - 1))

argument = sys.argv[1]
if (argument == "prev"):
    move_container_prev_workspace()
elif (argument == "next"):
    move_container_next_workspace()