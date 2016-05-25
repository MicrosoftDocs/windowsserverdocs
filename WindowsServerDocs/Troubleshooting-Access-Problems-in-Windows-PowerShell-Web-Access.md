---
title: Troubleshooting Access Problems in Windows PowerShell Web Access
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-management-and-automation
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 310c96d5-a215-47e4-8ec4-eee22a258089
author: jpjofre
---
# Troubleshooting Access Problems in Windows PowerShell Web Access
  
## <a name="BKMK_trouble"></a>Troubleshooting access problems  
The following identifies some common problems that users might experience when they are attempting to connect to a remote computer by using [!INCLUDE[pswa_2](includes/pswa_2_md.md)], and includes suggestions for resolving the problems.  
  
Sign\-in failure \(Failure could occur because of any of the following\)  
  
-   An authorization rule that allows the user access to the computer, or a specific session configuration on the remote computer, does not exist. [!INCLUDE[pswa_2](includes/pswa_2_md.md)] security is restrictive; users must be granted explicit access to remote computers by using authorization rules. For more information about creating authorization rules, see [Authorization Rules and Security Features of Windows PowerShell Web Access_1](Authorization-Rules-and-Security-Features-of-Windows-PowerShell-Web-Access_1.md) in this guide.  
  
-   The user does not have authorized access to the destination computer. This is determined by access control lists \(ACLs\). For more information, see “Signing in to [!INCLUDE[wps_2](includes/wps_2_md.md)] Web Access” in [Use the Web-based Windows PowerShell Console_1](Use-the-Web-based-Windows-PowerShell-Console_1.md), or the [Windows PowerShell Team Blog](http://msdn.microsoft.com/library/windows/desktop/ee706585.aspx).  
  
    -   [!INCLUDE[wps_2](includes/wps_2_md.md)] remote management might not be enabled on the destination computer. Verify that it is enabled on the computer to which the user is trying to connect. For more information, see “How to Configure Your Computer for Remoting” in [about_Remote_Requirements](http://technet.microsoft.com/library/dd315349.aspx) in the [!INCLUDE[wps_2](includes/wps_2_md.md)] About Help Topics.  
  
Internal Server Error \(When users try to sign in to [!INCLUDE[pswa_2](includes/pswa_2_md.md)] in an Internet Explorer window, they are shown an **Internal Server Error** page, or Internet Explorer stops responding. This issue is specific to Internet Explorer and can occur for users who have signed in with a domain name that contains Chinese characters, or if one or more Chinese characters are part of the gateway server name. To work around this issue, the user should [install and run Internet Explorer 10](http://ie.microsoft.com/testdrive/info/downloads/Default.html), and then perform the following steps\)  
  
1.  Change the Internet Explorer **Document Mode** setting to **IE10 standards**.  
  
    1.  Press **F12** to open the Developer Tools console.  
  
    2.  In Internet Explorer 10, click **Browser Mode**, and then select **Internet Explorer 10**.  
  
    3.  Click **Document Mode**, and then click **IE10 standards**.  
  
    4.  Press **F12** again to close the Developer Tools console.  
  
2.  Disable automatic proxy configuration.  
  
    1.  In Internet Explorer 10, click **Tools**, and then click **Internet Options**.  
  
    2.  In the **Internet Options** dialog box, on the **Connections** tab, click **LAN settings**.  
  
    3.  Clear the **Automatically detect settings** check box. Click **OK**, and then click **OK** again to close the **Internet Options** dialog box.  
  
Cannot connect to a remote workgroup computer  
  
\(If the destination computer is a member of a workgroup, use the following syntax to provide your user name and sign in to the computer: <*workgroup\_name*>\\<*user\_name*>\)  
  
Cannot find Web Server \(IIS\) management tools, even though the role was installed  
  
If you installed [!INCLUDE[pswa_2](includes/pswa_2_md.md)] by using the `Install-WindowsFeature` cmdlet, management tools are not installed unless the `IncludeManagementTools` parameter is added to the cmdlet. For an example, see “To install Windows PowerShell Web Access by using Windows PowerShell cmdlets” in [Install and Use Windows PowerShell Web Access](Install-and-Use-Windows-PowerShell-Web-Access.md). You can add the IIS Manager console and other IIS management tools that you need by selecting the tools in an [!INCLUDE[arfw](includes/arfw_md.md)] session that is targeted at the gateway server. The [!INCLUDE[arfw](includes/arfw_md.md)] is opened from within [!INCLUDE[sm](includes/sm_md.md)].  
  
The [!INCLUDE[pswa_2](includes/pswa_2_md.md)] website is not accessible  
  
If Enhanced Security Configuration is enabled in Internet Explorer \(IE ESC\), you can add the [!INCLUDE[pswa_2](includes/pswa_2_md.md)] website to the list of trusted sites, or disable IE ESC. You can disable IE ESC in the **Properties** tile on the **Local Server** page in [!INCLUDE[sm](includes/sm_md.md)].  
  
The following error message is displayed while trying to connect when the gateway server is the destination computer, and is also in a workgroup: **An authorization failure occurred. Verify that you are authorized to connect to the destination computer.**  
  
When the gateway server is also the destination server, and it is in a workgroup, specify the user name, computer name, and user group name as shown in the following table. Do not use a dot \(.\) by itself to represent the computer name.  
  
|Scenario|UserName Parameter|UserGroup Parameter|ComputerName Parameter|ComputerGroup Parameter|  
|------------|----------------------|-----------------------|--------------------------|---------------------------|  
|Gateway server is in a domain|*Server\_name*\\*user\_name*, Localhost\\*user\_name*, or .\\*user\_name*|*Server\_name*\\*user\_group*, Localhost\\*user\_group*, or .\\*user\_group*|Fully qualified name of gateway server, or Localhost|*Server\_name*\\*computer\_group*, Localhost\\*computer\_group*, or .\\*computer\_group*|  
|Gateway server is in a workgroup|*Server\_name*\\*user\_name*, Localhost\\*user\_name*, or .\\*user\_name*|*Server\_name*\\*user\_group*, Localhost\\*user\_group* or .\\*user\_group*|Server name|*Server\_name*\\*computer\_group*, Localhost\\*computer\_group* or .\\*computer\_group*|  
  
Sign in to a gateway server as target computer by using credentials formatted as one of the following.  
  
-   *Server\_name*\\*user\_name*  
  
-   Localhost\\*user\_name*  
  
-   .\\*user\_name*  
  
A security identifier \(SID\) is displayed in an authorization rule instead of the syntax *user\_name*\/*computer\_name*  
  
Either the rule is no longer valid, or the Active Directory Domain Services query failed. An authorization rule is usually not valid in scenarios where the gateway server was at one time in a workgroup, but was later joined to a domain.  
  
Cannot sign in to a target computer that has been specified in authorization rules as an IPv6 address with a domain.  
  
Authorization rules do not support an IPv6 address in form of a domain name. To specify a destination computer by using an IPv6 address, use the original IPv6 address \(that contains colons\) in the authorization rule. Both domain and numerical \(with colons\) IPv6 addresses are supported as the target computer name on the [!INCLUDE[pswa_2](includes/pswa_2_md.md)] sign\-in page, but not in authorization rules. For more information about IPv6 addresses, see [How IPv6 Works](http://technet.microsoft.com/library/cc781672.aspx).  
  
## See Also  
[Authorization Rules and Security Features of Windows PowerShell Web Access_1](Authorization-Rules-and-Security-Features-of-Windows-PowerShell-Web-Access_1.md)  
[Use the Web-based Windows PowerShell Console_1](Use-the-Web-based-Windows-PowerShell-Console_1.md)  
[about_Remote_Requirements](http://technet.microsoft.com/library/dd315349.aspx)  
  

