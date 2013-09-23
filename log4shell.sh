
#######################
# Filename : log4shell.sh
# Version  : 1.0.0.5
# Create   : 2011/02/18  01: 58
# Update   : 2012/10/15  10: 09
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


PROG_NAME='log4shell'
MOD_NAME='log4shell'
VERSION='1.0.0.5'
MODS_DIR='/data/scripts/lib/shell_modules'
REQUEST_MODS=(array_module net_module system_module http_module)


####### LOAD INIT MODULE ########
source ${MODS_DIR}/init_module.sh
#################################


############ Setting Logger ##########

## LEVELS ##
#
# DEBUG : 1
# INFO : 2
# WARN : 3
# ERROR : 4
# ALERT : 5
# FATAL : 6


## OUTPUT ##
#
# log4shell_SCREEN : 1
# log4shell_FILE : 2
# log4shell_SYSLOG : 3
# log4shell_EMAIL : 4
shopt -s expand_aliases


log4shell_app_name="logger_test"
log4shell_current_date=`date +"%Y/%m/%d %H:%M:%S"`
log4shell_current_path=$(cd "$(dirname "$0")"; pwd)
log4shell_scripts_name=`echo $0|awk -F"/" '{print $NF}'`
log4shell_ip_address=$(get_ip_string)
log4shell_is_run_fg=$(is_run_fg)
#log4shell_FILE_log_path=/data/${log4shell_app_name}_`date +"%Y_%m_%d%H%M%S"`.log


### 设置输出等级以及输出目的 ##
#
#log4shell_logger1=(DEBUG  log4shell_SCREEN)
#log4shell_logger2=(INFO  log4shell_FILE)
#log4shell_logger3=(WARN  log4shell_SYSLOG)
#log4shell_logger4=(FATAL  log4shell_EMAIL )

log4shell_FILE_log_path=/data/${log4shell_app_name}.log

log4shell_SYSLOG_facility='user'


log4shell_name="LOG4SHELL"
log4shell_version="1.0.0.5"
log4shell_release_date="2012/10/12  21: 08"
log4shell_author="SpunkMars++"
log4shell_description="This Scritps By Bash Shell"
log4shell_copyright="SpunkMars++  All rights reserved. "
log4shell_contact=" EMail: spunkmars[at]gmail.com   Web: http://www.spunkmars.org "


declare -a log4shell_logger1
declare -a log4shell_logger2
declare -a log4shell_logger3
declare -a log4shell_logger4
declare -a log4shell_logger5
declare -a log4shell_logger6


declare -a log4shell_SCREEN
declare -a log4shell_FILE
declare -a log4shell_SYSLOG
declare -a log4shell_EMAIL

log4shell_total_levels=6
log4shell_total_logger=6

log4shell_SCREEN=(0 0 0 0 0 0 0)
log4shell_FILE=(0 0 0 0 0 0 0)
log4shell_SYSLOG=(0 0 0 0 0 0 0)
log4shell_EMAIL=(0 0 0 0 0 0 0)

function log4shell_error {

     echo ""
     echo ""
     echo "                     $log4shell_name "
     echo "              Version:  $log4shell_version"
     echo "              Author: $log4shell_author"
     echo "              Release Date: $log4shell_release_date"
     echo ""
     echo "-----------------------------------------------------------------------------"
     echo "|                                                                           |"
     echo "|                  ERROR !                                                  |"
     echo "|                                                                           |"
     echo "|                                                                           |"
     echo "|    $log4shell_current_date $1                                             |"
     echo "|                                                                           |"
     echo "|                                                                           |"
     echo "----------------------------------------------------------------------------"
     echo "   SUPPORT  $log4shell_contact "
     echo ""
     echo ""
     echo ""


}


function log4shell_INIT_LOGGER {
    local init_output
    local init_level
    local init_level_number
    local len
    local  y
    local z
    for (( z=1; z <= log4shell_total_logger ; z++ ))
        do
            eval len="\${#log4shell_logger$z[*]}"
            eval init_level="\${log4shell_logger$z[0]}"
            init_level_number=`log4shell_level_to_number "$init_level"`
            #echo "\$len=$len"
            for (( y=1 ; y < "$len"; y++ ))
                do
                    eval init_output="\${log4shell_logger$z[$y]}"
                    #echo "\$init_output = $init_output ; \$init_level_number = $init_level_number"
                    case "$init_output" in
                        log4shell_SCREEN ) log4shell_INIT_SCREEN "$init_level_number"
                                  ;;
                        log4shell_FILE  )  log4shell_INIT_FILE "$init_level_number"
                                  ;;
                        log4shell_SYSLOG ) log4shell_INIT_SYSLOG "$init_level_number"
                                  ;;
                        log4shell_EMAIL  ) log4shell_INIT_EMAIL "$init_level_number"
                                  ;;
                        *      )
                                      log4shell_error "Log4Shell init Fail! Please check again!"
                                      exit 1
                                   ;;
                    esac
                done
        done

}


