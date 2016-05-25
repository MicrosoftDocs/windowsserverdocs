---
title: Enable Remote Desktop
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: b2defa08-2121-4b42-917f-7e5273a1d6fc
author: Femila
---
# Enable Remote Desktop
  You can use this procedure to enable Remote Desktop on the server that you are installing as a domain controller so that service administrators can manage the domain controller remotely. Remote Desktop is disabled by default in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)].  
  
 You can enable Remote Desktop on the [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] server directly, or you can enable it remotely from another server or workstation computer.  
  
 Membership in local **Administrators**, or equivalent, is the minimum required to complete these procedures if Active Directory Domain Services \(AD DS\) is not installed. Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure if AD DS is installed. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To enable Remote Desktop locally by using Server Manager  
  
1.  Open Server Manager. To open Server Manager, click **Start**, point to **Administrative Tools**, and then click **Server Manager**.  
  
2.  In **Computer Information**, click **Configure Remote Desktop**.  
  
3.  In the **System Properties** dialog box, under **Remote Desktop**, click one of the following options:  
  
    -   **Allow connections from computers running any version of Remote Desktop \(less secure\)**. Use this option if you do not know the version of Remote Desktop Connection that will be used to connect to this server.  
  
    -   **Allow connections only from computers running Remote Desktop with Network Level Authentication \(more secure\)**. Use this option if you know that the users who will connect to this server are running Windows Vista or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)].  
  
4.  Review the information in the **Remote Desktop** dialog box, and then click **OK** twice.  
  
### To enable Remote Desktop remotely by using the registry  
  
1.  On any computer that is running a version of Windows Server 2003, Windows Server 2003 R2, [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], Windows XP Professional, or Windows Vista, open Regedit as an administrator. To open Regedit as an administrator, click **Start**, and then, in **Start Search**, type **regedit**. At the top of the **Start** menu, right\-click **regedit**, and then click **Run as administrator**. In the **User Account Control** dialog box, provide Domain Admins credentials, and then click **OK**.  
  
2.  On the **File** menu, click **Connect Network Registry**.  
  
3.  In the **Select Computer** dialog box, under **Enter the object name to select**, type the computer name, and then click **Check Names**.  
  
4.  After the computer name resolves, click **OK**.  
  
5.  In the computer node that appears in the Registry Editor, navigate to **HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Terminal Server**.  
  
6.  In the console tree, click **Terminal Server**, and then, in the details pane, double\-click **fDenyTSConnections**.  
  
7.  In the **Edit DWORD Value** box, in **Value data**, type **0**, and then click **OK**.  
  
     This value enables connections at the level that allows connections from computers running any version of Remote Desktop.  
  
8.  To implement the change, restart the server remotely, as follows:  
  
    -   Open a Command Prompt as an administrator: On the **Start** menu, right\-click **Command Prompt**, and then click **Run as administrator**. In the **User Account Control** dialog box, provide Domain Admins credentials, and then click **OK**.  
  
    -   At the command prompt, type the following command, and then press ENTER:  
  
         `shutdown /m \\<DomainControllerName> /r`  
  
    |Value|Description|  
    |-----------|-----------------|  
    |\/m \\\\\<DomainControllerName\>|The name of the computer to be shut down or restarted.|  
    |\/r|Shuts down and then restarts the computer.|  
  
  