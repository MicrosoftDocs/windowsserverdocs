---
title: Migrate an AD FS 2.0 federation server SQL farm
description: Provides information on migrating an AD FS 2.0 server SQL farm to Windows Server 2012
author: billmath
ms.author: billmath
manager: femila
ms.date: 06/28/2017
ms.topic: article
ms.prod: windows-server-threshold
ms.technology: identity-adfs
---

# Migrate an AD FS 2.0 WID farm  
This document provides detailed information on migrating an AD FS 2.0 SQL farm to Windows Server 2012.


## Migrate a SQL Server farm  
 To migrate a SQL Server farm to Windows Server 2012, perform the following procedure:  
  
1.  For each server in your SQL Server farm, review and perform the procedures in [Migrate a SQL Server farm](prepare-to-migrate-a-sql-server-farm.md).  
  
2.  Remove any server in your SQL Server farm from the load balancer.  
  
3.  Upgrade the operating system on this server in your SQL Server farm from Windows Server 2008 R2 or Windows Server 2008 to Windows Server 2012. For more information, see [Installing Windows Server 2012](https://technet.microsoft.com/library/jj134246.aspx).  
  
> [!IMPORTANT]
>  As the result of the operating system upgrade, the AD FS configuration on this server is lost and the AD FS 2.0 server role is removed. The Windows Server 2012 AD FS server role is installed instead, but it is not configured. You must manually create the original AD FS configuration and restore the remaining AD FS settings to complete the federation server migration.  
  
4. Create the original AD FS configuration on this server in your SQL Server farm by using AD FS Windows PowerShell cmdlets to add a server to an existing farm.  
  
> [!IMPORTANT]
>  You must use Windows PowerShell to create the original AD FS configuration if you are using SQL Server to store your AD FS configuration database.  

  - Open Windows PowerShell and run the following command: `$fscredential = Get-Credential`.  
  - Enter the name and the password of the service account that you recorded while preparing your SQL Server farm for migration.  
  - Run the following command: `Add-AdfsFarmNode -ServiceAccountCredential $fscredential -SQLConnectionString "Data Source=<Data Source>;Integrated Security=True"`, where `Data Source` is the data source value in the policy store connection string value in the following file: `%programfiles%\Active Directory Federation Services 2.0\Microsoft.IdentityServer.Servicehost.exe.config`.  
  
5. Add the server that you just upgraded to Windows Server 2012 to the load balancer.  
  
6. Repeat steps 2 through 6 for the remaining nodes in your SQL Server farm.  
  
7. When all of the servers in your SQL Server farm are upgraded to Windows Server 2012, restore any remaining AD FS customizations, such as custom attribute stores.  

## Next Steps
 [Prepare to Migrate the AD FS 2.0 Federation Server](prepare-to-migrate-ad-fs-fed-server.md)   
 [Prepare to Migrate the AD FS 2.0 Federation Server Proxy](prepare-to-migrate-ad-fs-fed-proxy.md)   
 [Migrate the AD FS 2.0 Federation Server](migrate-the-ad-fs-fed-server.md)   
 [Migrate the AD FS 2.0 Federation Server Proxy](migrate-the-ad-fs-2-fed-server-proxy.md)   
 [Migrate the AD FS 1.1 Web Agents](migrate-the-ad-fs-web-agent.md)