function log4shell_INIT_SCREEN {
    local i
    for (( i="$1" ; i <= log4shell_total_levels ; i++ ))
        do
            log4shell_SCREEN[$i]=1
            #echo "log4shell_SCREEN[$i] = ${log4shell_SCREEN[$i]}"
        done

}


function log4shell_INIT_FILE {
    local i
    for (( i="$1" ; i <= log4shell_total_levels ; i++ ))
        do
            log4shell_FILE[$i]=1
            #echo "log4shell_FILE[$i] = ${log4shell_FILE[$i]}"
        done
}


function log4shell_INIT_SYSLOG {
    local i
    for (( i="$1" ; i <= log4shell_total_levels ; i++ ))
        do
            log4shell_SYSLOG[$i]=1
            #echo "log4shell_SYSLOG[$i] = ${log4shell_SYSLOG[$i]}"
        done

}


function log4shell_INIT_EMAIL {
    local i
    for (( i="$1" ; i <= log4shell_total_levels ; i++ ))
        do
            log4shell_EMAIL[$i]=1
            #echo "log4shell_EMAIL[$i] = ${log4shell_EMAIL[$i]}"
        done

}


function log4shell_number_to_level {
    local levels=("NONE" "DEBUG" "INFO" "WARN" "ERROR" "ALERT" "FATAL")
    echo ${levels[$1]}
}


