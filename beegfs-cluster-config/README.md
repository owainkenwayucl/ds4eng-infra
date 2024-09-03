# Post cluster build BeeGFS setup.

The ansible playbook(s) in this folder are meant to be run after you have generated a cluster with [base-cluster-environment](../base-cluster-environment/).

A modified `generate_inventory.py` script is provided which will pull hosts from [base-cluster-environment](../base-cluster-environment/) so you should be able to run playbooks as usual e.g.

```
ansible-playbook -i generate_inventory.py full.yaml
```