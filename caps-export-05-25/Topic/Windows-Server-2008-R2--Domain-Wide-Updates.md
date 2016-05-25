---
title: Windows Server 2008 R2: Domain-Wide Updates
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: fdf03048-8b01-48fd-bb8f-03ab047dbf15
author: Femila
---
# Windows Server 2008 R2: Domain-Wide Updates
  If the operation that is performed by the **domainprep** command in [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] \(operations 75, 76, and 77\) complete successfully, the **revision** attribute for the CN\=ActiveDirectoryUpdate,CN\=DomainUpdates,CN\=System,DC\=ForestRootDomain object is set to 5:  
  
 **Operation 75**: {5e1574f6\-55df\-493e\-a6\-71\-aa\-ef\-fc\-a6\-a1\-00}  
  
 Create the following object:  
  
-   CN\=Managed Service Accounts  
  
 Attributes:  
  
-   objectClass: Container  
  
-   Description: Default container for managed services accounts  
  
-   ShowInAdvancedViewOnly: FALSE  
  
 Permissions:  
  
-   \(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;SY\)  
  
-   \(A;;RPWPCRCCDCLCLORCWOWDSW;;;DA\)  
  
-   \(OA;;CCDC;ce206244\-5827\-4a86\-ba1c\-1c0c386c1b64;;AO\)  
  
-   OA;;CCDC;bf967aba\-0de6\-11d0\-a285\-00aa003049e2;;AO\)  
  
-   \(OA;;CCDC;bf967a9c\-0de6\-11d0\-a285\-00aa003049e2;;AO\)  
  
-   \(A;;RPLCLORC;;;AU\)  
  
 **Operation 76**: {d262aae8\-41f7\-48ed\-9f\-35\-56\-bb\-b6\-77\-57\-3d}  
  
 Add the following value to the multivalued attribute **otherWellKnownObject** of the domain directory partition:  
  
-   B:32:1EB93889E40C45DF9F0C64D23BBB6237:CN\=Managed Service Accounts,\<*distinguished name of the domain*\>  
  
 **Operation 77**: {82112ba0\-7e4c\-4a44\-89d9\-d46c9612bf91}  
  
 Create the follow object:  
  
-   CN\=PSPs,CN\=System  
  
 Attributes:  
  
-   objectClass: msImaging\-PSPs  
  
 For more information about how to interpret the access control entry \(ACE\) strings, see ACE strings \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=137238](http://go.microsoft.com/fwlink/?LinkId=137238)\).  
  
 For more information about how to interpret the security ID \(SID\) strings, see SID strings \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=137240](http://go.microsoft.com/fwlink/?LinkId=137240)\).  
  
## See Also  
 [Windows Server 2008 R2: Appendix of Changes to Adprep.exe to Support AD DS](../Topic/Windows-Server-2008-R2--Appendix-of-Changes-to-Adprep.exe-to-Support-AD-DS.md)  
  
  