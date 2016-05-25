---
title: Windows Server 2008: Read-Only Domain Controller Updates
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: a44358eb-cd5f-4c19-a660-7c92bb7d5480
author: Femila
---
# Windows Server 2008: Read-Only Domain Controller Updates
  The following forest changes are necessary for read\-only domain controller functionality.  
  
> [!NOTE]  
>  During product development, the security ID \(SID\) for the Enterprise Read\-Only Domain Controllers \(ERODC\) group was changed. The reference to the ERODC group in operation 3.5 pertains to the original ERODC SID that is no longer used.  
  
 For more information about how to interpret the access control entry \(ACE\) strings, see ACE strings \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=137238](http://go.microsoft.com/fwlink/?LinkId=137238)\).  
  
 For more information about how to interpret the security ID \(SID\) strings, see SID strings \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=137240](http://go.microsoft.com/fwlink/?LinkId=137240)\).  
  
 **Operation 1:** Not applicable.  
  
 **Operation 2:** Add a set of ACEs to a specific object by using the object's distinguished name.  
  
1.  Add ACEs to directory partitions  
  
2.  \(OA;;CR;1131f6aa\-9c07\-11d1\-f79f\-00c04fc2dcd2;;\<ERODC\-SID\>\)  
  
3.  \(OA;;CR;89e95b76\-444d\-4c62\-991a\-0facbeda640c;;ED\)  
  
4.  \(OA;;CR;89e95b76\-444d\-4c62\-991a\-0facbeda640c;;BA\)  
  
5.  \(OA;;CR;1131f6ae\-9c07\-11d1\-f79f\-00c04fc2dcd2;;ED\)  
  
6.  \(OA;;CR;1131f6ae\-9c07\-11d1\-f79f\-00c04fc2dcd2;;BA\)  
  
7.  \(OA;;CIIO;CRRPWP;91e647de\-d96f\-4b70\-9557\-d63ff4f3ccd8;;PS\)  
  
 **Operation 3:** Remove a set of ACEs to a specific object by using the object's distinguished name.  
  
1.  Remove ACEs from directory partitions  
  
2.  \(OA;;CR;1131f6aa\-9c07\-11d1\-f79f\-00c04fc2dcd2;;S\-1\-5\-22\)  
  
3.  \(OA;;CR;1131f6ad\-9c07\-11d1\-f79f\-00c04fc2dcd2;;S\-1\-5\-22\)  
  
4.  \(A;CIIO;RPLCLOWPRC;;;S\-1\-5\-22\)  
  
5.  \(OA;;CR;1131f6aa\-9c07\-11d1\-f79f\-00c04fc2dcd2;;\<ERODC\-SID\>\)  
  
6.  \(OA;;CR;1131f6ad\-9c07\-11d1\-f79f\-00c04fc2dcd2;;\<ERODC\-SID\>\)  
  
7.  \(A;CIIO;RPLCLOWPRC;;;\<ERODC\-SID\>\)  
  
8.  \(OA;;CR;89e95b76\-444d\-4c62\-991a\-0facbeda640c;;\<ERODC\-SID\>\)  
  
## See Also  
 [Windows Server 2008: Appendix of Changes to Adprep.exe to Support AD DS](../Topic/Windows-Server-2008--Appendix-of-Changes-to-Adprep.exe-to-Support-AD-DS.md)  
  
  