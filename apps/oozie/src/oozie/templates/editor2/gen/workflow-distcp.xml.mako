## -*- coding: utf-8 -*-
## Licensed to Cloudera, Inc. under one
## or more contributor license agreements.  See the NOTICE file
## distributed with this work for additional information
## regarding copyright ownership.  Cloudera, Inc. licenses this file
## to you under the Apache License, Version 2.0 (the
## "License"); you may not use this file except in compliance
## with the License.  You may obtain a copy of the License at
##
##     http://www.apache.org/licenses/LICENSE-2.0
##
## Unless required by applicable law or agreed to in writing, software
## distributed under the License is distributed on an "AS IS" BASIS,
## WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
## See the License for the specific language governing permissions and
## limitations under the License.

<%namespace name="common" file="workflow-common.xml.mako" />

    <action name="${ node['name'] }"${ common.credentials(node['properties']['credentials']) }>
        <distcp xmlns="uri:oozie:distcp-action:0.1">
            <job-tracker>${'${'}jobTracker}</job-tracker>
            <name-node>${'${'}nameNode}</name-node>

            ${ common.prepares(node['properties']['prepares']) }
            ${ common.configuration(node['properties']['job_properties']) }

            % if node['properties']['java_opts']:
              <java-opts>${ node['properties']['java_opts'] }</java-opts>
            % endif

            % for argument in node['properties']['distcp_parameters']:
              <arg>${ argument['value'] }</arg>
            % endfor
        </distcp>
        <ok to="${ node_mapping[node['children'][0]['to']].name }"/>
        <error to="${ node_mapping[node['children'][1]['error']].name }"/>
        ${ common.sla(node) }
    </action>
