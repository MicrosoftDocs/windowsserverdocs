---
title: Subcommand set-Server
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: da55c29d-a94a-4d73-877b-af480f906ca0
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# Subcommand: set-Server

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Configures the settings for a Windows Deployment Services server.
## Syntax
```
wdsutil [Options] /Set-Server [/Server:<Server name>]
    [/Authorize:{Yes | No}]
    [/RogueDetection:{Yes | No}]
    [/AnswerClients:{All | Known | None}]
    [/Responsedelay:<time in seconds>]
    [/AllowN12forNewClients:{Yes | No}]
    [/ArchitectureDiscovery:{Yes | No}]
    [/resetBootProgram:{Yes | No}]
    [/DefaultX86X64Imagetype:{x86 | x64 | Both}]
    [/UseDhcpPorts:{Yes | No}]
    [/DhcpOption60:{Yes | No}]
    [/RpcPort:<Port number>]
    [/PxepromptPolicy 
        [/Known:{OptIn | Noprompt | OptOut}]
        [/New:{OptIn | Noprompt | OptOut}] 
    [/BootProgram:<Relative path>]
         /Architecture:{x86 | ia64 | x64}
    [/N12BootProgram:<Relative path>]
         /Architecture:{x86 | ia64 | x64}
    [/BootImage:<Relative path>]
         /Architecture:{x86 | ia64 | x64}
    [/PreferredDC:<DC Name>]
    [/PreferredGC:<GC Name>]
    [/PrestageUsingMAC:{Yes | No}]
    [/NewMachineNamingPolicy:<Policy>]
    [/NewMachineOU]
         [/type:{Serverdomain | Userdomain | UserOU | Custom}]
         [/OU:<Domain name of OU>]
    [/DomainSearchOrder:{GCOnly | DCFirst}]
    [/NewMachineDomainJoin:{Yes | No}]
    [/OSCMenuName:<Name>]
    [/WdsClientLogging]
         [/Enabled:{Yes | No}]
         [/LoggingLevel:{None | Errors | Warnings | Info}]
    [/WdsUnattend]
         [/Policy:{Enabled | Disabled}]
         [/CommandlinePrecedence:{Yes | No}]
         [/File:<path>]
             /Architecture:{x86 | ia64 | x64}
    [/AutoaddPolicy]
         [/Policy:{AdminApproval | Disabled}]
         [/PollInterval:{time in seconds}]
         [/MaxRetry:{Retries}]
         [/Message:<Message>]
         [/RetentionPeriod]
             [/Approved:<time in days>]
             [/Others:<time in days>]
    [/AutoaddSettings]
         /Architecture:{x86 | ia64 | x64}
         [/BootProgram:<Relative path>]
         [/ReferralServer:<Server name>
         [/WdsClientUnattend:<Relative path>]
         [/BootImage:<Relative path>]
         [/User:<Owner>]
         [/JoinRights:{JoinOnly | Full}]
         [/JoinDomain:{Yes | No}]
    [/BindPolicy]
         [/Policy:{Include | Exclude}]
         [/add]
              /address:<IP or MAC address>
              /addresstype:{IP | MAC}
         [/remove]
              /address:<IP or MAC address>
              /addresstype:{IP | MAC}
    [/RefreshPeriod:<time in seconds>]
    [/BannedGuidPolicy]
         [/add]
              /Guid:<GUID>
         [/remove]
             /Guid:<GUID>
    [/BcdRefreshPolicy]
         [/Enabled:{Yes | No}]
         [/RefreshPeriod:<time in minutes>]
    [/Transport]
         [/ObtainIpv4From:{Dhcp | Range}]
             [/start:<start IP address>]
             [/End:<End IP address>]
         [/ObtainIpv6From:Range]
             [/start:<start IP address>]
             [/End:<End IP address>]
         [/startPort:<start Port>
             [/EndPort:<start Port>
        [/Profile:{10Mbps | 100Mbps | 1Gbps | Custom}]
        [/MulticastSessionPolicy]
             [/Policy:{None | AutoDisconnect | Multistream}]
                 [/Threshold:<Speed in KBps>]
                 [/StreamCount:{2 | 3}]
                 [/Fallback:{Yes | No}]    
        [/forceNative]
```
## Parameters
|Parameter|Description|
|-------|--------|
|[/Server:<Server name>]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server will be used.|
|[/Authorize:{Yes &#124; No}]|Specifies whether to authorize this server in Dynamic Host Control Protocol (DHCP).|
|[/RogueDetection:{Yes &#124; No}]|Enables or disables DHCP rogue detection.|
|[/AnswerClients:{All &#124; Known &#124; None}]|Specifies which clients this server will answer. If you set this value to **Known**, a computer must be prestaged in active directory Domain Services (AD DS) before it will be answered by the Windows Deployment Services server.|
|[/Responsedelay:<time in seconds>]|The amount of time that the server will wait before answering a booting client. This setting does not apply to prestaged computers.|
|[/AllowN12forNewClients:{Yes &#124; No}]|for Windows Server 2008, specifies that unknown clients will not have to press the F12 key to initiate a network boot. Known clients will receive the boot program specified for the computer or, if not specified, the boot program specified for the architecture.<br /><br />for Windows Server 2008 R2, this option has been replaced with the following command: wdsutil /Set-Server /PxepromptPolicy /New:Noprompt|
|[/ArchitectureDiscovery:{Yes &#124; No}]|Enables or disables architecture discovery. This facilitates the discovery of x64-based clients that do not broadcast their architecture correctly.|
|[/resetBootProgram:{Yes &#124; No}]|Determines whether the boot path will be erased for a client that has just booted without requiring an F12 key press.|
|[/DefaultX86X64Imagetype: {x86 &#124; x64 &#124; Both}]|Controls which boot images will be shown to x64-based clients.|
|[/UseDhcpPorts:{Yes &#124; No}]|Specifies whether or not the PXE server should attempt to bind to the DHCP port, TCP port 67. If DHCP and Windows Deployment Services are running on the same computer, you should set this option to **No** to enable the DHCP server to utilize the port, and set the **/DhcpOption60** parameter to **Yes**. The default setting for this value is **Yes**.|
|[/DhcpOption60:{Yes &#124; No}]|Specifies whether DHCP option 60 should be configured for PXE support. If DHCP and Windows Deployment Services are running on the same server, set this option to **Yes** and set the **/UseDhcpPorts** option to **No**. The default setting for this value is **No**.|
|[/RpcPort:<Port number>]|Specifies the TCP port number to be used to service client requests.|
|[/PxepromptPolicy]|Configures how known (prestaged) and new clients initiate a PXE boot. This option only applies to Windows Server 2008 R2. You set the settings using the following options:<br /><br />-   [/Known:{OptIn&#124;OptOut&#124;Noprompt}]  - Sets the policy for prestaged clients.<br />-   [/New:{OptIn&#124;OptOut&#124;Noprompt}] - Sets the policy for new clients.<br /><br />**OptIn** means the client needs to press a key in order to PXE boot, otherwise it will fall back to the next boot device.<br /><br />**Noprompt** means the client will always PXE Boot.<br /><br />**OptOut** means the client will PXE boot unless the Esc key is pressed.|
|[/BootProgram:<Relative path>] /Architecture:{x86 &#124; ia64 &#124; x64}|Specifies the relative path to the boot program in the remoteInstall folder (for example, **boot\x86\pxeboot.n12**), and specifies the architecture of the boot program.|
|[/N12BootProgram:<Relative path>] /Architecture:{x86 &#124; ia64 &#124; x64}|Specifies the relative path to the boot program that does not require pressing the F12 key (for example, **boot\x86\pxeboot.n12**), and specifies the architecture of the boot program.|
|[/BootImage:<Relative path>] /Architecture:{x86 &#124; ia64 &#124; x64}|Specifies the relative path to the boot image that booting clients should receive, and specifies the architecture of the boot image. You can specify this for each architecture.|
|[/PreferredDC:<DC Name>]|Specifies the name of the domain controller that Windows Deployment Services should use. This can be either the NetBIOS name or the FQDN.|
|[/PreferredGC:<GC Name>]|Specifies the name of the global catalog server that Windows Deployment Services should use. This can be either the NetBIOS name or the FQDN.|
|[/PrestageUsingMAC:{Yes &#124; No}]|Specifies whether Windows Deployment Services, when creating computer accounts in AD DS, should use the MAC address rather than the GUID/UUID to identify the computer.|
|[/NewMachineNamingPolicy:<Policy>]|Specifies the format to use when generating computer names for clients. For information about the format to use for <policy>, right-click the server in the mmc snap-in, click  **Properties**, and view the **directory Services** tab. For example, **/NewMachineNamingPolicy: %61Username%#**.|
|[/NewMachineOU]|Used to specify the location in AD DS where client computer accounts will be created. You specify the location using the following options.<br /><br />-   [/type: Serverdomain &#124; Userdomain &#124; UserOU &#124; Custom ]   Specifies the type of location. **Serverdomain** creates accounts in the same domain as the Windows Deployment Services server. **Userdomain** creates accounts in the same domain as the user performing the installation. **UserOU** creates accounts in the organizational unit of the user performing the installation. **Custom** allows you to specify a custom location (you must also specify a value for **/OU** with this option).<br />-   [/OU:<Domain name of OU>] - if you specify **Custom** for the **/type** option, this option specifies the organizational unit where computer accounts should be created.|
|[/DomainSearchOrder:{GCOnly &#124; DCFirst}]|Specifies the policy for searching computer accounts in AD DS (global catalog or domain controller).|
|[/NewMachineDomainJoin:{Yes &#124; No}]|Specifies whether or not a computer that is not already prestaged in AD DS should be joined to the domain during installation. The default setting is **Yes**.|
|[/WdsClientLogging]|Specifies the logging level for the server.<br /><br />-   [/Enabled:{Yes &#124; No}] - Enables or disables logging of Windows Deployment Services client actions.<br />-   [/LoggingLevel: {None &#124; Errors &#124; Warnings &#124; Info} - Sets the logging level. **None** is equivalent to disabling logging. **Errors** is the lowest level of logging and indicates that only errors will be logged. **Warnings** includes both warnings and errors. **Info** is the highest level of logging and includes errors, warnings, and informational events.|
|[/WdsUnattend]|These settings control the unattended installation behavior of Windows Deployment Services client. You set the settings using the following options:<br /><br />-   [/Policy:{Enabled &#124; Disabled}] - Specifies whether or not unattended installation is used.<br />-   [/CommandlinePrecedence: {Yes &#124; No}] - Specifies whether an Autounattend.xml file (if present on the client) or an unattended setup file that was passed directly to the Windows Deployment Services client with the /Unattend option will be used instead of an image unattend file during a client installation. The default setting is **No**.<br />-   [/File:<Relative path> /Architecture:{x86 &#124; ia64 &#124; x64}] - Specifies the file name, path, and architecture of the unattend file.|
|[/AutoaddPolicy]|These settings control the Auto-add policy. You define the settings using the following options:<br /><br />-   [/Policy: {AdminApproval &#124; Disabled}] - **AdminApprove** causes all unknown computers to be added to a pending queue, where the administrator can then review the list of computers and approve or reject each request, as appropriate. **Disabled** indicates that no additional action is taken when an unknown computer attempts to boots to the server.<br />-   [/PollInterval:{time in seconds}] - Specifies the interval (in seconds) at which the network boot program should poll the Windows Deployment Services server.<br />-   [/MaxRetry: <Number>] - Specifies the number of times the network boot program should poll the Windows Deployment Services server. This value, along with **/PollInterval**, dictates how long the network boot program will wait for an administrator to approve or reject the computer before timing out. For example, a **MaxRetry** value of 10 and a **PollInterval** vlue of 60 would indicate that the client should poll the server 10 times, waiting 60 seconds between tries. Therefore, the client would time out after 10 minutes (10 x 60 seconds = 10 minutes).<br />-   [/Message: <Message>] - Specifies the message that is displayed to the client on the network boot program dialog page.<br />-   [/RetentionPeriod] - Specifies the number of days a computer can be in a pending state before being automatically purged.<br />-   [/Approved: <time in days>] - Specifies the retention period for approved computers. You must use this parameter with the **/RetentionPeriod** option.<br />-   [/Others: <time in days>] - Specifies the retention period for unapproved computers (rejected or pending). You must use this parameter with the **/RetentionPeriod** option.|
|[/AutoaddSettings]|Specifies the default settings to be applied to each computer. You define the settings using the following options:<br /><br />-   /Architecture: {x86 &#124; ia64 &#124; x64} - Specifies the architecture.<br />-   [/BootProgram: <Relative path>] - Specifies the boot program sent to the approved computer. If no boot program is specified, the default for the architecture of the computer (as specified on the server) will be used.<br />-   [/WdsClientUnattend: <Relative path>] - Sets the relative path to the unattend file that the approved client should receive.<br />-   [/ReferralServer: <Server name>] - Specifies the Windows Deployment Services server that the client will use to download images.<br />-   [/BootImage: <Relative path>] - Specifies the boot image that the approved client will receive.<br />-   [/User: <Domain\User &#124; User@Domain>] - Sets permissions on the computer account object to give the specified user the necessary rights to join the computer to the domain.<br />-   [JoinRights: {JoinOnly &#124; Full}] - Specifies the type of rights to be assigned to the user. **JoinOnly** requires the administrator to reset the computer account before the user can join the computer to the domain. **Full** gives full access to the user, including the right to join the computer to the domain.<br />-   [/JoinDomain: {Yes &#124; No}] - Specifies whether or not the computer should be joined to the domain as this computer account during a Windows Deployment Services installation. The default setting is **Yes**.|
|[/BindPolicy]|Configures the network interfaces for the PXE provider to listen on. You define the policy using the following options:<br /><br />-   [/Policy: {Include &#124; Exclude}] - Sets the interface bind policy to include or exclude the addresses on the interface list.<br />-   [/add] - adds an interface to the list. You must also specify /addresstype and /address.<br />-   [/remove] - removes an interface from the list. You must also specify /addresstype and /address.<br />-   /address:<IP or MAC address> - Specifies the IP or MAC address of the interface to add or remove.<br />-   /addresstype: {IP &#124; MAC} - Indicates the type of address specified in the **/address** option.|
|[/RefreshPeriod: <seconds>]|Specifies how often (in seconds) the server will refreshes its settings.|
|[/BannedGuidPolicy]|Manages the list of banned GUIDs using the following options:<br /><br />-   [/add] /Guid:<GUID> - adds the specified GUID to the list of banned GUIDs. Any client with this GUID will be identified by its MAC address instead.<br />-   [/remove] /Guid:<GUID> - removes the specified GUID from the list of banned GUIDs.|
|[/BcdRefreshPolicy]|Configures the settings for refreshing Bcd files using the following options:<br /><br />-   [/Enabled:{Yes &#124; No}] - Specifies the Bcd refreshing policy. When **/Enabled** is set to **Yes**, Bcd files are refreshed at the specified time interval.<br />-   [/RefreshPeriod:<time in minutes>] - Specifies the time interval at which Bcd files are refreshed.|
|[/Transport]|Configures the following options:<br /><br /><ul><li>[/ObtainIpv4From: {Dhcp &#124; Range}] - Specifies the source of IPv4 addresses.<br /><br /><ul><li>[/start: <starting Ipv4 address>] - Specifies the start of the IP address range. This option is required and valid only if **/ObtainIpv4From** is set to **Range**</li><li>[/End: <Ending Ipv4 address>] - Specifies the end of the IP address range. This option is required and valid only if **/ObtainIpv4From** is set to **Range**.</li></ul></li><li>[/ObtainIpv6From:Range] [/start:<start IP address>] [/End:<End IP address>]  Specifies the source of IPv6 addresses. This option only applies to Windows Server 2008 R2 and the only supported value is Range.</li><li>[/startPort: <starting port>] - Specifies the start of the port range.</li><li>[/EndPort: <Ending port>] - Specifies the end of the port range.</li><li>[/Profile: {10Mbps &#124; 100Mbps &#124; 1Gbps &#124; Custom}] - Specifies the network profile to be used. This option is only supported forservers running Windows Server 2008.</li><li>[/MulticastSessionPolicy]  Configures the transfer settings for multicast transmissions. This command is only available for Windows Server 2008 R2.<br /><br /><ul><li>[/Policy:{None &#124; AutoDisconnect &#124; Multistream}] - Determines how to handle slow clients. None means to keep all clients in one session at the same speed. AutoDisconnect means that any clients that drop below the specified /Threshold will be disconnected. Multistream means clients will be separated into multiple sessions as specified by /StreamCount.</li><li>[/Threshold:<Speed in KBps>] - for /Policy:AutoDisconnect, this option sets the minimum transfer rate in KBps. Clients that drop below this rate will be disconnected from multicast transmissions.</li><li>[/StreamCount:{2 &#124; 3}] [/Fallback:{Yes &#124; No}] - for /Policy:Multistream, this option determines the number of sessions. 2 means two sessions (fast and slow) 3 means three sessions (slow, medium, fast).</li><li>[/Fallback:{Yes&#124; No}] - Determines whether clients that are disconnected will continue the transfer using another method (if supported by the client). If you are using the WDS client, the computer will fallback to unicasting. Wdsmcast.exe does not support a fallback mechanism. This option also applies to clients that do not support Multistream. In that case, the computer will fall back to another method instead of moving to a slower transfer session.</li></ul></li></ul>|
## <a name="BKMK_examples"></a>Examples
To set the server to answer only known clients, with a response delay of 4 minutes, type:
```
wdsutil /Set-Server /AnswerClients:Known /Responsedelay:4
```
To set the boot program and architecture for the server, type:
```
wdsutil /Set-Server /BootProgram:boot\x86\pxeboot.n12 /Architecture:x86
```
To enable logging on the server, type:
```
wdsutil /Set-Server /WdsClientLogging /Enabled:Yes /LoggingLevel:Warnings
```
To enable unattend on the server, as well as the architecture and the client unattend file, type:
```
wdsutil /Set-Server /WdsUnattend /Policy:Enabled /File:WDSClientUnattend \unattend.xml /Architecture:x86
```
To set the Pre-Boot execution Environment (PXE) server to attempt to bind to TCP ports 67 and 60, type:
```
wdsutil /Set-server /UseDhcpPorts:No /DhcpOption60:Yes
```
#### additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
[Using the disable-Server Command](using-the-disable-server-command.md)
[Using the enable-Server Command](using-the-enable-server-command.md)
[Using the get-Server Command](using-the-get-server-command.md)
[Using the Initialize-Server Command](using-the-initialize-server-command.md)
[Subcommand: start-Server](subcommand-start-server.md)
[Subcommand: stop-Server](subcommand-stop-server.md)
[The uninitialize-Server Option](the-uninitialize-server-option.md)
