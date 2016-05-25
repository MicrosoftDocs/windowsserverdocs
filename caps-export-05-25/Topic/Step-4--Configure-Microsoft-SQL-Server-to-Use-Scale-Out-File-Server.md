---
title: Step 4: Configure Microsoft SQL Server to Use Scale-Out File Server
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: dd876529-f1ff-40ee-8f8f-ae07d2d8f93d
author: JasonGerend
---
# Step 4: Configure Microsoft SQL Server to Use Scale-Out File Server
SQL Server is one of two Microsoft applications that are supported when using File Server for scale\-out application data storage. SQL Server 2008 R2 and SQL Server 2012 are supported in this scenario. SQL Server 2008 R2 is supported in a stand\-alone configuration, and SQL Server 2012 adds support for clustered servers.  
  
|Task|Description|  
|--------|---------------|  
|[4.1. Verify permissions](../Topic/Step-4--Configure-Microsoft-SQL-Server-to-Use-Scale-Out-File-Server.md#BKMK_1.1)|Ensure that the permissions on the continuously available file share are configured correctly to host the database files.|  
|[4.2. Create the database files](../Topic/Step-4--Configure-Microsoft-SQL-Server-to-Use-Scale-Out-File-Server.md#BKMK_1.2)|Create the database files by using SQL Server Management Studio or by using a query.|  
  
## <a name="BKMK_1.1"></a>4.1. Verify permissions  
You should ensure that the proper permissions are granted on the continuously available file share before you create SQL Server database files.  
  
#### To verify permissions  
  
1.  Log on to the file server as a member of the local Administrators group.  
  
2.  Open Windows Explorer and navigate to the scale\-out file share.  
  
3.  Right\-click the folder, and then click **Properties**.  
  
4.  Click the **Sharing** tab, click **Advanced Sharing**, and then click **Permissions**.  
  
5.  Ensure that the SQL Server service account has full\-control permissions.  
  
6.  Click **OK** twice.  
  
7.  Click the **Security** tab.  
  
8.  Ensure that the SQL Server service account has full\-control permissions.  
  
## <a name="BKMK_1.2"></a>4.2. Create the database files  
When creating the database files, you can store the database files in a scale\-out file share by using SQL Server Management Studio or by using a query. In SQL Server 2012, you can choose to store all database files in a scale\-out file share during installation.  
  
## <a name="BKMK_Links"></a>See also  
  
-   [Step 1: Install Prerequisites for Scale\-out File Servers](assetId:///3847444c-b148-4d45-bb40-ce438ef36cd6)  
  
-   [Step 2: Configure Scale\-Out File Server](assetId:///b5e3a0c1-d4e8-4761-975a-10c042c7455e)  
  
-   [Step 3: Configure Hyper-V to Use Scale-Out File Server](../Topic/Step-3--Configure-Hyper-V-to-Use-Scale-Out-File-Server.md)  
  
-   [Deploy Scale\-out File Servers](assetId:///11415db9-8fb8-4aea-a6c0-38f706a0586e)  
  
-   [Scale-Out File Server for Application Data Overview_1](../Topic/Scale-Out-File-Server-for-Application-Data-Overview_1.md)  
  
-   [Provide cost\-effective storage for Hyper\-V workloads by using Windows Server](http://technet.microsoft.com/library/dn554251.aspx)  
  
