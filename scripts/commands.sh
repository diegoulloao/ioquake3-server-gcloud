#!/bin/sh

# Commands script
# @description display all commands and their usage
#
# generated with https://www.tablesgenerator.com/text_tables

echo "\n\033[0;36mAll commands and their usage are listed below:\033[0m"

# table
cat << EOF

+----------------+-----------------------------------------------------------------------------+
| command        | description                                                                 |
+================+=============================================================================+
| permissions    | give to scripts necessary permissions to run in the system                  |
+----------------+-----------------------------------------------------------------------------+
| prepare        | give permissions to the scripts and download dependencies                   |
+----------------+-----------------------------------------------------------------------------+
| build          | build docker image                                                          |
+----------------+-----------------------------------------------------------------------------+
| start          | create container and run the server in localhost                            |
+----------------+-----------------------------------------------------------------------------+
| create:cluster | create cluster in google cloud                                              |
+----------------+-----------------------------------------------------------------------------+
| deploy         | deploy the server to the cluster in google cloud                            |
+----------------+-----------------------------------------------------------------------------+
| deploy:force   | force deploy the server even when there are no new commits                  |
+----------------+-----------------------------------------------------------------------------+
| create:remote  | create cluster in google cloud, download dependencies and deploy the server |
+----------------+-----------------------------------------------------------------------------+
| delete:remote  | deletes the cluster from google cloud                                       |
+----------------+-----------------------------------------------------------------------------+
| ip             | displays the server public ip                                               |
+----------------+-----------------------------------------------------------------------------+

EOF

# more information message
echo "\033[0;36mFor more information please visit:
https://github.com/diegoulloao/ioquake3-server-gcloud/blob/main/README.md\033[0m\n"

exit 0
