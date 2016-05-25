---
title: Migration Guide template
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ba4cfd72-e63a-4396-8952-d969243322ee
author: jaimeo
---
# Migration Guide template
  
  
  
  
  
**Important instructions for role teams:** While the Server Role Migration Guide Template provides very specific guidance for the document format, it is important to consider the following while generating the guide content:  
  
• Define migration instructions such that they focus on avoiding or minimizing any client or server environment downtime during and after the migration.  
  
• Minimize risk, avoid or minimize changes to the source environment and other servers and the clients, in order to minimize disruption and simplify rollback in case of unsuccessful migration.  
  
• Address all phases of migration: preparation (source server, destination server, IT environment), migration, verification, rollback (what to do if migration failed).  
  
• Provide an approximate time estimate for a typical migration and identify factors that can affect that estimate.  
  
• Define client and server environment impact during and after the migration (for example, during DHCP migration, will client computers be able to obtain IP address? What if they reboot?).  
  
• Define which server role configurations are supported and not supported (for example, is DHCP migration supported in Workgroup scenario? In Domain scenario? Across Domains? What about Cluster configurations?).  
  
• Document dependencies on other roles or server components, and how they affect migration. If multiple roles are installed on the server, in which order should your role be migrated relative to other roles?  
  
• Assuming that if a server is performing more than one server role, the roles may be migrated one by one, rather than all at once, thus requiring old and new servers to be operational at the same time.  
  
• Write migration instructions with the understanding that server identity (Computer Name and IP address) migration is optional. Not migrating identity may be important for staged migrations, when multiple server roles are migrated one at a time, rather than all at once. This is also important for split and consolidation scenarios.  
  
• Write migration instructions in a step-by-step fashion. The migration instructions should be end to end, meaning that they should describe not only how to migrate role configuration and data, but also how to perform any other steps (i.e. migrate certain OS settings) necessary to fully replace the server role on the old server with the equivalently-functioning server role on the new server.  
  
\[Introduction optional, created by iX if necessary or desired\]  
  
About this guide  
----------------  
  
Note  
  
