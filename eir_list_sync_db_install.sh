#!/bin/bash
conf_file=${APP_HOME}/configuration/configuration.properties
typeset -A config # init array

while read line
do
    if echo $line | grep -F = &>/dev/null
    then
        varname=$(echo "$line" | cut -d '=' -f 1)
        config[$varname]=$(echo "$line" | cut -d '=' -f 2-)
    fi
done < $conf_file
dbPassword=$(java -jar  ${APP_HOME}/utility/pass_dypt/pass_dypt.jar spring.datasource.password)
conn="mysql -h${config[dbIp]} -P${config[dbPort]} -u${config[dbUsername]} -p${dbPassword} ${config[appdbName]}"

`${conn} <<EOFMYSQL


INSERT IGNORE INTO sys_param (tag, value, feature_name, description, type, active, remark, user_type, modified_by) VALUES ('LSM_ENABLE_PROCESSING_BLACKED_LIST', 'YES', 'eir_list_sync', 'Enable Syncing for Black List', 0, 1,NULL, 'system', 'system');
INSERT IGNORE INTO sys_param (tag, value, feature_name, description, type, active, remark, user_type, modified_by) VALUES ('LSM_ENABLE_PROCESSING_BLOCKED_TAC', 'YES', 'eir_list_sync', 'Enable Syncing for Blocked Tac List', 0, 1,NULL, 'system', 'system');
INSERT IGNORE INTO sys_param (tag, value, feature_name, description, type, active, remark, user_type, modified_by) VALUES ('LSM_ENABLE_PROCESSING_TRACKED_LIST', 'YES', 'eir_list_sync', 'Enable Syncing for Tracked List', 0, 1,NULL, 'system', 'system');
INSERT IGNORE INTO sys_param (tag, value, feature_name, description, type, active, remark, user_type, modified_by) VALUES ('LSM_ENABLE_PROCESSING_EXCEPTION_LIST', 'YES', 'eir_list_sync', 'Enable Syncing for Excception List', 0, 1,NULL, 'system', 'system');

insert ignore into sys_param(tag,value,feature_name,description,type,active,remark,user_type,modified_by) values ('LSM_FAILED_SYNC_RETRY_AFTER_MINUTES','5','eir_list_sync','', 0, 1,NULL, 'system', 'system');

INSERT IGNORE INTO sys_param (tag, value, feature_name, description, type, active, remark, user_type, modified_by) VALUES ('LSM_NO_OF_OPERATORS', '4', 'eir_list_sync', '', 0, 1,NULL, 'system', 'system');
INSERT IGNORE INTO sys_param (tag, value, feature_name, description, type, active, remark, user_type, modified_by) VALUES ('LSM_OPERATORS_1', 'metfone', 'eir_list_sync', '', 0, 1,NULL, 'system', 'system');
INSERT IGNORE INTO sys_param (tag, value, feature_name, description, type, active, remark, user_type, modified_by) VALUES ('LSM_OPERATORS_2', 'cellcard', 'eir_list_sync', '', 0, 1,NULL, 'system', 'system');

INSERT IGNORE INTO sys_param (tag, value, feature_name, description, type, active, remark, user_type, modified_by) VALUES ('LSM_OPERATORS_3', 'smart', 'eir_list_sync', '', 0, 1,NULL, 'system', 'system');

INSERT IGNORE INTO sys_param (tag, value, feature_name, description, type, active, remark, user_type, modified_by) VALUES ('LSM_OPERATORS_4', 'seatel', 'eir_list_sync', '', 0, 1,NULL, 'system', 'system');

INSERT IGNORE INTO sys_param (tag, value, feature_name, description, type, active, remark, user_type, modified_by) VALUES ('LSM_SMART_READ_TIME_OUT', '10', 'eir_list_sync', 'Read Time out for Operator', 0, 1,NULL, 'system', 'system');
INSERT IGNORE INTO sys_param (tag, value, feature_name, description, type, active, remark, user_type, modified_by) VALUES ('LSM_SMART_TPS', '100', 'eir_list_sync', 'TPS to sync with Opertor', 0, 1,NULL, 'system', 'system');
INSERT IGNORE INTO sys_param (tag, value, feature_name, description, type, active, remark, user_type, modified_by) VALUES ('LSM_SMART_BASIC_AUTH_CREDENTIALS', 'abc:password', 'eir_list_sync', 'Basic Auth Credentials for Operator', 0, 1,NULL, 'system', 'system');
INSERT IGNORE INTO sys_param (tag, value, feature_name, description, type, active, remark, user_type, modified_by) VALUES ('LSM_SMART_NO_EIRS', '1', 'eir_list_sync', 'No of EIR for Operator', 0, 1,NULL, 'system', 'system');
INSERT IGNORE INTO sys_param (tag, value, feature_name, description, type, active, remark, user_type, modified_by) VALUES ('LSM_SMART_URL_1', 'https://lsm.smart.com.kh:9081', 'eir_list_sync', 'Operators EIR URL', 0, 1,NULL, 'system', 'system');


INSERT IGNORE INTO sys_param (tag, value, feature_name, description, type, active, remark, user_type, modified_by) VALUES ('LSM_METFONE_READ_TIME_OUT', '10', 'eir_list_sync', 'Read Time out for Operator', 0, 1,NULL, 'system', 'system');
INSERT IGNORE INTO sys_param (tag, value, feature_name, description, type, active, remark, user_type, modified_by) VALUES ('LSM_METFONE_TPS', '100', 'eir_list_sync', 'TPS to sync with Opertor', 0, 1,NULL, 'system', 'system');
INSERT IGNORE INTO sys_param (tag, value, feature_name, description, type, active, remark, user_type, modified_by) VALUES ('LSM_METFONE_BASIC_AUTH_CREDENTIALS', 'abc:password', 'eir_list_sync', 'Basic Auth Credentials for Operator', 0, 1,NULL, 'system', 'system');
INSERT IGNORE INTO sys_param (tag, value, feature_name, description, type, active, remark, user_type, modified_by) VALUES ('LSM_METFONE_NO_EIRS', '1', 'eir_list_sync', 'No of EIR for Operator', 0, 1,NULL, 'system', 'system');
INSERT IGNORE INTO sys_param (tag, value, feature_name, description, type, active, remark, user_type, modified_by) VALUES ('LSM_METFONE_URL_1', 'https://lsm.metfone.com.kh:9081', 'eir_list_sync', 'Operators EIR URL', 0, 1,NULL, 'system', 'system');

INSERT IGNORE INTO sys_param (tag, value, feature_name, description, type, active, remark, user_type, modified_by) VALUES ('LSM_CELLCARD_READ_TIME_OUT', '10', 'eir_list_sync', 'Read Time out for Operator', 0, 1,NULL, 'system', 'system');
INSERT IGNORE INTO sys_param (tag, value, feature_name, description, type, active, remark, user_type, modified_by) VALUES ('LSM_CELLCARD_TPS', '100', 'eir_list_sync', 'TPS to sync with Opertor', 0, 1,NULL, 'system', 'system');
INSERT IGNORE INTO sys_param (tag, value, feature_name, description, type, active, remark, user_type, modified_by) VALUES ('LSM_CELLCARD_BASIC_AUTH_CREDENTIALS', 'abc:password', 'eir_list_sync', 'Basic Auth Credentials for Operator', 0, 1,NULL, 'system', 'system');
INSERT IGNORE INTO sys_param (tag, value, feature_name, description, type, active, remark, user_type, modified_by) VALUES ('LSM_CELLCARD_NO_EIRS', '1', 'eir_list_sync', 'No of EIR for Operator', 0, 1,NULL, 'system', 'system');
INSERT IGNORE INTO sys_param (tag, value, feature_name, description, type, active, remark, user_type, modified_by) VALUES ('LSM_CELLCARD_URL_1', 'https://lsm.cellcard.com.kh:9081', 'eir_list_sync', 'Operators EIR URL', 0, 1,NULL, 'system', 'system');

INSERT IGNORE INTO sys_param (tag, value, feature_name, description, type, active, remark, user_type, modified_by) VALUES ('LSM_SEATEL_READ_TIME_OUT', '10', 'eir_list_sync', 'Read Time out for Operator', 0, 1,NULL, 'system', 'system');
INSERT IGNORE INTO sys_param (tag, value, feature_name, description, type, active, remark, user_type, modified_by) VALUES ('LSM_SEATEL_TPS', '100', 'eir_list_sync', 'TPS to sync with Opertor', 0, 1,NULL, 'system', 'system');
INSERT IGNORE INTO sys_param (tag, value, feature_name, description, type, active, remark, user_type, modified_by) VALUES ('LSM_SEATEL_BASIC_AUTH_CREDENTIALS', 'abc:password', 'eir_list_sync', 'Basic Auth Credentials for Operator', 0, 1,NULL, 'system', 'system');
INSERT IGNORE INTO sys_param (tag, value, feature_name, description, type, active, remark, user_type, modified_by) VALUES ('LSM_SEATEL_NO_EIRS', '1', 'eir_list_sync', 'No of EIR for Operator', 0, 1,NULL, 'system', 'system');
INSERT IGNORE INTO sys_param (tag, value, feature_name, description, type, active, remark, user_type, modified_by) VALUES ('LSM_SEATEL_URL_1', 'https://10.100.1.171:9081', 'eir_list_sync', 'Operators EIR URL', 0, 1,NULL, 'system', 'system');

INSERT IGNORE INTO sys_param (tag, VALUE, feature_name, DESCRIPTION, TYPE, ACTIVE, remark, user_type, modified_by) VALUES ('LSM_ENABLE_PROCESSING_ALLOWED_TAC', 'No', 'eir_list_sync', 'Last Enable Processing allowed tac', 0, 1,NULL, 'system', 'system');
INSERT IGNORE INTO sys_param (tag, value, feature_name, description, type, active, remark, user_type, modified_by) VALUES ('LSM_PICK_DATE_BEFORE_TIME', '2', 'eir_list_sync', 'Last Pickup Date before time', 0, 1,NULL, 'system', 'system');

create index indx_CREATED_ON on grey_list_his (CREATED_ON);
create index indx_CREATED_ON on exception_list_his (CREATED_ON);
create index indx_CREATED_ON on blocked_tac_his (CREATED_ON);
create index indx_CREATED_ON on black_list_his (CREATED_ON);

EOFMYSQL`

echo "DB Script Execution Completed "
