---
title: Adding Domain Controllers in Remote Sites
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 3358a310-0957-43c6-a696-6d9e98b171c7
author: Femila
---
# Adding Domain Controllers in Remote Sites
  You can create an additional domain controller in a domain by installing Active Directory Domain Services \(AD DS\) on a server computer. When you are placing the additional domain controller in a remote site, you can install AD DS on the server either before or after you ship it to the remote site, as follows:  
  
-   Ship the computer as a workgroup computer, and install AD DS on it in the remote site. If you do not have administrative support in the remote site, enable Remote Desktop on the computer before you ship the computer so that you can perform the installation remotely. In the remote site, you can either:  
  
    -   Install AD DS from installation media that has been shipped to the site on removable media.  
  
    -   Install AD DS over the network.  
  
-   Install AD DS on the server in a hub or staging site, and then ship the installed domain controller to the remote site.  
  
 Both methods have advantages and disadvantages, and both methods require care to ensure the secure transfer of Active Directory data, whether it is installed or in the form of removable media.  
  
 For information about the advantages and disadvantages of shipping a server to a remote site before or after installing AD DS, see [Known Issues for Adding Domain Controllers in Remote Sites](../Topic/Known-Issues-for-Adding-Domain-Controllers-in-Remote-Sites.md).  
  
 For recommended practices for adding domain controllers to remote sites for the method that you are using, see [Best Practices for Adding Domain Controllers in Remote Sites](../Topic/Best-Practices-for-Adding-Domain-Controllers-in-Remote-Sites.md).  
  
 By reviewing issues and guidelines, you can decide the best method of adding domain controllers in remote sites for your environment. By following the instructions in this guide, you can safely and securely install domain controllers in remote sites, either locally or remotely.  
  
> [!NOTE]  
>  On servers that are running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], you can install a read\-only domain controller \(RODC\), which is ideal for providing AD DS in remote sites without incurring the security risks of a writable domain controller. For information about installing and managing RODCs in remote sites, see Planning and Deploying Read\-Only Domain Controllers \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=120709](http://go.microsoft.com/fwlink/?LinkID=120709)\).  
  
 This section includes the following tasks, known issues, and best practices for adding domain controllers in remote sites:  
  
-   [Known Issues for Adding Domain Controllers in Remote Sites](../Topic/Known-Issues-for-Adding-Domain-Controllers-in-Remote-Sites.md)  
  
-   [Best Practices for Adding Domain Controllers in Remote Sites](../Topic/Best-Practices-for-Adding-Domain-Controllers-in-Remote-Sites.md)  
  
-   [Preparing a Server Computer for Shipping and Installation from Media](../Topic/Preparing-a-Server-Computer-for-Shipping-and-Installation-from-Media.md)  
  
-   [Preparing an Existing Domain Controller for Shipping and Long-Term Disconnection](../Topic/Preparing-an-Existing-Domain-Controller-for-Shipping-and-Long-Term-Disconnection.md)  
  
-   [Reconnecting a Domain Controller After a Long-Term Disconnection](../Topic/Reconnecting-a-Domain-Controller-After-a-Long-Term-Disconnection.md)  
  
  