Your detailed feedback is very important, and helps us to make Windows Server Migration Guides as reliable, complete, and easy to use as possible. Please take a moment to rate this topic, and then add comments that support your rating. Click **Rate this topic** at the top of the page. Describe what you liked, did not like, or want to see in future versions of the topic. To submit additional suggestions about how to improve Migration guides or utilities, post on the [Windows Server Migration forum](http://go.microsoft.com/fwlink/?LinkId=247606).  
  
What this guide covers. \[This para authored by feature iX\]  
  
(Boilerplate text for all guides that use cmdlet-based Windows Server Migration Tools, supplied by Migration writer) Migration documentation and tools ease the migration of server role settings and data from an existing server to a destination server that is running Windows Server® Preview. By using the tools that are described in this guide, you can simplify the migration process, reduce migration time, increase the accuracy of the migration process, and help to eliminate possible conflicts that might otherwise occur during the migration process. For more information about installing and using the migration tools on both source and destination servers, see [Install, Use, and Remove Windows Server Migration Tools](http://technet.microsoft.com/library/jj134202.aspx).  
  
### Target audience  
  
\[Completed by iX, role team must verify\]  
  
• IT architects responsible for computer management and security throughout an organization  
  
• IT operations engineers who are responsible for the day-to-day management and troubleshooting of networks, servers, client computers, operating systems, or applications.  
  
• IT operations managers who are accountable for network and server management.  
  
What this guide does not provide  
--------------------------------  
  
• Clustering scenarios currently are not supported by this migration process.  
  
• Upgrading roles on the same computer (in-place upgrade) is out of scope for this guide.  
  
• This guide does not provide instructions for migrating more than one server role at one time.  
  
Supported migration scenarios  
-----------------------------  
  
This guide provides you with instructions for migrating a server that is running &lt;Feature\_name&gt; to a server that is running Windows Server Preview. This guide does not contain instructions for migration when the source server is running multiple roles. If your server is running multiple roles, it is recommended that you design a custom migration procedure specific to your server environment, based on the information provided in other role migration guides. Migration guides for additional roles are available on the [Windows Server Migration Portal](http://technet.microsoft.com/windowsserver/jj554790.aspx).  
  
Caution  
  
If your source server is running multiple roles, some migration steps in this guide, such as those for computer name and IP configuration, can cause other roles that are running on the source server to fail.  
  
### Supported operating systems  
  
| Source server operating system | Destination server operating system | Destination server processor |  
|--------------------------------|-------------------------------------|------------------------------|  
|                                |                                     | x64-based                    |  
|                                |                                     |                              |  
|                                |                                     |                              |  
|                                |                                     |                              |  
|                                |                                     |                              |  
|                                |                                     |                              |  
  
The versions of operating systems shown in the preceding table are the oldest combinations of operating systems and service packs that are supported. Newer service packs, if available, are supported.  
  
Standard, Enterprise, and Datacenter editions of Windows Server are supported as sourceservers.  
  
Migrations between physical operating systems and virtual operating systems are supported.  
  
Migration from a source server to a destination server that is running an operating system in a different system UI language (that is, the installed language) than the source server is not supported. For example, you cannot use Windows Server Migration Tools to migrate roles, operating system settings, data, or shares from a computer that is running Windows Server 2008 in the French system UI language to a computer that is running Windows Server 2012 in the German system UI language.  
  
Note  
  
The system UI language is the language of the localized installation package that was used to set up the Windows operating system.  
  
Both x86- and x64-based migrations are supported for Windows Server 2008 R2. All editions of Windows Server 2008 R2 and newer releases of Windows Server are x64-based.  
  
Roles that are running on Server Core installations of Windows Server 2008 cannot be migrated, because there is no .NET Framework available on Server Core installations of Windows Server 2008.  
  
### Supported role configurations  
  
\[Completed by the role team\] Describe which role configurations can and cannot be migrated using this migration guide. For example, does this guide cover DNS migration in both standalone DNS configuration, and the configuration where the DNS server is integrated with AD?  
  
### Supported role services and features  
  
\[Completed by the role team\] Specify in a table format migration of which role services and features and their respective settings is covered by this guide. For each item specify the level of support – whether it is automated (i.e. using tools that automate significant portion of the migration steps) or manual migration.  
  
### Migration dependencies  
  
\[Completed by the role team\] For each role we must mention any migration order dependencies. For example, if the source server has multiple roles installed, must other installed roles be migrated, before beginning migration of the guide’s subject role can be started? If other roles must be migrated (for example, DNS with AD DS), the order in which each is migrated must be clear to users.  
  
Migration scenarios that are not supported  
------------------------------------------  
  
This section should contain a bulleted list of specific scenarios that are not covered by this guide, with technical detail about why not, if that information is available.  
  
Overview of migration process for this role  
-------------------------------------------  
  
\[Completed by the role team\] Describe the overall migration process for the role, breaking migration into phases, such as those outlined in this TOC: preparing to migrate, migration, verification, and post-migration, for example.  
  
### Process diagram (optional)  
  
\[Completed by iX and reviewed by product team\] This is an optional section that illustrates the preceding section, the process overview. Include optional process diagram(s) showing high-level overview of migration steps for this role.  
  
Impact of migration  
-------------------  
  
\[Completed by the role team\]  
  
### Impact of migration on the source server  
  
How this migration affects the source server (i.e. performance, restart required). Is there any impact to the source server or its operation if users choose not to use Windows Server Migration Tools?  
  
### Impact of migration on other computers in the enterprise  
  
How this migration will affect other servers in the enterprise during and after migration? How are client computers affected during and after the migration? If there is any downtime, how much downtime is expected?  
  
Access rights required to complete migration  
--------------------------------------------  
  
\[Completed by the role team\] Provide rights required – and on which computers -- for each phase of migration, in a bulleted list if more than one type of user rights are required.  
  
### Access rights required to complete migration on the destination server  
  
### Access rights required to complete migration on the source server  
  
### Access rights required to complete migration on other computers in the enterprise  
  
Estimated duration  
------------------  
  
\[Completed by the role team\] If you can get this data, provide a general idea how long it generally requires to fully migrate the server using this migration guide. How long is each phase (preparation, migration, verification, rollout, rollback) expected to take?  
  
Additional references  
---------------------  
  
1. Links to other topics in the guide  
  
2. Links to role or feature landing pages in the TechCenter, or relevant deployment or ops content that users might find helpful as they migrate features  
  
3. Links to social content sites (forums, blogs, Wiki topics) for the role or feature  
  
4. Link to WS08 R2, WS12 Migration Guides for the feature or role, if they exist  
  
5. [Windows Server Migration forum](http://go.microsoft.com/fwlink/?LinkId=247606)  
  
## Prepare to Migrate  
====================  
  
\[Completed by iX if necessary or desired\]  
  
Prepare your destination server  
-------------------------------  
  
\[Completed by the role team\] Describe how to prepare your destination environment for migration.  
  
### Hardware requirements for the destination server  
  
### Software requirements for the destination server  
  
Describe how the OS should be configured and what prerequisites need to be installed before the migration can begin.  
  
### To &lt;Procedure 1 title&gt;  
  
  
  
| 1.  |  
|-----|  
  
### To &lt;Procedure 2 title&gt;  
  
  
  
| 1.  |  
|-----|  
  
Back up your source server  
--------------------------  
  
\[Completed by the role team. Use the following default instructions, or provide any server-role-specific backup instructions.\] Before you start migration, as a best practice, we recommend that you back up the source server.  
  
• For information about backing up Windows Server 2003, see [Backing up and restoring data](http://technet.microsoft.com/library/cc738632(WS.10).aspx).  
  
• For information about backing up Windows Server 2008 and Windows Server 2008 R2, see [Backup and Recovery](http://technet.microsoft.com/library/cc754097(WS.10).aspx).  
  
• For information about backing up Windows Server 2012, see [Windows Server Backup](http://go.microsoft.com/fwlink/?LinkId=247621).  
  
• For information about backing up Windows Server 2012 R2 Preview, see [Windows Server Backup Feature Overview](http://technet.microsoft.com/library/jj614621.aspx).  
  
Install migration tools  
-----------------------  
  
Windows Server Migration Tools, first introduced in Windows Server® 2008 R2, lets an administrator migrate some server roles, features, operating system settings, shares, and other data from computers that are running certain editions of Windows Server 2003, Windows Server 2008, Windows Server 2008 R2, Windows Server 2012, or Windows Server Preview to computers that are running Windows Server 2012 or Windows Server Preview.  
  
Complete installation, configuration, and removal instructions for Windows Server Migration Tools are available on Microsoft TechNet, in the [Install, Use, and Remove Windows Server Migration Tools](http://technet.microsoft.com/library/jj134202.aspx) step-by-step guide. Windows Server Migration Tools must be installed on both the destination server and the source server, in that order.  
  
Migration documentation and tools ease the process of migrating server role settings and data from an existing server that is running Windows Server 2003 and later releases of the Windows operating system to another computer. By using these tools to migrate roles, you can simplify migration, reduce migration time, increase accuracy of the migration process, and help eliminate conflicts that could otherwise occur during the migration process.  
  
Windows Server Migration Tools is a set of Windows PowerShell® cmdlets. For more information about Windows PowerShell and working with cmdlets, see [Windows PowerShell](http://technet.microsoft.com/library/bb978526.aspx) on Microsoft TechNet.  
  
Prepare your source server  
--------------------------  
  
\[Completed by the role team\] Describe how to prepare your source server for migration. What services—and at which point—must first be stopped, before you can begin migration? When should users be disconnected (if required)? Focus on minimizing the downtime and the user impact.  
  
### &lt;Procedure1 title&gt;  
  
  
  
| 1.  |  
|-----|  
  
### &lt;Procedure2 title&gt;  
  
  
  
| 1.  |  
|-----|  
  
Prepare other computers in the enterprise  
-----------------------------------------  
  
Important  
  
Before you run the **Import-SmigServerSetting**, **Export-SmigServerSetting**, or **Get-SmigServerFeature** cmdlets, verify that during migration, both source and destination servers can contact the domain controller that is associated with domain users or groups who are members of local groups on the source server.  
  
Before you run the **Send-SmigServerData** or **Receive-SmigServerData** cmdlets, verify that during migration, both source and destination servers can contact the domain controller that is associated with those domain users who have rights to files or shares that are being migrated.  
  
\[Completed by the role team\] This is an optional section. If migration requires taking any preparation steps on other servers or client computers, describe these steps here. Specify whether outage or downtime notifications should be sent to users of other computers in the enterprise.  
  
### &lt;Procedure1 title&gt;  
  
  
  
| 1.  |  
|-----|  
  
### &lt;Procedure2 title&gt;  
  
  
  
| 1.                                                                                                                                                                                                                                                                           
                                                                                                                                                                                                                                                                               
 Important                                                                                                                                                                                                                
                                                                                                                                                                                                                                                                               
 IMPORTANT: If preparation steps depend on particular role configuration or migration scenario (i.e. whether a DNS server operates as a standalone server or is integrated with AD), provide a separate set of preparation steps for each supported configuration/scenario.  |  
|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|  
  
Additional references  
---------------------  
  
1. Links to other topics in the guide  
  
2. Links to role or feature landing pages in the TechCenter, or relevant deployment or ops content that users might find helpful as they migrate features  
  
3. Links to social content sites (forums, blogs, Wiki topics) for the role or feature  
  
4. Link to WS08 R2 or WS12 Migration Guides for the feature or role, if they exist  
  
5. [Windows Server Migration Portal](http://technet.microsoft.com/windowsserver/jj554790.aspx)  
  
 ## Migrate the Server Role  
=========================  
  
\[Completed by iX, if necessary or desired\]  
  
\[Below sections are completed by the role or feature team\]  
  
Provide step-by-step migration instructions for each supported OS, scenario and configuration. If migration steps are mostly the same for all supported OSes, scenarios and configurations, use a single section to describe the migration pointing out differences relevant for the different OSes, scenarios or configurations. If migration steps are mostly different, dedicate a separate section for each migration scenario.  
  
Migrate from &lt;OS1&gt; in &lt;Scenario1&gt;  
---------------------------------------------  
  
\[Intro to migration section…how does migrating from this OS release differ from migrating from other releases?\]  
  
### &lt;Procedure1 title&gt;  
  
  
  
| 1.  |  
|-----|  
  
### &lt;Procedure2 title&gt;  
  
  
  
| 1.  |  
|-----|  
  
Migrate from &lt;OS2&gt; in &lt;Scenario1&gt;  
---------------------------------------------  
  
…and so forth, or  
  
Migrate (if role migration is similar for all scenarios, and for all source OSs)  
--------------------------------------------------------------------------------  
  
### &lt;Task1 title&gt;  
  
  
                                                          
 \( a. Procedure within Task 1 )                         
                       
                                                          
                                                   |  
  
  
### &lt;Task2 title&gt;  
  
  
                                                          
 \| a. Procedure within Task 2 |                           
 |----------------------------|                           
                                                          
  
                                                          
 \| a. Another procedure within Task 2 |                   
 \|------------------------------------|                   
                                                          
 1.                                                     |  
|-------------------------------------------------------|  
  
Additional references  
---------------------  
  
1. Links to other topics in the guide  
  
2. Links to role or feature landing pages in the TechCenter, or relevant deployment or ops content that users might find helpful as they migrate features  
  
3. Links to social content sites (forums, blogs, Wiki topics) for the role or feature  
  
4. Link to WS08 R2or WS12 Migration Guides for the feature or role, if they exist  
  
5. [Windows Server Migration Portal](http://technet.microsoft.com/windowsserver/jj554790.aspx)  
  
## Verify the Migration  
======================  
  
\[Completed by iX, if necessary or desired\]  
  
Verify destination server configuration  
---------------------------------------  
  
\[Completed by the role team\] Describe how to verify that the destination server is configured and functioning properly.  
  
### &lt;Task1 title&gt;  
  
  
  
|   
                                                          
 | a. Procedure within Task 1 |                           
 |----------------------------|                           
                                                          
 1.                                                     |  
|-------------------------------------------------------|  
  
### &lt;Task2 title&gt;  
  
  
  
|   
                                                          
 | a. Procedure within Task 2 |                           
 |----------------------------|                           
                                                          
    
                                                          
 | a. Another procedure within Task 2 |                   
 |------------------------------------|                   
                                                          
 1.                                                     |  
|-------------------------------------------------------|  
  
### Perform a Best Practices Analyzer scan  
  
\[Completed by role writer. If the role can be scanned by using Best Practices Analyzer, include this section.\]  
  
To verify that &lt;role name&gt; is optimally configured on Windows Server Preview after migration, we recommend that you run a Best Practices Analyzer (BPA) scan on the role. BPA is a server management tool that is available in Windows Server 2008 R2 and newer releases of Windows Server. After migration of &lt;role name&gt; to Windows Server Preview is finished, BPA can help you ensure that your server is configured according to best practices after completing migration. You can use either the Server Manager console UI or Windows PowerShell to perform BPA scans and view results. For detailed information about how to scan your role and view results, see the [Run Best Practices Analyzer scans and manage scan results](http://go.microsoft.com/fwlink/?LinkID=223177).  
  
Verify configuration of other computers in the enterprise  
---------------------------------------------------------  
  
\[Completed by the role or feature team\] Describe how to verify that other servers and other client computers are still working properly and are not affected in an unexpected way by the completed migration.  
  
### &lt;Task1 title&gt;  
  
  
  
|   
                                                          
 | a. Procedure within Task 1 |                           
 |----------------------------|                           
                                                          
 1.                                                     |  
|-------------------------------------------------------|  
  
### &lt;Task2 title&gt;  
  
  
  
|                                                                                                                                                                                                                                                            
                                                                                                                                                                                                                                                                                                                    
 | a. Procedure within Task 2 |                                                                                                                                                                                                                                                                                     
 |----------------------------|                                                                                                                                                                                                                                                                                     
                                                                                                                                                                                                                                                                                                                    
                                                                                                                                                                                                                                                           
                                                                                                                                                                                                                                                                                                                    
 | a. Another procedure within Task 2 |                                                                                                                                                                                                                                                                             
 |------------------------------------|                                                                                                                                                                                                                                                                             
                                                                                                                                                                                                                                                                                                                    
 1. \[Completed by the role or feature team\] If verification steps depend on particular role configuration or migration scenario (i.e. whether a DNS server operates as a standalone server, or is integrated with AD), provide a separate set of verification steps for each supported configuration/scenario.  |  
|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|  
  
Additional references  
---------------------  
  
1. Links to other topics in the guide  
  
2. Links to role or feature landing pages in the TechCenter, or relevant deployment or ops content that users might find helpful as they migrate features  
  
3. Links to social content sites (forums, blogs, Wiki topics) for the role or feature  
  
4. Link to WS08 R2 or WS12 Migration Guides for the feature or role, if they exist  
  
5. [Windows Server Migration Portal](http://technet.microsoft.com/windowsserver/jj554790.aspx)  
  
## Post-migration Tasks  
======================  
  
\[Completed by iX if necessary or desired\]  
  
Completing migration  
--------------------  
  
\[Completed by the role or feature team\]  
  
If necessary, provide any additional instructions for switching the migrated workload to the destination server.  
  
### &lt;Task1 title&gt;  
  
  
  
|    
                                                          
 | a. Procedure within Task 1 |                           
 |----------------------------|                           
                                                          
 1.                                                     |  
|-------------------------------------------------------|  
  
### &lt;Task2 title&gt;  
  
  
  
|   
                                                          
 | a. Procedure within Task 2 |                           
 |----------------------------|                           
                                                          
   
                                                          
 | a. Another procedure within Task 2 |                   
 |------------------------------------|                   
                                                          
 1.                                                     |  
|-------------------------------------------------------|  
  
Restoring the role in the event of migration failure  
----------------------------------------------------  
  
\[Completed by the role team\] If verification wasn’t successful, provide instructions about reversing changes to the source server, other servers, and client computers, and then restore the source server back into service.  
  
### Rollback requirements  
  
\[Completed by the role team\] Describe any requirements that the server and client environment must meet before rollback can be completed. For example, a rollback procedure might depend upon the source server still being available in the same state as right after migration has been completed.  
  
### Estimated time to complete rollback  
  
### Roll back migration changes on other computers in the enterprise  
  
  
  
| 1.  |  
|-----|  
  
### Roll back migration of on the source server &lt;Scenario1&gt;  
  
  
  
| 1.  |  
|-----|  
  
### Roll back migration of on the source server &lt;Scenario2&gt;  
  
  
  
| 1.  |  
|-----|  
  
### Rolling back migration of on the destination server running Windows Server 2012  
  
  
  
| 1. If rollback steps depend on particular role configuration or migration scenario (i.e. whether a DNS server operates as a standalone server or is integrated with AD), provide a separate set of rollback steps for each supported configuration/scenario. |  
|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|  
  
Retiring on your source server  
------------------------------  
  
\[Completed by the role or feature team.\] Assuming migration was successful, provide instructions for taking the migrated role on the source server out of service without disrupting the client and server environment, if at all possible.  
  
### &lt;Procedure1 title&gt;  
  
  
  
| 1.  |  
|-----|  
  
### &lt;Procedure2 title&gt;  
  
  
  
| 1.  |  
|-----|  
  
Retiring your source server  
---------------------------  
  
\[Completed by the role and feature team\] Assuming migration was successful, provide instructions for taking the source server out of service without disrupting client and server environment, once migration is completed.  
  
### &lt;Procedure1 title&gt;  
  
  
  
| 1.  |  
|-----|  
  
### &lt;Procedure2 title&gt;  
  
  
  
| 1.  |  
|-----|  
  
Troubleshooting cmdlet-based migration  
--------------------------------------  
  
The Windows Server Migration Tools deployment log file is located at %*windir*%\\Logs\\SmigDeploy.log. Additional Windows Server Migration Tools log files are created at the following locations.  
  
• %*windir*%\\Logs\\ServerMigration.log  
  
• On Windows Server 2008, Windows Server 2008 R2, Windows Server 2012, and Windows Server 2012 R2 Preview: %*localappdata*%\\SvrMig\\Log  
  
• On Windows Server 2003: %*userprofile*%\\Local Settings\\Application Data\\SvrMig\\Log  
  
If migration log files cannot be created in the preceding locations, **ServerMigration.log** and **SmigDeploy.log** are created in %*temp*%, and other logs are created in %*windir*%\\System32.  
  
If a migration cmdlet fails, and the Windows PowerShell session closes unexpectedly with an access violation error message, look for a message similar to the following example in the %*localappdata*%\\SvrMig\\Logs\\setuperr.log file.  
  
FatalError \[0x090001\] PANTHR Exception (code 0xC0000005: ACCESS\_VIOLATION) occurred at 0x000007FEEDE9E050 in C:\\Windows\\system32\\migwiz\\unbcl.dll (+000000000008E050).  Minidump attached (317793 bytes).  
  
This failure occurs when the server cannot contact domain controllers that are associated with domain users or groups who are members of local groups, or who have rights to files or shares that are being migrated. When this happens, each domain user or group is displayed in the GUI as an unresolved security identifier (SID). An example of a SID is **S-1-5-21-1579938362-1064596589-3161144252-1006**.  
  
To prevent this problem, verify that required domain controllers or global catalog servers are running, and that network connectivity allows communication between both source and destination servers and required domain controllers or global catalog servers. Then, run the cmdlets again.  
  
If connections between either the source or destination servers and the domain controllers or global catalog servers cannot be restored, do the following.  
  
| 1. Before you run **Export-SmigServerSetting**, **Import-SmigServerSetting** or **Get-SmigServerFeature** again, remove all unresolved domain users or groups who are members of local groups from the server on which you are running the cmdlet.   
                                                                                                                                                                                                                                                       
 2. Before you run **Send-SmigServerData** or **Receive-SmigServerData** again, remove all unresolved domain users or groups who have user rights to files, folders, or shares on the migration source server.                                       |  
|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|  
  
### Viewing the content of Windows Server Migration Tools result objects  
  
All Windows Server Migration Tools cmdlets return results as objects. You can save result objects, and query them for more information about settings and data that were migrated. You can also use result objects as input for other Windows PowerShell commands and scripts.  
  
#### Result object descriptions  
  
The Windows Server Migration Tools **Import-SmigServerSetting** and **Export-SmigServerSetting** cmdlets return results in a list of **MigrationResult** objects. Each **MigrationResult** object contains information about the data or setting that the cmdlet processes, the result of the operation, and any related error or warning messages. The following table describes the properties of a **MigrationResult** object.  
  
| Property name | Type                                | Definition                                                                                                                          |  
|---------------|-------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------|  
| ItemType      | Enum                                | The type of item being migrated. Values include **General**, **WindowsFeatureInstallation**, **WindowsFeature**, and **OSSetting**. |  
| ID            | String                              | The ID of the migrated item. Examples of values include **Local User**, **Local Group**, and **DHCP**.                              |  
| Success       | Boolean                             | The value **True** is displayed if migration was successful; otherwise, **False** is displayed.                                     |  
| DetailsList   | List &lt;MigrationResultDetails&gt; | A list of **MigrationResultDetails** objects.                                                                                       |  
  
**Send-SmigServerData** and **Receive-SmigServerData** cmdlets return results in a list of **MigrationDataResult** objects. Each **MigrationDataResult** object contains information about the data or share that the cmdlet processes, the result of the operation, any error or warning messages, and other related information. The following table describes the properties of a **MigrationDataResult** object.  
  
| Property name       | Type                                | Definition                                                                                         |  
|---------------------|-------------------------------------|----------------------------------------------------------------------------------------------------|  
| ItemType            | Enum                                | The type of migrated item. Values include **File**, **Folder**, **Share**, and **Encrypted File**. |  
| SourceLocation      | String                              | The source location of the item, shown as a path name.                                             |  
| DestinationLocation | String                              | The destination location of the item, shown as a path name.                                        |  
| Success             | Boolean                             | The value **True** is displayed if migration was successful; otherwise, **False** is displayed.    |  
| Size                | Integer                             | The item size, in bytes.                                                                           |  
| ErrorDetails        | List &lt;MigrationResultDetails&gt; | A list of **MigrationResultDetails** objects.                                                      |  
| Error               | Enum                                | Errors enumeration for errors that occurred.                                                       |  
| WarningMessageList  | List &lt;String&gt;                 | A list of warning messages.                                                                        |  
  
The following table describes the properties of objects within the **MigrationResultDetails** object that are common to both **MigrationResult** and **MigrationDataResult** objects.  
  
| Property name | Type                | Definition                                                                                                                                                     |  
|---------------|---------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------|  
| FeatureId     | String              | The name of the migration setting that is related to the item. Examples of values include **IPConfig** and **DNS**. This property is empty for data migration. |  
| Messages      | List &lt;String&gt; | A list of detailed event messages.                                                                                                                             |  
| DetailCode    | Integer             | The error or warning code associated with each event message.                                                                                                  |  
| Severity      | Enum                | The severity of an event, if events occurred. Examples of values include **Information**, **Error**, and **Warning**.                                          |  
| Title         | String              | Title of the result object. Examples of values include NIC physical address for IP configuration, or user name for local user migration.                       |  
  
#### Examples  
  
The following examples show how to store the list of the result objects in a variable, and then use the variable in a query to return the content of result objects after migration is complete.  
  
To store a list of result objects as a variable for queries  
  
| 1. To run a cmdlet and save the result in variable, type a command in the following format, and then press **Enter**.                                                                                                                                                                                                                                                  
                                                                                                                                                                                                                                                                                                                                                                         
 **$***VariableName* **=** $(*Cmdlet*)                                                                                                                                                                                                                                                                                                                                   
                                                                                                                                                                                                                                                                                                                                                                         
 The following is an example.                                                                                                                                                                                                                                                                                                                                            
                                                                                                                                                                                                                                                                                                                                                                         
 **$ImportResult = $(Import-SmigServerSetting -FeatureId DHCP -User all -Group -Path D:\\rmt\\DemoStore -force -Verbose)**                                                                                                                                                                                                                                               
                                                                                                                                                                                                                                                                                                                                                                         
 This command runs the **Import-SmigServerSetting** cmdlet with several parameters specified, and then saves result objects in the variable **ImportResult**.                                                                                                                                                                                                            
                                                                                                                                                                                                                                                                                                                                                                         
 2. After the **Import-SmigServerSetting** cmdlet has completed its operations, return the information contained in the result object by typing a command in the following format, and then pressing **Enter**.                                                                                                                                                          
                                                                                                                                                                                                                                                                                                                                                                         
 **$***VariableName*                                                                                                                                                                                                                                                                                                                                                     
                                                                                                                                                                                                                                                                                                                                                                         
 In the following example, the variable is named **ImportResult**.                                                                                                                                                                                                                                                                                                       
                                                                                                                                                                                                                                                                                                                                                                         
 **$***ImportResult*                                                                                                                                                                                                                                                                                                                                                     
                                                                                                                                                                                                                                                                                                                                                                         
 This command returns information contained in the result objects that were returned by **Import-SmigServerSetting** in the example shown in step 1. The following is an example of the output that is displayed by calling the **ImportResult** variable.                                                                                                               
                                                                                                                                                                                                                                                                                                                                                                         
 ItemType ID Success DetailsList                                                                                                                                                                                                                                                                                                                                         
                                                                                                                                                                                                                                                                                                                                                                         
 -------- -- ------- -----------                                                                                                                                                                                                                                                                                                                                         
                                                                                                                                                                                                                                                                                                                                                                         
 OSSetting Local User True {Local User, Loc...                                                                                                                                                                                                                                                                                                                           
                                                                                                                                                                                                                                                                                                                                                                         
 OSSetting Local Group True {Local Group, Lo...                                                                                                                                                                                                                                                                                                                          
                                                                                                                                                                                                                                                                                                                                                                         
 WindowsFeature DHCP True {}                                                                                                                                                                                                                                                                                                                                             
                                                                                                                                                                                                                                                                                                                                                                         
 Each line of the preceding sample is a migration result for an item that was migrated by using the **Import-SmigServerSetting** cmdlet. The column heading names are properties of **MigrationResult** objects. You can incorporate these properties into another command to return greater detail about result objects, as shown by examples in step 3 and forward.    
                                                                                                                                                                                                                                                                                                                                                                         
 3. To display a specific property for all result objects in the list, type a command in the following format, and then press **Enter**.                                                                                                                                                                                                                                 
                                                                                                                                                                                                                                                                                                                                                                         
 **$&lt;VariableName&gt;| Select-Object -ExpandProperty &lt;PropertyName&gt;**                                                                                                                                                                                                                                                                                           
                                                                                                                                                                                                                                                                                                                                                                         
 The following is an example.                                                                                                                                                                                                                                                                                                                                            
                                                                                                                                                                                                                                                                                                                                                                         
 **$importResult | Select-Object -ExpandProperty DetailsList**                                                                                                                                                                                                                                                                                                           
                                                                                                                                                                                                                                                                                                                                                                         
 4. You can run more advanced queries to analyze result objects by using Windows PowerShell cmdlets. The following are examples.                                                                                                                                                                                                                                         
                                                                                                                                                                                                                                                                                                                                                                         
 • The following command returns only those details of result objects that have the ID **Local User**.                                                                                                                                                                                                                                                                   
                                                                                                                                                                                                                                                                                                                                                                         
 **$ImportResult | Where-Object { $\_.ID -eq "Local User" } | Select-Object -ExpandProperty DetailsList**                                                                                                                                                                                                                                                                
                                                                                                                                                                                                                                                                                                                                                                         
 • The following command returns only those details of result objects with an ID of **Local User** that have a message severity equal to **Warning**.                                                                                                                                                                                                                    
                                                                                                                                                                                                                                                                                                                                                                         
 **$ImportResult | Where-Object { $\_.ID -eq "Local User" } | Select-Object -ExpandProperty DetailsList | ForEach-Object { if ($\_.Severity -eq "Warning") {$\_} }**                                                                                                                                                                                                     
                                                                                                                                                                                                                                                                                                                                                                         
 • The following command returns only the details of result objects with an ID of **Local User** that also have the title **Remote Desktop Users**.                                                                                                                                                                                                                      
                                                                                                                                                                                                                                                                                                                                                                         
 **$ImportResult | Where-Object { $\_.ID -eq "Local Group" } | Select-Object -ExpandProperty DetailsList | ForEach-Object { if ($\_.Title -eq "Remote DesktopUsers") {$\_} }**                                                                                                                                                                                         |  
|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|  
  
#### More information about querying results  
  
For more information about the cmdlets that are used in the preceding examples, see the following additional resources. The following resources apply to Windows PowerShell 4.0.  
  
• [Where-Object](http://technet.microsoft.com/library/hh849715(v=wps.630).aspx)  
  
• [Select-Object](http://technet.microsoft.com/library/hh849895(v=wps.630).aspx)  
  
• [ForEach-Object](http://technet.microsoft.com/library/hh849731(v=wps.630).aspx)  
  
For more information about Windows PowerShell scripting techniques, see the [Windows PowerShell User’s Guide](http://technet.microsoft.com/library/cc196356.aspx).  
  
Additional references  
---------------------  
  
1. Links to other topics in the guide  
  
2. Links to role or feature landing pages in the TechCenter, or relevant deployment or ops content that users might find helpful as they migrate features  
  
3. Links to social content sites (forums, blogs, Wiki topics) for the role or feature  
  
4. Link to WS08 R2 or WS12 Migration Guides for the feature or role, if they exist  
  
5. [Windows Server Migration Portal](http://technet.microsoft.com/windowsserver/jj554790.aspx)  
  
  
--------------------------------------------------  
  
## Welcome to CAPS Markdown Editor!  
  
CAPS is using GitHub Flavored Markdown(GFM) which is one of the most popular Markdown flavor. Lets' learn how to make your customized document with below rules.    
  
*View the [Markdown Basics](https://help.github.com/articles/markdown-basics/)*  
*View the [Github Flavored Markdown](https://help.github.com/articles/github-flavored-markdown/)*  
*View the [Online sample](http://github.github.com/github-flavored-markdown/sample_content.html).*  
    
Quick Guidance  
---  
When you are authoring your Markdown content in CAPS, you could get help from different ways:  
- Use `Alt + F1` in IE or `F1` in Chrome to open `Command Palette`  
- Use `Ctrl + space` at any place to open insert.  
- Use authoring tool bar on the top of the editor to help create your content  
  
Format your content  
---  
- **Paragraph**  
  Paragraphs in Markdown are just one or more lines of consecutive text followed by one or more blank lines.  
    
  ```  
  On July 2, an alien ship entered Earth's orbit and deployed several dozen saucer-shaped "destroyer" spacecraft, each 15 miles (24 km) wide.  
    
  On July 3, the Black Knights, a squadron of Marine Corps F/A-18 Hornets, participated   
  ```  
    
- **Headings**    
  You can either you header dropdown list provided in the authoring toolbar, or manually add '---' or '===' in the     next line under your section title. You can also create a heading by adding one or more `#` symbols before your     heading text. The number of `#` you use will determine the size of the heading.  
  
  ```  
  ## The second largest heading (an <h2> tag)  
  …  
  ###### The 6th largest heading (an <h6> tag)  
  ```  
  
- **Block quotes**  
  You can indicate block quotes with a `>`.  
  ```  
  In the words of Abraham Lincoln:  
    
  > Pardon my French  
  > Second line of the quote  
  ```  
  
- **Styling text**  
  You can make your text **Bold** or *italic*  
  ```  
  **This text will be bold**  
  *This text will be italic*    
  ```  
  You can also use authoring toolbar to achieve this  
  
- **Lists**  
  You can add an unordered list by preceding list items with `*` or `-`  
  ```  
  * Item  
  * Item  
  * Item  
    
  - Item  
  - Item  
  - Item    
  ```  
  You can add ordered list by preceding list items with a number  
  ```  
  1. Item 1  
  2. Item 2  
  3. Item 3    
  ```  
  You can create nested lists by indenting list items by two spaces.  
  ```  
  1. Item 1  
    1. A corollary to the above item.  
    2. Yet another point to consider.  
  2. Item 2  
    * A corollary that does not need to be ordered.  
      * This is indented four spaces, because it's two spaces further than the item above.  
      * You might want to consider making a new list.  
  3. Item 3   
  ```  
  You can also use authoring toolbar to achieve this  
    
- **Code formatting**  
  You can use triple ticks (```) to format text as its own distinct block.  
  Check out this neat program I wrote:    
  ~~~~  
  ```  
  x = 0  
  x = 2 + 2  
  what is x  
  ```  
  ~~~~  
  
Add Reference to your content  
---  
- **Insert Links**  
  You can create an inline link by wrapping link text in brackets `[Link Label]`, and then wrapping the link in    parentheses `(http://URL)`.   
  [Bing.com](http://www.bing.com)  
    
  You can also create a link to an existing topic in CAPS with the authoring toolbar  
    
- **Insert Image**  
  You can reference a online image from external resource by using `![Image Label]`, and then wrapping the image resource url in parentheses `(http://ImageURL)`  
    
  You can also insert an image from CAPS with the authoring toolbar  
  
  
Using tables in your content  
---  
You can create tables by assembling a list of words and dividing them with hyphens - (for the first row), and then separating each column with a pipe |:  
  
First Header  | Second Header  
------------- | -------------  
Content Cell  | Content Cell  
Content Cell  | Content Cell  
  
You can also include inline Markdown format syntax such as links, bold, italics, or strike through:  
  
| Name | Description          |  
| ------------- | ----------- |  
| Help      | ~~Display the~~ help window.|  
| Close     | _Closes_ a window     |  
  
You can have more formatting control by including colons : within the header row, you can define text to be left-aligned, right-aligned, or center-aligned:  
  
| Left-Aligned  | Center Aligned  | Right Aligned |  
| :------------ |:---------------:| -----:|  
| col 3 is      | some wordy text | $1600 |  
| col 2 is      | centered        |   $12 |  
| zebra stripes | are neat        |    $1 |  
  
A colon on the **left-most** side indicates a left-aligned column; a colon on the **right-most** side indicates a right-aligned column; a colon on **both** sides indicates a center-aligned column.  
  
  
HTML  
---  
You can use a subset of HTML within your content.   
A full list of our supported tags and attributes can be found [here](https://github.com/github/markup/tree/master#html-sanitization)  
  
  
    
