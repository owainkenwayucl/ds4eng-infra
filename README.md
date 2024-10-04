# Infrastructure for Engineering for Data Scientists course

## Generally:

## 1. Set up kube conf.

Either put the config file in `~/.kube/config` or `export KUBECONFIG=/path/to/file`.

## 2. Install Terraform

Depends on your platform - I've added the official Hashicorp repos to my Linux machines for Vault so I installed it from them. Note that the version in Homebrew is frozen at an old version from before the license change. Hashicorp do have a Homebrew tap though.

## 2. Set up SSH key.

Put your public key under the `ds4eng-ns` namespace 

I've writte the Terraform scripts with the assumption that your key is named after your username which is probably what we should tell the students to do, the scripts then name your vm [username]-[purpose]-[number].

## 4. Deploy

Set user name and key name  in `variables.tf`

To build an environment, set the number of servers (>= 2 for clusters!) in `variables.tf` then do:

```
terraform init
terraform apply
```

(You may have to wait a little bit for cloudinit to finish setting up - I've started making the cloudinit bits as short as possible to avoid this)

```
ansible-playbook -i ./generate_inventory.py full.yaml
```

(or individual playbooks)
