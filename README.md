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
