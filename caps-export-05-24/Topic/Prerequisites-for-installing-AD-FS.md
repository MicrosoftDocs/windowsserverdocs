---
title: Prerequisites for installing AD FS
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: bf7f9cf4-6170-40e8-83dd-e636cb4f9ecb
author: femila
---
# Prerequisites for installing AD FS
This topic summarizes AD FS installation permission requirements and other prerequisites, including options to extend the Active Directory schema to create objects and containers that are required to support Device Registration Service \(DRS\) for Active Directory Workplace Join. For more detailed information about deploying AD FS, see [How to deploy AD FS in Windows Server 2012 R2](assetId:///dccc483a-4df5-49bd-bc7a-39b6d42cee4c).  
  
## <a name="BKMK_InstallPermissions"></a>Installation permission requirements  
This section covers permissions that are required to install Active Directory Federation Services \(AD FS\).  
  
-   To install any server role or feature, including the AD FS server role or the Web Application Proxy role service \(part of the Remote Access server role\), you must be a member of the local Administrators group on the target server.  
  
-   To configure AD FS, whether you create a new federation server farm or add nodes to an existing federation server farm, you must be a member of the Domain Admins group in the domain to which the federation server is joined.  
  
-   To configure Web Application Proxy, you must be a member of the local Administrators group on the target server, and you must have the credentials of a local administrator on the AD FS server.  
  
-   To enable the Device Registration Service \(DRS\), you need to be a member of the Enterprise Admins group or the Domain Admins group in the root domain of the forest in order to create the DRS configuration and registered device containers and objects in Active Directory.  
  
    DRS also requires the [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] Active Directory schema. To extend the schema, you must run **adprep \/forestprep**, which requires Schema Admins, Enterprise Admins, and Domain Admins credentials. For more information about how to run **adprep \/forestprep**, see [Running Adprep.exe](http://technet.microsoft.com/library/dd464018(v=ws.10).aspx).  
  
## Hardware and software prerequisites  
The following table lists hardware and software prerequisites.  
  
|||  
|-|-|  
|Hardware|Minimum requirement<br /><br />-   CPU: Single\-core, 1.4 gigahertz \(GHz\) 64\-bit processor<br />-   RAM: 1 GB<br />-   Disk space: 50 MB<br /><br />Recommended configuration:<br /><br />-   CPU: Quad\-core, 2 GHz<br />-   RAM: 4 GB<br />-   Disk space: 100 MB|  
|Certificates|<ul><li>SSL Server Authentication Certificate: This certificate must be trusted publicly \(chained to a public root certification authority\) or explicitly trusted by all computers that require access to the federation service.<br /><br />    You must have both the certificate and its private key available. For example, if you have the certificate and its private key in a .pfx file, you can import the file directly into the Active Directory Federation Services Configuration Wizard. This SSL certificate must contain the following:<br /><br /><ol><li>Subject name or subject alternative name must contain the exact name of your federation service such as **fs.contoso.com** or a matching wildcard expression such as **\*.contoso.com**</li><li>If you plan to use DRS for Active Directory Workplace Join, the subject name or subject alternative name must contain the value **enterpriseregistration** followed by the UPN suffix of your organization. For example, **enterpriseregistration.corp.contoso.com**.<br /><br />        If your organization uses multiple UPN suffixes, the SSL certificate must contain a subject alternative name entry for each suffix.</li></ol></li><li>Token signing and token decryption certificate: By default, a token\-signing certificate and a token decryption certificate are created automatically during the AD FS installation and do not have to be provided by the administrator.<br /><br />    Optionally, certificates that are issued by your corporate certification authority \(CA\) or a third\-party CA can be used for token signing and token encryption certificates, but this configuration option requires that you use Windows PowerShell and not the AD FS Configuration Wizard to create the farm or to add farm nodes. If you choose to use this option, the certificates do not need to be trusted publicly. However, relying party federation servers and applications that consume tokens issued by the federation service will need to trust this certificate as part of their claims provider trust configuration.</li><li>Service Communications Certificate: This certificate is used for scenarios that require message security. This certificate is distinct from the SSL certificate of the federation server. By default, the initial AD FS configuration assigns the certificate that the administrator provides as the SSL certificate to the service communications certificate role. This can be changed after initial AD FS configuration by using the AD FS Management snap\-in. To manage the Service Communications Certificate, use the AD FS Management snap\-in. For more information, see [Set a Service Communications Certificate](http://technet.microsoft.com/library/dd807075.aspx).</li></ul>|  
|Browser|Any web browser with JavaScript capability can work as an AD FS client. JavaScript must be enabled, and cookies must be enabled for browser\-based sign\-in and sign\-out. Support for Transport Layer Security\/Secure Sockets Layer \(TLS\/SSL\) is also required.|  
|Device Registration Service \(DRS\)|To install the DRS, the Active Directory schema must be [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. For more information about how to extend the schema, see [Running Adprep.exe](http://technet.microsoft.com/library/dd464018(v=WS.10).aspx).|  
  
## Updating the AD DS schema to support Device Registration Service  
To create the new containers and objects, the AD DS schema must be extended to the [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] level. For the permissions that are required to update the AD DS schema, see [Installation permission requirements](../Topic/Prerequisites-for-installing-AD-FS.md#BKMK_InstallPermissions). There are three ways to extend the schema:  
  
-   In an existing Active Directory forest, run **adprep \/forestprep** from the \\Support\\Adprep folder of the [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] operating system DVD on any 64\-bit server that runs Windows Server 2008 or later. In this case, no additional domain controller has to be installed, and no existing domain controllers have to be upgraded.  
  
    To run **adprep \/forestprep**, you must be a member of the Schema Admins group, the Enterprise Admins group, and the Domain Admins group of the domain that hosts the schema master.  
  
-   In an existing Active Directory forest, install a domain controller that runs [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. In this case, **adprep \/forestprep** runs automatically as part of the domain controller installation.  
  
    During the domain controller installation, you must enter additional credentials to run **adprep \/forestprep**.  
  
-   Create a new Active Directory forest by installing AD DS on a server that runs [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. In this case, **adprep \/forestprep** does not need to be run because the schema will be initially created with all the necessary containers and objects to support DRS.  
  
    To create a new forest, you must be a member of the Administrators group on the server where you install AD DS.  
  
For more information about Adprep.exe, see [Running Adprep.exe](http://technet.microsoft.com/library/dd464018(v=WS.10).aspx). For a list of objects and containers that are created when the AD DS schema is extended for [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], see the SCH.ldf files that are listed for DRS in [Changes to Adprep](http://technet.microsoft.com/library/jj916254.aspx).  
  
