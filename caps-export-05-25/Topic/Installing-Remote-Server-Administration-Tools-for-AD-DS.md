---
title: Installing Remote Server Administration Tools for AD DS
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 610ba7d9-51b5-4e14-9232-0510a9091aba
author: Femila
---
# Installing Remote Server Administration Tools for AD DS
  When you install Active Directory Domain Services \(AD DS\) on a computer to create a domain controller, the administrative tools that you use to manage AD DS on the domain controller are installed automatically. If you want to manage domain controllers remotely from a computer that is not a domain controller, you can install Remote Server Administration Tools \(RSAT\) on a member server that is running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]. You can also install RSAT on a computer that is running Windows Vista with Service Pack 1 \(SP1\) or on a computer that is running [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)]. The RSAT component that you use to manage AD DS is Active Directory Domain Services Tools.  
  
## Installing Active Directory Domain Services Tools on a member server that is running Windows Server 2008 or Windows Server 2008 R2  
 You can use the following procedure to add the Active Directory Domain Services Tools component of RSAT to a member server.  
  
 Membership in **Administrators**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[gen_win7_review_details](../Token/gen_win7_review_details_md.md)]  
  
#### To install Active Directory Domain Services Tools on a member server  
  
1.  Open Server Manager. To open Server Manager, on the **Start** menu, click **Administrative Tools**, and then click **Server Manager**.  
  
2.  In the console tree, right\-click **Features**, and then click **Add Features**.  
  
3.  In **Features**, expand **Remote Service Administration Tools** and **Role Administration Tools**:  
  
    1.  On a Windows Server 2008 member server, expand **Active Directory Domain Services Tools**, and then click **Active Directory Domain Controllers Tools**.  
  
    2.  On a [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] member server, expand **AD DS and AD LDS Tools**, expand **AD DS Tools**, and then click **AD DS Snap\-Ins and Command\-Line Tools**.  
  
4.  Click **Next**, review the installation information, and then click **Install**.  
  
5.  If you are prompted to restart the computer, restart it before you continue with the next step. Click **Yes** to restart the server, or click **No** to restart the server later.  
  
6.  After the server restarts, on the **Installation Results** page of the Resume Configuration Wizard, click **Close**. The Active Directory Domain Services Administration Tools are available on the **Administrative Tools** menu.  
  
## Installing Active Directory Domain Services Tools on a computer that is running Windows Vista with SP1  
 [!INCLUDE[nextref_vista_SP1](../Token/nextref_vista_SP1_md.md)] does not ship with the RSAT installation file. You must first download the appropriate RSAT installation file. For instructions and links to the download locations for the tools, see [article 931314](http://go.microsoft.com/fwlink/?LinkID=116179) in the Microsoft Knowledge Base \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=116179\).  
  
## Installing Active Directory Domain Services Tools on a computer that is running Windows 7  
 [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)] does not ship with RSAT installation files. You must first download the RSAT installation file. For instructions and links to the download locations for the tools, see [Remote Server Administration Tools for Windows 7](http://go.microsoft.com/fwlink/?LinkId=167131) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=167131\).  
  
  