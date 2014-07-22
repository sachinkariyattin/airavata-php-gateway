/**
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

package org.airavata.appcatalog.cpi;

import org.apache.airavata.model.appcatalog.appdeployment.ApplicationDeploymentDescription;

import java.util.List;
import java.util.Map;

public interface ApplicationDeployment {
    /**
     * Add application deployment
     * @param deploymentDescription application deployment
     * @return unique id for application deployment
     */
    String addApplicationDeployment (ApplicationDeploymentDescription deploymentDescription) throws AppCatalogException;

    /**
     * This method will update application deployment
     * @param deploymentId unique deployment id
     * @param updatedDeployment updated deployment
     */
    void updateApplicationDeployment (String deploymentId, ApplicationDeploymentDescription updatedDeployment) throws AppCatalogException;;

    /**
     * This method will retrive application deployement
     * @param deploymentId unique deployment id
     * @return application deployment
     */
    ApplicationDeploymentDescription getApplicationDeployement (String deploymentId) throws AppCatalogException;

    /**
     * This method will return a list of application deployments according to given search criteria
     * @param filters map should be provided as the field name and it's value
     * @return list of application deployments
     */
    List<ApplicationDeploymentDescription> getApplicationDeployements (Map<String, String> filters) throws AppCatalogException;

    List<ApplicationDeploymentDescription> getAllApplicationDeployements () throws AppCatalogException;

    List<String> getAllApplicationDeployementIds () throws AppCatalogException;

    /**
     * Check whether application deployment exists
     * @param deploymentId unique deployment id
     * @return true or false
     */
    boolean isAppDeploymentExists (String deploymentId) throws AppCatalogException;

    /**
     * Remove application deployment
     * @param deploymentId unique deployment id
     */
    void removeAppDeployment (String deploymentId) throws AppCatalogException;
}
