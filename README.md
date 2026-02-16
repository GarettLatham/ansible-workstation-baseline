# Ansible Workstation Baseline

Automated hardened Linux workstation setup using Ansible.

## Features

- Security hardening
- Neovim config deployment
- Package baseline
- User environment setup
- Reproducible provisioning

## Usage

```bash
ansible-playbook -i inventories/localhost playbooks/site.yml
=======
# Workstation Baseline (Fedora)

A neutral, composable Ansible baseline for a Fedora Workstation laptop.

## Run (dry-run first)
ansible-playbook -i inventory/workstation.ini playbooks/baseline.yml --check --diff

## Apply
ansible-playbook -i inventory/workstation.ini playbooks/baseline.yml

## Run everything (future expansion)
ansible-playbook -i inventory/workstation.ini playbooks/site.yml
