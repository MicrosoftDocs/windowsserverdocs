---
title: Rename a Domain Controller Using System Properties
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 84ec4e53-4369-4fa1-8e1c-40433a30921e
author: Femila
---
# Rename a Domain Controller Using System Properties
  You can use this procedure to rename a domain controller by using the System Properties graphical user interface \(GUI\). Be aware, this option is not preferred. You should instead [use Netdom.exe](http://technet.microsoft.com/library/cc816601(v=ws.10).aspx) to do the rename. For more information about both options, see [Renaming a Domain Controller](http://technet.microsoft.com/library/cc794951(v=ws.10).aspx).  
  
 The corresponding nTFRSMember or msDFSR\-Member object is not renamed automatically, but the reference attributes are correctly set so SYSVOL replication is not impacted. The only potential problem with not renaming these objects is that if another domain controller is created at a later date with the same NetBIOS name of the old domain controller, then a conflict can occur as described in [KB article 316826](http://support.microsoft.com/kb/316826). After the rename is complete, you can optionally [rename the nTFRSMember or msDFSR\-Member object](http://technet.microsoft.com/library/cc794759(v=ws.10).aspx) as part of cleanup.  
  
 Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To rename a domain controller using System Properties  
  
1.  In **Server Manager**, click **Change System Properties**.  
  
2.  On the **Computer Name** tab, click **Change**.  
  
3.  Click **OK** to acknowledge that renaming the domain controller may cause it to become temporarily unavailable to users and computers.  
  
    > [!NOTE]  
    >  Renaming a domain controller in this way may result in Active Directory replication latency, making it more difficult for clients to locate or authenticate the domain controller under its new name.  
  
4.  Under **Computer Name**, type the new name, and then click **OK**.  
  
5.  Click **OK** to close the **System Properties** dialog box.  
  
6.  If you are prompted, provide the user name and password for an account with Domain Admin or Enterprise Admin credentials.  
  
## See Also  
 [Rename a Domain Controller Using Netdom](../Topic/Rename-a-Domain-Controller-Using-Netdom.md)  
  
  