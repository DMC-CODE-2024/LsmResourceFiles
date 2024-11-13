source ~/.bash_profile

source $commonConfigurationFilePath
dbDecryptPassword=$(java -jar  ${APP_HOME}/encryption_utility/PasswordDecryptor-0.1.jar spring.datasource.password)

mysql  -h$dbIp -P$dbPort -u$dbUsername -p${dbDecryptPassword} $appdbName <<EOFMYSQL


CREATE TABLE `device_sync_request` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `failure_reason` varchar(200) DEFAULT NULL,
  `list_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `imei` varchar(20) DEFAULT NULL,
  `actual_imei` varchar(20) DEFAULT NULL,
  `imsi` varchar(20) DEFAULT NULL,
  `insert_for_sync_time` timestamp NULL DEFAULT NULL,
  `msisdn` varchar(20) DEFAULT NULL,
  `no_of_retry` int DEFAULT NULL,
  `operation` int NOT NULL,
  `operator_name` varchar(20) DEFAULT NULL,
  `eir_id` int NOT NULL,
  `request_date` timestamp NULL DEFAULT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `sync_request_time` timestamp NULL DEFAULT NULL,
  `sync_response_time` timestamp NULL DEFAULT NULL,
  `tac` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`id`)
);


CREATE TABLE `device_sync_request_pointer` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_on` timestamp NOT NULL,
  `synced_till_date` timestamp NOT NULL,
  `list_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`)
);

 
insert into sys_param(tag,value,feature_name) values ('LSM_ENABLE_PROCESSING_BLACKED_LIST','YES','eir_list_sync');
	insert into sys_param(tag,value,feature_name) values ('LSM_ENABLE_PROCESSING_BLOCKED_TAC','YES', 'eir_list_sync');
	insert into sys_param(tag,value,feature_name) values ('LSM_ENABLE_PROCESSING_TRACKED_LIST','YES', 'eir_list_sync');
	insert into sys_param(tag,value,feature_name) values ('LSM_ENABLE_PROCESSING_EXCEPTION_LIST','YES', 'eir_list_sync');
	insert into sys_param(tag,value,feature_name) values  ('LSM_NO_OF_OPERATORS','2', 'eir_list_sync');
	insert into sys_param(tag,value,feature_name)  values  ('LSM_OPERATORS_1','SMART', 'eir_list_sync');
	insert into sys_param(tag,value,feature_name)  values  ('LSM_OPERATORS_2','METFONE', 'eir_list_sync');
	
	insert into sys_param(tag,value,feature_name) values ('LSM_SMART_READ_TIME_OUT','10', 'eir_list_sync');
	insert into sys_param(tag,value,feature_name) values ('LSM_SMART_TPS','100','ListSyncModule');
	insert into sys_param(tag,value,feature_name) values ('LSM_SMART_BASIC_AUTH_CREDENTIALS','smart:smart_lsm', 'eir_list_sync');
	insert into sys_param(tag,value,feature_name) values ('LSM_SMART_NO_EIRS','2', 'eir_list_sync');
	insert into sys_param(tag,value,feature_name) values ('LSM_SMART_URL_1','https://127.0.0.1:9081', 'eir_list_sync');
	insert into sys_param(tag,value,feature_name) values ('LSM_SMART_URL_2','https://127.0.0.1:9082', 'eir_list_sync');
	
	insert into sys_param(tag,value,feature_name) values ('LSM_METFONE_READ_TIME_OUT','10', 'eir_list_sync');
	insert into sys_param(tag,value,feature_name) values ('LSM_METFONE_TPS','100', 'eir_list_sync');
	insert into sys_param(tag,value,feature_name) values ('LSM_METFONE_BASIC_AUTH_CREDENTIALS','metfone:metfone_lsm', 'eir_list_sync');
	insert into sys_param(tag,value,feature_name) values ('LSM_METFONE_NO_EIRS','1', 'eir_list_sync');
    insert into sys_param(tag,value,feature_name) values ('LSM_METFONE_URL_1','https://127.0.0.1:9081', 'eir_list_sync');        

EOFMYSQL
