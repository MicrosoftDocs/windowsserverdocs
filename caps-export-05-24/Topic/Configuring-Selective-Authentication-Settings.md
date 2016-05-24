---
title: Configuring Selective Authentication Settings
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 04ab9d47-7501-4d70-af1d-749ad4ecef82
author: Femila
---
# Configuring Selective Authentication Settings
  Trusts that are created between Windows Server 2008 forests can use legacy authentication settings \(settings that were used in Windows 2000 Server\) or selective authentication. Selective authentication is a security setting that can be enabled on external trusts and forest trusts between Windows Server 2003 forests and Windows Server 2008 forests, in any combination. Selective authentication provides Active Directory administrators who manage a trusting forest more control over which groups of users in a trusted forest can access shared resources in the trusting forest. Because creating an external trust or forest trust provides a pathway for all authentication requests between the forests, this increased control is especially important when administrators need to grant access to shared resources in their organization’s forest to a limited set of users in another organization’s forest.  
  
 For more information about how selective authentication settings work, see Security Considerations for Trusts \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=111846](http://go.microsoft.com/fwlink/?LinkID=111846)\).  
  
 **Task requirements**  
  
 Either of the following tools is required to perform the procedures for this task:  
  
-   Active Directory Domains and Trusts  
  
-   Netdom.exe  
  
 For more information about how to use the Netdom command\-line tool to configure selective authentication settings, see Netdom Overview \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=111537](http://go.microsoft.com/fwlink/?LinkId=111537)\).  
  
 To complete this task, you can perform the following procedures:  
  
-   [Enable Selective Authentication over an External Trust](../Topic/Enable-Selective-Authentication-over-an-External-Trust.md)  
  
-   [Enable Selective Authentication over a Forest Trust](../Topic/Enable-Selective-Authentication-over-a-Forest-Trust.md)  
  
-   [Enable Domain-Wide Authentication over an External Trust](../Topic/Enable-Domain-Wide-Authentication-over-an-External-Trust.md)  
  
-   [Enable Forest-Wide Authentication over a Forest Trust](../Topic/Enable-Forest-Wide-Authentication-over-a-Forest-Trust.md)  
  
-   [Grant the Allowed to Authenticate Permission on Computers in the Trusting Domain or Forest](../Topic/Grant-the-Allowed-to-Authenticate-Permission-on-Computers-in-the-Trusting-Domain-or-Forest.md)  
  
  