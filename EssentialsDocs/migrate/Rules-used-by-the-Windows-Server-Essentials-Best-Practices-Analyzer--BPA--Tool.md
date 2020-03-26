---
title: "Rules used by the Windows Server Essentials Best Practices Analyzer (BPA) Tool"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 37e1dae7-586c-4dd7-bf83-7e14a9567c8f
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Rules used by the Windows Server Essentials Best Practices Analyzer (BPA) Tool

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

This article describes the rules used by the  Windows Server Essentials Best Practices Analyzer (BPA). The BPA examines a server that is running  Windows Server Essentials and presents a report that describes issues and provides recommendations for resolving them. The recommendations are developed by the product support organization for  Windows Server Essentials.  
  
## Using the tool  
 It is a standard practice, when you migrate to  Windows Server Essentials from Windows Server 2011 Essentials, Windows Small Business Server 2011 Essentials, or Windows Home Server 2011, to run the BPA on the Destination Server after you finish migrating your settings and data. You can run the tool from the Dashboard at any time.  
  
#### To run the  Windows Server Essentials BPA on the server  
  
1.  Log on to the server as an administrator, and then open the Dashboard.  
  
2.  On the Dashboard, click the **Devices** tab.  
  
3.  On the **Server Tasks** pane, click **Best Practices Analyzer**.  
  
4.  Review each BPA message, and follow the instructions to resolve issues if necessary.  
  
## Rules used by the Best Practices Analyzer  
  
### Disable IP filtering  
 **Issue:** IP filtering is currently enabled on the server. You must disable IP filtering.  
  
 **Impact:** If IP filtering is enabled, network traffic might be blocked.  
  
 **Resolution:**  
  
##### To disable IP filtering  
  
1.  Open regedit.exe on the server.  
  
2.  Navigate to HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters.  
  
3.  Right-click **EnableSecurityFilters**, and then click **Modify**.  
  
4.  In the **Edit DWORD (32-bit) Value** window, change the **Value data** field to zero, and then click **OK**.  
  
5.  To apply the change, restart the server.  
  
### The Distributed Transaction Coordinator (MSDTC) service should be set to start automatically by default  
 **Issue:** The MSDTC service is not configured to start automatically  
  
 **Impact:** The MSDTC service might not start automatically when the server starts. If the service is stopped, some SQL Server or COM functions might fail. As a result, applications that use Microsoft SQL Server or COM functions might not work correctly.  
  
 **Resolution:**  
  
##### To configure the MSDTC service to start automatically  
  
1.  Open services.msc on the server.  
  
2.  Right-click the **Distributed Transaction Coordinator** service, and then click **Properties**.  
  
3.  On the **General** tab, change the **Startup type** to **Automatic (Delayed Start)**, and then click **OK**.  
  
### The Netlogon service should be configured to start automatically by default  
 **Issue:** The Netlogon service is not configured to start automatically.  
  
 **Impact:**  The Netlogon service might not start automatically when the server starts. If the service is stopped, the server might not authenticate users and services.  
  
 **Resolution:**  
  
##### To configure the Netlogon service to start automatically  
  
1.  Open services.msc on the server.  
  
2.  Right-click the **Netlogon** service, and then click **Properties**.  
  
3.  On the **General** tab, change the **Startup type** to **Automatic**, and then click **OK**.  
  
### The DNS Client service should be configured to start automatically by default  
 **Issue:**  The DNS Client service is not configured to start automatically.  
  
 **Impact:**  The DNS Client service might not start automatically when the server starts. If this service is stopped, the server might not be able to resolve DNS names.  
  
 **Resolution:**  
  
##### To configure the DNS Client service to start automatically  
  
1.  Open services.msc on the server.  
  
2.  Right-click the **DNS Client** service, and then click **Properties**.  
  
3.  On the **General** tab, change the **Startup type** to **Automatic**, and then click **OK**.  
  
### The DNS Server service should be configured to start automatically by default  
 **Issue:**  The DNS Server service is not configured to start automatically.  
  
 **Impact:**  The DNS Server service might not start automatically when the server starts. If this service is stopped, DNS updates will not occur.  
  
 **Resolution:**  
  
##### To configure the DNS Server service to start automatically  
  
1.  Open services.msc on the server.  
  
2.  Right-click the **DNS Server** service, and then click **Properties**.  
  
3.  On the **General** tab, change the **Startup type** to **Automatic**, and then click **OK**.  
  
