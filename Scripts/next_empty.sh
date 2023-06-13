#!/usr/bin/python

import json, subprocess

workspaces = json.loads(subprocess.check_output(['i3-msg', '-t', 'get_workspaces']))

next_empty = next(i for i in range(1, 100) if not [ws for ws in workspaces if ws['num'] == i])

subprocess.call(['i3-msg', 'move container to workspace number %i' % next_empty])
