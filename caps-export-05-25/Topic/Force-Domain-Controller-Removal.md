---
title: Force Domain Controller Removal
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 63498966-d6b0-4b66-8578-9dffe19c3d7c
author: Femila
---
# Force Domain Controller Removal
  You can use this procedure to forcefully remove Active Directory Domain Services \(AD DS\) from a domain controller running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]. On a domain controller that is running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], you can forcefully remove a domain controller even when it can be started only in Directory Services Restore Mode \(DSRM\).  
  
 Typically, you force the removal of a domain controller only if the domain controller has no connectivity with other domain controllers. Because the domain controller cannot contact other domain controllers during the operation, the Active Directory domain and forest metadata is not updated automatically as it is when a domain controller is removed normally. Instead, you must manually update the metadata after you remove the domain controller. For information about performing metadata cleanup, see [Clean Up Server Metadata](../Topic/Clean-Up-Server-Metadata.md).  
  
 You can forcefully remove a domain controller at a command line or by using an answer file. For answer file parameters that you can use to remove AD DS, see Demotion Operation \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=120996](http://go.microsoft.com/fwlink/?LinkId=120996)\).  
  
 Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To force removal of AD DS from a domain controller  
  
1.  Click **Start**, click **Run**, type the following command, and then press ENTER:  
  
     `Dcpromo /forceremoval`  
  
     If the domain controller hosts any operations master \(also known as flexible single master operations or FSMO\) roles or if it is a Domain Name System \(DNS\) server or a global catalog server, warnings appear that explain how the forced removal will affect the rest of the environment. After you read each warning, click **Yes**. To suppress the warnings in advance of the removal operation, type `/demotefsmo:yes` at the command prompt. If you forcefully removal AD DS from a server that hosts an operations master role, you must seize the role after the Dcpromo operation. For information about seizing an operations master role, see [Seizing an operations master role](../Topic/Seizing-an-operations-master-role.md).  
  
2.  On the **Welcome to the Active Directory Domain Services Installation Wizard** page, click **Next**.  
  
3.  On the **Force the Removal of Active Directory Domain Services** page, review the information about forcing the removal of AD DS and metadata cleanup requirements, and then click **Next**.  
  
4.  On the **Administrator Password** page, type and confirm a secure password for the local Administrator account, and then click **Next**.  
  
5.  On the **Summary** page, review your selections. Click **Back** to change any selections, if necessary.  
  
     To save the settings that you selected to an answer file that you can use to automate subsequent AD DS operations, click **Export settings**. Type a name for your answer file, and then click **Save**.  
  
     When you are sure that your selections are accurate, click **Next** to remove AD DS.  
  
6.  You can select **Reboot on completion** to have the server restart automatically, or you can restart the server to complete the AD DS removal when you are prompted to do so.  
  
7.  Perform metadata cleanup, as described in [Clean Up Server Metadata](../Topic/Clean-Up-Server-Metadata.md).  
  
## See Also  
 [Seizing an operations master role](../Topic/Seizing-an-operations-master-role.md)  
  
  