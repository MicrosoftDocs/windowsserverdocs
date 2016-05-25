---
title: Join the MultiPoint Server computer to a domain (optional)
ms.custom: na
ms.prod: multipoint-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 623b7c21-dcbb-402e-8b5a-8e434cd225bd
author: cfreemanwa
---
# Join the MultiPoint Server computer to a domain (optional)
If you will access your [!INCLUDE[win8_server_multipoint_2](../Token/win8_server_multipoint_2_md.md)] computer over an Active Directory domain, your next step is to add the computer to the domain. Only [!INCLUDE[win8_server_multipoint-prem_1](../Token/win8_server_multipoint-prem_1_md.md)] can be added to an Active Directory domain. [!INCLUDE[win8_server_multipoint-std_1](../Token/win8_server_multipoint-std_1_md.md)] supports joining a workgroup only.  
  
> [!IMPORTANT]  
> You must verify your time zone before you join the computer to a domain. For instructions, see [Set the date, time, and time zone](../Topic/Set-the-date,-time,-and-time-zone.md).  
  
### To join the [!INCLUDE[win8_server_multipoint_2](../Token/win8_server_multipoint_2_md.md)] computer to a domain  
  
1.  From the **Start** screen, open **Control Panel**. Click **System and Security**, and then click **System**.  
  
    \-Or\-  
  
    Open the computer properties in File Explorer. \(Right\-click **Computer**, and then click **Properties**.\)  
  
2.  Under **Computer name, domain, and workgroup settings**, click **Change settings**.  
  
3.  On the **Computer name** tab, click **Change**.  
  
4.  In the **Computer Name\/Domain Changes** dialog box, select **Domain**, enter the name of the domain, and click **OK**, and then follow the steps in the wizard to complete the process.  
  
5.  After the computer restarts, log on as Administrator and wait for MultiPoint Manager to open.  
  
> [!IMPORTANT]  
> To ensure that your MultiPoint Server domain deployment works correctly, you will need to configure a couple of group policies and update the Registry. For information, see [Configure group policies for a domain deployment](../Topic/Configure-group-policies-for-a-domain-deployment.md).  
  
