---
title: WSUS 3.0 SP2 Security Settings
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0b284e97-679b-4d0f-83e5-99e68bce5fb9
author: britw
---
# WSUS 3.0 SP2 Security Settings
This topic lists security settings that you can implement in the Windows Server operating system, Internet Information Services \(IIS\), and SQL Server to improve the security for a WSUS server.  
  
In this topic:  
  
-   [Windows Server security settings](../Topic/WSUS-3.0-SP2-Security-Settings.md#winserver)  
  
-   [Internet Information Services security settings](../Topic/WSUS-3.0-SP2-Security-Settings.md#iis)  
  
-   [SQL Server security settings](../Topic/WSUS-3.0-SP2-Security-Settings.md#sql)  
  
## <a name="winserver"></a>Windows Server security settings  
We recommend that you implement security for the Windows Server operating system in the following areas. For more information about security in Windows Server, see [Security and Protection](http://go.microsoft.com/fwlink/?LinkID=203806&clcid=0x409) in the Windows Server Technical Library.  
  
-   [Audit policy settings](../Topic/WSUS-3.0-SP2-Security-Settings.md#audit)  
  
-   [Security options for Windows Server](../Topic/WSUS-3.0-SP2-Security-Settings.md#security)  
  
-   [Event log settings](../Topic/WSUS-3.0-SP2-Security-Settings.md#eventlogs)  
  
-   [System service settings](../Topic/WSUS-3.0-SP2-Security-Settings.md#system)  
  
-   [TCP\/IP settings](../Topic/WSUS-3.0-SP2-Security-Settings.md#tcpip)  
  
### <a name="audit"></a>Audit policy settings  
You should enable audit events to make sure that sufficient logs are collected. The logs are valuable for tracking and troubleshooting. For more information about audit policy settings, see the [Security Audit Policy Reference](http://go.microsoft.com/fwlink/?LinkID=203807&clcid=0x409).  
  
### Audit policy settings  
  
|Option|Security setting|Setting rationale|  
|----------|--------------------|---------------------|  
|Audit account logon events|Success, Failure|Audit for successful and failed logon events to collect useful data regarding password brute\-force attempts.|  
|Audit account management|Success, Failure|Audit for successful and failed account management events to track management activities.|  
|Audit directory service access|No Auditing|Important for only domain controllers running Active Directory Domain Services \(AD DS\).|  
|Audit logon events|Success, Failure|Audit for successful and failed logon events that provides useful data regarding password brute\-force attempts.|  
|Audit object access|No Auditing|It is unnecessary to audit object access; this activity creates many unnecessary logs.|  
|Audit policy change|Success, Failure|Audit for successful and failed policy changes to track management activities.|  
|Audit privilege use|Success, Failure|Audit for successful and failed permission usage to track administrator activities.|  
|Audit process tracking|No Auditing|It is unnecessary to audit process\-tracking events for WSUS.|  
|Audit system events|Success, Failure|Audit for successful and failed system events to track system activities.|  
  
### <a name="security"></a>Security options for Windows Server  
We recommend that you configure security settings in the Windows Server operating system in the following ways to guarantee optional security and functionality.  
  
### Security options settings  
  
|Option|Security setting|Setting rationale|  
|----------|--------------------|---------------------|  
|Accounts: Administrator account status|Enabled|The administrator account must be enabled for authorized users.|  
|Accounts: Guest account Status|Disabled|Because it is risky to have guest accounts, the guest account should be disabled.|  
|Accounts: Limit local account use of blank passwords to console logon only|Enabled|Accounts that have blank passwords significantly increase the probability of network\-based attacks.|  
|Accounts: Rename administrator account|Not Defined|Rename the administrator account to force a malicious individual to guess both the account name and password. Note that even though the account can be renamed, it uses a well\-known security identifier \(SID\). Tools are available to quickly identify the SID and thereby resolve the administrator account name.|  
|Accounts: Rename Guest account|Not Defined|Because the Guest account is disabled, it is not important to rename the Guest account.|  
|Audit: Audit the access of global system objects|Enabled|You must enable this setting for auditing to occur in the Event Viewer. The auditing setting can be set to **Not Defined**, **Success**, or **Failure** in the Event View.|  
|Audit: Audit the use of backup and restore privilege|Enabled|You should enable this option so that auditors know about backup activity of potentially sensitive data.|  
|Audit: Shut down system immediately if unable to log security audits|Disabled|If you enable this option, the system shuts down if it cannot log audits. This setting prevents missed audit events. Enabling very large log files on a separate partition helps reduce the effect of this.|  
|Devices: Allow undock without having to log on|Disabled|Disable this option to make sure that only authenticated users can dock and undock computers.|  
|Devices: Allow to format and eject removable media|Administrators|This option is not typically useful for desktop images.|  
|Devices: Prevent users from installing printer drivers|Enabled|The Windows Graphics Device Interface \(GDI\) system runs in kernel space. This allows a user to install a printer driver, which could lead to elevated user rights.|  
|Devices: Restrict CD\-ROM access to locally logged\-on user only|Enabled|Enable this option to prevent remote users from accessing the local CD\-ROM, which might contain sensitive information.|  
|Devices: Restrict floppy access to locally logged\-on user only|Enabled|Enable this option to allow for system recovery where the server is physically secured and password authentication is required by the Recovery Console.|  
|Devices: Unsigned driver installation behavior|Warn but allow for installation|Most driver software is signed. You should not install unsigned drivers unless the origin and authenticity can be verified, and the software has first been thoroughly tested in a lab environment.|  
|Domain controller: Allow server operators to schedule tasks|Disabled|The ability to schedule tasks should be limited to administrators.|  
|Domain controller: LDAP server signing requirements|Not Defined|This option applies only to domain controllers.|  
|Domain controller: Refuse computer account password changes|Disabled|Enable this option to enable computer accounts to automatically change their passwords.|  
|Domain member: Digitally encrypt or sign security channel data \(always\)|Disabled|If the domain controller supports encrypting the security channel, you should enable this option to protect against local network attacks.|  
|Domain member: Digitally encrypt security channel data \(when it is possible\)|Enabled|Enable this option to provide high flexibility and enable the highest security \(when the server supports it\).|  
|Domain member: Digitally sign security channel data \(when it is possible\)|Enabled|Enable this option to provide high flexibility and enable the highest security \(when the server supports it\).|  
|Domain member: Disable computer account password changes|Disabled|Disable this option to enable computer accounts to automatically change their passwords.|  
|Domain member: Maximum computer account password age|30 days|It is easier to break passwords that are rarely changed. You should enable this setting and configure the password to be regularly changed.|  
|Domain member: Require strong \([!INCLUDE[win2kfamily](../Token/win2kfamily_md.md)] or later versions\) session key|Enabled|Enable this option to set strong session keys for all computers that are running at least Windows Server 2000.|  
|Interactive logon: Do not display last user name|Enabled|You should enable this option to hide the last user name, especially when the administrator user account is renamed. This setting helps prevent a passerby from determining account names.|  
|Interactive logon: Do not require CTRL\+ALT\+DEL|Disabled|The CTRL\+ALT\+DEL sequence is intercepted at a level lower than user mode programs can interact. Require this sequence at logon to prevent a Trojan Horse program from capturing users' passwords.|  
|Interactive logon: Message text for users who try to log on|\[provide legal text\]|Use this setting to display an appropriate legal and warning message, according to the corporate security policy.|  
|Interactive logon: Message title for users who try to log on|\[provide legal title text\]|Use this setting to display an appropriate legal and warning message, according to the corporate security policy.|  
|Interactive logon: Number of previous logons to cache \(in case domain controller is not available\)|10 logons|This option is usually appropriate for portable computers that might be disconnected from the domain. It presents a security risk for some types of servers, such as application servers. If a server is compromised and domain logons are cached, the attacker can use this locally stored information to gain domain\-level credentials.|  
|Interactive logon: Prompt user to change password before expiration|14 days|Password prompts should be aligned according to the corporate security policy.|  
|Interactive logon: Require Domain Controller authentication to unlock workstation|Enabled|Enable this option to allow a domain controller account to unlock any workstation. This setting should be enabled for the local Administrator account only.|  
|Interactive logon: Require smart card|Not Defined|If the system does not use smart cards, this option is not required.|  
|Interactive logon: Smart card removal behavior|Not Defined|If the system does not use smart cards, this option is not required.|  
|Microsoft network client: Digitally sign communications \(always\)|Disabled|For systems that communicate with servers that do not support Server Message Block \(SMB\) signing, you should disable this option. If packet authenticity is required, you should enable this option.|  
|Microsoft network client: Digitally sign communications \(if server agrees\)|Enabled|For systems that communicate to servers that support SMB signing, you should enable this option.|  
|Microsoft network client: Send unencrypted password to third\-party SMB servers|Disabled|Enable this option to allow a non\-Microsoft SMB server to negotiate a dialect that does not support cryptographic functions. Authentication is performed by using plain\-text passwords.|  
|Microsoft network server: Amount of idle time required before suspending session|15 minutes|This setting should be defined appropriately so that idle connections do not linger or consume resources.|  
|Microsoft network server: Digitally sign communications \(always\)|Disabled|For systems that communicate to servers that do not support SMB signing, you should disable this option. If packet authenticity is required, you should enable this option.|  
|Microsoft network server: Digitally sign communications \(if client agrees\)|Enabled|For systems that communicate with servers that do not support SMB signing, you should disable this option. If packet authenticity is required, you should enable this option.|  
|Microsoft network server: Disconnect clients when logon hours expire|Enabled|Enable this option to prevent users from logging on after authorized hours.|  
|Network access: Allow anonymous SID\/Name translation|Disabled|This option is highly important to help secure networking for the Windowsoperating system. Disable this setting to severely restrict the abilities that are granted to a user who connects by using a null session.|  
|Network access: Do not allow for anonymous enumeration of SAM accounts|Enabled|This option is highly important to help secure networking for the Windowsoperating system. Enable it to severely restrict the abilities that are granted to a user who connects by using a null session. Because “Everyone” is no longer in the anonymous user’s token, access to IPC$ is not allowed. Pipes that are explicitly set to allow for anonymous users are inaccessible because the SMB tree connection to this shared resource fails.|  
|Network access: Do not allow for anonymous enumeration of SAM accounts and shares|Enabled|This option is highly important to help secure networking for the Windowsoperating system. Enable it to severely restrict the abilities that are granted to a user who connects by using a null session. Because “Everyone” is no longer in the anonymous user’s token, access to IPC$ is not allowed. Pipes that are explicitly set to allow for anonymous users are inaccessible because the SMB tree connection to this shared resource fails.|  
|Network access: Do not allow for storage of credentials or .NET passports for network authentication|Enabled|Enable this option to prevent storing sensitive passwords in the computers’ cache.|  
|Network access: Let Everyone permissions apply to anonymous users|Disabled|Disable this option to prevent access by anonymous users.|  
|Network access: Named Pipes that can be accessed anonymously|Not Defined|Named pipes should be restricted anonymously. Restricting named pipes breaks some intersystem processes, such as network printing.|  
|Network access: Remotely accessed registry paths|Not Defined|Registry paths should be restricted from remote access unless it is required for monitoring purposes.|  
|Network access: Shares that can be accessed anonymously|None|No shared resources should be accessed anonymously.|  
|Network access: Sharing and security model for local accounts|Guest only—local users authenticate as Guest|Limit all local accounts to Guest permissions.|  
|Network security: Do not store LAN Manager hash value on next password change|Enabled|Enable this feature to delete the weaker LAN Manager hashes and reduce the probability of password attacks.|  
|Network security: Force logoff when logon hours expire|Enabled|Enable this option as part of the acceptable policy.|  
|Network security: LAN Manager authentication level|Send NTLMv2 response only|It is less secure to send LAN Manager traffic than to send NTLM traffic. This setting should be enabled only if the system communicates with computers that are running [!INCLUDE[win98](../Token/win98_md.md)] or [!INCLUDE[win95](../Token/win95_md.md)]. Whenever possible, use NTLMv2 only; however, computers that are running [!INCLUDE[win98](../Token/win98_md.md)], Windows 95, or unpatched Windows NT 4.0 will not be able to communicate with servers that are running NTLMv2.|  
|Network security: LDAP client signing requirements|Negotiate signing|Require signing when the system authenticates to non\-Microsoft LDAP servers. This setting prevents attacks against rogue LDAP servers and clear\-text submission of passwords over the network.|  
|Network security: Minimum session security for NTLM SSP\-based \(including secure RPC\) clients|Require NTLMv2 session security|The NTLM hashes contain weaknesses that attacks can exploit. When enabled, these requirements strengthen the authentication algorithms for Windows.|  
|Network security: Minimum session security for NTLM SSP\-based \(including secure RPC\) servers|Require NTLMv2 session security|The NTLM hashes contain weaknesses that attacks could exploit. When enabled, these requirements will strengthen the authentication algorithms for Windows.|  
|Recovery console: Allow automatic administrative logon|Disabled|If automatic administrative logon is enabled, a malicious user who has console access can restart the computer and gain administrative rights. An organization can enable this feature if the computer is a physically secure server. This will allow for access to the system if the administrator password is forgotten.|  
|Recovery console: Allow floppy copy and access to all drives and all folders|Disabled|The recovery console can be used as an attack method to gain access to the Security Account Manager \(SAM\) database files offline; therefore, this option should be enabled to prevent those files from being copied to removable media.|  
|Shutdown: Allow system to be shut down without having to log on|Disabled|This option is used to prevent users who do not have valid accounts from shutting down the system.|  
|Shutdown: Clear virtual memory pagefile|Disabled|Clear the memory page file at shutdown to prevent offline analysis of the file, which might contain sensitive information from system memory. However, in situations in which the computer is physically secured, this can be enabled to reduce system startup time.|  
|System cryptography: Force strong key protection for user keys stored on the computer|User is prompted when the key is first used|Protect local cryptographic secrets to prevent permission escalation across the network after system access is obtained.|  
|System cryptography: Use FIPS compliant algorithms for encryption, hashing, and signing|Not Defined|Require stronger, standard, and compliant algorithms for encryption, hashing, and signing.|  
|System Objects: Default owner for objects created by members of the Administrators group|Administrators group|Only administrators should have access to the created file.|  
|System objects: Require case insensitivity for non\-Windows subsystems|Disabled|Require case\-sensitivity for non\-Windows subsystems, such as UNIX passwords.|  
|System settings: Optional subsystems|Enter POSIX here only if expressly required|The POSIX execution layer has had multiple local exploits in the past, and it should be disabled unless it is required by non\-Microsoft software. It is very rare for POSIX to be required by commercial software packages.|  
|System settings: Use Certificate Rules on Windows executables for Software Restriction policies|Not Defined|When certificate rules are created, you should enable this option to enforce software restriction policies that check a certificate revocation list. A certificate revocation list makes sure that the software's certificate and signature are valid.|  
  
> [!IMPORTANT]  
> The WSUS directories **UpdateServicesPackages**, **WsusContent**, and **WsusTemp** are created as shared directories for WSUS administrators and for the network service account as part of WSUS Setup. By default, these directories are located under the WSUS directory at the root of the largest partition on the WSUS server. If you do not use local publishing, you should disable sharing of these directories.  
  
### <a name="eventlogs"></a>Event log settings  
You can configure Event Log settings to help guarantee that a sufficient level of activity is being monitored. For more information about event logs, see [Event Log](http://go.microsoft.com/fwlink/?LinkID=203808&clcid=0x409) in the Windows Server Technical Library.  
  
### Event log settings  
  
|Option|Security setting|Setting rationale|  
|----------|--------------------|---------------------|  
|Maximum application log size|100489 kilobytes|A large event log lets administrators store and search for problematic and suspicious events.|  
|Maximum security log size|100489 kilobytes|A large event log lets administrators store and search for problematic and suspicious events.|  
|Maximum system log size|100489 kilobytes|A large event log lets administrators store and search for problematic and suspicious events.|  
|Prevent local guests group from accessing application log|Enabled|Guest accounts should not be able to access sensitive information in the event log.|  
|Prevent local guests group from accessing security log|Enabled|Guest accounts should not be able to access sensitive information in the event log.|  
|Prevent local guests group from accessing system log|Enabled|Guest accounts should not be able to access sensitive information in the event log.|  
|Retain application log|7 Days|Logs should be stored on a centralized log server after they have existed for one week.|  
|Retain security log|7 Days|Logs should be stored on a centralized log server after they have existed for one week.|  
|Retain system log|7 Days|Logs should be stored on a centralized log server after they have existed for one week.|  
|Retention method for application log|As Needed|Overwrite audit logs as needed when log files are full.|  
|Retention method for security log|As Needed|Overwrite audit logs as needed when log files are full.|  
|Retention method for system log|As Needed|Overwrite audit logs as needed when log files are full.|  
  
### <a name="system"></a>System service settings  
You should enable only those system services that are required for WSUS. For more information about services, see [System Services](http://go.microsoft.com/fwlink/?LinkID=203809&clcid=0x409) in the Windows Server Technical Library.  
  
### Service recommendations for WSUS  
  
|Option|Security setting|Setting rationale|  
|----------|--------------------|---------------------|  
|Alerter|Disabled|The **alerter** service is useful when an administrator is logged on to the network and wants to be notified of events. For WSUS servers, this service is not required.|  
|Application Management|Manual|This service is necessary only when you install new applications by using Active Directory.|  
|Automatic Updates|Automatic|This service is required to support a currently updated operating environment.|  
|Clipbook|Disabled|This service is unnecessary to WSUS.|  
|COM\+ Event System|Manual|The COM\+ event system might be used in the Web\-based application.|  
|Computer Browser|Automatic|The computer browser service is required on interactive workstations.|  
|DHCP Client|Automatic|DHCP is required to have an IP address on the WSUS server.|  
|Distributed File System|Disabled|The Distributed File System \(DFS\) is used for file sharing across multiple servers. This service is not needed on WSUS servers.|  
|Distributed Link Tracking Client|Disabled|This service is appropriate only if a domain uses distributed link tracking.|  
|Distributed Link Tracking Server|Disabled|This service is appropriate only if a domain uses distributed link tracking.|  
|Distributed Transaction Coordinator|Disabled|This service is appropriate only if a domain uses distributed transactions, which are not needed for WSUS.|  
|DNS Client|Automatic|Domain Name System \(DNS\) is necessary for IP address\-to\-name resolution.|  
|Event Log|Automatic|The Event Log service is important for logging system events. It provides critical auditing information for WSUS.|  
|File Replication|Disabled|This service is used for file replication and synchronization, which are not required for WSUS.|  
|IIS ADMIN Service|Automatic|This service is required for WSUS administration.|  
|Indexing Service|Manual|This service is used by Internet Information Services \(IIS\).|  
|Intersite Messaging|Disabled|This service should be enabled on domain controllers only.|  
|Internet Connection Firewall\/Internet Connection Sharing|Manual|This service is required if the local Internet Connection Firewall \(ICF\) is being used.|  
|IPsec Services|Automatic|This service is required if Internet Protocol security \(IPsec\) is being used.|  
|Kerberos Key Distribution Center|Disabled unless functioning as a domain controller|By default, this service is enabled to join and authenticate to domain controllers that are running the Windows Server operating system.|  
|License Logging Service|Disabled|This service is necessary for systems on which application licensing must be tracked.|  
|Logical Disk Manager|Automatic|This service is used in logical disk management.|  
|Logical Disk Manager Administrative Service|Manual|This service is used in logical disk management.|  
|Messenger|Disabled|This service is necessary only if NetBIOS messaging is being used.|  
|Net Logon|Automatic|This service is necessary for domain membership.|  
|NetMeeting Remote Desktop Sharing|Disabled|NetMeeting is an application that enables collaboration over a network. It is used on interactive workstations, and should be disabled for servers because it presents a security risk.|  
|Network Connections|Manual|This service enables network connections to be centrally managed.|  
|Network DDE|Disabled|Network Dynamic Data Exchange \(DDE\) is a form of interprocess communication \(IPC\) across networks. Because Network DDE opens network shares and allows for remote access to local resources, it should be disabled unless it is explicitly needed.|  
|Network DDE DSDM|Disabled|Network DDE is a form of IPC across networks. Because Network DDE opens network shared resources and allows for remote access to local resources, it should be disabled unless explicitly needed.|  
|NTLM Security Support Provider|Manual|The NTLM Security Support Provider is required to authenticate users of remote procedure call \(RPC\) services that use transports such as TCP and UDP.|  
|Performance Logs and Alerts|Manual|This service is only necessary when logs and alerts are used.|  
|Plug and Play|Automatic|Plug and Play is needed if the system uses Plug and Play hardware devices.|  
|Print Spooler|Disabled|This service is necessary if the system is used for printing.|  
|Protected Storage|Automatic|This service must be enabled for the IIS Admin service.|  
|Remote Access Auto Connection Manager|Disabled|Enable this service for remote access servers only.|  
|Remote Access Connection Manager|Disabled|Enable this service for remote access servers only.|  
|Remote Procedure Call \(RPC\)|Automatic|This service is required for RPC communications.|  
|Remote Procedure Call \(RPC\) Locator|Manual|This service is required for RPC communications.|  
|Remote Registry|Manual|Remote Registry is a key target for attackers, viruses, and worms. This setting should be set to manual unless otherwise needed, where the server can enable it.|  
|Removable Storage|Manual|For a dynamic server, this service is necessary.|  
|Routing and Remote Access|Disabled|Enable this service for remote access servers only.|  
|Security Accounts Manager|Automatic|This service should be enabled because it manages local accounts.|  
|Server|Automatic|This service should be enabled or disabled as necessary. The service supports file, print, and named\-pipe sharing over the network for this computer.|  
|Smart Card|Manual|Because users will not be using smart cards for two\-factor logon authentication, this service is unnecessary and should be disabled or set to manual.|  
|System Event Notification|Automatic|This service is needed for COM\+ events.|  
|Task Scheduler|Manual|This service should be enabled or disabled as necessary. The service enables a user to configure and schedule automated tasks on this computer.|  
|TCP\/IP NetBIOS Helper|Automatic|This service is used in Windows networking for computers that are running an operating system earlier than Windows Server 2003.|  
|Telephony|Disabled|This service is not required for WSUS because telephony devices are not used.|  
|Telnet|Disabled|The telnet service should be disabled.|  
|Terminal Services|Manual|Terminal services should be enabled or disabled as necessary.|  
|Uninterruptible Power Supply|Manual|This service is necessary if a uninterruptible power supply \(UPS\) is used.|  
|Windows Installer|Manual|Because users can use Windows Installer to install .msi packages on the system, this service should be set to Manual.|  
|Windows Management Instrumentation|Manual|Windows Management Instrumentation \(WMI\) provides extended management capabilities.|  
|Windows Management Instrumentation Driver Extensions|Manual|WMI Driver Extensions enable monitoring of network card connection state in the taskbar.|  
|Windows Time|Automatic|External time synchronization is required for Kerberos key exchange in Active Directory environments.|  
|Workstation|Automatic|The workstation service is necessary for networking for the Windowsoperating system.|  
  
### <a name="tcpip"></a>TCP\/IP settings  
We recommend that you use the following settings on the TCP\/IP interface for WSUS servers. For more information, see [TCP\/IP Registry Values for Microsoft Windows Vista and Windows Server 2008](http://go.microsoft.com/fwlink/?LinkID=203810&clcid=0x409) in the Microsoft Download Center.  
  
> [!WARNING]  
> [!INCLUDE[Registry](../Token/Registry_md.md)]  
  
### TCP\/IP registry key settings  
  
|Registry key|Security setting|Setting rationale|  
|----------------|--------------------|---------------------|  
|HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\Tcpip\\Parameters\\SynAttackProtect|REG\_DWORD \= 1|Causes TCP to adjust transmission of SYN attacks.|  
|HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\Tcpip\\Parameters\\TcpMaxHalfOpen|REG\_DWORD \= 500|Helps protect against SYN attacks.|  
|HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\Tcpip\\Parameters\\TcpMaxHalfOpenRetried|REG\_DWORD \= 400|Helps protect against SYN attacks.|  
|HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\Tcpip\\Parameters\\EnableICMPredirect|REG\_DWORD \= 0|Prevents expensive host routes when an ICMP redirect packet is received.|  
|HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\Tcpip\\Parameters\\DeadGWDetectDefault|REG\_DWORD \= 1|Allows TCP to detect failure of the default gateway and to adjust the IP routing table to use another default gateway.|  
|HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\Tcpip\\Parameters\\DisableIPSourceRouting|REG\_DWORD \= 1|Disables IP source routing.|  
|HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\Tcpip\\Parameters\\IPEnableRouter|REG\_DWORD \= 0|Disables forwarding packets between network interfaces.|  
  
## <a name="iis"></a>Internet Information Services security settings  
To secure WSUS administration, you should enable the IIS security settings in the following areas. For more information, see [Security Guidance for IIS](http://go.microsoft.com/fwlink/?LinkID=203811&clcid=0x409) in the Windows Server Technical Library.  
  
-   [Enable general IIS error messages](../Topic/WSUS-3.0-SP2-Security-Settings.md#iiserror)  
  
-   [Enable additional IIS logging options](../Topic/WSUS-3.0-SP2-Security-Settings.md#iislogging)  
  
-   [Remove IIS header extensions](../Topic/WSUS-3.0-SP2-Security-Settings.md#iisheader)  
  
### <a name="iiserror"></a>Enable general IIS error messages  
By default, IIS provides detailed error messages to remote web client computers. We recommend that you enable less\-detailed, general IIS error messages to prevent an unauthorized user from probing the IIS environment by using the error details.  
  
##### To enable general IIS error messages  
  
1.  On the **Start** menu, point to **Programs**, point to **Administrator Tools**, and then click **Internet Information Services \(IIS\) Manager**.  
  
2.  Expand the local computer node and expand **Sites**.  
  
3.  Click **Default Web Site**.  
  
4.  Under **HTTP Features**, right\-click **Error Pages**, and then click **Open Feature**.  
  
5.  Under **Actions**, click **Edit Feature Settings**.  
  
6.  On the **Edit Error Pages Settings** page, select **Detailed errors for local requests and custom error pages for remote requests**, and then click **OK**.  
  
    You can optionally browse to a text file that contains a custom message that you want to display to users.  
  
### <a name="iislogging"></a>Enable additional IIS logging options  
By default, IIS enables logging for a selected number of options. We recommend that you enable logging for several additional options.  
  
##### To enable additional IIS logging options  
  
1.  On the **Start** menu, point to **Programs**, point to **Administrator Tools**, and then click **Internet Information Services \(IIS\) Manager**.  
  
2.  Expand the local computer node and expand **Sites**.  
  
3.  Click **Default Web Site**.  
  
4.  Under **Health and Diagnostics**, right\-click **Logging**, and then click **Open Feature**.  
  
5.  Under **Log File**, click **Select Fields**.  
  
6.  Select the check boxes for the following logging fields, and then click **OK**.  
  
    -   **Server Name \(s\-computername\)**  
  
    -   **Time taken \(time\-taken\)**  
  
    -   **Host \(cs\-host\)**  
  
    -   **Cookie \(cs\(cookie\)\)**  
  
    -   **Referer \(cs\(Referer\)\)**  
  
### <a name="iisheader"></a>Remove IIS header extensions  
By default, IIS enables header extensions for HTTP requests. We recommend that you remove IIS header extensions.  
  
##### To remove header extensions for HTTP requests  
  
1.  On the **Start** menu, point to **Programs**, point to **Administrator Tools**, and then click **Internet Information Services Manager**.  
  
2.  Expand the local computer node and expand **Sites**.  
  
3.  Click **Default Web Site**.  
  
4.  Under **HTTP Features**, right\-click **HTTP Response Headers**, and then click **Open Feature**.  
  
5.  Select the row that contains the name **X\-Powered\-By**, with the value of **ASP.NET**, and then click **Remove**. When you are prompted to confirm the action, click **Yes**.  
  
## <a name="sql"></a>SQL Server security settings  
We recommend that you implement the following security measures if you are using SQL Server with WSUS. For more information about security and SQL Server, see [Security Considerations for a SQL Server Installation](http://go.microsoft.com/fwlink/?LinkID=203803&clcid=0x409).  
  
-   [SQL Server registry permissions](../Topic/WSUS-3.0-SP2-Security-Settings.md#sqlreg)  
  
-   [SQL Server stored procedures](../Topic/WSUS-3.0-SP2-Security-Settings.md#sqlsp)  
  
### <a name="sqlreg"></a>SQL Server registry permissions  
Use access control permissions to help secure the SQL Server registry keys.  
  
> [!WARNING]  
> [!INCLUDE[Registry](../Token/Registry_md.md)]  
  
**HKEY\_LOCAL\_MACHINE\\SOFTWARE\\MICROSOFT\\MSSQLSERVER**  
  
|ISEC setting|Rationale|  
|----------------|-------------|  
|Administrators: Full Control<br /><br />SQL Service Account: Full Control<br /><br />System: Full Control|These settings limit access to the application’s registry key to authorized administrators or system accounts.|  
  
### <a name="sqlsp"></a>SQL Server stored procedures  
Remove all stored procedures that are unnecessary and that can let unauthorized users perform command\-line actions on the database. You can remove stored procedures by using the following command:  
  
**use master exec sp\_dropextendedproc***stored procedure*  
  
where:  
  
*stored procedure* is the name of the stored procedure that is to be removed.  
  
We recommend that you remove the following stored procedures:  
  
-   Sp\_OACreate  
  
-   Sp\_OADestroy  
  
-   Sp\_OAGetErrorInfo  
  
-   Sp\_OAGetProperty  
  
-   Sp\_OAMethod  
  
-   Sp\_OASetProperty  
  
-   SP\_OAStop  
  
-   Xp\_regaddmultistring  
  
-   Xp\_regdeletekey  
  
-   Xp\_regdeletevalue  
  
-   Xp\_regenumvalues  
  
-   Xp\_regread  
  
-   Xp\_regremovemultistring  
  
-   Xp\_regwrite  
  
-   sp\_sdidebug  
  
-   xp\_availablemedia  
  
-   xp\_cmdshell  
  
-   xp\_deletemail  
  
-   xp\_dirtree  
  
-   xp\_dropwebtask  
  
-   xp\_dsninfo  
  
-   xp\_enumdsn  
  
For more information about SQL Server stored procedures, see [SQL Server Agent Stored Procedures \(Transact\-SQL\)](http://go.microsoft.com/fwlink/?LinkID=203802&clcid=0x409).  
  
## See Also  
[Secure the WSUS 3.0 SP2 Deployment](assetId:///5c494e41-05d1-4403-ae7b-4fbca2e56cd7)  
  
