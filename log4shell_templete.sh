#!/bin/bash

#######################
# Filename : log4shell_example.sh
# Version  : 1.0.0
# Create   : 2012/10/10
# Update   : 2012/10/10
# Author   : SpunkMars++
# Contact  : spunkmars@gmail.com, spunkmars@163.com
# Site     : http://www.spunkmars.org
# Description :
# Notes:
#
######## Changlog #####
#Version 1.0.0
# xxx xxx xxx xxxx
#------------------
#
#Version 1.0.1
# xxx xxx xxx xxx
#######################


PROG_NAME='log4shell_example'
MOD_NAME='log4shell_example'
VERSION='1.0.0'
MODS_DIR='/data/scripts/lib/shell_modules'
REQUEST_MODS=(log4shell)


####### LOAD INIT MODULE ########
source ${MODS_DIR}/init_module.sh
#################################


#### INIT Log4Shell #####
log4shell_app_name="log4shell_templete"
#log4shell_logger1=(DEBUG  log4shell_SCREEN)
log4shell_logger2=(INFO  log4shell_SCREEN log4shell_FILE log4shell_SYSLOG)
log4shell_logger3=(ERROR  log4shell_SCREEN log4shell_FILE log4shell_SYSLOG log4shell_EMAIL)
log4shell_FILE_log_path=/data/${log4shell_app_name}.log
log4shell_SYSLOG_facility='user'
log4shell_INIT_LOGGER
#########################


