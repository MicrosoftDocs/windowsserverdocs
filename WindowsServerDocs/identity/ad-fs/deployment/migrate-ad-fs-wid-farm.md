---
title: Migrate an AD FS 2.0 federation server WID farm
description: Provides information on migrating an AD FS 2.0 server WID farm to Windows Server 2012
author: billmath
ms.author: billmath
manager: femila
ms.date: 06/28/2017
ms.topic: article
ms.prod: windows-server-threshold
ms.technology: identity-adfs
---


# Migrate an AD FS 2.0 WID farm  
This document provides detailed information on migrating an AD FS 2.0 Windows Internal Database (WID) farm to Windows Server 2012.

## Migrate an AD FS WID farm
To migrate a WID farm to Windows Server 2012, perform the following procedure:  
  
1.  For every node (server) in the WID farm, review and perform the procedures in [Prepare to migrate a WID farm](prepare-to-migrate-a-wid-farm.md).  
  
2.  Remove any non-primary nodes from the load balancer.  
  
3.  Upgrade of the operating system on this server from Windows Server 2008 R2 or Windows Server 2008 to Windows Server 2012. For more information, see [Installing Windows Server 2012](https://technet.microsoft.com/library/jj134246.aspx).  
  
> [!IMPORTANT]
>  As the result of the operating system upgrade, the AD FS configuration on this server is lost and the AD FS 2.0 server role is removed. The Windows Server 2012 AD FS server role is installed instead, but it is not configured. You must create the original AD FS configuration and restore the remaining AD FS settings to complete the federation server migration.  
  
4. Create the original AD FS configuration on this server.  
  
You can create the original AD FS configuration by using the **AD FS Federation Server Configuration Wizard** to add a federation server to a WID farm. For more information, see [Add a Federation Server to a Federation Server Farm](add-a-federation-server-to-a-federation-server-farm.md).  
  
> [!NOTE]
> When you reach the **Specify the Primary Federation Server and a Service Account** page in the **AD FS Federation Server Configuration Wizard**, enter the name of the primary federation server of the WID farm and be sure to enter the service account information that you recorded while preparing for the AD FS migration. For more information, see [Prepare to Migrate the AD FS 2.0 Federation Server](prepare-to-migrate-a-wid-farm.md). 
>  
> When you reach the **Specify the Federation Service Name** page, be sure to select the same SSL certificate you recorded in the “Prepare to migrate a WID farm” in [Prepare to Migrate the AD FS 2.0 Federation Server](prepare-to-migrate-a-wid-farm.md).  
  
5. Update your AD FS webpages on this server. If you backed up your customized AD FS webpages while preparing for the migration, you need to use your backup data to overwrite the default AD FS webpages that were created by default in the **%systemdrive%\inetpub\adfs\ls** directory as a result of the AD FS configuration on Windows Server 2012.  
  
6. Add the server that you just upgraded to Windows Server 2012 to the load balancer.  
  
7. Repeat steps 1 through 6 for the remaining secondary servers in your WID farm.  
  
8. Promote one of the upgraded secondary servers to be the primary server in your WID farm. To do this, open Windows PowerShell and run the following command: `PSH:> Set-AdfsSyncProperties –Role PrimaryComputer`.  
  
9. Remove the original primary server of your WID farm from the load balancer.  
  
10. Demote the original primary server in your WID farm to be a secondary server by using Windows PowerShell. Open Windows PowerShell and run the following command to add the AD FS cmdlets to your Windows PowerShell session: `PSH:>add-pssnapin “Microsoft.adfs.powershell”`. Then run the following command to demote the original primary server to be a secondary server: `PSH:> Set-AdfsSyncProperties – Role SecondaryComputer –PrimaryComputerName <FQDN of the Primary Federation Server>`.  
  
11. Upgrade of the operating system on this last node (server) in your WID farm from Windows Server 2008 R2 or Windows Server 2008 to Windows Server 2012. For more information, see [Installing Windows Server 2012](https://technet.microsoft.com/library/jj134246.aspx).  
  
> [!IMPORTANT]
>  As the result of upgrading the operating system, the AD FS configuration on this server is lost and the AD FS 2.0 server role is removed. The Windows Server 2012 AD FS server role is installed instead, but it is not configured. You must manually create the original AD FS configuration and restore the remaining AD FS settings to complete the federation server migration.  
  
12. Create the original AD FS configuration on this last node (server) in your WID farm.  
  
You can create the original AD FS configuration by using the **AD FS Federation Server Configuration Wizard** to add a federation server to a WID farm. For more information, see [Add a Federation Server to a Federation Server Farm](add-a-federation-server-to-a-federation-server-farm.md).  
  
> [!NOTE]
> When you reach the **Specify the Primary Federation server and a Service Account** page in the **AD FS Federation Server Configuration Wizard**, enter the service account information that you recorded while preparing for the AD FS migration. For more information, see [Prepare to Migrate the AD FS 2.0 Federation Server](prepare-to-migrate-a-wid-farm.md). 
>  
> When you reach the **Specify the Federation Service Name** page, be sure to select the same SSL certificate you recorded in [Prepare to Migrate the AD FS 2.0 Federation Server](prepare-to-migrate-a-wid-farm.md).  
  
13. Update your AD FS webpages on this last server in your WID farm. If you backed up your customized AD FS webpages while preparing for the migration, use your backup data to overwrite the default AD FS webpages that were created by default in the **%systemdrive%\inetpub\adfs\ls** directory as a result of the AD FS configuration on Windows Server 2012.  
  
14. Add this last server of your WID farm that you just upgraded to Windows Server 2012 to the load balancer.  
  
15. Restore any remaining AD FS customizations, such as custom attribute stores.  
  
## Next Steps
 [Prepare to Migrate the AD FS 2.0 Federation Server](prepare-to-migrate-ad-fs-fed-server.md)   
 [Prepare to Migrate the AD FS 2.0 Federation Server Proxy](prepare-to-migrate-ad-fs-fed-proxy.md)   
 [Migrate the AD FS 2.0 Federation Server](migrate-the-ad-fs-fed-server.md)   
 [Migrate the AD FS 2.0 Federation Server Proxy](migrate-the-ad-fs-2-fed-server-proxy.md)   
 [Migrate the AD FS 1.1 Web Agents](migrate-the-ad-fs-web-agent.md)