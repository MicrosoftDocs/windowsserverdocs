---
title: Issues with WSUS 3.0 Services
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 50cbd09c-7984-4dcd-8cfc-d14e69561ab3
author: britw
---
# Issues with WSUS 3.0 Services
WSUS uses seven services. They are the Update Service \(wsusservice.exe\), the Reporting Web Service, the API Remoting Web Service, the Client Web Service, the Simple Web Authentication Web Service, the Server Synchronization Service, and the DSS Authentication Web Service. This section explains how to troubleshoot these services in general.  
  
## Troubleshooting services  
  
#### General service troubleshooting  
You can use the following steps to restart services that are not functioning properly:  
  
1.  Locate the service \(click **Start**, point to **Administrative Tools**, click **Services**, and then look for the service\).  
  
2.  Verify that the service is running. Click **Start** if it is stopped or **Restart** to refresh the service if it is running.  
  
You can also use the Event Viewer to check the Application, Security, and System event logs to see if there are any events that indicate a problem.  
  
Check the SoftwareDistribution.log to see if there are events that indicate a problem.  
  
#### Internet Information Services  
Use the following procedure to reset Internet Information Services \(IIS\) if you suspect that there are problems with web services.  
  
1.  Open a Command Prompt window.  
  
2.  Type **iisreset**.  
  
#### SQL Server service  
The SQL Server service must be running for all the services except the self\-update service. If any of the log files indicate SQL Server connection problems, check the SQL Server service first. To access the SQL Server service, click the **Start** button, point to **Administrative Tools**, click **Services**, and then look for one of the following:  
  
-   **MSSQLSERVER** \(if you are using [!INCLUDE[nextref_wyukon](../Token/nextref_wyukon_md.md)], or if you are using SQL Server and you are using the default instance name \).  
  
-   **MSSQL$WSUS** \(if you are using a SQL Server database and you have named your database instance "WSUS"\).  
  
Right\-click the service, and then click **Start** if the service is not running or **Restart** to refresh the service if it is running.  
  
#### Access rights in web service directories  
Incorrectly set permissions in web service directories can cause problems for WSUS web services. WSUS setup will create these directories and set the access rights correctly, but subsequent developments, such as the installation of applications or the operation of security software, may have reduced the permissions. For more information about the web service directories and the correct access rights for them, see [Permissions on WSUS Directories and Registry Keys](../Topic/Permissions-on-WSUS-Directories-and-Registry-Keys.md).  
  
#### IIS settings for web services  
IIS must be configured correctly for WSUS web services. WSUS setup will configure its web services correctly, but subsequently adding new web services or reconfiguring the default web site \(if the default site is used by WSUS\) may cause the configuration to change. For an explanation of how to check the IIS configuration, in addition to the correct settings for the web services and the WWW web service, see [IIS Settings for WSUS 3.0 SP2 Web Services](../Topic/IIS-Settings-for-WSUS-3.0-SP2-Web-Services.md).  
  
