---
title: Relocate Folder Redirection and Roaming User Profiles
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 7a361812-80a9-451e-bbbb-a0a9b0d277ee
author: Femila
---
# Relocate Folder Redirection and Roaming User Profiles
  If you are using Folder Redirection or roaming user profiles, you might need to relocate the network paths for them before the domain rename operation. If you place Folder Redirection or roaming user profiles \(and the home directory\) on a network location by using a domain\-based, Distributed File System \(DFS\) namespace, renaming the domain invalidates the path to this domain\-based namespace, and Folder Redirection or roaming user profiles that use this path stop working. For roaming user profiles, this prevents user logons until the paths are fixed.  
  
 However, if the NetBIOS name of a domain is used to connect to a domain\-based DFS namespace and the NetBIOS name of the domain is not changed during a domain rename operation, the path to the domain\-based DFS namespace continues to be valid. The same is true for the fully qualified domain name \(FQDN\); if the FQDN name of a domain is used to connect to a domain\-based DFS namespace and the FQDN name of the domain is not changed during a domain rename operation, the path to the domain\-based DFS namespace continues to be valid. If you are not using DFS namespaces at all and paths are not specified to server names using FQDNs, the paths will continue to be valid.  
  
 The following table lists some examples where the path to a domain\-based DFS namespace remains valid after a domain rename and where it must be updated. In these examples, the FQDN of the existing domain is Contoso.com and the NetBIOS name is CORP\-DOM.  
  
|New domain name|DFS paths|Server paths|  
|---------------------|---------------|------------------|  
|New FQDN name:<br /><br /> Tailspintoys.com|DFS path that does not have to be updated:<br /><br /> \\\\CORP\-DOM\\profiles\\department\\%username%<br /><br /> DFS path that has to be updated:<br /><br /> \\\\CONTOSO.COM\\profiles\\department\\%username%|Server path that does not have to be updated:<br /><br /> \\\\CON\-FIL01\\profiles\\department\\%username%<br /><br /> Server path that has to be updated:<br /><br /> \\\\CON\-FIL01.CONTOSO.COM\\profiles\\department\\%username%|  
|New NETBIOS name:<br /><br /> CONTOSO\-DOM|DFS path that does not have to be updated:<br /><br /> \\\\CONTOSO.COM\\profiles\\department\\%username%<br /><br /> DFS path that has to be updated:<br /><br /> \\\\CONTOSO\-DOM\\profiles\\department\\%username%|Server path that does not have to be updated:<br /><br /> \\\\CON\-FIL01.CONTOSO.COM\\profiles\\department\\%username%<br /><br /> Another server path that does not have to be updated:<br /><br /> \\\\CON\-FIL01\\profiles\\department\\%username%|  
|New FQDN name:<br /><br /> TAILSPINTOYS.COM<br /><br /> New NETBIOS name:<br /><br /> CONTOSO\-DOM|DFS path that has to be updated:<br /><br /> \\\\CONTOSO\-DOM\\profiles\\department\\%username%<br /><br /> Another DFS path that has to be updated:<br /><br /> \\\\CONTOSO.COM\\profiles\\department\\%username%|Server path that does not have to be updated:<br /><br /> \\\\CON\-FIL01\\profiles\\department\\%username%<br /><br /> Server path that has to be updated:<br /><br /> \\\\CON\-FIL01.CONTOSO.COM\\profiles\\department\\%username%|  
  
 If the domain rename operation will change both the NetBIOS name and the FQDN, you have to decide how to relocate the network paths to a domain\-based DFS namespace for Folder Redirection or roaming user profiles. You can relocate them to a new domain\-based DFS namespace that matches the new name of the domain, or you can relocate them to a stand\-alone DFS namespace.  
  
 In general, relocating the network paths to a new domain\-based DFS namespace is a recommended long\-term solution. But in the case of roaming user profiles, users are unable to log on until the domain rename operation is complete. To minimize the downtime for users of computers that run Windows Vista or Windows 7, you can use Group Policy to set the new network paths.  
  
 If your client computers are running a version of Windows earlier than Windows Vista or if the potential downtime during the domain rename operation is unacceptable, you can relocate the network paths to a stand\-alone DFS namespace that is hosted on a Windows Failover Cluster. This option provides these additional advantages:  
  
-   You can build the name hierarchy in advance to match the domain\-based DFS namespace structure.  
  
-   You make uniform changes to user properties for a smooth transition.  
  
-   You can move over the user paths without copying data, which can easily be hundreds of gigabytes \(GBs\).  
  
-   After the domain rename is complete, you can move back to a new domain\-based DFS namespace in the same way.  
  
  