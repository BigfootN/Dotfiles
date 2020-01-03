from i3ipc import Connection, Event
import sys

i3 = Connection()
workspaces = i3.get_workspaces()
workspace_focused = next (w for w in workspaces if w.focused == True)
workspace_focused_number = workspace_focused.num
workspace_focused_name = workspace_focused.name

def format_workspace_names():
    idx = 0
    while idx < len(workspaces):
        i3.command("rename workspace " + workspaces[idx].name + " to " + str(idx + 1))
        idx += 1

def focused_workspace_is_empty():
    tree = i3.get_tree()
    container_con_list = tree.find_named("^"+workspace_focused_name+"$")
    workspace_con = next (c for c in container_con_list if c.type == "workspace")
    windows = [c for c in workspace_con.nodes if c.window_class is not None]
    empty = (len(windows) == 0)
    return empty

def goto_workspace_next():
    if focused_workspace_is_empty():
        if workspace_focused_number == len(workspaces):
            i3.command("workspace 1")
        else:
            i3.command("workspace " + str(workspace_focused_number + 1))
    else:
        if workspace_focused_number == len(workspaces):
            i3.command("workspace " + str(workspace_focused_number + 1))
        else:
            i3.command("workspace next")

def goto_workspace_prev():
    if workspace_focused_number == 1:
        i3.command("workspace " + str(len(workspaces)))
    else:
        i3.command("workspace prev")

format_workspace_names()

argument = sys.argv[1]
if argument == "next":
    goto_workspace_next()
elif argument == "prev":
    goto_workspace_prev()