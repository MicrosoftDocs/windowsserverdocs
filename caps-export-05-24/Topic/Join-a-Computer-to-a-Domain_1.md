---
title: Join a Computer to a Domain_1
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: get-started-article
ms.assetid: 41030615-6e02-48df-ab8b-0637e81f72c5
author: billmath
---
# Join a Computer to a Domain_1
For [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)] to function, each computer that you want to configure as a federation server must be joined to a domain.  
  
> [!IMPORTANT]  
> For [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] running on [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] to function, the Active Directory domain must run one of the following operating systems:  
>   
> -   Windows Server 2008  
> -   [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]  
> -   [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]  
> -   [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]  
  
> [!IMPORTANT]  
> If you plan to use a group Managed Service Account \(gMSA\) as the service account for [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)], you must have at least one domain controller in your environment that is running on the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or the [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] operating system.  
  
> [!IMPORTANT]  
> If you plan to deploy Device Registration Service \(DRS\) for AD Workplace Join as a part of your [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] deployment, the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] schema must be updated to the [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] level. There are three ways to update the schema:  
>   
> 1.  In an existing Active Directory forest, run `adprep /forestprep` from the \\Support\\Adprep folder of the [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] operating system DVD on any 64\-bit server that runs Windows Server 2008or later. In this case, no additional domain controller has to be installed, and no existing domain controllers must be upgraded.  
>   
>     To run `adprep /forestprep`, you must be a member of the Schema Admins group, the Enterprise Admins group, and the Domain Admins group of the domain that hosts the schema master.  
> 2.  In an existing Active Directory forest, install a domain controller that runs [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. In this case, `adprep /forestprep` can be run automatically as part of the domain controller installation.  
>   
>     During the domain controller installation, you must provide additional credentials to run `adprep /forestprep`.  
> 3.  Create a new Active Directory forest by installing [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] on a server that runs [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. In this case, `adprep /forestprep` does not have to be run because the schema is initially created with all the necessary containers and objects to support DRS.  
  
Membership in **Administrators**, or equivalent, on the local computer is the minimum requirement to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To join a computer to a domain  
  
1.  [!INCLUDE[clickstart](../Token/clickstart_md.md)]**Control Panel**, and then press Enter.  
  
2.  Navigate to **System and Security**, and then click **System**.  
  
3.  Under **Computer name, domain, and workgroup settings**, click **Change settings**.  
  
4.  On the **Computer Name** tab, click **Change**.  
  
5.  Under **Member of**, click **Domain**, type the name of the domain that this computer joins, and then click **OK**.  
  
6.  Click **OK**, and then restart the computer.  
  
## See Also  
[Deploying a Federation Server Farm](../Topic/Deploying-a-Federation-Server-Farm.md)  
  
