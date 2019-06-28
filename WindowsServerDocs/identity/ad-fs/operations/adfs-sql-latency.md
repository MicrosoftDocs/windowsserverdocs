---
title: Fine Tuning SQL and Addressing Latency Issues with AD FS
description: This document discusses how to fine tune SQL with AD FS.
author: billmath
ms.author: billmath
manager: daveba
ms.date: 06/20/2019
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
---


# Fine tuning SQL and addressing latency issues with AD FS
In an update for [AD FS 2016](https://support.microsoft.com/help/4503294/windows-10-update-kb4503294) we introduced the following improvements to reduce cross database latency. A upcoming update for AD FS 2019 will include these improvements.

## In-Memory cache update in background thread 
In prior Always on Availability (AoA) deployments, latency existed for any “Read” operation as the master node could be located in a separate datacenter. The call between two different datacenters resulted in latency.  

In the latest update to AD FS, a reduction in latency is targeted through the addition of a background thread to refresh the AD FS configuration cache and a setting to set the refresh time period. The time spent for a database lookup is significantly reduced in the request thread, as the database cache updates are moved into the background thread.  

When the `backgroundCacheRefreshEnabled` is set to true, AD FS will enable the background thread to run cache updates. The frequency of fetching data from the cache can be customized to a time value by setting `cacheRefreshIntervalSecs`. The default value is set to 300 seconds when `backgroundCacheRefreshEnabled` is set to true. After the set value duration, AD FS begins refreshing it’s cache and while the update is in progress, the old cache data will continue to be used.  

>[!NOTE]
> The cache’s data will be refreshed outside of the `cacheRefreshIntervalSecs` value if ADFS receives a notification from SQL signifying that a change has occurred in the database. This notification will trigger the cache to be refreshed. 

### Recommendations for setting the cache refresh 
The default value for the cache refresh is **five minutes**. It is recommended to set it to **1 hour** to reduce an unnecessary data refresh by AD FS because the cache data will be refreshed if any SQL changes occur.  

AD FS registers a callback for SQL changes, and upon a change, ADFS receives a notification. Through this method, ADFS receives each new change from SQL as soon as it occurs. 

In the event of a network glitch which results in AD FS missing the SQL notification, AD FS will refresh at the interval specified by the cache refresh value. If any connectivity issues are suspected between AD FS and SQL, it is recommended to set the cache refresh value to lower than 1 hour.  

### Configuration instructions 
The configuration file supports multiple cache entries. The following listed below can all be configured based on the needs of your organization. 

The following example enables the background cache refresh and sets the cache refresh period to 1800 seconds, or 30 minutes. This must be done on each ADFS node and the ADFS service must be restarted afterwards. The changes do not impact other nodes and test the first node before making the change in all the nodes. 

  1. Navigate to the AD FS config file and under the section “Microsoft.IdentityServer.Service” , add the below entry:  
  
  - `backgroundCacheRefreshEnabled`  - Specifies if the background cache feature is enabled. “true/false” values.
  - `cacheRefreshIntervalSecs` - Value in seconds at which ADFS will refresh the cache. AD FS will refresh the cache if there is any change in SQL. AD FS will receive a SQL notification and refresh the cache.  
 
 >[!NOTE]
 > All the entries in the configuration file are case sensitive.  
 &lt;cache cacheRefreshIntervalSecs="1800" backgroundCacheRefreshEnabled="true" /&gt; 
 
Additional supported configurable values: 

   - **maxRelyingPartyEntries** - Maximum number of relying party entries which AD FS will keep in memory. This value is also used by the oAuth application permission cache. If there are more application permissions than RPs and if all will be stored in memory, this value should be the number of application permissions. The default value is 1000.
   - **maxIdentityProviderEntries** - This is the maximum number of claims provider entries AD FS will keep in memory. The default value is 200. 
   - **maxClientEntries** - This is the maximum number of OAuth client entries AD FS will keep in memory. The default value is 500. 
   - **maxClaimDescriptorEntries** - Maximum number of claim descriptor entries AD FS will keep in memory. The default value is 500. 
   - **maxNullEntries** - This is used as negative cache. When AD FS looks for an entry in the database and it is not found, AD FS adds in negative cache. This is the max size of that cache. There is negative cache for each type of objects, it is not a single cache for all the objects. The default value is 50,0000. 

## Multiple artifact DB support across datacenters 
For prior configurations of multiple datacenters, AD FS has only supported a single Artifact database, causing cross center datacenter latency during retrieval calls.  

To reduce cross datacenter latency, an AD FS administrator can now deploy multiple artifact DB instances and then modify an AD FS node’s configuration file to point to different artifact DB instances. The artifact database connection string can be provided in the configuration file allowing a per-node Artifact DB. If the connection string is not present within the configuration file, the node will fall back to the previous design to use the artifact database which is present in the configuration DB.  
Hybrid environments are also supported with this configuration.  

### Requirements: 
Prior to setting up multiple artifact database support, run an update on all the nodes and update the binaries since multi-node calls occur through this feature. 
  1. Generate deployment script to create the Artifact DB: 
 To deploy multiple artifact DB instances, an admin will need to generate the SQL deployment script for the Artifact DB. As part of this update, the existing `Export-AdfsDeploymentSQLScript`cmdlet has been updated to optionally take in a parameter specifying which AD FS database to generate an SQL deployment script for. 
 
 For example, to generate the deployment script for just the Artifact DB, specify the `-DatabaseType` parameter and pass in the value “Artifact”. The optional `-DatabaseType` parameter specifies the AD FS database type and can be set to: All (default), Artifact, or Configuration. If no `-DatabaseType` parameter is specified, the script will configure both the Artifact and Configuration scripts.  

   ```PowerShell
   PS C:\> Export-AdfsDeploymentSQLScript -DestinationFolder <script folder where scripts will be created> -ServiceAccountName <domain\serviceaccount> -DatabaseType "Artifact" 
   ```
The generated script should be run on the SQL machine to create the required databases and give the AD FS service account, SQL SA permissions to those databases.

 2. Create the Artifact DB using the deployment script. Copy the newly generated CreateDB.sql and SetPermissions.sql deployment scripts over to the SQL server machine and execute them to create the local Artifact DB. 
 
 3. Modify the Configuration file to add the Artifact DB connection. 
 Navigate to the AD FS node’s config file, and under the section “Microsoft.IdentityServer.Service”, add an entry point to the newly configured ArtifactDB. 

 >[!NOTE] 
 > artifactStore and connectionString are case sensitive values. Ensure they are correctly configured. 
 &lt;artifactStore connectionString="Data Source=.\SQLInstance;Integrated Security=True;Initial Catalog=AdfsArtifactStore" /&gt; 
>
>Use a Data Source value that matches your sql connection.



 4. Restart the AD FS service for the changes to take effect. 
 
 >[!NOTE] 
 > It is not recommended to use SQL replication or synchronization between the artifact databases. The recommendation is to set up one artifact database per datacenter. 
 
### Cross datacenter failover and database recovery  
It is recommended to create failover artifact databases on the same datacenter as the master artifact database. If a failover occurs, there will be no increase in latency. Failover Artifact databases across datacenters is not recommended. The following details how calls for OAuth, SAML, ESL, and token replay detection function with multiple artifact databases. 
 - **OAuth and SAML** 

   For OAuth and SAML artifact requests, the node will create the artifact in the artifact DB present in the configuration file. If the configuration file does not contain a artifact database connection, it will use the common artifact DB. When the next request to fetch the artifact goes to another node, the other node will make rest API to the 1st node to fetch the artifact from the artifact DB. This is required as different nodes might have different artifact databases and the nodes do not know about that. If the 1st node is down, the artifact resolution will fail. Due to this design, replicating the artifact DB across different datacenters is not necessary. If one whole datacenter is down, most likely the node which created the artifact is also down, meaning that artifact cannot be resolved anymore.  

 - **Extranet Lockout** 

    The Artifact database referenced to in the configuration file will be used for Extranet Lockout data. However, for the ESL feature, AD FS chooses a master which writes the data in the artifact DB. All the nodes make a REST API call to the master node to get and set the latest information about each user. If multiple artifact DB’s are in use, the admin must select a master node for each artifact DB or datacenter. 

    To select one node to be the ESL master, navigate to the ADFS node’s config file, and under the section “Microsoft.IdentityServer.Service”, add the following:       
    
    On the master add following entry. Note that all three keys are case sensitive. 

    &lt;useractivityfarmrole masterFQDN=[FQDN of the selected primary] isMaster="true"/&gt;
    
    On the other nodes add following entry:

   &lt;useractivityfarmrole masterFQDN=[FQDN of the selected primary] isMaster="false"/&gt;
 
    >[!NOTE] 
    >Since multiple artifact databases do not synchronize data, ESL values will not be synchronized between artifact DBs.
    A user can potentially hit a different datacenter for a request, therefore making the ExtranetLockoutThreshold dependent on the number of Artifact DBs, ExtranetLockoutThreshold * Number of Artifact DBs. 
 
  - **Token Replay Detection** 
    
    Token replay detection data is always called from the central Artifact database. AD FS saves the token from the Claims Provider Trust, ensuring that the same token cannot be replayed. If an attacker attempts to replay the same token, AD FS verifies if the token exists in the Artifact DB. If the token is present, the request will be rejected. The central Artifact database is used for security, since the Artifact DB data is not replicated, an attacker could send the request to another datacenter and replay a token. Creating additional read-only copies of the ArtifactDB will not prevent cross datacenter latency in this scenario, as only the central Artifact database is used.    
 
 