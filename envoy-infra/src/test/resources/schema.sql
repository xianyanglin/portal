CREATE TABLE IF NOT EXISTS hango_health_check_rule (
      id bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY,
      create_time bigint(20) NOT NULL ,
      update_time bigint(20) NOT NULL ,
      service_id bigint(20) NOT NULL ,
      gw_id bigint(20) NOT NULL ,
      active_switch tinyint(4) NOT NULL ,
      path varchar(255) DEFAULT '' ,
      timeout int(11) DEFAULT NULL ,
      expected_statuses varchar(255) DEFAULT '' ,
      healthy_interval int(11) DEFAULT NULL ,
      healthy_threshold int(11) DEFAULT NULL ,
      unhealthy_interval int(11) DEFAULT NULL ,
      unhealthy_threshold int(11) DEFAULT NULL ,
      passive_switch tinyint(4) NOT NULL ,
      consecutive_errors int(11) DEFAULT NULL ,
      base_ejection_time int(11) DEFAULT NULL ,
      max_ejection_percent tinyint(4) DEFAULT NULL ,
      min_health_percent tinyint(4) DEFAULT 50 ,
      PRIMARY KEY (id),
      UNIQUE KEY unique_service_gw_id (service_id,gw_id),

      KEY index_service_gw_id (service_id,gw_id)
    ) ;

