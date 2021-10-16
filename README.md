# setup_local


1. Im common_setup.yml & work_setup.yml den OS-User setzen.
2. Den eigenen pub und private key ablegen in:  \
`roles/os_config/files/id_rsa_<os_user>`  \
`roles/os_config/files/id_rsa_<os_user>.pub`

- Für den id_rsa Verschlüsselung nutzen:
```
ansible-vault create roles/os_config/files/id_rsa_<os_user>
```
3. Den Pub key in gitlab registrieren.

4. Im root folder dieses Repos folgendes encryptetes File erstellen:
```
ansible-vault create work_secrets.yml.<os_user>
```
- Der Inhalt von work_secrets.yml.<os_user> ist folgender:
```
secure_connect_password: <das STA-POLARIS User Passwort (die JMV Options der Backends)>
abraxas_sso_pw: <dein singel sign on Passwort>
```

5. Installation des Workstation Setups starten in der bash:
```
sudo apt install ansible -y \
 && sudo apt install git -y \
 && ansible-galaxy install -r requirements.yml \
 && ansible-playbook setup.yml --ask-vault-pass --skip-tags map-keys,config-touchpad
```
