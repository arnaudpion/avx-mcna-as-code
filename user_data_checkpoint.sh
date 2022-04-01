#!/bin/bash

clish -c "set user <user> password-hash <100+ character hash string>" -s
clish -c 'set interface eth1 state on' -s
clish -c 'set hostname checkpoint' -s
blink_config -s 'upload_info=false&download_info=false&install_security_gw=true&install_ppak=true&install_security_managment=false&ipstat_v6=off&ftw_sic_key=<password>'