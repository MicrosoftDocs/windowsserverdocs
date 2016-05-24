---
title: Windows Server 2008 R2: Forest-Wide Updates
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 889bb9d5-c1d0-4856-a646-908080007606
author: Femila
---
# Windows Server 2008 R2: Forest-Wide Updates
  You can review the following list of changes to help understand the schema updates that are performed by **adprep \/forestprep** in [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] and prepare for them. The adprep \/forestprep command must be completed and the changes must replicate throughout the forest before you can add domain controllers that run [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]. For more information about how to run **adprep \/forestprep**, see [Prepare a Windows 2000 or Windows Server 2003 Forest Schema for a Domain Controller That Runs Windows Server 2008 or Windows Server 2008 R2](../Topic/Prepare-a-Windows-2000-or-Windows-Server-2003-Forest-Schema-for-a-Domain-Controller-That-Runs-Windows-Server-2008-or-Windows-Server-2008-R2.md). To determine if **adprep \/forestprep** completed successfully, you can use ADSIEdit to verify the value of the **Revision** attribute of the **ActiveDirectoryUpdate** container. If all the operations that are performed by the **adprep \/forestprep** command in [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] \(79, 80, 81, 82, and 83\) complete successfully, the **Revision** attribute for the CN\=ActiveDirectoryUpdate,CN\=ForestUpdates,CN\=Configuration,DC\=*ForestRootDomain* object is set to 5:  
  
 **Operation 79**: {21ae657c\-6649\-43c4\-bb\-b3\-7f\-18\-4f\-df\-58\-c1}  
  
 Add an access control entry \(ACE\) to the object CN\=Partitions in the Configuration directory partition.  
  
 Permissions:  
  
-   Add \(OA;;RP;5706aeaf\-b940\-4fb2\-bcfc\-5268683ad9fe;;AU\)  
  
 **Operation 80**:{dca8f425\-baae\-47cd\-b4\-24\-e3\-f6\-c7\-6e\-d0\-8b}  
  
 Update display specifier for contact\-Display object to set attribute **treatAsLeaf** default value to TRUE.  
  
 **Operation 81**: {a662b036\-dbbe\-4166\-b4ba\-21abea17f9cc}  
  
 Update display specifiers.  
  
 **Operation 82**: {9d17b863\-18c3\-497d\-9bde\-45ddb95fcb65}  
  
 Add an ACE to the object CN\=Sites in the Configuration directory partition.  
  
 Permissions:  
  
-   Add {OA;CIIO;SW;d31a8757\-2447\-4545\-8081\-3bb610cacbf2;f0f8ffab\-1191\-11d0\-a060\-00aa006c33ed;RO}  
  
 **Operation 83**: {11c39bed\-4bee\-45f5\-b195\-8da0e05b573a}  
  
 Add an ACE to the object CN\=ms\-DS\-Managed\-Service\-Account in the Schema directory partition.  
  
 Permissions:  
  
-   Add {OA;;RP;b7c69e6d\-2cc7\-11d2\-854e\-00a0c983f608;;ED}  
  
 For more information about how to interpret the access control entry \(ACE\) strings, see ACE strings \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=137238](http://go.microsoft.com/fwlink/?LinkId=137238)\). For more information about how to interpret the security ID \(SID\) strings, see SID strings \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=137240](http://go.microsoft.com/fwlink/?LinkId=137240)\).  
  
## See Also  
 [Windows Server 2008 R2: Appendix of Changes to Adprep.exe to Support AD DS](../Topic/Windows-Server-2008-R2--Appendix-of-Changes-to-Adprep.exe-to-Support-AD-DS.md)  
  
  