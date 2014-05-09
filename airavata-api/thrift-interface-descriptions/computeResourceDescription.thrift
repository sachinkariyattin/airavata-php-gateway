/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements. See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership. The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License. You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations
 * under the License.
 *
 */

namespace java org.apache.airavata.model.appcatalog.computeresource

const string DEFAULT_ID = "DO_NOT_SET_AT_CLIENTS"

/**
 * Enumeration of local resource job managers supported by Airavata
 *
 * FORK:
 *  Forking of commands without any job manager
 *
 * PBS:
 *  Job manager supporting the Portal Batch System (PBS) protocol. Some examples include TORQUE, PBSPro, Grid Engine.
 *
 * UGE:
 *  Univa Grid Engine, a variation of PBS implementation.
 *
 * SLURM:
 *  The Simple Linux Utility for Resource Management is a open source workload manager.
 *
*/
enum ResourceJobManager {
    FORK,
    PBS,
    UGE,
    SLURM
}

/**
 * Enumeration of Airavata supported Job Submission Mechanisms for High Perforamance Computing Clusters.
 *
 * SSH:
 *  Execute remote job submission commands using via secure shell protocol.
 *
 * GRAM:
 *  Execute remote jobs via Globus GRAM service.
 *
 * UNICORE:
 *  Execute remote jobs via Unicore services
 *
*/
enum JobSubmissionProtocol {
    SSH,
    GRAM,
    UNICORE
}

/**
 * Enumeration of data movement supported by Airavata
 *
 * SCP:
 *  Job manager supporting the Portal Batch System (PBS) protocol. Some examples include TORQUE, PBSPro, Grid Engine.
 *
 * SFTP:
 *  The Simple Linux Utility for Resource Management is a open source workload manager.
 *
 * GridFTP:
 *  Globus File Transfer Protocol
 *
 * UNICORE_STORAGE_SERVICE:
 *  Storage Service Provided by Unicore
 *
*/
enum DataMovementProtocol {
    SCP,
    SFTP,
    GridFTP,
    UNICORE_STORAGE_SERVICE
}

/**
 * Enumeration of security authentication and authorization mechanisms supported by Airavata. This enumeration just
 *  describes the supported mechanism. The corresponding security credentials are registered with Airavata Credential
 *  store.
 *
 * USERNAME_PASSWORD:
 *  A User Name.
 *
 * SSH_KEYS:
 *  SSH Keys
 *
*/
enum SecurityProtocol {
    USERNAME_PASSWORD,
    SSH_KEYS,
    GSI,
    KERBEROS,
    OAUTH
}

struct SSHJobSubmission {
    1: required SecurityProtocol securityProtocol,
    2: required ResourceJobManager resourceJobManager,
    3: optional i32 sshPort = 22
}

struct SCPDataMovement {
    1: required SecurityProtocol securityProtocol,
    2: optional i32 sshPort = 22,
}

struct GlobusJobSubmission {
    1: required SecurityProtocol securityProtocol,
    2: required ResourceJobManager resourceJobManager,
    3: optional string globusGateKeeperEndPoint
}

struct EC2JobSubmission {
    1: required SecurityProtocol securityProtocol,
    2: required ResourceJobManager resourceJobManager,
    3: optional string imageID,
    4: optional string instanceID
}

struct UnicoreJobSubmission {
    1: required SecurityProtocol securityProtocol,
    2: required ResourceJobManager resourceJobManager,
    3: optional string unicoreBESEndPoint
}

struct GSISSHJobSubmission {
    1: required SecurityProtocol securityProtocol,
    2: required ResourceJobManager resourceJobManager,
    3: optional i32 sshPort = 22,
    4: optional list<string> exports,
    5: optional string preJobCommands,
    6: optional string postJobCommands,
    7: optional string installedPath,
    8: optional string monitorMode
}
struct WhirConfiguration {
	1: optional string configurationFile,
	2: optional string byonClusterConfigurationFile,
	3: optional map<string,string> properties,
}
struct HadoopJobSubmission {
	1: required string jobProtocolDataId = DEFAULT_ID,
    2: required SecurityProtocol securityProtocol,
    3: required ResourceJobManager resourceJobManager,
    4: optional string hadoopConfigurationDirectory,
    5: optional WhirConfiguration whirrConfiguration,
}
/**
 * Job Submission Protocols
 *
 * resourceId:
 *
 * hostName:
 *   Fully Qualified Host Name.
 *
 * ipAddress:
 *   IP Addresse of the Hostname.
 *
 * resourceDescription:
 *  A user friendly description of the hostname.
 *
 * preferedJobSubmissionProtocol:
 *  HPC resources may have multiple options to interact with the resource. This flag identified a prefered mechanism.
 *
 * preferedDataMovementProtocol:
 *  Option to specify a prefered data movement mechanism of the available options.
 *
*/
struct JobSubmissionProtocols {
    1: required bool isEmpty = 0,
    2: optional JobSubmissionProtocol preferedJobSubmissionProtocol,
    3: optional SSHJobSubmission sshJobSubmissionInfo,
    4: optional string globusGRAMHost,
    5: optional i32 globusGRAMPort = 2119,
    6: optional string unicoreBESEndPoint
}

/**
 * Computational Resource Description
 *
 * resourceId:
 *
 * hostName:
 *   Fully Qualified Host Name.
 *
 * ipAddress:
 *   IP Addresse of the Hostname.
 *
 * resourceDescription:
 *  A user friendly description of the hostname.
 *
 * JobSubmissionProtocols:
 *  A computational resources may have one or more ways of submitting Jobs. This structure
 *  will hold all available mechanisms to interact with the resource.
 *
 * DataMovementProtocol:
 *  Option to specify a prefered data movement mechanism of the available options.
 *
*/
struct ComputeResourceDescription {
    1: required bool isEmpty = 0,
    2: required string resourceId = DEFAULT_ID,
    3: required string hostName,
    4: optional set<string> hostAliases,
    4: optional set<string> ipAddresses,
    5: optional string resourceDescription,
    6: optional string scratchLocation
    7: optional list<string> jobSubmissionProtocolPreferenceOrder,
    8: required map<string, JobSubmissionProtocol> jobSubmissionProtocols,
    9: required map<string, DataMovementProtocol> dataMovementProtocols
}

/*
struct ComputeResourceDescription {
    1: required bool isEmpty = 0,
    2: required string resourceId = DEFAULT_ID,
    3: required string hostName,
    4: optional set<string> hostAliases,
    4: optional set<string> ipAddresses,
    5: optional string resourceDescription,
    6: required map<JobSubmissionProtocol, JobSubmissionProtocols> jobSubmissionProtocols,
    7: required map<DataMovementProtocol, DataMovementProtocol> dataMovementProtocols
}*/

enum ParameterType {
	STRING,
	INT,
	URL,
	
}

struct Validation{
}

struct InputParameter {
	1:required string name,
	2:required ParameterType type,
	3:required bool optional=0,
	4:optional string defaultValue,
	5:optional list<Validation> validations,
}

struct OutputParameter {
	1:required string name,
	2:required ParameterType type,
}

struct ApplicationDeployment {
    1: required string deploymentId = DEFAULT_ID,
	2: required string hostId,
	3: required string executablePath,
	4: optional map<string,string> environment,
}

struct Application {
    1: required bool isEmpty = 0,
    2: required string applicationId = DEFAULT_ID,
    4: optional list<InputParameter> input,
    5: optional list<OutputParameter> input,
	6: required list<ApplicationDeployment> deployment 
}