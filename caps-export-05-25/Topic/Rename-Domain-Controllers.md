---
title: Rename Domain Controllers
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: d77dfd30-486f-402a-99aa-55f4c15651c4
author: Femila
---
# Rename Domain Controllers
  You can use this procedure to rename domain controllers after a domain rename operation.The Domain Name System \(DNS\) host names of the domain controllers in the renamed domains do not change automatically as a result of the domain rename operation. In other words, the DNS suffix in the fully qualified DNS host name of a domain controller in the renamed domain continues to reflect the old domain name. You can change the DNS host name of domain controllers in a renamed domain at a later time by using a special procedure.  
  
 Modification of the computer name causes updates to the DNS and Active Directory databases. The computer performs these updates automatically. After the updated data propagates to the DNS servers and Active Directory domain controllers that a client computer uses, the client computer can locate and authenticate to the renamed domain controller computer. However, DNS and Active Directory replication latency \(the time that it takes for the name change to replicate throughout the databases\) might cause a temporary inability of clients to locate or authenticate the renamed domain controller. Therefore, renaming a mission\-critical server, such as a domain controller, requires that you follow a computer rename preparation procedure before you rename the domain controller. This preparation procedure ensures that there will be no interruption in the ability of client computers to locate or authenticate the renamed domain controller. For more information about how to rename a domain controller, see [Renaming a Domain Controller](../Topic/Renaming-a-Domain-Controller.md).  
  
> [!NOTE]  
>  If your forest contains Exchange 2003 Service Pack 1 \(SP1\) servers, and you chose to rename domain controllers, you must perform several Exchange\-specific steps to update the Recipient Update Service and DSAccess registry keys. For more information, see Microsoft Exchange Server Domain Rename Fixup \(XDR\-Fixup\) \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=123322](http://go.microsoft.com/fwlink/?LinkID=123322)\).  
  
  