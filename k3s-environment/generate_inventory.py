#!/usr/bin/env python3

import json
import subprocess

def run(command):
    return subprocess.run(command, capture_output=True, encoding='UTF-8')

def generate_inventory():
    command = "terraform output --json vm_ips".split()
    ip_data = json.loads(run(command).stdout)
    head_node = ip_data.pop()

    headnodes = {}
    headnodes_hosts = {}
    headnodes_hosts[head_node] = None
    headnodes["hosts"] = headnodes_hosts
    print(f"Head node: {head_node}")

    workers = {}
    workers_hosts = {}
    for a in ip_data:
        workers_hosts[f"{a}"] = None
        print(f"Worker node: {a}")

    workers["hosts"] = workers_hosts

    children = {}
    children["headnode"] = headnodes
    children["workers"] = workers
    al = {}
    al["children"] = children

    inv = {}
    inv["all"] = al
    jd = json.dumps(inv, indent=4)

    print(jd)
    inv_file = open("inventory.json", "w")
    inv_file.write(jd)
    inv_file.close()


if __name__ == "__main__":
    generate_inventory()
