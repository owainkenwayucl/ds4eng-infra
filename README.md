# Infrastructure for Engineering for Data Scientists course

Generally:

Have a key named after your user name, set user name in `variables.tf` and `terraform init`,  `terraform apply` and everything should just work.

On the K3s stuff, set the number of servers (>= 2) in `variables.tf`, after doing `terraform apply` do:

```
ansible-playbook -i ./generate_inventory.py full.yaml
```

(or individual playbooks)

Log into the head node and you should have `kubectl`, `helm` etc.