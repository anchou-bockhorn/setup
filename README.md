# setup_local

## Prerquisites:
* Ubuntu 20.04 LTS

## Customize ansible project
* Im common.yml den OS-User setzen.
* Den eigenen pub und private key ablegen in:  \
`roles/os_config/files/id_rsa_<os_user>`  \
`roles/os_config/files/id_rsa_<os_user>.pub`

* Für den id_rsa Verschlüsselung nutzen:
```
 sudo apt install ansible -y \
 && ansible-vault create roles/os_config/files/id_rsa_<os_user>
```
## First time run
* Installation des Workstation Setups starten in der bash:
```
 ansible-galaxy install -r requirements.yml \
 && sudo echo "enter sudo password" \
 && ansible-playbook setup.yml --ask-vault-pass --skip-tags map-keys,config-touchpad
```
