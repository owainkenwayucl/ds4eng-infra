#!/usr/bin/env python3

import json
import subprocess
import argparse

def run(command):
    return subprocess.run(command, capture_output=True, encoding='UTF-8')

def generate_inventory():
    command = "terraform output --json primary_ips".split()
    ip_data = json.loads(run(command).stdout)
    primary_node = ip_data.pop()

    host_vars = {}

    host_vars[primary_node] = { "ip": [primary_node] }
    
    command = "terraform output --json replica_ips".split()
    ip_data = json.loads(run(command).stdout)

    host_vars = {}


    counter = 0
    replicas = []

    for a in ip_data:
        name = a
        host_vars[name] = { "ip": [a] }
        replicas.append(name)
        counter += 1

    _meta = {}
    _meta["hostvars"] = host_vars
    _all = { "children": ["primary_node", "replicas"] }

    _replicas = { "hosts": replicas }
    _primary = { "hosts": [primary_node] }

    _jd = {}
    _jd["_meta"] = _meta
    _jd["all"] = _all
    _jd["replicas"] = _replicas
    _jd["primary_node"] = _primary



    jd = json.dumps(_jd, indent=4)
    return jd


if __name__ == "__main__":

    ap = argparse.ArgumentParser(
        description = "Generate a K3s cluster inventory from Terraform.",
        prog = __file__
    )

    mo = ap.add_mutually_exclusive_group()
    mo.add_argument("--list",action="store", nargs="*", default="dummy", help="Show JSON of all managed hosts")
    mo.add_argument("--host",action="store", help="Display vars related to the host")

    args = ap.parse_args()

    if args.host:
        print(json.dumps({}))
    elif len(args.list) >= 0:
        jd = generate_inventory()
        print(jd)
    else:
        raise ValueError("Expecting either --host $HOSTNAME or --list")

    
