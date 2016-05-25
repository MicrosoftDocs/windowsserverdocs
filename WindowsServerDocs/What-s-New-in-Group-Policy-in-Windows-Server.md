---
title: What&#39;s New in Group Policy in Windows Server
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 45100f25-2d04-49c1-a251-0e248c059d28
author: coreyp
---
# What&#39;s New in Group Policy in Windows Server
This topic describes the new and changed functionality of the Group Policy feature in [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)] and Windows Server 2012.  
  
Group Policy is an infrastructure that enables you to specify managed configurations for users and computers through Group Policy settings and Group Policy Preferences. For Group Policy settings that affect only a local computer or user, you can use the Local Group Policy Editor. You can manage Group Policy settings and Group Policy Preferences in an Active Directory Domain Services \(AD DS\) environment through the Group Policy Management Console \(GPMC\). Group Policy management tools also are included in the Remote Server Administration Tools, which provides a way for you to administer Group Policy settings from your desktop.  
  
**In this topic:**  
  
-   [What’s new in Group Policy in Windows Server 2012 R2](What-s-New-in-Group-Policy-in-Windows-Server.md#BKMK_GP2012R2)  
  
-   [What’s new in Group Policy in Windows Server 2012](What-s-New-in-Group-Policy-in-Windows-Server.md#BKMK_GP2012)  
  
## <a name="BKMK_GP2012R2"></a>What’s new in Group Policy in Windows Server 2012 R2  
In [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)], Group Policy offers enhanced support in the following areas.  
  
|Feature\/functionality|New or Updated|  
|--------------------------|------------------|  
|[IPv6 support](What-s-New-in-Group-Policy-in-Windows-Server.md#BKMK_gpupdate)|Updated|  
|[Policy caching](What-s-New-in-Group-Policy-in-Windows-Server.md#BKMK_gpresults)|New|  
|[Event logging](What-s-New-in-Group-Policy-in-Windows-Server.md#BKMK_gpinfra)|Updated|  
  
### <a name="BKMK_gpupdate"></a>IPv6 support  
[!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)] expands support for IPv6 in Group Policy. This expanded support encompasses printers, item\-level targeting, and VPN networks. The following procedures describe how you can use this expanded support.  
  
##### Printers  
  
1.  Under **User Configuration**, expand **Preferences**, and expand **Control Panel Settings**.  
  
2.  Click **Printers**, right\-click, click **New**, and then click **TIP\/IP Printer**.  
  
3.  Select the **Use IPv6 Address** check box and  enter an IPv6 address in the corresponding field.  
  
##### Item\-level targeting  
  
1.  In any Group Policy preference, click **Properties**, and click the **Common** tab.  
  
2.  Select the **Item\-level targeting** check box, and click the **Targeting…** button.  
  
3.  In the **Targeting Editor**, click the **New Item** menu, and click **IP Address Range**.  
  
4.  Select the **Use IPv6** check box and enter an IPv6 address in the corresponding field. You can filter by **submpa**.  
  
##### VPN connections  
  
1.  Under **User Configuration**, expand **Preferences**, and expand **Control Panel Settings**.  
  
2.  Click **Network Option**, right\-click, click **New**, and click **VPN Connection**.  
  
3.  In the **New VPN Connection** window, select the **Use IPv6** check box.  
  
### <a name="BKMK_gpresults"></a>Policy caching  
In [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)], when Group Policy gets the latest version of a policy from the domain controller, it writes that policy to a local store. Then if Group Policy is running in synchronous mode the next time the computer reboots, it reads the most recently downloaded version of the policy from the local store, instead of downloading it from the network. This reduces the time it takes to process the policy. Consequently, the boot time is shorter in synchronous mode. This is especially important if you have a latent connection to the domain controller, for example, with DirectAccess or for computers that are off premises. This behavior is controllable by a new policy called Configure Group Policy Caching.  
  
### <a name="BKMK_gpinfra"></a>Event logging  
[!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)] provides more detailed events for Group Policy settings in the operational event log. The logged events include more information about how long it takes to download and process policies. There are also details about WMI processing. This can help you analyze and diagnose long sign\-in times.  
  
## <a name="BKMK_GP2012"></a>What’s new in Group Policy in Windows Server 2012  
In Windows Server 2012, Group Policy offers enhanced support for the following scenarios.  
  
|Feature\/Functionality|New or Updated|  
|--------------------------|------------------|  
|[Remote Group Policy update](What-s-New-in-Group-Policy-in-Windows-Server.md#BKMK_GPUP)|New|  
|[Group Policy Results report improvements](What-s-New-in-Group-Policy-in-Windows-Server.md#BKMK_Results)|Updated|  
|[Group Policy infrastructure status](What-s-New-in-Group-Policy-in-Windows-Server.md#BKMK_INFRA)|New|  
|[Local Group Policy support on Windows RT](What-s-New-in-Group-Policy-in-Windows-Server.md#BKMK_WinRT)|New|  
|[Sign\-in optimizations](What-s-New-in-Group-Policy-in-Windows-Server.md#BKMK_SI)|Updated|  
|[Fast Startup](What-s-New-in-Group-Policy-in-Windows-Server.md#BKMK_FastBoot)|New|  
|[New Group Policy starter GPOs](What-s-New-in-Group-Policy-in-Windows-Server.md#BKMK_starterGPO)|New|  
|[Group Policy cmdlet changes](What-s-New-in-Group-Policy-in-Windows-Server.md#BKMK_GPPS)|Updated|  
|[Registry.pol changes](What-s-New-in-Group-Policy-in-Windows-Server.md#BKMK_REG)|Updated|  
|[Group Policy Client service idle state](What-s-New-in-Group-Policy-in-Windows-Server.md#BKMK_Perf)|Updated|  
|[Group Policy settings in Internet Explorer 10](What-s-New-in-Group-Policy-in-Windows-Server.md#BKMK_IEpolicy)|New|  
|[Group Policy Preferences for Internet Explorer 10](What-s-New-in-Group-Policy-in-Windows-Server.md#BKMK_IEpref)|New|  
  
See also [Removed or deprecated functionality](What-s-New-in-Group-Policy-in-Windows-Server.md#BKMK_DEP2010).  
  
### <a name="BKMK_GPUP"></a>Remote Group Policy update  
In [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)], you can refresh Group Policy settings, including security settings that are set on a group of remote computers, by using the functionality that is added to the context menu for an organizational unit \(OU\) in the Group Policy Management Console \(GPMC\). This functionality schedules a task on all computers in a selected OU, which refreshes the computer and user Group Policy settings.  
  
**What value does this change add?**  
  
When you troubleshoot Group Policy issues for a specific computer or user, you can run **gpupdate.exe** to verify that the most current Group Policy settings have been applied. This command\-line utility needs to be run on a specific computer. In [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)], you can schedule **gpupdate.exe** to run on multiple computers from the GPMC or from a Windows PowerShell session by using the new **Invoke\-GPUpdate** cmdlet.  
  
**What works differently?**  
  
Prior to [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)], you would have to remote to a specific computer and run **gpupdate.exe** from the command\-line. In [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] you can update Group Policy for all computers in a specific OU and the OUs that it contains. For more information about the new remote Group Policy update feature, see [Force a Remote Group Policy Refresh &#40;GPUpdate&#41;](Force-a-Remote-Group-Policy-Refresh--GPUpdate-.md)  
  
### <a name="BKMK_Results"></a>Group Policy Results report improvements  
Group Policy Results in [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] includes more information to help determine if a Group Policy setting was applied to a computer or user. If the results do not match the expected results, there is information about why this happened.  
  
**What value does this change add?**  
  
It is sometimes hard to determine why Group Policy applied the specific policy settings and Preferences. The **Group Policy Results** report includes the following new information to help you understand why a particular Group Policy result was achieved:  
  
-   Whether the connection was determined to be a slow link or fast link  
  
-   Whether block inheritance has been set  
  
-   Whether loopback has been set  
  
-   The processing time for each client\-side extension  
  
-   The GPO name is now displayed with each Group Policy setting and preference item. This identifies which is the winning GPO for a particular policy setting or preference item.  
  
**What works differently?**  
  
The following applicable conditions are displayed on the Group Policy Results **Summary** tab:  
  
-   If a slow link or fast link is detected  
  
-   If block inheritance is set  
  
-   If loopback is enabled  
  
The Group Policy Results **Details** tab displays:  
  
1.  The OU that contains the computer or user.  
  
2.  The **Component Status** section displays the amount of time each client\-side extension took to process and the last time each client\-side extension processed.  
  
3.  The **Component Status** section provides a link in the **Event Log** column that displays the event log messages from the last Group Policy refresh. This functionality is equivalent to the information that is returned from the GPLogview.exe utility.  
  
4.  The **Winning GPO** name is displayed in a table with each **Policy** setting name and the value that is set for each policy setting and preference item.  
  
> [!IMPORTANT]  
> To view the **Group Policy Results** for a specific computer, the following firewall rules must be set on each client computer to allow the following connections:  
>   
> -   Remote Event Log Management \(NP\-IN\)  
> -   Remote Event Log Management \(RPC\)  
> -   Remote Event Log Management \(RPC\-EPMAP\)  
> -   Windows Management Instrumentation \(WMI\-IN\)  
>   
> If you do not want to allow the connections on computers, you can also run **Gpresult.exe \/h***<filename.html>* from the command line on the each local computer, where filename.html is the name of a file to which **Gpresult** writes the output.  
  
### <a name="BKMK_INFRA"></a>Group Policy infrastructure status  
Display the status of Active Directory and SYSVOL replication as it relates to all Group Policy Objects or a single Group Policy Object.  
  
**What value does this change add?**  
  
Group Policy relies on being stored and replicated to all domain controllers in a domain. There can be a lag time after a change is made on one domain controller before the change is replicated to all other domain controllers. Until changes to a GPO are replicated to the domain controller that a client computer is accessing, that computer will receive the earlier version of the GPO during Group Policy refresh. In earlier versions of the Windows operating system, administrators had to download **GPOtool.exe** to diagnose these issues.  
  
**What works differently?**  
  
In [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)], you no longer need to download and run a separate tool for monitoring and diagnosing replication issues related to Group Policy at the domain level. Potential differences that can be viewed by using the Group Policy infrastructure status are:  
  
-   Active Directory and SYSVOL security descriptor \(ACL details\)  
  
-   Active Directory and SYSVOL GPO version details  
  
-   Number of GPOs listed in Active Directory and SYSVOL for each domain controller  
  
For more information about the new Group Policy infrastructure status, see [Check Group Policy Infrastructure Status](Check-Group-Policy-Infrastructure-Status.md).  
  
### <a name="BKMK_WinRT"></a>Local Group Policy support for Windows RT  
You can configure Group Policy on devices that run [!INCLUDE[winrt_2](includes/winrt_2_md.md)].  
  
**What value does this change add?**  
  
Local Group Policy is available for [!INCLUDE[winrt_2](includes/winrt_2_md.md)]. It is off by default, but can be turned on by the local administrator.  
  
**What works differently?**  
  
For [!INCLUDE[winrt_2](includes/winrt_2_md.md)] devices, the Group Policy Client service is disabled by default. The Group Policy Client service must be set to Automatic and started by the administrator before Group Policy is processed on the device.  
  
##### To turn on the Group Policy Client service  
  
1.  From the start screen, type **Services.msc**.  
  
2.  Double\-click **Group Policy Client** to open the **Group Policy Client Properties \(Local Computer\)** dialog box.  
  
3.  Set the **Startup type** to **Automatic**, and then click the **Start** button.  
  
### <a name="BKMK_SI"></a>Sign\-in optimizations  
Slow link processing during sign\-in is improved.  
  
**What value does this change add?**  
  
More control to determine if the network connection should be processed as a slow link improves the sign\-in experience for users by allowing users to sign\-in faster.  
  
**What works differently?**  
  
For DirectAccess connections, when the network connection speed cannot be determined, Group Policy processing defaults to slow\-link mode. During sign\-in, if a slow link is detected, Group Policy automatically switches to asynchronous processing. A new policy setting enables administrators to configure all 3G connections so that they are treated as a slow link. To disable 3G slow\-link connections, select the **Always treat WWAN connections as a slow link**  check box after you have enabled the **Configure Group Policy slow link detection** policy setting.  
  
> [!NOTE]  
> The **Configure Group Policy slow link detection** policy setting is located under Computer Configuration\\Policies\\Administrative Templates\\System\\Group Policy in the Group Policy Management Editor.  
  
### <a name="BKMK_FastBoot"></a>Fast Startup  
Improvement in start times affects Group Policy processing.  
  
**What value does this change add?**  
  
Fast Startup decreases the time it takes to shut down and start a computer by causing the computer to enter a hibernate state instead of performing a full shutdown.  
  
**What works differently?**  
  
Group Policy settings or scripts that are applied during start or shutdown might not be applied when computers are configured to use Fast Startup. For more information about the impact of this change, see [Understand the Effect of Fast Logon Optimization and Fast Startup on Group Policy](Understand-the-Effect-of-Fast-Logon-Optimization-and-Fast-Startup-on-Group-Policy.md).  
  
### <a name="BKMK_starterGPO"></a>New Group Policy starter GPOs  
You can configure firewall port requirements to allow Group Policy remote RSoP reporting and remote Group Policy update.  
  
**What value does this change add?**  
  
The two starter GPOs make configuring Group Policy firewall port requirements easier. You can import the starter GPOs at the same time that you create a new GPO for this purpose.  
  
**What works differently?**  
  
For more information about the new Starter GPOs, see [Configure Firewall Port Requirements for Group Policy](Configure-Firewall-Port-Requirements-for-Group-Policy.md).  
  
### <a name="BKMK_GPPS"></a>Group Policy cmdlet changes  
Automate the remote Group Policy update by using the new **Invoke\-GPUpdate** cmdlet.  
  
> [!NOTE]  
> Group Policy cmdlets can also run on the Server Core installation option.  
  
**What value does this change add?**  
  
The new **Invoke\-GPUpdate** cmdlet provides more functionality than applying remote Group Policy update through the GPMC interface. For example, the **Invoke\-GPUpdate** cmdlet enables you to refresh computers located in the default computer container, while the remote Group Policy update functionality in the GPMC enables you to remotely refresh only computers that are located in an OU.  
  
On a Server Core installation, you can manage GPMC functionality by using Group Policy cmdlets. This provides you with more flexibility for managing Group Policy.  
  
The **Get\-GPPermissions** cmdlet and the **Set\-GPPermissions** cmdlet are renamed to the singular form: **Get\-GPPermission** and **Set\-GPPermission**. Both cmdlets have aliases for their previous names to support backward compatibility.  
  
**What works differently?**  
  
For more information about all Group Policy cmdlets, see [Group Policy Cmdlets in Windows PowerShell](http://technet.microsoft.com/library/hh967461.aspx).  
  
### <a name="BKMK_REG"></a>Registry.pol changes  
An increase in the maximum size allowed for registry.pol enables faster downloads of registry.pol files from domain controllers.  
  
**What value does this change add?**  
  
With this change, there should be very few situations where the maximum size of the registry.pol file restrains administrators from adding new Administrative Template settings to a GPO. With the faster download of registry.pol files, Group Policy processing should increase.  
  
**What works differently?**  
  
The registry.pol file maximum size is increased to 100 MB. The Group Policy processing has been changed to read larger amounts of data from a registry.pol file when processing the Administrative Template settings. This change results in less network access for reading the registry.pol file from the domain controller, which speeds up Group Policy processing.  
  
### <a name="BKMK_Perf"></a>Group Policy Client service idle state  
The Group Policy Client service will sleep when the Group Policy service is idle for more than 10 minutes.  
  
**What value does this change add?**  
  
Group Policy processes approximately every 90 minutes, by default. Setting the Group Policy Client service to sleep in between processing helps create better performance for client computers.  
  
**What works differently?**  
  
Group Policy background refresh starts as a scheduled task, not as a service that continuously checks to determine when it is time to run the background refresh. The scheduled task model requires less overhead processing, which creates better performance for client computers.  
  
### <a name="BKMK_IEpolicy"></a>Group Policy settings in Internet Explorer 10  
Group Policy Administrative Template settings that support Internet Explorer 10 are added.  
  
**What value does this change add?**  
  
New Group Policy settings in the Internet Explorer 10 Administrative Template support new features.  
  
**What works differently?**  
  
For more information about the new and changed policy settings that can be used to manage and control your Internet Explorer 10 configuration, see [Group Policy Settings in Internet Explorer 10](http://technet.microsoft.com/library/hh846775.aspx).  
  
### <a name="BKMK_IEpref"></a>Group Policy Preferences for Internet Explorer 10  
[!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] and [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)] include Group Policy Preferences support for Internet Explorer 10.  
  
**What value does this change add?**  
  
Group Policy Preferences consolidates multiple ways to configure Internet Explorer preference settings.  
  
**What works differently?**  
  
The Internet Explorer Maintenance \(IEM\) snap\-in is replaced by the Internet Explorer 10 preference extension. Administrators can use the Internet Explorer 10 preference extension or the Internet Explorer Administration Kit \(IEAK\) to configure Group Policy settings. Information about the Internet Explorer 10 preference extension can be found at:  
  
-   [Internet Explorer Maintenance Replacements](http://technet.microsoft.com/library/hh846772.aspx)  
  
-   [Configure an Internet Explorer 10 Item](http://technet.microsoft.com/library/jj149118.aspx)  
  
### <a name="BKMK_DEP2010"></a>Removed or deprecated functionality  
The following features and functionalities have been removed from this release of Group Policy. Applications, code, or usage that depends on these features will not function in this release unless you employ an alternate method. For more information about removed or deprecated functionality in this release, see [Features Removed or Deprecated in the Windows Server 2012](http://msdn.microsoft.com/windowsserver/hh440439).  
  
-   The Immediate Task preference item no longer supports the following actions:  
  
    -   Send an email  
  
    -   Display a message  
  
    For more information, see [Configure an Immediate Task Item \(Windows Vista and later versions\)](http://technet.microsoft.com/library/dd851779.aspx)  
  
-   NetMeeting Administrative Template files are removed  
  
## See also  
  
-   [Group Policy Overview](Group-Policy-Overview.md)  
  
-   [What's New in Group Policy in Windows Server 2008 R2](http://technet.microsoft.com/library/dd367853(v=ws.10).aspx)  
  
-   [What's New About Group Policy in Windows Server 2003](http://technet.microsoft.com/library/cc779353(v=ws.10).aspx)  
  

