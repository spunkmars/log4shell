#!/bin/bash

install_dest_dir='/data/scripts/lib/shell_modules'
mkdir -p /data/scripts
mkdir -p /data/scripts/lib
mkdir -p /data/logs
mkdir -p /data/logs/scripts_logs
mkdir -p ${install_dest_dir}

cp -rf log4shell.sh  ${install_dest_dir}
cp -rf log4shell_templete.sh ${install_dest_dir}
chmod +x ${install_dest_dir}/log4shell.sh