CREATE TABLE IF NOT EXISTS `hango_route_ws_param_info` (
  `id` bigint(20) unsigned NOT NULL GENERATED BY DEFAULT AS IDENTITY,
  `create_date` bigint(20) DEFAULT NULL,
  `modify_date` bigint(20) DEFAULT NULL,
  `gw_id` bigint(20) NOT NULL,
  `service_id` bigint(20) NOT NULL,
  `route_id` bigint(11) NOT NULL,
  `request_template` text NOT NULL,
  `response_array_type_list` text NOT NULL,
  `ws_port_type` varchar(255) NOT NULL,
  `ws_operation` varchar(255) NOT NULL,
  `ws_binding` varchar(255) NOT NULL,
  `ws_address` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ;


CREATE TABLE IF NOT EXISTS `hango_service_protobuf_proxy` (
  `id` bigint(20) unsigned NOT NULL GENERATED BY DEFAULT AS IDENTITY COMMENT '主键id',
  `create_date` bigint(20) DEFAULT NULL COMMENT '创建时间',
  `modify_date` bigint(20) DEFAULT NULL COMMENT '修改时间',
  `service_id` bigint(20) NOT NULL COMMENT '服务id',
  `virtual_gw_id` bigint(11) DEFAULT NULL,
  `pb_file_name` varchar(255) NOT NULL DEFAULT '' COMMENT '上传的pb文件名',
  `pb_file_content` text NOT NULL COMMENT 'pb文件内容',
  `pb_service_list` text NOT NULL COMMENT 'pb文件包含的服务列表',
  PRIMARY KEY (`id`)
) ;

CREATE TABLE IF NOT EXISTS `hango_service_protobuf` (
  `id` bigint(20) unsigned NOT NULL GENERATED BY DEFAULT AS IDENTITY COMMENT '主键id',
  `create_date` bigint(20) DEFAULT NULL COMMENT '创建时间',
  `modify_date` bigint(20) DEFAULT NULL COMMENT '修改时间',
  `service_id` bigint(11) unsigned NOT NULL COMMENT '服务id',
  `pb_file_name` varchar(255) NOT NULL DEFAULT '' COMMENT '上传的pb文件名',
  `pb_file_content` text NOT NULL COMMENT 'pb文件内容',
  `pb_service_list` text NOT NULL COMMENT 'pb文件包含的服务列表',
  PRIMARY KEY (`id`),
  KEY `service_id` (`service_id`)
) ;

CREATE TABLE IF NOT EXISTS `hango_service_wsdl_info` (
  `id` bigint(20) unsigned NOT NULL GENERATED BY DEFAULT AS IDENTITY,
  `create_date` bigint(20) DEFAULT NULL,
  `modify_date` bigint(20) DEFAULT NULL,
  `gw_id` bigint(20) NOT NULL,
  `service_id` bigint(11) NOT NULL,
  `wsdl_file_name` varchar(255) NOT NULL,
  `wsdl_file_content` text NOT NULL,
  `wsdl_binding_list` text NOT NULL,
  PRIMARY KEY (`id`)
) ;

CREATE TABLE IF NOT EXISTS `apigw_envoy_virtual_host_info` (
  `id` bigint(11) NOT NULL GENERATED BY DEFAULT AS IDENTITY,
  `project_id` bigint(20) NOT NULL COMMENT '项目id',
  `gw_id` bigint(11) NOT NULL COMMENT '虚拟网关所在物理网关id',
  `hosts` text COMMENT '虚拟网关中的域名列表',
  `virtual_host_code` varchar(255) NOT NULL COMMENT 'vh唯一标识，${projectCode}-${projectId}-{gwId}',
  `create_time` bigint(20) NOT NULL COMMENT 'vh创建时间',
  `update_time` bigint(20) NOT NULL COMMENT 'vh更新时间',
  `bind_type` varchar(10) NOT NULL DEFAULT 'host',
  `projects` text,
  PRIMARY KEY (`id`)
) ;

CREATE TABLE IF NOT EXISTS `apigw_gportal_api_document_status` (
  `id` bigint(20) NOT NULL GENERATED BY DEFAULT AS IDENTITY,
  `status` varchar(255) NOT NULL COMMENT 'API文档状态',
  PRIMARY KEY (`id`,`status`)
) ;

CREATE TABLE IF NOT EXISTS `apigw_gportal_api_model` (
  `id` bigint(11) NOT NULL GENERATED BY DEFAULT AS IDENTITY COMMENT '主键',
  `create_date` bigint(20) DEFAULT NULL COMMENT '创建时间',
  `modify_date` bigint(20) DEFAULT NULL COMMENT '修改时间',
  `model_name` varchar(255) NOT NULL COMMENT '模型名称',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `type` tinyint(11) DEFAULT NULL COMMENT '数据模型的类型',
  `format` tinyint(11) DEFAULT NULL COMMENT '数据模型的类别',
  `service_id` bigint(20) NOT NULL COMMENT '服务Id',
  `swagger_sync` tinyint(2) DEFAULT '0' COMMENT 'swagger同步状态 0-本地数据 1-同步 2-失步',
  `project_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_model_id` (`id`)
) ;

CREATE TABLE IF NOT EXISTS `apigw_gportal_api_status_code` (
  `id` bigint(20) NOT NULL GENERATED BY DEFAULT AS IDENTITY,
  `create_date` bigint(20) DEFAULT NULL COMMENT '创建时间',
  `modify_date` bigint(20) DEFAULT NULL COMMENT '修改时间',
  `error_code` varchar(255) DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `status_code` bigint(20) DEFAULT NULL COMMENT 'http status code',
  `object_id` bigint(20) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `description` text COMMENT '描述',
  PRIMARY KEY (`id`),
  KEY `index_api_id` (`object_id`)
) ;

CREATE TABLE IF NOT EXISTS `apigw_gportal_api` (
  `id` bigint(11) NOT NULL GENERATED BY DEFAULT AS IDENTITY COMMENT '主键',
  `create_date` bigint(11) DEFAULT NULL COMMENT '创建时间',
  `modify_date` bigint(20) DEFAULT NULL,
  `api_name` varchar(255) NOT NULL COMMENT 'api名称',
  `api_path` varchar(255) NOT NULL COMMENT 'api路径',
  `api_method` varchar(255) NOT NULL COMMENT '方法',
  `description` text,
  `type` varchar(255) NOT NULL COMMENT '风格,Action | Restful',
  `service_id` bigint(20) NOT NULL COMMENT '服务id',
  `status` varchar(255) NOT NULL DEFAULT '0' COMMENT 'API状态，0:待发布 1:已发布 2:已下线',
  `regex` varchar(255) DEFAULT NULL,
  `document_status_id` bigint(20) DEFAULT '0' COMMENT 'API文档状态id',
  `request_example_value` text,
  `response_example_value` text,
  `alias_name` varchar(128) DEFAULT NULL COMMENT 'api英文标识，用于SDK生成',
  `project_id` bigint(11) DEFAULT NULL COMMENT '基于项目隔离，项目id',
  `sync_status` tinyint(2) DEFAULT '0' COMMENT '同步状态 0-本地数据 1-同步 2-失步',
  `ext_api_id` bigint(20) DEFAULT NULL COMMENT '外部apiId',
  `swagger_sync` tinyint(2) DEFAULT '0' COMMENT 'swagger同步状态 0-本地数据 1-同步 2-失步',
  PRIMARY KEY (`id`)
) ;

CREATE TABLE IF NOT EXISTS `apigw_gportal_body_param` (
  `id` bigint(11) NOT NULL GENERATED BY DEFAULT AS IDENTITY COMMENT '主键',
  `create_date` bigint(11) DEFAULT NULL COMMENT '创建时间',
  `modify_date` bigint(20) DEFAULT NULL,
  `api_id` bigint(11) NOT NULL COMMENT 'api id',
  `param_name` varchar(255) NOT NULL COMMENT '参数名称',
  `required` varchar(20) NOT NULL DEFAULT '0' COMMENT '是否必输项, 1表示必须输入，0表示非必须',
  `def_value` varchar(255) DEFAULT NULL COMMENT '默认值',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `type` varchar(255) NOT NULL COMMENT '区分REQUEST|RESPONSE',
  `param_type_id` bigint(20) DEFAULT NULL,
  `array_data_type_id` bigint(20) DEFAULT NULL,
  `association_type` varchar(63) DEFAULT 'NORMAL' COMMENT '关联类型 NORMAL/DUBBO',
  PRIMARY KEY (`id`)
) ;

CREATE TABLE IF NOT EXISTS `hango_dubbo_meta` (
  `id` bigint(11) NOT NULL GENERATED BY DEFAULT AS IDENTITY COMMENT '主键ID',
  `application_name` varchar(255) NOT NULL COMMENT '应用名称',
  `protocol_version` varchar(255) DEFAULT NULL COMMENT 'dubbo协议版本',
  `interface_name` varchar(255) NOT NULL COMMENT '接口名称',
  `dubbo_group` varchar(255) DEFAULT NULL COMMENT '分组',
  `dubbo_version` varchar(255) DEFAULT NULL COMMENT '版本',
  `method` varchar(255) NOT NULL COMMENT '方法名称',
  `dubbo_params` varchar(4000) DEFAULT NULL COMMENT '参数列表',
  `dubbo_returns` varchar(255) DEFAULT NULL COMMENT '返回类型',
  `create_time` bigint(11) DEFAULT NULL COMMENT '创建时间',
  `virtual_gw_id` bigint(11) NOT NULL COMMENT '网关ID',
  PRIMARY KEY (`id`)
) ;

CREATE TABLE IF NOT EXISTS `hango_dubbo_binding` (
  `id` bigint(11) NOT NULL GENERATED BY DEFAULT AS IDENTITY COMMENT '主键ID',
  `object_id` bigint(11) NOT NULL COMMENT '关联ID',
  `object_type` varchar(255) NOT NULL COMMENT '关联类型 api/route',
  `dubbo_info` text COMMENT 'dubbo参数类型',
  PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `apigw_gportal_entry_traffic_policy` (
  `id` bigint(20) unsigned NOT NULL GENERATED BY DEFAULT AS IDENTITY,
  `gw_id` bigint(11) NOT NULL COMMENT '网关id',
  `gw_name` varchar(255) DEFAULT NULL COMMENT '网关名',
  `traffic_color_name` varchar(255) DEFAULT NULL COMMENT '流量染色规则名称',
  `application_name` varchar(255) DEFAULT NULL COMMENT '应用名称',
  `service_name` varchar(255) DEFAULT NULL COMMENT '服务名称',
  `route_rule_names` varchar(255) DEFAULT NULL COMMENT '路由名称列表',
  `create_time` bigint(20) NOT NULL COMMENT '创建时间',
  `update_time` bigint(20) NOT NULL COMMENT '修改时间',
  `route_rule_ids` varchar(255) NOT NULL,
  `enable_status` int(4) DEFAULT '0' COMMENT '入口流量染色状态，0未启用，1为启用',
  `traffic_match` varchar(255) DEFAULT NULL COMMENT '流量匹配',
  `color_tag` varchar(255) DEFAULT NULL COMMENT '染色标识',
  `protocol` varchar(255) DEFAULT NULL COMMENT '协议',
  `param` text COMMENT '流量匹配参数列表',
  `project_id` bigint(11) DEFAULT NULL COMMENT '流量染色规则所属的项目id',
  PRIMARY KEY (`id`)
) ;

CREATE TABLE IF NOT EXISTS `apigw_gportal_gateway_info` (
  `id` bigint(20) NOT NULL GENERATED BY DEFAULT AS IDENTITY,
  `gw_name` varchar(255) NOT NULL COMMENT '网关名称，区分G0和G1',
  `gw_addr` varchar(255) NOT NULL COMMENT '网关IP地址',
  `description` varchar(255) DEFAULT NULL,
  `create_date` bigint(20) DEFAULT NULL,
  `modify_date` bigint(20) DEFAULT NULL COMMENT '修改时间',
  `status` int(11) DEFAULT '1',
  `last_check_time` bigint(20) DEFAULT '0',
  `health_interface_path` varchar(255) DEFAULT NULL COMMENT '健康检查接口path',
  `mongo_addr` varchar(255) DEFAULT NULL COMMENT 'mongo addr地址',
  `project_id` text COMMENT '基于项目隔离，租户id',
  `env_id` varchar(128) DEFAULT NULL COMMENT '网关所属环境id',
  `auth_addr` varchar(128) DEFAULT NULL COMMENT '认证中心地址',
  `audit_datasource_switch` varchar(255) DEFAULT NULL COMMENT 'mongo审计数据源切换选项mongo/mysql',
  `mysql_addr` text COMMENT 'mysql addr 地址',
  `gw_uni_id` varchar(128) DEFAULT NULL COMMENT '网关英文标识',
  `metric_url` varchar(255) DEFAULT NULL COMMENT '网关监控地址',
  `api_plane_addr` varchar(255) DEFAULT NULL COMMENT 'envoy网关对应api_plane_addr地址',
  `gw_cluster_name` varchar(255) DEFAULT NULL COMMENT 'envoy网关对应的网关集群名称',
  `gw_type` varchar(20) DEFAULT 'g0' COMMENT '网关类型，api-gateway/envoy-proxy',
  `audit_addr` varchar(255) DEFAULT NULL COMMENT '审计数据源地址',
  `prom_addr` varchar(255) DEFAULT NULL COMMENT 'Prometheus地址',
  `audit_db_config` varchar(1024) DEFAULT NULL COMMENT '审计数据源配置',
  `camel_addr` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ;

CREATE TABLE IF NOT EXISTS `apigw_gportal_grpc_param` (
  `id` bigint(11) NOT NULL GENERATED BY DEFAULT AS IDENTITY COMMENT '主键',
  `create_date` bigint(11) DEFAULT NULL COMMENT '创建时间',
  `modify_date` bigint(11) DEFAULT NULL COMMENT '修改时间',
  `api_id` bigint(11) NOT NULL COMMENT 'api id',
  `service_id` bigint(11) NOT NULL COMMENT 'service id',
  `pb_name` varchar(255) NOT NULL DEFAULT '' COMMENT 'pb文件别名',
  `pb_package_name` varchar(255) NOT NULL DEFAULT '' COMMENT 'package名称',
  `pb_service_name` varchar(255) NOT NULL DEFAULT '' COMMENT 'service名称',
  `pb_method_name` varchar(255) NOT NULL DEFAULT '' COMMENT 'method名称',
  PRIMARY KEY (`id`),
  KEY `api_id` (`api_id`),
  KEY `pb_name` (`pb_name`)
) ;

CREATE TABLE IF NOT EXISTS `apigw_gportal_header_param` (
  `id` bigint(11) NOT NULL GENERATED BY DEFAULT AS IDENTITY COMMENT '主键',
  `create_date` bigint(11) DEFAULT NULL COMMENT '创建时间',
  `modify_date` bigint(20) DEFAULT NULL,
  `api_id` bigint(20) NOT NULL COMMENT 'api id',
  `param_name` varchar(255) NOT NULL COMMENT '参数名称,包含自定义参数以及原生的Header提供的类型,如content-type',
  `param_value` varchar(255) DEFAULT NULL COMMENT '参数值',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `type` varchar(255) NOT NULL COMMENT '区分REQUEST|RESPONSE',
  PRIMARY KEY (`id`)
) ;

CREATE TABLE IF NOT EXISTS `apigw_gportal_model_param` (
  `id` bigint(11) NOT NULL GENERATED BY DEFAULT AS IDENTITY COMMENT '主键',
  `create_date` bigint(11) DEFAULT NULL COMMENT '创建时间',
  `modify_date` bigint(20) DEFAULT NULL,
  `model_id` varchar(255) NOT NULL COMMENT '模型名称',
  `param_name` varchar(255) NOT NULL COMMENT '参数名称',
  `param_type_id` bigint(11) NOT NULL COMMENT '模型中的参数Id,包含基本类型如String等和自定义类型',
  `array_data_type_id` bigint(20) DEFAULT NULL,
  `object_id` bigint(20) DEFAULT NULL,
  `def_value` varchar(255) DEFAULT NULL COMMENT '默认值',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `required` varchar(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `index_model_param_id` (`id`)
) ;

CREATE TABLE IF NOT EXISTS `apigw_gportal_operation_log` (
  `id` bigint(20) NOT NULL GENERATED BY DEFAULT AS IDENTITY,
  `create_date` bigint(20) DEFAULT NULL COMMENT '创建时间',
  `email` varchar(255) DEFAULT NULL COMMENT '邮箱',
  `object_id` bigint(20) DEFAULT NULL COMMENT '对象Id',
  `operation` text COMMENT '具体记录',
  `type` varchar(255) DEFAULT NULL COMMENT '对象类型',
  PRIMARY KEY (`id`),
  KEY `index_object_id` (`object_id`,`type`)
) ;

CREATE TABLE IF NOT EXISTS `apigw_gportal_param_object` (
  `id` bigint(11) NOT NULL GENERATED BY DEFAULT AS IDENTITY COMMENT '主键',
  `create_date` bigint(11) DEFAULT NULL COMMENT '创建时间',
  `modify_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `object_value` varchar(1024) DEFAULT NULL COMMENT '匿名类型取值，json字符串',
  PRIMARY KEY (`id`),
  KEY `index_param_object_id` (`id`)
) ;

CREATE TABLE IF NOT EXISTS `apigw_gportal_param_type` (
  `id` bigint(11) NOT NULL GENERATED BY DEFAULT AS IDENTITY COMMENT '主键',
  `create_date` bigint(11) DEFAULT NULL COMMENT '创建时间',
  `modify_date` bigint(20) DEFAULT NULL,
  `param_type` varchar(255) NOT NULL COMMENT '参数类型,基本类型|自定义类型',
  `location` varchar(255) NOT NULL COMMENT '位置，取值为HEADER|BODY',
  `model_id` bigint(20) DEFAULT '0',
  PRIMARY KEY (`id`,`param_type`)
) ;

CREATE TABLE IF NOT EXISTS `apigw_gportal_plugin` (
  `id` bigint(11) unsigned NOT NULL GENERATED BY DEFAULT AS IDENTITY COMMENT '主键id',
  `create_date` bigint(20) DEFAULT NULL COMMENT '创建时间',
  `modify_date` bigint(20) DEFAULT NULL COMMENT '修改时间',
  `gw_id` bigint(20) DEFAULT NULL COMMENT '网关实例id',
  `plugin_name` varchar(255) DEFAULT NULL COMMENT '插件名称',
  `plugin_version` varchar(255) DEFAULT NULL COMMENT '插件版本',
  `plugin_file_name` varchar(255) DEFAULT NULL COMMENT '上传的插件文件名称',
  `plugin_content` text COMMENT '插件内容',
  `plugin_variable` text COMMENT '插件变量',
  `plugin_status` int(11) DEFAULT NULL COMMENT '当前状态：1表示启用；0表示停用',
  `last_start_time` bigint(20) DEFAULT NULL COMMENT '最近一次启动时间点',
  `plugin_starting_time` bigint(11) DEFAULT NULL COMMENT '最近一次启动时长',
  `plugin_call_number` bigint(11) DEFAULT NULL COMMENT '被调用次数',
  PRIMARY KEY (`id`)
) ;

CREATE TABLE IF NOT EXISTS `apigw_gportal_registry_center` (
  `id` bigint(20) NOT NULL GENERATED BY DEFAULT AS IDENTITY COMMENT '注册中心配置主键',
  `registry_type` varchar(255) NOT NULL COMMENT '注册中心类型',
  `registry_addr` varchar(255) NOT NULL COMMENT '注册中心地址',
  `registry_alias` varchar(255) DEFAULT NULL COMMENT '注册中心别名',
  `create_date` bigint(11) DEFAULT NULL COMMENT '创建时间',
  `modify_date` bigint(11) DEFAULT NULL COMMENT '修改时间',
  `project_id` bigint(20) DEFAULT NULL COMMENT '项目ID',
  `is_shared` tinyint(4) DEFAULT NULL COMMENT '项目是否共享0-不共享，1-共享',
  `gw_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ;

CREATE TABLE IF NOT EXISTS `apigw_gportal_service_protobuf_proxy` (
  `id` bigint(20) unsigned NOT NULL GENERATED BY DEFAULT AS IDENTITY COMMENT '主键id',
  `create_date` bigint(20) DEFAULT NULL COMMENT '创建时间',
  `modify_date` bigint(20) DEFAULT NULL COMMENT '修改时间',
  `pb_id` bigint(20) NOT NULL COMMENT 'pb文件id',
  `gw_id` bigint(20) NOT NULL COMMENT '网关id',
  PRIMARY KEY (`id`),
  KEY `pb_id` (`pb_id`)
) ;


CREATE TABLE IF NOT EXISTS `hango_route_rule_proxy` (
  `id` bigint(11) NOT NULL GENERATED BY DEFAULT AS IDENTITY,
  `route_rule_id` bigint(11) NOT NULL COMMENT '路由规则id',
  `virtual_gw_id` bigint(11) DEFAULT NULL,
  `destination_services` varchar(1024) NOT NULL COMMENT '目的地址信息',
  `project_id` bigint(11) NOT NULL COMMENT '路由规则发布所属项目id',
  `priority` bigint(11) DEFAULT NULL COMMENT '路由规则优先级',
  `orders` bigint(11) DEFAULT NULL COMMENT '路由规则orders，与pilot交互',
  `enable_state` varchar(10) DEFAULT 'enable' COMMENT '路由规则使能状态，默认为enable',
  `create_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '路由规则发布时间，时间戳格式，精确到毫秒',
  `update_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '路由规则更新时间，时间戳格式，精确到毫秒',
  `service_id` bigint(11) DEFAULT NULL COMMENT '路由规则发布关联的服务id',
  `hosts` text COMMENT 'vs中对应的hosts信息',
  `timeout` bigint(11) DEFAULT '60000' COMMENT '路由超时时间',
  `http_retry` text COMMENT '路由重试配置',
  `virtual_cluster` text COMMENT '路由指标virtual_cluster',
  `mirror_traffic` text COMMENT '流量镜像配置',
  `mirror_service_id` bigint(11) DEFAULT NULL COMMENT '流量镜像指向服务id',
  `uri` varchar(1024) DEFAULT NULL COMMENT '路由uri，与匹配模式共同作用',
  `method` varchar(1024) DEFAULT NULL COMMENT '匹配方法列表GETPOSTPUTDELETEHEAD等',
  `header` text COMMENT '匹配header列表',
  `query_param` text COMMENT '匹配路由queryParam列表',
  `host` varchar(1024) DEFAULT NULL COMMENT '路由host列表',
  `need_route_metric` tinyint(4) NOT NULL DEFAULT '1',
  `gw_type` varchar(255) DEFAULT NULL COMMENT '网关类型',
  `version` bigint(20) DEFAULT '0' COMMENT '版本号',
  PRIMARY KEY (`id`),
  KEY `idx_gw_id` (`virtual_gw_id`),
  KEY `idx_route_rule_id` (`route_rule_id`)
) ;

CREATE TABLE IF NOT EXISTS `hango_route_rule` (
  `id` bigint(11) NOT NULL GENERATED BY DEFAULT AS IDENTITY,
  `service_id` varchar(11) DEFAULT NULL COMMENT '服务id（路由规则所属的服务id）',
  `route_rule_name` varchar(255) NOT NULL COMMENT '路由规则名称',
  `uri` varchar(1024) NOT NULL COMMENT '路由uri，与匹配模式共同作用',
  `method` varchar(1024) DEFAULT NULL COMMENT '匹配方法列表，GETPOSTPUTDELETEHEAD等',
  `header` text COMMENT '匹配header列表',
  `query_param` text COMMENT '匹配路由queryParam列表',
  `host` varchar(1024) DEFAULT NULL COMMENT '路由host列表',
  `priority` bigint(11) DEFAULT NULL COMMENT '路由规则优先级priority',
  `orders` bigint(11) DEFAULT NULL COMMENT '路由规则orders，与pilot交互',
  `project_id` bigint(11) DEFAULT NULL COMMENT '路由规则所属项目id',
  `publish_status` int(4) DEFAULT '0' COMMENT '路由规则发布状态，0未发布，1已发布',
  `create_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建时间，时间戳格式，精确到毫秒',
  `update_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '更新时间，时间戳格式，精确到毫秒',
  `description` varchar(255) DEFAULT NULL COMMENT '路由规则描述信息',
  `route_rule_source` varchar(255) DEFAULT NULL COMMENT '路由来源Gateway/NSF',
  `header_operation` varchar(1024) DEFAULT NULL COMMENT 'l路由头处理',
  PRIMARY KEY (`id`)
) ;


CREATE TABLE IF NOT EXISTS `hango_certificate_info` (
  `id` int(10) unsigned NOT NULL GENERATED BY DEFAULT AS IDENTITY COMMENT '主键',
  `create_time` bigint(20) NOT NULL COMMENT '创建时间',
  `update_time` bigint(20) NOT NULL COMMENT '修改时间',
  `name` varchar(255) NOT NULL COMMENT '证书名称',
  `type` varchar(64) DEFAULT NULL COMMENT '证书类型 serverCert/caCert',
  `domain` varchar(64) NOT NULL COMMENT '证书域名',
  `signature` text NOT NULL COMMENT '公钥指纹',
  `issuing_agency` varchar(64) NOT NULL COMMENT '签发机构',
  `issuing_time` bigint(20) NOT NULL COMMENT '证书签发时间',
  `expired_time` bigint(20) NOT NULL COMMENT '证书过期时间',
  `content` text NOT NULL COMMENT '证书信息',
  `private_key` text NOT NULL COMMENT '私钥',
  PRIMARY KEY (`id`)
) ;

CREATE TABLE IF NOT EXISTS `hango_domain_info` (
  `id` int(10) unsigned NOT NULL GENERATED BY DEFAULT AS IDENTITY COMMENT '主键',
  `create_time` bigint(20) NOT NULL COMMENT '创建时间',
  `update_time` bigint(20) NOT NULL COMMENT '更新时间',
  `host` varchar(255) NOT NULL COMMENT '域名',
  `project_id` bigint(11) NOT NULL COMMENT '项目id',
  `env` varchar(128) DEFAULT NULL COMMENT '网关所属环境',
  `protocol` varchar(255) NOT NULL COMMENT '协议，可以支持多个协议',
  `status` varchar(64) NOT NULL COMMENT '域名状态',
  `certificate_id` bigint(64) DEFAULT NULL COMMENT '服务端证书id',
  `description` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `relevance_id` bigint(11) DEFAULT NULL COMMENT '关联对象id',
  PRIMARY KEY (`id`)
) ;

CREATE TABLE IF NOT EXISTS `hango_gateway_advanced` (
  `id` bigint(20) NOT NULL GENERATED BY DEFAULT AS IDENTITY COMMENT '主键ID',
  `gw_id` bigint(20) NOT NULL COMMENT '网关(物理)ID',
  `metric_url` varchar(255) DEFAULT NULL COMMENT '监控地址',
  `audit_db_config` varchar(1024) DEFAULT NULL COMMENT '审计数据源配置',
  `auth_addr` varchar(255) DEFAULT NULL COMMENT '认证中心地址',
  PRIMARY KEY (`id`)
) ;

CREATE TABLE IF NOT EXISTS `hango_gateway` (
  `id` bigint(20) NOT NULL GENERATED BY DEFAULT AS IDENTITY COMMENT '网关ID',
  `name` varchar(255) NOT NULL COMMENT '网关名称',
  `env_id` varchar(255) NOT NULL COMMENT '所属环境',
  `svc_type` varchar(255) NOT NULL COMMENT '网关service类型， ClusterIP/NodePort',
  `svc_name` varchar(255) NOT NULL COMMENT '网关service名称',
  `type` varchar(255) NOT NULL COMMENT '网关类型',
  `gw_cluster_name` varchar(255) NOT NULL COMMENT '网关集群名称',
  `conf_addr` varchar(255) NOT NULL COMMENT '配置下发地址',
  `description` varchar(1000) DEFAULT NULL COMMENT '备注',
  `create_time` bigint(20) DEFAULT NULL COMMENT '创建时间',
  `modify_time` bigint(20) DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ;

CREATE TABLE IF NOT EXISTS `hango_plugin_binding` (
  `id` bigint(11) NOT NULL GENERATED BY DEFAULT AS IDENTITY,
  `plugin_type` varchar(255) NOT NULL COMMENT '绑定的插件类型，全局唯一，如：RateLimiter、WhiteList等',
  `binding_object_type` varchar(255) NOT NULL COMMENT '插件所绑定的对象类型，包含路由规则、服务等',
  `binding_object_id` varchar(255) NOT NULL COMMENT '插件所绑定的对象的唯一标识，与binding_object_type共同决定某一具体对象',
  `plugin_configuration` text NOT NULL COMMENT '插件配置',
  `create_time` bigint(20) NOT NULL COMMENT '最新绑定时间，时间戳格式，精确到毫秒',
  `update_time` bigint(20) NOT NULL COMMENT '绑定（配置）修改时间，时间戳格式，精确到毫秒',
  `virtual_gw_id` bigint(11) NOT NULL COMMENT '对象-插件绑定关系作用的虚拟网关id',
  `project_id` bigint(11) NOT NULL COMMENT '插件绑定关系所属项目id',
  `binding_status` varchar(127) NOT NULL DEFAULT 'enable' COMMENT '插件绑定关系状态，enable/disable',
  `template_id` bigint(20) DEFAULT '0' COMMENT '关联插件模板id',
  `template_version` bigint(20) DEFAULT '0' COMMENT '关联插件模板版本号',
  `gw_type` varchar(10) NOT NULL COMMENT '网关类型',
  `version` bigint(20) DEFAULT '0' COMMENT '版本号',
  PRIMARY KEY (`id`)
) ;

CREATE TABLE IF NOT EXISTS `hango_plugin_template` (
  `id` bigint(11) unsigned NOT NULL GENERATED BY DEFAULT AS IDENTITY COMMENT '主键id',
  `create_time` bigint(20) NOT NULL COMMENT '模板创建时间，时间戳格式，精确到毫秒',
  `update_time` bigint(20) NOT NULL COMMENT '模板最后更新时间，时间戳格式，精确到毫秒',
  `plugin_type` varchar(255) NOT NULL COMMENT '绑定的插件类型，全局唯一，如：RateLimiter、WhiteList等',
  `plugin_configuration` text NOT NULL COMMENT '插件配置',
  `project_id` bigint(11) NOT NULL COMMENT '插件绑定关系所属项目id',
  `template_version` bigint(10) NOT NULL COMMENT '插件模板版本',
  `template_name` varchar(255) NOT NULL COMMENT '插件模板名称',
  `template_notes` varchar(255) DEFAULT NULL COMMENT '插件模板备注',
  PRIMARY KEY (`id`)
) ;

CREATE TABLE IF NOT EXISTS `hango_service_advanced` (
  `id` bigint(11) NOT NULL GENERATED BY DEFAULT AS IDENTITY COMMENT '主键',
  `service_name` varchar(255) DEFAULT NULL COMMENT '服务标识',
  `sync_status` tinyint(2) DEFAULT '0' COMMENT '同步状态 0-本地数据 1-同步 2-失步',
  `ext_service_id` bigint(20) DEFAULT NULL COMMENT '外部serviceId',
  PRIMARY KEY (`id`)
) ;

CREATE TABLE IF NOT EXISTS `hango_service_info` (
  `id` bigint(11) NOT NULL GENERATED BY DEFAULT AS IDENTITY COMMENT '主键',
  `create_date` bigint(11) DEFAULT NULL COMMENT '创建时间',
  `modify_date` bigint(11) DEFAULT NULL COMMENT '修改时间',
  `display_name` varchar(255) NOT NULL COMMENT '服务显示名称',
  `service_name` varchar(255) DEFAULT NULL COMMENT '服务标识',
  `contacts` varchar(255) DEFAULT NULL COMMENT '负责人',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '状态，0表示未发布，1表示已发布',
  `service_type` varchar(63) DEFAULT NULL COMMENT '服务类型',
  `project_id` bigint(11) DEFAULT NULL COMMENT '基于项目隔离，项目id',
  `extension_info` varchar(255) DEFAULT NULL COMMENT '服务协议相关扩展信息，如wsdl的地址',
  PRIMARY KEY (`id`)
) ;

CREATE TABLE IF NOT EXISTS `hango_service_proxy` (
  `id` bigint(11) NOT NULL GENERATED BY DEFAULT AS IDENTITY COMMENT '主键',
  `create_time` bigint(20) DEFAULT NULL COMMENT '创建时间',
  `update_time` bigint(20) DEFAULT NULL COMMENT '更新时间',
  `service_id` bigint(11) NOT NULL COMMENT '服务元数据id',
  `virtual_gw_id` bigint(11) NOT NULL COMMENT '服务发布所属虚拟网关id',
  `project_id` bigint(11) DEFAULT '0' COMMENT '发布所属项目id',
  `code` varchar(255) NOT NULL COMMENT '服务元数据标识',
  `publish_protocol` varchar(10) DEFAULT 'http' COMMENT '发布服务，服务协议，http/https,默认为http',
  `backend_service` text COMMENT '发布关联真实网关服务',
  `publish_type` varchar(255) DEFAULT NULL COMMENT '发布策略，STATIC/DYNAMIC',
  `load_balancer` varchar(127) NOT NULL DEFAULT 'ROUND_ROBIN' COMMENT '负载均衡',
  `subsets` text COMMENT '版本集合',
  `registry_center_type` varchar(255) DEFAULT NULL COMMENT '注册中心类型Consul/Kubernetes/Eureka/Zookeeper，DYNAMIC时必填，默认Kubernetes',
  `traffic_policy` text COMMENT '负载均衡和连接池配置',
  `gw_type` varchar(255) DEFAULT NULL COMMENT '网关类型',
  `version` bigint(20) DEFAULT '0' COMMENT '版本号',
  PRIMARY KEY (`id`)
) ;

CREATE TABLE IF NOT EXISTS `hango_virtual_gateway` (
  `id` bigint(20) NOT NULL GENERATED BY DEFAULT AS IDENTITY COMMENT '虚拟网关ID',
  `gw_id` bigint(20) NOT NULL COMMENT '网关ID',
  `name` varchar(255) NOT NULL COMMENT '虚拟网关名称',
  `code` varchar(255) NOT NULL COMMENT '虚拟网关标识',
  `addr` varchar(255) DEFAULT NULL COMMENT '虚拟网关访问地址',
  `project_id` text COMMENT '基于项目隔离，项目id',
  `description` varchar(255) DEFAULT NULL COMMENT '虚拟网关描述',
  `type` varchar(255) NOT NULL COMMENT '虚拟网关类型',
  `protocol` varchar(255) NOT NULL COMMENT '监听协议类型',
  `port` int(10) DEFAULT NULL COMMENT 'j监听端口',
  `create_time` bigint(20) DEFAULT NULL COMMENT '创建时间',
  `modify_time` bigint(20) DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ;

 CREATE TABLE IF NOT EXISTS hango_pb_service_info
(
	id bigint auto_increment comment '主键',
	service_name varchar(255) not null comment 'grpc接口名，如helloworld.Greeter',
	pb_id bigint not null comment 'proto文件(hango_service_protobuf)表id',
	pb_proxy_id bigint null comment 'proto发布信息(hango_service_protobuf_proxy)表id',
	publish_status tinyint(1) default 0 not null comment '发布状态',
	constraint hango_pb_service_info_pk
		primary key (id)
)
comment 'pb文件服务信息表';