### Active Directory Web Services is not set to the default start mode  
 **Issue:**  Active Directory Web Services is not set to the default start mode of Automatic.  
  
 **Impact:**  Active Directory Web Services (ADWS) is not set to the default start mode of Automatic. If ADWS on the server is stopped or disabled, client applications such as the Active Directory module for Windows PowerShell or the Active Directory Administrative Center cannot access or manage directory service instances that are running on this server. For more information, see [What's New in AD DS: Active Directory Web Services](https://technet.microsoft.com/library/dd391908\(WS.10\).aspx) (https://technet.microsoft.com/library/dd391908(WS.10).aspx) in the Windows Server Technical Library.  
  
 **Resolution:**  
  
##### To configure the Active Directory Web Services service to start automatically  
  
1.  Open services.msc on the server.  
  
2.  Right-click the **Active Directory Web Services** service, and then click **Properties**.  
  
3.  On the **General** tab, change the **Startup type** to **Automatic**, and then click **OK**.  
  
### The DHCP Client service should be configured to start automatically by default  
 **Issue:**  The DHCP Client service is not configured to start automatically.  
  
 **Impact:**  The DHCP Client service will not start automatically when the server starts. If this service is stopped, client computers cannot receive an IP address from the server.  
  
 **Resolution:**  
  
##### To configure the DHCP Client service to start automatically  
  
1.  Open services.msc on the server.  
  
2.  Right-click the **DHCP Client** service, and then click **Properties**.  
  
3.  On the **General** tab, change the **Startup type** to **Automatic**, and then click **OK**.  
  
### The IIS Admin Service should be configured to start automatically by default  
 **Issue:** The IIS Admin Service is not configured to start automatically.  
  
 **Impact:** The IIS Admin Service will not start automatically when the server starts. If this service is stopped, you might be unable to access websites running on the server, such as Remote Web Access.  
  
 **Resolution:**  
  
##### To configure the IIS Admin service to start automatically  
  
1.  Open services.msc on the server.  
  
2.  Right-click **IIS Admin Service**, and then click **Properties**.  
  
3.  On the **General** tab, change the **Startup type** to **Automatic**, and then click **OK**.  
  
### The World Wide Web Publishing Service should be configured to start automatically by default  
 **Issue:**  The World Wide Web Publishing Service is not configured to start automatically.  
  
 **Impact:**  The World Wide Web Publishing Service might not start automatically when the server starts. If this service is stopped, you might be unable to access websites running on the server, such as Remote Web Access.  
  
 **Resolution:**  
  
##### To configure the World Wide Web Publishing Service to start automatically  
  
1.  Open services.msc on the server.  
  
2.  Right-click **World Wide Web Publishing Service**, and then click **Properties**.  
  
3.  On the **General** tab, change the **Startup type** to **Automatic**, and then click **OK**.  
  
### The Remote Registry service should be configured to start automatically by default  
 **Issue:**  The Remote Registry service is not configured to start automatically.  
  
 **Impact:**  
  
 The Remote Registry service might not start automatically when the server starts. If this service is stopped, you might be unable to perform some network operations remotely.  
  
 **Resolution:**  
  
##### To configure the Remote Registry service to start automatically  
  
1.  Open services.msc on the server.  
  
2.  Right-click the **Remote Registry** service, and then click **Properties**.  
  
3.  On the **General** tab, change the **Startup type** to **Automatic**, and then click **OK**.  
  
### The Remote Desktop Gateway service should be configured to start automatically by default  
 **Issue:**  The Remote Desktop Gateway service is not configured to start automatically.  
  
 **Impact:**  If this service is stopped, users might be unable to access computers using Remote Web Access.  
  
 **Resolution:**  
  
##### To configure the Remote Desktop Gateway service to start automatically  
  
1.  Open services.msc on the server.  
  
2.  Right-click the **Remote Desktop Gateway** service, and then click **Properties**.  
  
3.  On the **General** tab, change the **Startup type** to **Automatic (Delayed Start)**, and then click **OK**.  
  
### The Windows Time service should be configured to start automatically by default  
 **Issue:**  The Windows Time service is not configured to start automatically.  
  
 **Impact:**  If this service is stopped, data and time synchronization are not available.  
  
 **Resolution:**  
  
##### To configure the Windows Time service to start automatically  
  
1.  Open services.msc on the server.  
  
2.  Right-click the **Windows Time** service, and then click **Properties**.  
  
3.  On the **General** tab, change the **Startup type** to **Automatic**, and then click **OK**.  
  
### The Distributed Transaction Coordinator (MSDTC) service should be started  
 **Issue:**  The MSDTC service is not running on the server.  
  
 **Impact:**  If this service is stopped, some SQL Server or COM functions might fail. As a result, applications that use Microsoft SQL Server or COM functions might not work correctly.  
  
 **Resolution:**  
  
##### To start the Distributed Transaction Coordinator service  
  
1.  Open services.msc on the server.  
  
2.  Right-click the **Distributed Transaction Coordinator** service, and then click **Start**.  
  
### The Netlogon service should be started  
 **Issue:**  The Netlogon service is not running on the server.  
  
 **Impact:**  If this service is not started, the server might not authenticate users and services.  
  
 **Resolution:**  
  
##### To start the Netlogon service  
  
1.  Open services.msc on the server.  
  
2.  Right-click the **Netlogon** service, and then click **Start**.  
  
### The DNS Client service should be started  
 **Issue:**  The DNS Client service is not running on the server.  
  
 **Impact:**  If this service is not started, the server might be unable to resolve DNS names.  
  
 **Resolution:**  
  
##### To start the DNS Client service  
  
1.  Open services.msc on the server.  
  
2.  Right-click the **DNS Client** service, and then click **Start**.  
  
### The DNS Server service should be started  
 **Issue:**  The DNS Server service is not running on the server.  
  
 **Impact:**  If the DNS Server service is not started, DNS updates might not occur.  
  
 **Resolution:**  
  
##### To start the DNS Server service  
  
1.  Open services.msc on the server.  
  
2.  Right-click the **DNS Server** service, and then click **Start**.  
  
### Active Directory Web Services is not started  
 **Issue:**  Active Directory Web Services is not started.  
  
 **Impact:**  Active Directory Web Services (ADWS) is not started. If ADWS on the server is stopped or disabled, client applications such as the Active Directory module for Windows PowerShell or the Active Directory Administrative Center cannot access or manage directory service instances that are running on this server. For more information, see [What's New in AD DS: Active Directory Web Services](https://technet.microsoft.com/library/dd391908\(WS.10\).aspx) (https://technet.microsoft.com/library/dd391908(WS.10).aspx) in the Windows Server Technical Library.  
  
 **Resolution:**  
  
##### To start the Active Directory Web Services service  
  
1.  Open services.msc on the server.  
  
2.  Right-click **Active Directory Web Services**, and then click **Start**.  
  
### The DHCP Client service should be started  
 **Issue:**  The DHCP Client service is not running on the server.  
  
 **Impact:**  If this service is stopped, client computers cannot receive an IP address from the server.  
  
 **Resolution:**  
  
##### To start the DHCP Client service  
  
1.  Open services.msc on the server.  
  
2.  Right-click the **DHCP Client** service, and then click **Start**.  
  
### The IIS Admin Service should be started  
 **Issue:**  The IIS Admin Service is not running on the server.  
  
 **Impact:**  If this service is stopped, you might be unable to access websites running on the server, such as Remote Web Access.  
  
 **Resolution:**  
  
##### To start the IIS Admin Service  
  
1.  Open services.msc on the server.  
  
2.  Right-click **IIS Admin Service**, and then click **Start**.  
  
### The World Wide Web Publishing Service should be started  
 **Issue:**  The World Wide Web Publishing Service is not running on the server.  
  
 **Impact:**  If this service is stopped, you might be unable to access websites running on the server, such as Remote Web Access.  
  
 **Resolution:**  
  
##### To start the World Wide Web Publishing Service  
  
1.  Open services.msc on the server.  
  
2.  Right-click **World Wide Web Publishing Service**, and then click **Start**.  
  
### The Remote Desktop Gateway service should be started  
 **Issue:**  The Remote Desktop Gateway service is not running on the server.  
  
 **Impact:**  If this service is stopped, users might be unable to access computers by using Remote Web Access.  
  
 **Resolution:**  
  
##### To start the Remote Desktop Gateway Service  
  
1.  Open services.msc on the server.  
  
2.  Right-click the **Remote Desktop Gateway** service, and then click **Start**.  
  
### The Windows Time service should be started  
 **Issue:**  The Windows Time service is not running on the server.  
  
 **Impact:**  If this service is stopped, data and time synchronization will be unavailable.  
  
 **Resolution:**  
  
##### To start the Windows Time Service  
  
1.  Open services.msc on the server.  
  
2.  Right-click the **Windows Time** service, and then click **Start**.  
  
### The Distributed Transaction Coordinator (MSDTC) service logon account should be NT AUTHORITY\Network Service  
 **Issue:**  The default logon account for the Distributed Transaction Coordinator (MSDTC) service is changed.  
  
 **Impact:**  The service might not have the permissions that are required to work as expected. As a result, applications that use SQL Server or COM functions might not work correctly.  
  
 **Resolution:**  
  
##### To change the logon account for the service  
  
1.  Open services.msc on the server.  
  
2.  Right-click the **Distributed Transaction Coordinator** service, and then click **Properties**.  
  
3.  On the **Log On** tab, select **This account**, type **NT AUTHORITY\Network Service**, and then click **OK**.  
  
### The Netlogon service should use the Local System account as its logon account  
 **Issue:**  The default logon account for the Netlogon service is changed.  
  
 **Impact:**  The service might not have the permissions that are required to work as expected. As a result, the server might not authenticate users and services.  
  
 **Resolution:**  
  
##### To change the Netlogon service logon account  
  
1.  Open services.msc on the server.  
  
2.  Right-click the **Netlogon** service, and then click **Properties**.  
  
3.  On the **Log On** tab, select **Local System account**.  
  
### The DNS Client service should use the NT AUTHORITY\Network Service account as its logon account  
 **Issue:**  The default logon account for the DNS Client service is changed.  
  
 **Impact:**  The service might not have the permissions that are required to work as expected. As a result, the server might be unable to resolve DNS names.  
  
 **Resolution:**  
  
##### To change the DNS Client service logon account  
  
1.  Open services.msc on the server.  
  
2.  Right-click the **DNS Client** service, and then click **Properties**.  
  
3.  On the **Log On** tab, select **This account**, and then type **NT AUTHORITY\Network Service**.  
  
### The DNS Server service should use the Local System account as its logon account  
 **Issue:**  The default logon account for the DNS Server service is changed.  
  
 **Impact:**  The service might not have the permissions that are required to work as expected. As a result, DNS updates might not occur.  
  
 **Resolution:**  
  
##### To change the DNS Server service logon account  
  
1.  Open services.msc on the server  
  
2.  Right-click the **DNS Server** service, and then click **Properties**.  
  
3.  On the **Log On** tab, select **Local System account**.  
  
### Active Directory Web Services is not the default logon account  
 **Issue:**  Active Directory Web Services is not the default logon account. By default, the logon account is set to **Local System account**.  
  
 **Impact:**  Active Directory Web Services (ADWS) is not started. If ADWS on the server is stopped or disabled, client applications such as the Active Directory module for Windows PowerShell or the Active Directory Administrative Center cannot access or manage directory service instances that are running on this server. For more information, see [What's New in AD DS: Active Directory Web Services](https://technet.microsoft.com/library/dd391908\(WS.10\).aspx) (https://technet.microsoft.com/library/dd391908(WS.10).aspx) in the Windows Server Technical Library.  
  
 **Resolution:**  
  
##### To change the Active Directory Web Services logon account  
  
1.  Open services.msc on the server.  
  
2.  Right-click **Active Directory Web Services**, and then click **Properties**.  
  
3.  Change the **Startup type** to **Automatic**, and then click **OK**.  
  
4.  In Active Directory Web Services **Properties**, click the **Log On** tab.  
  
5.  Select the **Local System account** option, and then click **OK**.  
  
### The Windows Update service should use the Local System account as its logon account  
 **Issue:**  The default logon account for the Automatic Updates service is changed.  
  
 **Impact:**  The service might not have the permissions that are required to work as expected. As a result, the server might not receive automatic updates.  
  
 **Resolution:**  
  
##### To change the Windows Update service logon account  
  
1.  Open services.msc on the server.  
  
2.  Right-click the **Windows Update** service, and then click Properties.  
  
3.  On the **Log On** tab, select **Local System account**.  
  
### The DHCP Client service should use the NT AUTHORITY\LocalService account as its logon account  
 **Issue:**  The default logon account for the DHCP Client service is changed.  
  
 **Impact:**  The service might not have the permissions that are required to work as expected. As a result, the client computer will not receive IP addresses from the server.  
  
 **Resolution:**  
  
##### To change the DHCP Client service logon account  
  
1.  Open services.msc on the server.  
  
2.  Right-click the **DHCP Client** service, and then click **Properties**.  
  
3.  On the **Log On** tab, select **This account**, and then type **NT AUTHORITY\Local Service**.  
  
### The IIS Admin service should use the Local System account as its logon account  
 **Issue:**  The default logon account for the IIS Admin service is changed.  
  
 **Impact:**  The service might not have the permissions required that are required to work as expected. As a result, you might be unable to access websites running on the server, such as Remote Web Access.  
  
 **Resolution:**  
  
##### To change the service logon account  
  
1.  Open services.msc on the server.  
  
2.  Right-click **IIS Admin service**, and then click **Properties**.  
  
3.  On the **Log On** tab, select **Local System account**.  
  
### The World Wide Web Publishing Service should use the Local System account as its logon account  
 **Issue:**  The default logon account for the World Wide Web Publishing Service is changed.  
  
 **Impact:**  The service might not have the permissions that are required to work as expected. As a result, you might be unable to access websites running on the server, such as Remote Web Access.  
  
 **Resolution:**  
  
##### To change the World Wide Web Publishing Service logon account  
  
1.  Open services.msc on the server.  
  
2.  Right-click **World Wide Web Publishing Service**, and then click **Properties**.  
  
3.  On the **Log On** tab, select **Local System account**.  
  
### The Remote Desktop Gateway service should use the NT AUTHORITY\Network Service account as its logon account  
 **Issue:**  The default logon account for the Remote Desktop Gateway service is changed.  
  
 **Impact:**  The service might not have the appropriate permissions to work as expected. As a result, users might not be able to access computers by using Remote Web Access.  
  
 **Resolution:**  
  
##### To change the Remote Desktop Gateway service logon account  
  
1.  Open services.msc on the server.  
  
2.  Right-click the **Remote Desktop Gateway** service, and then click **Properties**.  
  
3.  On the **Log On** tab, select **This account**, and then type **NT AUTHORITY\Network Service**.  
  
### The Windows Time service should use the NT AUTHORITY\Network Service account as its logon account  
 **Issue:**  The default logon account for the Windows Time service is changed.  
  
 **Impact:**  The service might not have the appropriate permissions to work as expected. As a result, date and time synchronization might be unavailable.  
  
 **Resolution:**  
  
##### To change the Windows Time service logon account  
  
1.  Open services.msc on the server.  
  
2.  Right-click the **Windows Time** service, and then click **Properties**.  
  
3.  On the **Log On** tab, select **This account**, and then type **NT AUTHORITY\Local Service**.  
  
### The built-in Administrators group does not have the right to log on as batch job  
 **Issue:**  The built-in Administrators group does not have the right to log on as a batch job.  
  
 **Impact:**  If the Administrator creates an alert and configures the alert to run when the Administrator is not logged on, the alert will fail with an error code of 2147943785.  
  
 **Resolution:**  For information about how to give the built-in Administrators group permission to log on as a batch job, see [Give the built-in Administrator group the right to log on as a batch job](https://technet.microsoft.com/library/jj635076) (https://technet.microsoft.com/library/jj635076).  
  
### The Windows Firewall is turned off  
 **Issue:**  Windows Firewall is turned off. The default value is on.  
  
 **Impact:**  Depending on your firewall settings, Windows Firewall can help protect your server and network from malicious activity by blocking some information from passing through the server.  
  
 **Resolution:**  
  
##### To turn on Windows Firewall on the server  
  
1.  Open Control Panel on the server.  
  
2.  In Control Panel, click **System and Security**, and then click **Windows Firewall**.  
  
3.  In Windows Firewall, click **Turn Windows Firewall on or off**, select the **Turn on Windows Firewall** option, and then click **OK**.  
  
### The internal network adapter is not configured to register IP address in DNS  
 **Issue:**  The internal network adapter is not configured to register its IP address in DNS.  
  
 **Impact:**  If the IP address of the internal network adapter is not registered in DNS, it might not be possible to access the server by using the server s computer name.  
  
 **Resolution:**  Verify that the internal network adapter is configured to register in DNS.  
  
### DNS: The values for the DNS ForwardingTimeout and RecursionTimeout registry key are identical  
 **Issue:**  The value of the DNS ForwardingTimeout registry key should not be the same as the value of the RecursionTimeout registry key.  
  
 **Impact:**  You might not be able to access Internet resources by name.  
  
 **Resolution:**  Set the value for the RecursionTimeout registry key to be greater than the value of the ForwardingTimeout key, located in the registry at HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DNS\Parameters.  
  
### The forward DNS zone for your Active Directory domain does not allow secure updates  
 **Issue:**  You should configure the forward lookup zone to allow only secure dynamic updates.  
  
 **Impact:**  When you enable secure dynamic updates, only authorized users and hosts can make changes to the records.  
  
 **Resolution:**  
  
##### To configure the forward lookup zone for your Active Directory domain  
  
1.  Open dnsmgmt.msc on the server.  
  
2.  Right-click the forward lookup zone for your Active Directory domain, and then click **Properties**.  
  
3.  In the **Dynamic updates** drop-down list, select **Secure only**, and then click **OK**.  
  
### The forward DNS zone does not allow secure updates  
 **Issue:**  You should configure the forward lookup zone for the _msdcs.* zone to allow only secure dynamic updates.  
  
 **Impact:**  When you enable secure dynamic updates, only authorized users and hosts can make changes to records in the msdcs.* zone.  
  
 **Resolution:**  
  
##### To allow secure updates in the _msdcs zone  
  
1.  Open dnsmgmt.msc on the server.  
  
2.  Right-click the forward lookup zone for the _msdcs zone, and then click **Properties**.  
  
3.  In the **Dynamic updates** drop-down list, select **Secure only**, and then click **OK**.  
  
### Internet Explorer Enhanced Security Configuration is not enabled  
 **Issue:**  Internet Explorer Enhanced Security Configuration (IE ESC) is currently not enabled for the Administrators group.  
  
 **Impact:**  If Internet Explorer Enhanced Security Configuration is not enabled for the Administrators group, your server and Internet Explorer have increased exposure to malicious attacks that can occur through Web content and application scripts.  
  
 **Resolution:**  
  
##### To enable Internet Explorer Enhanced Security Configuration  
  
1.  Open **Server Manager** on the server, and then click **Local Server**.  
  
2.  On the **Properties** pane, change the setting for **IE Enhanced Security Configuration** to **On**, and then click **OK**.  
  
### Internet Explorer Enhanced Security Configuration is not enabled  
 **Issue:**  Internet Explorer Enhanced Security Configuration (IE ESC) is currently not enabled for the Users group.  
  
 **Impact:**  If Internet Explorer Enhanced Security Configuration is not enabled for the Users group, your server and Internet Explorer have increased exposure to malicious attacks that can occur through Web content and application scripts.  
  
 **Resolution:**  
  
##### To enable Internet Explorer Enhanced Security Configuration  
  
1.  Open **Server Manager**, and then click **Local Server**.  
  
2.  On the **Properties** pane, change the setting for **IE Enhanced Security Configuration** to **On**, and then click **OK**.  
  
### The source server remains in Active Directory Sites and Services  
 **Issue:**  The source server that is running Windows Small Business Server still exists in Active Directory Sites and Services in the Default-First-Site-Name.  
  
 **Impact:**  If the source server remains in Active Director Sites and Services, client computers can experience connectivity Issue: s.  
  
 **Resolution:**  You should demote the source server, remove it from the domain, and then delete the source server from Active Directory Sites and Services and Active Directory Users and Computers.  
  
### Source server remains in SBSComputer OU  
 **Issue:**  The source server that is running Windows Small Business Server still exists in Active Directory Users and Computers.  
  
 **Impact:**  If the source server remains in Active Director Users and Computers, client computers can experience connectivity Issue: s.  
  
 **Resolution:**  You should demote the source server, remove it from the domain, and then delete the source server from Active Directory Sites and Services and Active Directory Users and Computers.  
  
### A Group Policy is missing  
 **Issue:**  The Default Domain Policy group policy is missing.  
  
 **Impact:**  The Default Domain Policy is required for proper domain functions.  
  
 **Resolution:**  
  
##### To restore a missing group policy  
  
1.  Open gpmc.msc on the server.  
  
2.  In Group Policy Manager, expand the domain forest, and search the console tree for the **Default Domain Policy** group policy object.  
  
3.  If the policy does not appear in the tree, restore it from a system state backup.  
  
### No DNS name server resource records  
 **Issue:**  There are no DNS name server (NS) resource records in the forward lookup zone for your server.  
  
 **Impact:**  If no DNS name server (NS) resource record exists in the forward lookup zone for the Active Directory domain, users might not be able to access resources on the network or on the Internet.  
  
 **Resolution:**  
  
##### To restore missing DNS name server resource records  
  
1.  Open dnsmgmt.msc on the server.  
  
2.  In DNS Manager, right-click the forward lookup zone for the Active Directory domain, and then click **Properties**.  
  
3.  On the **Name Servers** tab, verify that the settings are correct.  
  
4.  Make any necessary changes, and then click **OK** to save the settings.  
  
### No DNS name server records  
 **Issue:**  There are no DNS name server (NS) resource records in the _msdcs zone for your server (for example: _msdcs.contoso.local).  
  
 **Impact:**  If no DNS name server (NS) resource record exists in the _msdcs zone for the Active Directory domain, users might not be able to access resources on the network or on the Internet.  
  
 **Resolution:**  
  
##### To restore missing DNS name server records  
  
1.  Open dnsmgmt.msc on the server.  
  
2.  In DNS Manager, right-click the forward lookup zone for the _msdcs zone, and then click **Properties**.  
  
3.  On the **Name Servers** tab, verify that the settings are correct.  
  
4.  Make any necessary changes, and then click **OK** to save the settings.  
  
### No DNS name server records  
 **Issue:**  There are no DNS name server (NS) resource records for the delegated _msdcs forward lookup zone.  
  
 **Impact:**  If no DNS name server (NS) resource record exists for the delegated _msdcs forward lookup zone, the DNS Server service cannot resolve the DNS resource records for the domain and will fail to start.  
  
 **Resolution:**  
  
##### To reconfigure missing DNS name server records  
  
1.  Open dnsmgmt.msc on the server.  
  
2.  In DNS Manager, expand your server name, and then expand **Forward Lookup Zones**.  
  
3.  Click the forward lookup zone for your Active Directory domain (for example: contoso.local).  
  
4.  The delegated _msdcs zone appears as a greyed out folder. Right-click the _msdcs zone, and then click **Properties**.  
  
5.  On the **Name Servers** tab, verify that the settings are correct.  
  
6.  Make any necessary changes, and then click **OK** to save the settings.  
  
### Authenticated Users not a member of the Pre-Windows 2000 Compatible Access group  
 **Issue:**  The Authenticated Users group is not a member of the Pre-Windows 2000 Compatible Access group.  
  
 **Impact:**  If the built-in Authenticated Users group is not a member of the Pre-Windows 2000 Compatible Access group, network users might encounter "Access is Denied" errors.  
  
 **Resolution:**  
  
##### To add Authenticated Users to the Pre-Windows 2000 Compatible Access group  
  
1.  Open dsa.msc on the server.  
  
2.  In the **Builtin** folder, right-click **Pre-Windows 2000 Compatible Access**, and then click **Properties**.  
  
3.  Click **Add**, type **Authenticated Users**, and then click **OK** two times.  
  
### DNS client not configured  
 **Issue:**  The DNS client is not configured to point only to the internal IP address of the server.  
  
 **Impact:**  If the DNS client is not configured to point only to the internal IP address of the server, DNS name resolution can fail.  
  
 **Resolution:**  
  
##### To configure DNS to point only to the server s internal IP address  
  
1.  From the client computer, open the **Properties** page for the network connection.  
  
2.  Make sure that DNS is configured to point only to the internal IP address of the server.  
  
### Default Application Pool value changed  
 **Issue:**  The number of Maximum Worker Processes for the DefaultAppPool Application Pool is not set to the default value of 1.  
  
 **Impact:**  Users might not be able to connect to Windows Small Business Server web-based services.  
  
 **Resolution:**  
  
##### To reset Maximum Worker Processes for the default application pool  
  
1.  Open Internet Information Services (IIS) Manager on the server.  
  
2.  In IIS Manager, expand your server name and then click **Application Pools**.  
  
3.  In **Application Pools**, right-click **DefaultAppPool**, and then click **Advanced Settings**.  
  
4.  In **Advanced Settings**, change the value for **Maximum Worker Processes** to 1, and then click **OK**.  
  
5.  Close **Advanced Settings**, right-click **DefaultAppPool**, and then stop and restart the application pool.  
  
### Application pool for Remote Web Access does not use the default account  
 **Issue:**  The RemoteAppPool application pool is not running with the default account.  
  
 **Impact:**  Network users might not be able to access the Remote Web Access website.  
  
 **Resolution:**  
  
##### To reset the remote application pool to use the default account  
  
1.  Open Internet Information Services (IIS) Manager on the server.  
  
2.  In IIS Manager, expand your server name and then click **Application Pools**.  
  
3.  In **Application Pools**, right-click **RemoteAppPool**, and then click **Advanced Settings**.  
  
4.  In **Advanced Settings**, change the **Identity** to **NetworkService**, and then click **OK**.  
  
5.  Close **Advanced Settings**, right-click **RemoteAppPool**, and then stop and restart the application pool.  
  
### Application pool for Remote Web Access does not use the default .NET Framework version  
 **Issue:**  The RemoteAppPool application pool is not running with the default version of Microsoft .NET Framework.  
  
 **Impact:**  Network users might not be able to access the Remote Web Access website.  
  
 **Resolution:**  
  
##### To change the .NET Framework version used by the RemoteAppPool  
  
1.  Open Internet Information Services (IIS) Manager on the server.  
  
2.  In IIS Manager, expand your server name and then click **Application Pools**.  
  
3.  In **Application Pools**, right-click **RemoteAppPool**, and then click **Advanced Settings**.  
  
4.  In **Advanced Settings**, change the **.NET Framework Version** to v4.0, and then click **OK**.  
  
5.  Close **Advanced Settings**, right-click **RemoteAppPool**, and then stop and restart the application pool.  
  
### The RemoteAccess.log file is larger than 1 GB in size  
 **Issue:**  If the size of the Remoteaccess.log file exceeds 1 GB, you can experience low disk space errors on the system drive.  
  
 **Impact:**  If the Remoteaccess.log file is too large, it might cause free space Issue: s on drive C:.  
  
 **Resolution:**  After you back up the server, you can delete the Remoteaccess.log file, which is located in the %ProgramData%\Microsoft\Windows Server\Logs\WebApps folder.  
  
### Default Web site's log directory is over 1 GB in size  
 **Issue:**  If the size of the default website's log folder exceeds 1 GB, you can experience low disk space errors on the system drive.  
  
 **Impact:**  If the default website's log folder is too large, it might cause free space Issue: s on drive C:  
  
 **Resolution:**  After you back up the server, and while the default website is stopped, you can delete the log files in the C:\inetpub\logs\LogFiles\W3SVC1 folder. Then start the default website.  
  
### No binding for SSL on all IP addresses  
 **Issue:**  There is no binding for Secure Sockets Layer (SSL) on all IP addresses on the server.  
  
 **Impact:**  If SSL is not bound to all IP addresses on the server, some websites will not be available to users.  
  
 **Resolution:**  
  
##### To bind SSL to all IP addresses on the server  
  
1.  Open Internet Information Services (IIS) Manager on the server.  
  
2.  In IIS Manager, on the **Connections** pane, expand your server, expand **Sites**, right-click **Default Web Site**, and then click **Edit Bindings**.  
  
3.  In **Site Bindings**, click **Add**, and then select the following settings:  
  
    -   **Type** = **https**  
  
    -   **IP Address** = **All Unassigned**  
  
    -   **Port** = 443  
  
4.  Select an SSL certificate, and then click **OK** to save your changes.  
  
### No binding for SSL on the Default Web Site  
 **Issue:**  There is no binding for SSL on the default website.  
  
 **Impact:**  If SSL is not bound to the default website, some websites might not be available to users.  
  
 **Resolution:**  
  
##### To bind SSL to the default website  
  
1.  Open Internet Information Services (IIS) Manager on the server.  
  
2.  In IIS Manager, on the **Connections** pane, expand your server, expand **Sites**, right-click **Default Web Site**, and then click **Edit Bindings**.  
  
3.  In **Site Bindings**, click **Add**, and then select the following options:  
  
    -   **Type** = **https**  
  
    -   **IP Address** = **All Unassigned**  
  
    -   **Port** = 443  
  
    > [!NOTE]
    >  If an HTTPS binding for port 443 exists for a specific IP address, change the **IP Address** attribute for that binding to **All Unassigned**. The exception to this is for IP address 127.0.0.1. Do not change the binding for 127.0.0.1.  
  
4.  Select an SSL certificate, and then click **OK** to save your changes.  
  
### A certificate expires within 30 days  
 **Issue:**  Your server certificate will expire within 30 days.  
  
 **Impact:**  The server cannot use an expired certificate. If the certificate expires, users might not be able to use Anywhere Access functions.  
  
 **Resolution:**  To prevent the certificate from expiring, renew the certificate with your Trusted Certification Authority.  
  
### Certificate subject does not match the name configured by Domain Name wizard  
 **Issue:**  The certificate subject does not match the name that was configured by Domain Name wizard.  
  
 **Impact:**  If the certificate subject does not match the name that was configured by Domain Name wizard, some websites will not initialize. Other sites will display the error "There is a problem with this website's security certificate."  
  
 **Resolution:**  To resolve this Issue: , either run the Set up Anywhere Access Wizard again and provide the correct domain name for the certificate, or purchase a new certificate that matches the domain name that you wish to use.  
  
### One or more user accounts have duplicate CN names  
 **Issue:**  One or more user accounts have duplicate CN names: {0}.  
  
 **Impact:**  If user accounts have duplicate CN names, users might not be able to log on to the network. In addition, searches of Active Directory for users can return incorrect values.  
  
 **Resolution:**  To resolve this Issue: , ensure that network user accounts do not have duplicate "CN=" names. To make this easier, consider exporting Active Directory contents to a text file for review. For information about how to do this, see [Using LDIFDE to import and export directory objects to Active Directory (Knowledge Base article 237677)](https://support.microsoft.com/kb/237677) (https://support.microsoft.com/kb/237677).  
  
### NT Backup is installed  
 **Issue:**  The Windows NT Backup program is installed on the server.  
  
 **Impact:**   Windows Server Essentials uses Windows Server Backup. If the Windows NT Backup program is also installed, conflicts can exist between the two backup programs. This can cause the Windows Server Backup process to fail. The conflicts might also prevent you from using a backup to restore the server.  
  
 **Resolution:** To resolve this Issue: , uninstall the NT Backup program from the server.  
  
### IIS does not own port 80 (0.0.0.0:80) or port 443 (0.0.0.0:443)  
 **Issue:**  Internet Information Services (IIS) does not own port 80 (0.0.0.0:80) or Port 443. These ports are currently bound by other applications.  
  
 **Impact:**   Windows Server Essentials web applications require the use of port 80 and port 443 to make services available to users. If another process or application is already using port 80 or port 443, the  Windows Server Essentials web applications cannot run. If this occurs, Remote Web Access and other applications are not available to users.  
  
 **Resolution:**  To resolve this Issue: , either uninstall the application that is already using port 80 or port 443, or assign that application to a different port.  
  
### The default website is not running  
 **Issue:**  The default website is not running in your  Windows Server Essentials environment.  
  
 **Impact:**   Windows Server Essentials web applications require the use of the default website. If the default website is not running, Remote Web Access and other applications are not available to users.  
  
 **Resolution:**  
  
##### To start the default website  
  
1.  Open Internet Information Services (IIS) Manager on the server.  
  
2.  In IIS Manager, expand your server name and then click **Sites**.  
  
3.  Right-click **Default Web Site**, point to **Manage Website**, and then click **Start**.  
  
### Read and Script permissions for the /Remote virtual directory are incorrect  
 **Issue:**  Read and Script permissions are not assigned to the /Remote virtual directory.  
  
 **Impact:**  If the Read and Script permissions for the /Remote virtual directory are incorrect, users cannot use Remote Web Access. When they try to use Remote Web Access to browse the Internet, they might encounter the error "HTTP Error 403.1   Forbidden."  
  
 **Resolution:**  
  
##### To assign Read and Script permissions to the /Remote directory  
  
1.  Open Internet Information Services (IIS) Manager on the server.  
  
2.  In IIS Manager, expand your server name and then click **Sites**.  
  
3.  Expand **Default Web Site**, and then expand **Remote**.  
  
4.  In **Features View**, double-click **Handler Mappings**.  
  
5.  On the **Actions** pane, click **Edit Feature Permissions**.  
  
6.  Select the **Read** and **Script** check boxes, and then click **OK**.  
  
### HTTP Redirect is either set or inherited on the /Remote virtual directory  
 **Issue:**  The HTTP Redirect attribute is unexpectedly set or inherited on the /Remote virtual directory.  
  
 **Impact:**  If the HTTP Redirect attribute is set on the /Remote virtual directory, Remote Web Workplace does not work correctly.  
  
 **Resolution:**  
  
##### To remove the HTTP Redirect attribute  
  
1.  Open Internet Information Services (IIS) Manager on the server.  
  
2.  In IIS Manager, expand your server name and then click **Sites**.  
  
3.  Expand **Default Web Site**, and then expand **Remote**.  
  
4.  In **Features View**, double-click **HTTP Redirect**.  
  
5.  Clear the **Redirect requests to this destination** check box, and then click **Apply** on the **Actions** pane.  
  
### A host name exists for port 80 on the default website  
 **Issue:**  A host name is assigned for port 80 on the default website.  
  
 **Impact:**  If a host name is assigned for port 80 on the default website, you might not be able to connect to some  Windows Server Essentials web applications. A host name is not required and is not recommended in this situation  
  
 **Resolution:**  
  
##### To clear the host name entry for port 80 on the default website  
  
1.  Open Internet Information Services (IIS) Manager on the server.  
  
2.  In IIS Manager, expand your server name and then click **Sites**.  
  
3.  In **Features View**, right-click **Default Web Site**, and then click **Bindings**.  
  
4.  In **Site Bindings**, select the **http for port 80** setting, and then click **Edit**.  
  
5.  In **Edit Site Binding**, clear the **Host name** entry, and then click **OK**.  
  
### Backup does not succeed because of a hidden partition  
 **Issue:**  A non-NTFS partition is scheduled for backup by Windows Server Backup.  
  
 **Impact:**  Windows Server Backup can only back up partitions that are formatted as NTFS.  
  
 **Resolution:**  Do not configure Windows Server Backup to back up non-NTFS partitions. For more information, see [Event IDs 12290 and 16387 are logged when system state backup fails on a Windows Server 2008-based computer (Knowledge Base article 968128)](https://support.microsoft.com/kb/968128) (https://support.microsoft.com/kb/968128).  
  
### The most recent backup did not succeed  
 **Issue:**  The most recent backup attempt did not complete successfully.  
  
 **Impact:**  The backup status for the system is not correct.  
  
 **Resolution:**  Review the event logs and backup logs for errors that occurred during the most recent backup.  
  
### The startup type for the File Replication Service is not set to Automatic  
 **Issue:**  The File Replication Service (FRS) might not start if the startup type is not set to the default value of Automatic.  
  
 **Impact:**  If the File Replication Service is not running, the domain controller might stop advertising its services. This can lead to other problems such as logon errors and Group Policy errors.  
  
 **Resolution:**  
  
##### To configure the File Replication Service for automatic startup  
  
1.  Open the Services console.  
  
2.  In the list of services, double-click **File Replication**.  
  
3.  For **Startup type**, select **Automatic**, and then click **Apply**.  
  
### The File Replication Service is not running  
 **Issue:**  The File Replication Service is not running.  
  
 **Impact:**  If the File Replication Service is not running, the domain controller might stop advertising its services. This behavior can lead to other problems such as logon errors and Group Policy errors.  
  
 **Resolution:**  
  
##### To start the File Replication Service  
  
1.  Open the Services console.  
  
2.  In the list of services, double-click **File Replication Service**.  
  
3.  Click **Start**.  
  
### The logon account for the File Replication Service is not set to use the Local System account  
 **Issue:**  The File Replication Service is not configured to use the Local System account as the default logon account.  
  
 **Impact:**  If the File Replication Service does not use Local System as the default logon account, you might encounter permissions-related errors. These errors can trigger other errors, and can eventually cause the domain controller to stop advertising its services.  
  
 **Resolution:**  
  
##### To configure Local System as the default logon account for File Replication  
  
1.  Open the Services console.  
  
2.  In the list of services, double-click **File Replication**.  
  
3.  On the **Service Properties** page, click the **Log On** tab.  
  
4.  Select the **Local System account** option, and then click **Apply**.  
  
5.  Restart the service.  
  
### The startup type for the DFS Replication service is not set to Automatic  
 **Issue:**  The DFS Replication service might not start if the startup type is not set to the default value of Automatic.  
  
 **Impact:**  If the DFS Replication service is not running, the domain controller might stop advertising its services. This can lead to other problems such as logon errors and Group Policy errors.  
  
 **Resolution:**  
  
##### To configure the DFS Replication service for automatic startup  
  
1.  Open the Services console.  
  
2.  In the list of services, double-click **DFS Replication**.  
  
3.  For **Startup type**, select **Automatic**, and then click **Apply**.  
  
### The DFS Replication service is not running  
 **Issue:**  The DFS Replication service is not currently running.  
  
 **Impact:**  If the DFS Replication service is not running, the domain controller might stop advertising its services. This behavior can lead to other problems such as logon errors and Group Policy errors.  
  
 **Resolution:**  
  
##### To start the DFS Replication service  
  
1.  Open the Services console.  
  
2.  In the list of services, double-click **DFS Replication**.  
  
3.  Click **Start**.  
  
### The DFS Replication service is not is not set to use the Local System account  
 **Issue:**  The DFS Replication service is not set to use the Local System account as the default logon account.  
  
 **Impact:**  If the DFS Replication service does not use Local System as the default logon account, you might encounter permissions-related errors. These errors can trigger other errors, and can eventually cause the domain controller to stop advertising its services.  
  
 **Resolution:**  
  
##### To configure DFS Replication to use Local System as the default logon account  
  
1.  Open the Services console.  
  
2.  In the list of services, double-click **DFS Replication**.  
  
3.  On the **Service Properties** page, click the **Log On** tab.  
  
4.  Select the **Local System account** option, and then click **Apply**.  
  
5.  Restart the service.  
  
### The Windows Server Office 365 Integration Service is not set to use the Local System account  
 **Issue:**  The Windows Server Office 365 Integration Service is not set to use the Local System account as the default logon account.  
  
 **Impact:**  If Windows Server Office 365 Integration Service does not use Local System as the default logon account, some features of Office 365 might not function properly. You might also encounter permissions-related errors.  
  
 **Resolution:**  
  
##### To configure the Office 365 Integration Service to use Local System as the default logon account  
  
1.  Open the Services console.  
  
2.  In the list of services, double-click **Windows Server Office 365 Integration Service**.  
  
3.  On the **Service Properties** page, click the **Log On** tab.  
  
4.  Select the **Local System account** option, and then click **Apply**.  
  
5.  Restart the service.  
  
### The Windows Server Office 365 Integration Service is not running  
 **Issue:**  The Windows Server Office 365 Integration Service is not currently running.  
  
 **Impact:**  If the Windows Server Office 365 Integration Service is not running, the cloud-based features of Office 365 are not available.  
  
 **Resolution:**  
  
##### To start the Windows Server Office 365 Integration Service  
  
1.  Open the Services console.  
  
2.  In the list of services, double-click **Windows Server Office 365 Integration Service**.  
  
3.  Click **Start**.  
  
### The startup type for the Windows Server Office 365 Integration Service is not set to Automatic  
 **Issue:**  The Windows Server Office 365 Integration Service might not start if the startup type is not set to the default value of Automatic.  
  
 **Impact:**  If the Windows Server Office 365 Integration Service is not running, the cloud-based features of Office 365 are not available.  
  
 **Resolution:**  
  
##### To configure the Office 365 Integration Service for automatic startup  
  
1.  Open the Services console.  
  
2.  In the list of services, double-click **Windows Server Office 365 Integration Service**.  
  
3.  For **Startup type**, select **Automatic**, and then click **Apply**.  
  
### A registry value is missing or set incorrectly  
 **Issue:**  A registry key under HKEY_LOCAL_MACHINE \Software\Microsoft\Rpc\RpcProxy either contains incorrect values, or does not exist.  
  
 **Impact:**  If the RPCProxy registry key is set incorrectly, you might receive an error message that resembles the following: "Your computer can't connect to the remote computer because the Remote Desktop Gateway server is temporarily unavailable. Try reconnecting later or contact your network administrator for assistance."  
  
 **Resolution:**  
  
##### To correct the registry setting  
  
1.  Open Registry Editor.  
  
2.  Navigate to the following registry key:  
  
     HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\RpcProxy  
  
3.  Ensure that the string named "Website" has a data value of Default Web Site:  
  
    -   If the data value is incorrect, modify the string to use the correct value.  
  
    -   If the string does not exist, create a new string named "Website," and set the data value to Default Web Site."  
  
### The startup type for the Block Level Backup Engine Service is not set to Manual  
 **Issue:**  The Block Level Backup Engine Service is not using the default startup type of Manual.  
  
 **Impact:**  The Block Level Backup Engine Service might not start if the startup type is not set to Manual. This Issue:  can cause Windows Server Backup jobs to fail.  
  
 **Resolution:**  
  
##### To configure the Block Level Backup Engine Service for manual startup  
  
1.  Open the Services console.  
  
2.  In the list of services, double-click **Block Level Backup Engine Service**.  
  
3.  For **Startup type**, select **Manual**, and then click **Apply**.  
  
### The logon account for the Block Level Backup Engine Service is not set to use the Local System account  
 **Issue:**  The Block Level Backup Engine Service is not set to use the Local System account as the default logon account.  
  
 **Impact:**  If Block Level Backup Engine Service does not use Local System as the default logon account, you might encounter permissions-related errors. These errors can prevent Windows Server Backup jobs from completing successfully.  
  
 **Resolution:**  
  
##### To configure the Block Level Backup Engine Service to use Local System as the default logon account  
  
1.  Open the Services console.  
  
2.  In the list of services, double-click **Block Level Backup Engine Service**.  
  
3.  On the **Service Properties** page, click the **Log On** tab.  
  
4.  Select the **Local System account** option, and then click **Apply**.  
  
5.  Restart the service.  
  
### The common name on the certificate that is bound to the WSS Certificate Web Service website does not match the server name  
 **Issue:**  A non-valid certificate is bound to the WSS Certificate Web Service website in IIS. The common name on this certificate does not match the server name.  
  
 **Impact:**  If you bind a non-valid certificate to the WSS Certificate Web Service website, the Connect Wizard might not function correctly.  
  
 **Resolution:**  
  
##### To configure a valid certificate for the WSS Certificate Web Service  
  
1.  Open Internet Information Services (IIS) Manager on the server.  
  
2.  In IIS Manager, expand your server name and then click **Sites**.  
  
3.  Right-click **WSS Certificate Web Service**, and then click **Edit Bindings**.  
  
4.  In **Site Bindings**, click **HTTPS**, and then click **Edit**.  
  
5.  In **Edit Site Binding**, for **SSL certificate**, select the certificate that has the same name as your server.  
  
6.  If more than one certificate entry has the same name as your server, click **View** to determine which certificate is valid, and then select the appropriate certificate.  
  
### There appears to be a problem with the certificate binding for the Remote Desktop Gateway service  
 **Issue:**  The certificate for the Remote Desktop Gateway service seems to be bound incorrectly.  
  
 **Impact:**  If the certificate for the Remote Desktop Gateway service is not configured correctly, users cannot connect to Remote Web Access.  
  
 **Resolution:**  
  
##### To fix the binding for the Remote Desktop Gateway service  
  
-   Open a command prompt as an Administrator, and enter the following commands:  
  
    ```  
    REG ADD HKLM\SYSTEM\CurrentControlSet\services\HTTP\Parameters\SslBindingInfo\0.0.0.0:443  /v DefaultFlags /t REG_DWORD /d 1 /f  
    net stop tsgateway  
    net start tsgateway  
    ```  
  
     For more information, see [How to Manage the Remote Desktop Gateway Service in Windows Server Essentials (Knowledge Base article 2472211)](https://support.microsoft.com/kb/2472211) (https://support.microsoft.com/kb/2472211).
