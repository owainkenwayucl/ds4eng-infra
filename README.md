# Infrastructure for Engineering for Data Scientists course

Generally:

Have a key named after your user name, set user name in `variables.tf` and everything should just work.

To build an environment, set the number of servers (>= 2 for clusters!) in `variables.tf` then do:

```
terraform init
terraform apply
ansible-playbook -i ./generate_inventory.py full.yaml
```

(or individual playbooks)
