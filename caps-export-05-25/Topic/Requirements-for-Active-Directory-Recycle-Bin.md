---
title: Requirements for Active Directory Recycle Bin
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 27ca48a1-2af8-422f-aabe-7a933bc33041
author: Femila
---
# Requirements for Active Directory Recycle Bin
By default, Active Directory Recycle Bin in [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] is disabled. To enable Active Directory Recycle Bin, your environment must meet the requirements in the following sections.  
  
## Active Directory Domain Services environment  
Do the following before you enable Active Directory Recycle Bin in an Active Directory Domain Services \(AD DS\) environment:  
  
-   Run Adprep to update your Active Directory schema with the necessary Active Directory Recycle Bin attributes. Membership in the Schema Admins group is the minimum required to complete the following Adprep tasks:  
  
    > [!IMPORTANT]  
    > If you are performing a clean installation of a [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] Active Directory forest, you do not have to run Adprep and your Active Directory schema will automatically contain all the necessary attributes for the Active Directory Recycle Bin to function properly. If, however, you are introducing a [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] domain controller into your existing Windows Server 2003 or Windows Server 2008 forest and, subsequently, upgrading the rest of the domain controllers to [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], you must run Adprep to update your Active Directory schema with the attributes that are necessary for Active Directory Recycle Bin to function correctly.  
  
    -   Prepare the forest by running the **adprep \/forestprep** command on the server that holds the schema master operations master \(also known as flexible single master operations or FSMO\) role to update the schema.  
  
    -   Prepare the domain by running the **adprep \/domainprep \/gpprep** command on the server that holds the infrastructure operations master role.  
  
    -   If a read\-only domain controller \(RODC\) is present in your AD DS environment, you must also run the **adprep \/rodcprep** command.  
  
-   Make sure that all domain controllers in your Active Directory forest are running [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)].  
  
-   Raise the functional level of your Active Directory forest to [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)].  
  
## Active Directory Lightweight Directory Services environment  
Do the following before you enable Active Directory Recycle Bin in an Active Directory Lightweight Directory Services \(AD LDS\) environment:  
  
-   Upgrade the schema of your AD LDS configuration set with the necessary Active Directory Recycle Bin attributes by running the following command:  
  
    `Ldifde.exe –i –f MS-ADAM-Upgrade-2.ldf –s server:port –b username domain password –j . -$ adamschema.cat`  
  
    > [!NOTE]  
    > If you are upgrading your environment to [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], you can upgrade the schema first and then upgrade the operating system. If you select this approach, you will have to first locate and download the necessary MS\-ADAM\-Upgrade\-2.ldf and adamschema.cat files. Or you can do the reverse: upgrade the operating system first and then upgrade the schema. This is the recommended approach, because both MS\-ADAM\-Upgrade\-2.ldf and adamschema.cat are available in [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] in the C:\\Windows\\ADAM directory.  
  
-   Make sure that all servers hosting the instances of your AD LDS configuration set are running [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)].  
  
-   Raise the functional level of your AD LDS configuration set to [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] or higher. To do this using ADSIEdit:  
  
    1.  Open ADSIEdit, click **Action** and click **Connect to**.  
  
    2.  In **Connection Point**, click **Select a well known Naming Context:** and choose **Configuration** and in **Computer**, click **Select or type a domain or server:** and then type **Localhost:50000** or an alternative server name and port that you chose during the AD LDS installation, and then click **OK**.  
  
    3.  Double\-click **Configuration \[Localhost:50000\]**, double\-click **CN\=Configuration,CN\={***GUID***}**, right\-click **CN\=Partitions**, and click **Properties**.  
  
    4.  Select **msDS\-Behavior\-Version** and click **Edit**.  
  
    5.  Type a value of **4** to raise the functional level to Windows Server 2008 R2 or **5** to raise it to Windows Server 2012, and click **OK** twice.  
  
