<?php
return [
    'backend' => [
        'frontName' => 'admin'
    ],
    'crypt' => [
        'key' => '3b4e8eaa5835df0bbfa0a528d2755416'
    ],
    'db' => [
        'table_prefix' => '',
        'connection' => [
            'default' => [
                'host' => 'localhost',
                'dbname' => 'magento2_3',
                'username' => 'admin',
                'password' => 'admin',
                'active' => '1',
                'model' => 'mysql4',
                'engine' => 'innodb',
                'initStatements' => 'SET NAMES utf8;'
            ]
        ]
    ],
    'resource' => [
        'default_setup' => [
            'connection' => 'default'
        ]
    ],
    'x-frame-options' => 'SAMEORIGIN',
    'MAGE_MODE' => 'default',
    'session' => [
        'save' => 'redis',
        'redis' => [
            'host' => '127.0.0.1',
            'port' => '6379',
            'password' => '',
            'timeout' => '2.5',
            'persistent_identifier' => '',
            'database' => '2',
            'compression_threshold' => '2048',
            'compression_library' => 'gzip',
            'log_level' => '3',
            'max_concurrency' => '6',
            'break_after_frontend' => '5',
            'break_after_adminhtml' => '30',
            'first_lifetime' => '600',
            'bot_first_lifetime' => '60',
            'bot_lifetime' => '7200',
            'disable_locking' => '0',
            'min_lifetime' => '60',
            'max_lifetime' => '2592000',
            'sentinel_master' => '',
            'sentinel_servers' => '',
            'sentinel_connect_retries' => '5',
            'sentinel_verify_master' => '0'
        ]
    ],
    'cache_types' => [
        'config' => 1,
        'layout' => 1,
        'block_html' => 1,
        'collections' => 1,
        'reflection' => 1,
        'db_ddl' => 1,
        'compiled_config' => 1,
        'eav' => 1,
        'customer_notification' => 1,
        'config_integration' => 1,
        'config_integration_api' => 1,
        'full_page' => 1,
        'config_webservice' => 1,
        'translate' => 1,
        'vertex' => 1
    ],
    'install' => [
        'date' => 'Fri, 28 Dec 2018 11:34:30 +0000'
    ],
    'cache' => [
        'frontend' => [
            'default' => [
                'backend' => 'Cm_Cache_Backend_Redis',
                'backend_options' => [
                    'server' => '127.0.0.1',
                    'database' => '0',
                    'port' => '6379',
                    'password' => ''
                ]
            ],
            'page_cache' => [
                'backend' => 'Cm_Cache_Backend_Redis',
                'backend_options' => [
                    'server' => '127.0.0.1',
                    'database' => '1',
                    'port' => '6379',
                    'compress_data' => '0',
                    'password' => ''
                ]
            ]
        ]
    ],
    'system' => [
        'default' => [
            'dev' => [
                'js' => [
                    'session_storage_key' => 'collected_errors'
                ],
                'restrict' => [
                    'allow_ips' => NULL
                ]
            ],
            'system' => [
                'smtp' => [
                    'host' => 'localhost',
                    'port' => '25'
                ]
            ],
            'web' => [
                'unsecure' => [
                    'base_url' => 'http://10.16.16.92/',
                    'base_link_url' => '{{unsecure_base_url}}'
                ],
                'secure' => [
                    'base_url' => 'https://10.16.16.92/',
                    'base_link_url' => '{{secure_base_url}}'
                ],
                'default' => [
                    'front' => 'cms'
                ]
            ],
            'admin' => [
                'url' => [
                    'custom' => NULL
                ]
            ],
            'currency' => [
                'import' => [
                    'error_email' => NULL
                ]
            ],
            'customer' => [
                'create_account' => [
                    'email_domain' => 'example.com'
                ]
            ],
            'catalog' => [
                'search' => [
                    'elasticsearch_server_hostname' => 'localhost',
                    'elasticsearch_server_port' => '9200',
                    'elasticsearch_index_prefix' => 'magento2',
                    'elasticsearch_enable_auth' => '0',
                    'elasticsearch_server_timeout' => '15',
                    'elasticsearch5_server_hostname' => 'localhost',
                    'elasticsearch5_server_port' => '9200',
                    'elasticsearch5_index_prefix' => 'magento2',
                    'elasticsearch5_enable_auth' => '0',
                    'elasticsearch5_server_timeout' => '15'
                ],
                'productalert_cron' => [
                    'error_email' => NULL
                ]
            ],
            'payment' => [
                'payflowpro' => [
                    'user' => NULL,
                    'pwd' => NULL
                ],
                'payflow_link' => [
                    'pwd' => NULL,
                    'url_method' => 'GET'
                ],
                'payflow_advanced' => [
                    'user' => 'PayPal',
                    'pwd' => NULL,
                    'url_method' => 'GET'
                ],
                'authorizenet_directpost' => [
                    'debug' => '0',
                    'email_customer' => '0',
                    'login' => NULL,
                    'merchant_email' => NULL,
                    'test' => '1',
                    'trans_key' => NULL,
                    'trans_md5' => NULL,
                    'cgi_url' => 'https://secure.authorize.net/gateway/transact.dll',
                    'cgi_url_td' => 'https://api2.authorize.net/xml/v1/request.api'
                ],
                'braintree' => [
                    'private_key' => NULL
                ]
            ],
            'contact' => [
                'email' => [
                    'recipient_email' => 'hello@example.com'
                ]
            ],
            'trans_email' => [
                'ident_custom1' => [
                    'email' => 'custom1@example.com',
                    'name' => 'Custom 1'
                ],
                'ident_custom2' => [
                    'email' => 'custom2@example.com',
                    'name' => 'Custom 2'
                ],
                'ident_general' => [
                    'email' => 'owner@example.com',
                    'name' => 'Owner'
                ],
                'ident_sales' => [
                    'email' => 'sales@example.com',
                    'name' => 'Sales'
                ],
                'ident_support' => [
                    'email' => 'support@example.com',
                    'name' => 'CustomerSupport'
                ]
            ],
            'paypal' => [
                'wpp' => [
                    'api_password' => NULL,
                    'api_signature' => NULL,
                    'api_username' => NULL
                ],
                'fetch_reports' => [
                    'ftp_login' => NULL,
                    'ftp_password' => NULL
                ]
            ],
            'analytics' => [
                'url' => [
                    'signup' => 'https://advancedreporting.rjmetrics.com/signup',
                    'update' => 'https://advancedreporting.rjmetrics.com/update',
                    'bi_essentials' => 'https://dashboard.rjmetrics.com/v2/magento/signup',
                    'otp' => 'https://advancedreporting.rjmetrics.com/otp',
                    'report' => 'https://advancedreporting.rjmetrics.com/report',
                    'notify_data_changed' => 'https://advancedreporting.rjmetrics.com/report'
                ]
            ],
            'carriers' => [
                'dhl' => [
                    'account' => NULL,
                    'gateway_url' => 'https://xmlpi-ea.dhl.com/XMLShippingServlet',
                    'id' => NULL,
                    'password' => NULL
                ],
                'fedex' => [
                    'account' => NULL,
                    'meter_number' => NULL,
                    'key' => NULL,
                    'password' => NULL,
                    'sandbox_mode' => '0',
                    'production_webservices_url' => 'https://ws.fedex.com:443/web-services/',
                    'sandbox_webservices_url' => 'https://wsbeta.fedex.com:443/web-services/'
                ],
                'ups' => [
                    'access_license_number' => NULL,
                    'gateway_url' => 'http://www.ups.com/using/services/rave/qcostcgi.cgi',
                    'gateway_xml_url' => 'https://onlinetools.ups.com/ups.app/xml/Rate',
                    'tracking_xml_url' => 'https://onlinetools.ups.com/ups.app/xml/Track',
                    'username' => NULL,
                    'password' => NULL,
                    'is_account_live' => '0'
                ],
                'usps' => [
                    'gateway_url' => 'http://production.shippingapis.com/ShippingAPI.dll',
                    'gateway_secure_url' => 'https://secure.shippingapis.com/ShippingAPI.dll',
                    'userid' => NULL,
                    'password' => NULL
                ]
            ],
            'newrelicreporting' => [
                'general' => [
                    'api_url' => 'https://api.newrelic.com/deployments.xml',
                    'insights_api_url' => 'https://insights-collector.newrelic.com/v1/accounts/%s/events'
                ]
            ],
            'fraud_protection' => [
                'signifyd' => [
                    'api_url' => 'https://api.signifyd.com/v2/',
                    'api_key' => NULL
                ]
            ],
            'sitemap' => [
                'generate' => [
                    'error_email' => NULL
                ]
            ],
            'crontab' => [
                'default' => [
                    'jobs' => [
                        'analytics_subscribe' => [
                            'schedule' => [
                                'cron_expr' => '0 * * * *'
                            ]
                        ]
                    ]
                ]
            ]
        ]
    ]
];
