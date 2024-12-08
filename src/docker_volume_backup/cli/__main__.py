#!/usr/bin/env python3

import sys

from docker_volume_backup.cli.cli import run

rc = run()
sys.exit(rc)
