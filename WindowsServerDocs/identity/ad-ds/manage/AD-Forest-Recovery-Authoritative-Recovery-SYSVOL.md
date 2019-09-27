---
title: AD Forest Recovery - Authoritative sync of SYSVOL
description:
ms.author: joflore
author: MicrosoftGuyJFlo
manager: mtillman
ms.date: 08/09/2018
ms.topic: article
ms.prod: windows-server
ms.assetid: 38a1c543-c76d-4b8e-a06b-53742aaa172f
ms.technology: identity-adds
---
# AD Forest Recovery - Performing an authoritative synchronization of DFSR-replicated SYSVOL  

>Applies To: Windows Server 2016, Windows Server 2012 and 2012 R2, Windows Server 2008 and 2008 R2

There are different ways to perform an authoritative restore of SYSVOL. You can either edit the **msDFSR-Options** attribute or perform a system state restore using wbadmin –authsysvol. If you have the option to restore a system state backup (that is, you are restoring AD DS to the same hardware and operating system instance) then using wbadmin –authsysvol is simpler. But if you need to perform a bare metal restore, then you need to edit the **msDFSR-Options** attribute.  

Use the following steps to perform an authoritative synchronization of SYSVOL (if it is replicated using DFSR) by editing the **msDFSR-Options** attribute. If SYSVOL is replicated using FRS, see [article 290762](https://go.microsoft.com/fwlink/?LinkId=148443).  

## To perform an authoritative synchronization of DFSR-replicated SYSVOL  

1. Open Active Directory Users and Computers.  
2. Click **View**, and then select **Users, Contacts, Groups, and Computers as containers** and **Advanced Features**. 

   ![SYSVOL](media/AD-Forest-Recovery-Authoritative-Recovery-SYSVOL/sysvol1.png) 

3. In the tree-view, click **Domain Controllers**, the name of the DC you restored, **DFSR-LocalSettings**, and then **Domain System Volume**. 

   ![SYSVOL](media/AD-Forest-Recovery-Authoritative-Recovery-SYSVOL/sysvol2.png)  

4. In the Details pane, right-click **SYSVOL Subscription**, click **Properties**, and click **Attribute Editor**.  

   ![SYSVOL](media/AD-Forest-Recovery-Authoritative-Recovery-SYSVOL/sysvol3.png) 

5. Click **msDFSR-Options**, click **Edit**, type **1**, and click **OK**  

   ![SYSVOL](media/AD-Forest-Recovery-Authoritative-Recovery-SYSVOL/sysvol4.png) 

6. Click **OK** to close the Attribute Editor.  
  
## Next Steps

- [AD Forest Recovery Guide](AD-Forest-Recovery-Guide.md)
- [AD Forest Recovery - Procedures](AD-Forest-Recovery-Procedures.md)