function log4shell_level_to_number {
    local i
    local levels=("NONE" "DEBUG" "INFO" "WARN" "ERROR" "ALERT" "FATAL")
    local LIMIT=${#levels[*]}
    for ((i=1; i <= LIMIT ; i++))
    do
       if [ "${levels[$i]}" == "$1" ]
       then
           break
       fi
    done
    echo $i
}


function send_alert {

    local m_sub="$1"
    local m_content="$2"
    local m_type="${3-'EMAIL_SMTP'}"
    #local http_uri="http://sendinfo.test.com:8088/sendinfo.pl?subject=$(uri_encoder ${m_sub})&message=$(uri_encoder ${m_content})&type=$(uri_encoder ${m_type})"
    local http_uri="http://sendinfo.test.com:8088/sendinfo.pl?subject=${m_sub}&message=${m_content}&type=${m_type}"

    local send_alert_result=1
    local http_response
    if [ -x '/usr/bin/wget' ];then
        http_uri=$(echo "${http_uri}"|sed -r 's#&#\&#g')
        #http_response=`/usr/bin/wget "${http_uri}" -O /dev/null -o /dev/null  2>&1 `
        http_response=`/usr/bin/wget "${http_uri}" -O -   2>&1 `
    else
        http_response=$(shell_wget "${http_uri}")
    fi
    #echo "http_response=${http_response}"
    [ $(get_http_response_status "${http_response}") -eq 200 ] && send_alert_result=0

    echo "${send_alert_result}"

}


function log4shell_switch_output {
    local level_number=$1
    local  severity=$2
    local  severity_display_name=$3
    local  message=$6
    local  line_number=$5
    local  function_name=""
    local  encoder_message=$(uri_encoder "$log4shell_ip_address ${log4shell_app_name}[$$] [${log4shell_current_path}/${log4shell_scripts_name}]$line_number $severity_display_name > $message")
    local  encoder_subject=$(uri_encoder  "$log4shell_ip_address ${log4shell_app_name}[$$]  $severity_display_name")
    # echo "log4shell_switch_output \$level_number = $level_number"
    # echo "log4shell_switch_output \$severity = $severity"
    # echo "log4shell_switch_output \$severity_display_name = $severity_display_name"
    # echo "log4shell_switch_output \$message = $message"
    # echo "log4shell_switch_output \$line_number = $line_number"
    # echo "log4shell_switch_output \$function_name = $function_name"

    if [[ $log4shell_is_run_fg -eq 1 &&  ${log4shell_SCREEN[$level_number]} -eq 1 ]]
       then
           echo `date +"%Y/%m/%d %H:%M:%S"`" $log4shell_ip_address ${log4shell_app_name}[$$] [${log4shell_current_path}/${log4shell_scripts_name}] $line_number  $severity_display_name > $message"
    fi

    if  [[ ${log4shell_FILE[$level_number]} -eq 1 ]]
       then
    echo `date +"%Y/%m/%d %H:%M:%S"`" $log4shell_ip_address ${log4shell_app_name}[$$] [${log4shell_current_path}/${log4shell_scripts_name}]$line_number $severity_display_name > $message" >> $log4shell_FILE_log_path
    fi

    if  [[ ${log4shell_SYSLOG[$level_number]} -eq 1 ]]
        then
    logger   -p $log4shell_SYSLOG_facility.$severity -t ${log4shell_app_name}[$$] "[${log4shell_current_path}/${log4shell_scripts_name}]$line_number  $severity_display_name > $message"
    fi

    if  [[ ${log4shell_EMAIL[$level_number]} -eq 1 ]]
        then
    #/usr/bin/perl  /data/scripts/lib/send_email.pl  --subject="$log4shell_ip_address ${log4shell_app_name}[$$]  $severity_display_name"  --message="$log4shell_ip_address ${log4shell_app_name}[$$] [${log4shell_current_path}/${log4shell_scripts_name}]$line_number $severity_display_name > $message"
    send_alert "${encoder_subject}"  "${encoder_message}" "$(uri_encoder 'EMAIL_SMTP')"
    fi
}


function log4shell_log_debug_1 {
    local message=$3
    local line_number=$1
    local function_name=$2
    local level_number=`log4shell_level_to_number "DEBUG"`
    #echo "log_debug level_number =$level_number"
    log4shell_switch_output "$level_number" "debug" "DEBUG" "$message" "$line_number" "$function_name"
}


function log4shell_log_info_1 {
    local message=$3
    local line_number=$1
    local function_name=$2
    local level_number=`log4shell_level_to_number "INFO"`
    #echo "log_info level_number =$level_number"
    log4shell_switch_output "$level_number" "info" "INFO" "$message" "$line_number" "$function_name"
}

function log4shell_log_warn_1 {
    local message=$3
    local line_number=$1
    local function_name=$2
    local level_number=`log4shell_level_to_number "WARN"`
    #echo "log_warn level_number =$level_number"
    log4shell_switch_output "$level_number" "warn" "WARN" "$message" "$line_number" "$function_name"
}


function log4shell_log_error_1 {
    local message=$3
    local line_number=$1
    local function_name=$2
    local level_number=`log4shell_level_to_number "ERROR"`
    #echo "log_error level_number =$level_number"
    log4shell_switch_output "$level_number" "error" "ERROR" "$message" "$line_number" "$function_name"
}

function log4shell_log_alert_1 {
    local message=$3
    local line_number=$1
    local function_name=$2
    local level_number=`log4shell_level_to_number "ALERT"`
    #echo "log_alert level_number =$level_number"
    log4shell_switch_output "$level_number" "alert" "ALERT" "$message" "$line_number" "$function_name"
}

function log4shell_log_fatal_1 {
    local message=$3
    local line_number=$1
    local function_name=$2
    local level_number=`log4shell_level_to_number "FATAL"`
    #echo "log_fatal level_number =$level_number"
    log4shell_switch_output $level_number "emerg" "FATAL" "$message" "$line_number" "$function_name"
    exit
}


function log {
    logger   -p $1.$2 -t ${log4shell_app_name}[$$] "[$log4shell_current_path/$0] $3 > $4"
}



alias LOG4SHELL_LF:@^='echo ":$LINENO($FUNCNAME)"'
alias log_debug='log4shell_log_debug_1 `LOG4SHELL_LF:@^`'
alias log_info='log4shell_log_info_1 `LOG4SHELL_LF:@^`'
alias log_warn='log4shell_log_warn_1 `LOG4SHELL_LF:@^`'
alias log_error='log4shell_log_error_1 `LOG4SHELL_LF:@^`'
alias log_alert='log4shell_log_alert_1 `LOG4SHELL_LF:@^`'
alias log_fatal='log4shell_log_fatal_1 `LOG4SHELL_LF:@^`'

function test_log4shell {

    log4shell_INIT_LOGGER #初始化(开启）日志记录器 . 如需关闭日志记录器，只需注释此句就可!

    log_debug "DEBUG 1"
    log_debug "DEBUG 2"
    log_info "INFO 1"
    log_info "INFO 2"
    log_warn "WARN 1"
    log_warn "WARN 2"
    log_error "ERROR 1"
    log_error "ERROR 2"
    log_alert "ALERT 1"
    log_alert "ALERT 2"
    log_fatal "FATAL 1"
    log_fatal "FATAL 2"
}


#### RUN ########
