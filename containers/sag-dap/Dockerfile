###############################################################################
#  Copyright � 2013 - 2018 Software AG, Darmstadt, Germany and/or its licensors
#
#   SPDX-License-Identifier: Apache-2.0
#
#     Licensed under the Apache License, Version 2.0 (the "License");
#     you may not use this file except in compliance with the License.
#     You may obtain a copy of the License at
#
#        http://www.apache.org/licenses/LICENSE-2.0
#
#     Unless required by applicable law or agreed to in writing, software
#     distributed under the License is distributed on an "AS IS" BASIS,
#     WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#     See the License for the specific language governing permissions and
#     limitations under the License.                                                            
#
###############################################################################

ARG BUILDER_IMAGE
ARG BASE_IMAGE

FROM $BUILDER_IMAGE as builder

# 
ARG TEMPLATE=sag-is-mysql


ARG __is_fixes=[wMFix.integrationServer.Core]
ARG __is_instance_name=default
ARG __db_host=mysql-dts.worker-daeirnd06.k8s.eur.ad.sag
ARG __db_hostName=serverzbfiopzz-dap100-dap1-server-8284.worker-daeirnd06.k8s.eur.ad.sag
ARG __db_type=MYSQLCE
ARG __db_alias=Default
ARG __db_username=root
ARG __db_password=root
ARG __db_name=webm 
ARG __db_url="jdbc:mysql://mysql-dts.worker-daeirnd06.k8s.eur.ad.sag:30970/webm"
ARG __db_admin.user=root
ARG __db_admin.password=root
ARG __db_port=30970


# provision and unit test
RUN $CC_HOME/provision.sh $TEMPLATE && \
    $CC_HOME/provision.sh sag-dap && \
    $CC_HOME/cleanup.sh

FROM $BASE_IMAGE

EXPOSE 5555 9999 8283 8284

# copy everything from the builder stage $SAG_HOME
COPY --from=builder --chown=1724:1724 $SAG_HOME/ $SAG_HOME/

# custom entry point
ADD entrypoint.sh $SAG_HOME/
ENTRYPOINT $SAG_HOME/entrypoint.sh

# Current working directory for all commands. 
WORKDIR $SAG_HOME
