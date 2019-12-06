---
title: Prepare to Migrate the AD FS 2.0 Federation Server Proxy
description: Provides information on getting ready to migrate the AD FS server proxy to Windows Server 2012.
author: billmath
ms.author: billmath
manager: femila
ms.date: 06/28/2017
ms.topic: article
ms.prod: windows-server
ms.technology: identity-adfs
---

# Prepare to Migrate the AD FS 2.0 Federation Server Proxy

To prepare to migrate an AD FS 2.0 federation server proxy to Windows Server 2012, you must export and back up the AD FS configuration data from this server proxy.  The steps in this topic apply to a scenario with one proxy federation server or multiple proxy federation servers.  
  
 To export the AD FS configuration data, perform the following tasks:  
  
-   [Step 1: Export proxy service settings](#step-1-export-proxy-service-settings)  
  
-   [Step 2: Back up webpage customizations](#step-2-back-up-webpage-customizations)  
  
##  Step 1: Export proxy service settings  
 To export federation server proxy service settings, perform the following procedure:  
  
### To export proxy service settings  
  
1.  Export the Secure Sockets Layer (SSL) certificate and its private key to a .pfx file. For more information, see [Export the Private Key Portion of a Server Authentication Certificate](export-the-private-key-portion-of-a-server-authentication-certificate.md).  
  
> [!NOTE]
>  This step is optional because this certificate is preserved during the operating system upgrade.  
  
2. Export AD FS 2.0 federation proxy properties to a file. You can do that by using Windows PowerShell.  
  
Open Windows PowerShell and run the following command to add the AD FS cmdlets to your Windows PowerShell session: `PSH:>add-pssnapin “Microsoft.adfs.powershell”`. Then run the following command to export federation proxy properties to a file: `PSH:> Get-ADFSProxyProperties | out-file “.\proxyproperties.txt”`.  
  
3. Ensure you know the credentials of an account that is either an administrator of the AD FS federation server or the service account under which the AD FS federation service runs.  This information is required for the proxy trust setup.  
  
   Completing this step results in gathering the following information that is required to configure your AD FS federation server proxy:  
  
-   AD FS federation service name  
  
-   Name of the domain account that is required for the proxy trust setup  
  
-   The address and the port of the HTTP proxy (if there is an HTTP proxy between the AD FS federation server proxy and the AD FS federation servers)  
  
##  Step 2: Back up webpage customizations  
 To back up webpage customizations, copy the AD FS proxy webpages and the **web.config** file from the directory that is mapped to the virtual path **“/adfs/ls”** in IIS.  By default, it is in the **%systemdrive%\inetpub\adfs\ls** directory.  
  
## Next Steps
 [Prepare to Migrate the AD FS 2.0 Federation Server](prepare-to-migrate-ad-fs-fed-server.md)   
 [Prepare to Migrate the AD FS 2.0 Federation Server Proxy](prepare-to-migrate-ad-fs-fed-proxy.md)   
 [Migrate the AD FS 2.0 Federation Server](migrate-the-ad-fs-fed-server.md)   
 [Migrate the AD FS 2.0 Federation Server Proxy](migrate-the-ad-fs-2-fed-server-proxy.md)   
 [Migrate the AD FS 1.1 Web Agents](migrate-the-ad-fs-web-agent.md)