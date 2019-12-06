---
title: Migrate the AD FS 2.0 federation server proxy
description: Provides information on migrating the AD FS federation server proxy to Windows Server 2012.
author: billmath
ms.author: billmath
manager: femila
ms.date: 06/28/2017
ms.topic: article
ms.prod: windows-server
ms.technology: identity-adfs
---

# Migrate the AD FS 2.0 federation server proxy
This document provides detailed information on migrating an AD FS 2.0 federation proxy server to Windows Server 2012.

## Migrate the proxy

To migrate an AD FS 2.0 federation server proxy to Windows Server 2012, perform the following procedure:  
  
1.  For every federation server proxy that you plan to migrate to Windows Server 2012, review and perform the procedures in [Prepare to Migrate the AD FS 2.0 Federation Server Proxy](prepare-to-migrate-ad-fs-fed-proxy.md).  
  
2.  Remove a federation server proxy from the load balancer.  
  
3.  Perform an in-place upgrade of the operating system on this server from Windows Server 2008 R2 or Windows Server 2008 to Windows Server 2012. For more information, see [Installing Windows Server 2012](https://technet.microsoft.com/library/jj134246.aspx).  
  
> [!IMPORTANT]
>  As the result of the operating system upgrade, the AD FS proxy configuration on this server is lost and the AD FS 2.0 server role is removed. The Windows Server 2012 AD FS server role is installed instead, but it is not configured. You must manually create the original AD FS proxy configuration and restore the remaining AD FS proxy settings to complete the federation server proxy migration.  
  
4. Create the original AD FS proxy configuration by using the **AD FS Federation Server Proxy Configuration Wizard**. For more information, see [Configure a Computer for the Federation Server Proxy Role](configure-a-computer-for-the-federation-server-proxy-role.md). As you execute the wizard, use the information you gathered in Prepare to Migrate the AD FS 2.0 Federation Server Proxy as follows:  
  
 
|**Federation Server Proxy Wizard input option**|**Use the following value**|
|-----|-----|  
|**Federation Service Name**|Enter the BaseHostName value from proxyproperties.txt file|  
|**Use an HTTP proxy server when sending requests to this Federation** Service check box|Check this box if your proxyproperties.txt file contains a value for the ForwardProxyUrl property|  
|**HTTP proxy server address**|Enter the ForwardProxyUrl value from proxyproperties.txt file|  
|Credential prompt|Enter the credentials of an account that is either an administrator of the AD FS federation server or the service account under which the AD FS federation service runs.|  
  
5. Update your AD FS webpages on this server. If you backed up your customized AD FS proxy webpages while preparing your federation server proxy for the migration, use your backup data to overwrite the default AD FS webpages that were created by default in the **%systemdrive%\inetpub\adfs\ls** directory as a result of the AD FS proxy configuration in Windows Server 2012.  
  
6. Add this server back to the load balancer.  
  
7. If you have other AD FS 2.0 federation server proxies to migrate, repeat steps 2 through 6 for the remaining federation server proxy computers.  
  
  
## Next Steps
 [Prepare to Migrate the AD FS 2.0 Federation Server](prepare-to-migrate-ad-fs-fed-server.md)   
 [Prepare to Migrate the AD FS 2.0 Federation Server Proxy](prepare-to-migrate-ad-fs-fed-proxy.md)   
 [Migrate the AD FS 2.0 Federation Server](migrate-the-ad-fs-fed-server.md)   
 [Migrate the AD FS 2.0 Federation Server Proxy](migrate-the-ad-fs-2-fed-server-proxy.md)   
 [Migrate the AD FS 1.1 Web Agents](migrate-the-ad-fs-web-agent.md)