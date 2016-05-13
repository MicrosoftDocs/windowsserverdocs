---
title: Group Policy Overview
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: efaa8001-67d6-4e4d-804f-220c1092e5a3
---
# Group Policy Overview
Use this topic to find the documentation resources and other technical information you need to accomplish key Group Policy tasks. You can learn about new and updated functionality for Group Policy in [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)] and [!INCLUDE[winblue_client_2](includes/winblue_client_2_md.md)]and ways to automate common Group Policy tasks by using [!INCLUDE[wps_2](includes/wps_2_md.md)].

**Did you mean…**

-   [Group Policy Settings Reference for Windows Server 2012 and Windows 8](http://go.microsoft.com/fwlink/?LinkId=261775)

-   [Overview of Group Policy \(Windows Server 2008 R2\)](http://technet.microsoft.com/library/cc726027.aspx)

-   [Overview of Preferences](http://go.microsoft.com/fwlink/p/?linkid=216977)

-   [Refresh Group Policy settings with GPUpdate.exe](http://technet.microsoft.com/library/cc739112.aspx)

-   [Security Policy Settings Overview](Security-Policy-Settings-Overview.md)

-   [Remote Server Administration Tools for Windows Server 2012](Remote-Server-Administration-Tools-for-Windows-Server-2012.md)

-   [Windows Firewall with Advanced Security Overview](assetId:///9ae80ae1-a693-48ed-917a-f03ea92b550d)

## <a name="BKMK_OVER"></a>Feature description
Group Policy is an infrastructure that allows you to specify managed configurations for users and computers through Group Policy settings and Group Policy Preferences. To configure Group Policy settings that affect only a local computer or user, you can use the Local Group Policy Editor. You can manage Group Policy settings and Group Policy Preferences in an Active Directory Domain Services \(AD DS\) environment through the Group Policy Management Console \(GPMC\). Group Policy management tools also are included in the Remote Server Administration Tools pack to provide a way for you to administer Group Policy settings from your desktop.

**Windows PowerShell** When the GPMC is installed on servers or client computers, the Windows PowerShell module is also installed. You have full Windows PowerShell functionality. If you install the Remote Server Administration Tools pack, the latest Windows PowerShell cmdlets for Group Policy are also installed. For more information about Windows PowerShell cmdlets and scripts that you can use to manage Group Policy, see [Group Policy Cmdlets](http://technet.microsoft.com/library/hh967461.aspx).

You can configure the Group Policy feature by using Windows PowerShell cmdlets. For more information about using Server Manager cmdlets to install the Group Policy Management Console, see [Install or Uninstall Roles, Role Services, or Features_1](Install-or-Uninstall-Roles,-Role-Services,-or-Features_1.md) and [Server Manager deployment cmdlet module](http://go.microsoft.com/fwlink/?LinkId=242610).

## <a name="BKMK_APP"></a>Practical applications
By using Group Policy, you can significantly reduce your organization’s total cost of ownership. Various factors, such as the large number of policy settings available, the interaction between multiple policies, and inheritance options, can make Group Policy design complex. By carefully planning, designing, testing, and deploying a solution based on your organization’s business requirements, you can provide the standardized functionality, security, and management control that your organization needs.

Here are some [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] scenarios that use Group Policy to implement a solution:

-   [Configuring Policy-based Quality of Service &#40;QoS&#41;](Configuring-Policy-based-Quality-of-Service--QoS-.md)

-   [Managing the New Wired Network &#40;IEEE 802.3&#41; Policies Settings](Managing-the-New-Wired-Network--IEEE-802.3--Policies-Settings.md)

-   [Managing the Wireless Network &#40;IEEE 802.11&#41; Policies](Managing-the-Wireless-Network--IEEE-802.11--Policies.md)

-   [Securing End-to-End IPsec Connections by Using IKEv2 in Windows Server 2012](Securing-End-to-End-IPsec-Connections-by-Using-IKEv2-in-Windows-Server-2012.md)

## <a name="BKMK_NEW"></a>New and changed functionality
Group Policy designs can become very complex. Various factors, such as the large number of policy settings and preference items available, the interaction between multiple policies, and inheritance options, can make it difficult to determine if Group Policy is functioning correctly on each computer.

In [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)], Group Policy focused on improving the Group Policy troubleshooting experience. [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)] expands the support for IPv6 networking, adds policy caching to reduce sign\-in times in synchronous mode, and provides more detailed event logging. For more details about these changes and more information about the additional changes in functionality that are not listed here, see [What's New in Group Policy in Windows Server 2012 \[redirected\]](assetId:///2e7bfa32-9fa9-4031-8160-d3a8c526df8d) and [What's New in Group Policy in Windows Server](What-s-New-in-Group-Policy-in-Windows-Server.md).

## <a name="BKMK_LINKS"></a>See also

|Content type|References|
|----------------|--------------|
|**Planning**|Not yet available.|
|**Deployment**|Not yet available.|
|**Operations**|Not yet available.|
|**Troubleshooting**|[Group Policy Analysis and Troubleshooting Overview](Group-Policy-Analysis-and-Troubleshooting-Overview.md)|
|**Security**|Not yet available.|
|**Tools and settings**|-   [Group Policy Settings Reference for Windows and Windows Server](http://go.microsoft.com/fwlink/?LinkId=261775)<br />-   [Group Policy Cmdlets](http://technet.microsoft.com/library/hh967461.aspx)|
|**Community resources**|-   [Group Policy Team Blog](http://blogs.technet.com/b/grouppolicy/)<br />-   [Group Policy forum](http://social.technet.microsoft.com/Forums/winserverGP/threads?sort=repliesdesc)|
|**Related technologies**|Not yet available.|


