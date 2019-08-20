---
title: Administer Server Core
description: Learn how to administer a Server Core installation of Windows Server
ms.prod: windows-server-threshold
ms.mktglfcycl: manage
ms.sitesec: library
author: lizap
ms.author: elizapo
ms.localizationpriority: medium
ms.date: 12/18/2018
---
# Administer a Server Core server

>Applies to: Windows Server 2019, Windows Server 2016, and Windows Server (Semi-Annual Channel)

Because Server Core doesn't have a UI, you need to use Windows PowerShell cmdlets, command line tools, or remote tools to perform basic administration tasks. The following sections outline the PowerShell cmdlets and commands used for basic tasks. You can also use [Windows Admin Center](../../manage/windows-admin-center/overview.md), a unified management portal currently in public preview, to administer your installation. 

## Administrative tasks using PowerShell cmdlets
Use the following information to perform basic administrative tasks with Windows PowerShell cmdlets.

### Set a static IP address
When you install a Server Core server, by default it has A DHCP address. If you need a static IP address, you can set it using the following steps.

To view your current network configuration, use **Get-NetIPConfiguration**.

To view the IP addresses you're already using, use **Get-NetIPAddress**.

To set a static IP address, do the following: 

1. Run **Get-NetIPInterface**. 
2. Note the number in the **IfIndex** column for your IP interface or the **InterfaceDescription** string. If you have more than one network adapter, note the number or string corresponding to the interface you want to set the static IP address for.
3. Run the following cmdlet to set the static IP address:

   ```powershell
   New-NetIPaddress -InterfaceIndex 12 -IPAddress 192.0.2.2 -PrefixLength 24 -DefaultGateway 192.0.2.1
   ```

   where:
   - **InterfaceIndex** is the value of **IfIndex** from step 2. (In our example, 12)
   - **IPAddress** is the static IP address you want to set. (In our example, 191.0.2.2)
   - **PrefixLength** is the prefix length (another form of subnet mask) for the IP address you're setting. (For our example, 24)
   - **DefaultGateway** is the IP address to the default gateway. (For our example, 192.0.2.1)
4. Run the following cmdlet to set the DNS client server address: 

   ```powershell
   Set-DNSClientServerAddress –InterfaceIndex 12 -ServerAddresses 192.0.2.4
   ```
   
   where:
   - **InterfaceIndex** is the value of IfIndex from step 2.
   - **ServerAddresses** is the IP address of your DNS server.
5. To add multiple DNS servers, run the following cmdlet: 

   ```powershell
   Set-DNSClientServerAddress –InterfaceIndex 12 -ServerAddresses 192.0.2.4,192.0.2.5
   ```

   where, in this example, **192.0.2.4** and **192.0.2.5** are both IP addresses of DNS servers.

If you need to switch to using DHCP, run **Set-DnsClientServerAddress –InterfaceIndex 12 –ResetServerAddresses**.

### Join a domain
Use the following cmdlets to join a computer to a domain.

1. Run **Add-Computer**. You'll be prompted for both credentials to join the domain and the domain name.
2. If you need to add a domain user account to the local Administrators group, run the following command at a command prompt (not in the PowerShell window):

   ```
   net localgroup administrators /add <DomainName>\<UserName>
   ```
3. Restart the computer. You can do this by running **Restart-Computer**.

### Rename the server
Use the following steps to rename the server.

1. Determine the current name of the server with the **hostname** or **ipconfig** command.
2. Run **Rename-Computer -ComputerName \<new_name\>**.
3. Restart the computer.

### Activate the server

Run **slmgr.vbs –ipk\<productkey\>**. Then run **slmgr.vbs –ato**. If activation succeeds, you won't get a message.

> [!NOTE]
> You can also activate the server by phone, using a [Key Management Service (KMS) server](../../get-started/server-2016-activation.md), or remotely. To activate remotely, run the following cmdlet from a remote computer: 
> 
> ```powershell
> **cscript windows\system32\slmgr.vbs <ServerName> <UserName> <password>:-ato**
> ```
 
### Configure Windows Firewall

You can configure Windows Firewall locally on the Server Core computer using Windows PowerShell cmdlets and scripts. See [NetSecurity](/powershell/module/netsecurity/?view=win10-ps) for the cmdlets you can use to configure Windows Firewall.

### Enable Windows PowerShell remoting

You can enable Windows PowerShell Remoting, in which commands typed in Windows PowerShell on one computer run on another computer. Enable Windows PowerShell Remoting with **Enable-PSRemoting**.

For more information, see [About Remote FAQ](/powershell/module/microsoft.powershell.core/about/about_remote_faq?view=powershell-5.1).

## Administrative tasks from the command line
Use the following reference information to perform administrative tasks from the command line.

### Configuration and installation

|                             Task                              |                                                                                                                                                                                                                 Command                                                                                                                                                                                                                 |
|---------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|             Set the local administrative password             |                                                                                                                                                                                                      **net user administrator** \*                                                                                                                                                                                                      |
|                  Join a computer to a domain                  |                                                                                                                                                       **netdom join %computername%** **/domain:\<domain\> /userd:\<domain\\username\> /passwordd:**\* <br> Restart the computer.                                                                                                                                                        |
|              Confirm that the domain has changed              |                                                                                                                                                                                                                 **set**                                                                                                                                                                                                                 |
|                Remove a computer from a domain                |                                                                                                                                                                                                   **netdom remove \<computername\>**                                                                                                                                                                                                    |
|         Add a user to the local Administrators group          |                                                                                                                                                                                       **net localgroup Administrators /add \<domain\\username\>**                                                                                                                                                                                       |
|       Remove a user from the local Administrators group       |                                                                                                                                                                                     **net localgroup Administrators /delete \<domain\\username\>**                                                                                                                                                                                      |
|               Add a user to the local computer                |                                                                                                                                                                                                **net user \<domain\username\> \* /add**                                                                                                                                                                                                 |
|               Add a group to the local computer               |                                                                                                                                                                                                 **net localgroup \<group name\> /add**                                                                                                                                                                                                  |
|          Change the name of a domain-joined computer          |                                                                                                                                                           **netdom renamecomputer %computername% /NewName:\<new computer name\> /userd:\<domain\\username\> /passwordd:** \*                                                                                                                                                            |
|                 Confirm the new computer name                 |                                                                                                                                                                                                                 **set**                                                                                                                                                                                                                 |
|         Change the name of a computer in a work group         |                                                                                                                                                                **netdom renamecomputer \<currentcomputername\> /NewName:\<newcomputername\>** <br>Restart the computer.                                                                                                                                                                 |
|                Disable paging file management                 |                                                                                                                                                                        **wmic computersystem where name="\<computername\>" set AutomaticManagedPagefile=False**                                                                                                                                                                         |
|                   Configure the paging file                   |                                                            **wmic pagefileset where name=”\<path/filename\>” set InitialSize=\<initialsize\>,MaximumSize=\<maxsize\>** <br>Where *path/filename* is the path to and name of the paging file, *initialsize* is the starting size of the paging file, in bytes, and *maxsize* is the maximum size of the page file, in bytes.                                                             |
|                 Change to a static IP address                 | **ipconfig /all** <br>Record the relevant information or redirect it to a text file (**ipconfig /all >ipconfig.txt**).<br>**netsh interface ipv4 show interfaces**<br>Verify that there is an interface list.<br>**netsh interface ipv4 set address name \<ID from interface list\> source=static address=\<preferred IP address\> gateway=\<gateway address\>**<br>Run **ipconfig /all** to verify that DHCP enabled is set to **No**. |
|                   Set a static DNS address.                   |   <strong>netsh interface ipv4 add dnsserver name=\<name or ID of the network interface card\> address=\<IP address of the primary DNS server\> index=1 <br></strong>netsh interface ipv4 add dnsserver name=\<name of secondary DNS server\> address=\<IP address of the secondary DNS server\> index=2\*\* <br> Repeat as appropriate to add additional servers.<br>Run **ipconfig /all** to verify that the addresses are correct.   |
| Change to a DHCP-provided IP address from a static IP address |                                                                                                                                      **netsh interface ipv4 set address name=\<IP address of local system\> source=DHCP** <br>Run **ipconfig /all** to verify that DCHP enabled is set to **Yes**.                                                                                                                                      |
|                      Enter a product key                      |                                                                                                                                                                                                   **slmgr.vbs –ipk \<product key\>**                                                                                                                                                                                                    |
|                  Activate the server locally                  |                                                                                                                                                                                                           **slmgr.vbs -ato**                                                                                                                                                                                                            |
|                 Activate the server remotely                  |                                            **cscript slmgr.vbs –ipk \<product key\>\<server name\>\<username\>\<password\>** <br>**cscript slmgr.vbs -ato \<servername\> \<username\> \<password\>** <br>Get the GUID of the computer by running **cscript slmgr.vbs -did** <br> Run **cscript slmgr.vbs -dli \<GUID\>** <br>Verify that License status is set to **Licensed (activated)**.                                             |

### Networking and firewall

|Task|Command| 
|----|-------|
|Configure your server to use a proxy server|**netsh Winhttp set proxy \<servername\>:\<port number\>** <br>**Note:** Server Core installations can't access the Internet through a proxy that requires a password to allow connections.|
|Configure your server to bypass the proxy for Internet addresses|**netsh winttp set proxy \<servername\>:\<port number\> bypass-list="\<local\>"**| 
|Display or modify IPSEC configuration|**netsh ipsec**| 
|Display or modify NAP configuration|**netsh nap**| 
|Display or modify IP to physical address translation|**arp**| 
|Display or configure the local routing table|**route**| 
|View or configure DNS server settings|**nslookup**| 
|Display protocol statistics and current TCP/IP network connections|**netstat**| 
|Display protocol statistics and current TCP/IP connections using NetBIOS over TCP/IP (NBT)|**nbtstat**| 
|Display hops for network connections|**pathping**| 
|Trace hops for network connections|**tracert**| 
|Display the configuration of the multicast router|**mrinfo**| 
|Enable remote administration of the firewall|**netsh advfirewall firewall set rule group=”Windows Firewall Remote Management” new enable=yes**| 
 

### Updates, error reporting, and feedback

|                               Task                                |                                                                                                                               Command                                                                                                                                |
|-------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|                         Install an update                         |                                                                                                                    **wusa \<update\>.msu /quiet**                                                                                                                    |
|                      List installed updates                       |                                                                                                                            **systeminfo**                                                                                                                            |
|                         Remove an update                          |                                 **expand /f:\* \<update\>.msu c:\test** <br>Navigate to c:\test\ and open \<update\>.xml in a text editor.<br>Replace **Install** with **Remove** and save the file.<br>**pkgmgr /n:\<update\>.xml**                                 |
|                    Configure automatic updates                    |          To verify the current setting: **cscript %systemroot%\system32\scregedit.wsf /AU /v \*\*<br>To enable automatic updates: \*\*cscript scregedit.wsf /AU 4** <br>To disable automatic updates: **cscript %systemroot%\system32\scregedit.wsf /AU 1**          |
|                      Enable error reporting                       | To verify the current setting: **serverWerOptin /query** <br>To automatically send detailed reports: **serverWerOptin /detailed** <br>To automatically send summary reports: **serverWerOptin /summary** <br>To disable error reporting: **serverWerOptin /disable** |
| Participate in the Customer Experience Improvement Program (CEIP) |                                                     To verify the current setting: **serverCEIPOptin /query** <br>To enable CEIP: **serverCEIPOptin /enable** <br>To disable CEIP: **serverCEIPOptin /disable**                                                      |

### Services, processes, and performance

|                               Task                               |                                                                                                                                                                                                             Command                                                                                                                                                                                                              |
|------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|                    List the running services                     |                                                                                                                                                                                                  **sc query** or **net start**                                                                                                                                                                                                   |
|                         Start a service                          |                                                                                                                                                                                 **sc start \<service name\>** or **net start \<service name\>**                                                                                                                                                                                  |
|                          Stop a service                          |                                                                                                                                                                                  **sc stop \<service name\>** or **net stop \<service name\>**                                                                                                                                                                                   |
| Retrieve a list of running applications and associated processes |                                                                                                                                                                                                           **tasklist**                                                                                                                                                                                                           |
|                        Start Task Manager                        |                                                                                                                                                                                                           **taskmgr**                                                                                                                                                                                                            |
|    Create and manage event trace session and performance logs    | To create a counter, trace, configuration data collection or API: **logman ceate** <br>To query data collector properties: **logman query** <br>To start or stop data collection: **logman start\|stop** <br>To delete a collector: **logman delete** <br> To update the properties of a collector: **logman update** <br>To import a data collector set from an XML file or export it to an XML file: **logman import\|export** |

### Event logs

|Task|Command| 
|----|-------|
|List event logs|**wevtutil el**| 
|Query events in a specified log|**wevtutil qe /f:text \<log name\>**| 
|Export an event log|**wevtutil epl \<log name\>**| 
|Clear an event log|**wevtutil cl \<log name\>**| 


### Disk and file system

|                   Task                   |                        Command                        |
|------------------------------------------|-------------------------------------------------------|
|          Manage disk partitions          | For a complete list of commands, run **diskpart /?**  |
|           Manage software RAID           | For a complete list of commands, run **diskraid /?**  |
|        Manage volume mount points        | For a complete list of commands, run **mountvol /?**  |
|           Defragment a volume            |  For a complete list of commands, run **defrag /?**   |
| Convert a volume to the NTFS file system |        **convert \<volume letter\> /FS:NTFS**         |
|              Compact a file              |  For a complete list of commands, run **compact /?**  |
|          Administer open files           | For a complete list of commands, run **openfiles /?** |
|          Administer VSS folders          | For a complete list of commands, run **vssadmin /?**  |
|        Administer the file system        |  For a complete list of commands, run **fsutil /?**   |
|    Take ownership of a file or folder    |  For a complete list of commands, run **icacls /?**   |
 
### Hardware

|Task|Command| 
|----|-------|
|Add a driver for a new hardware device|Copy the driver to a folder at %homedrive%\\\<driver folder\>. Run **pnputil -i -a %homedrive%\\\<driver folder\>\\\<driver\>.inf**|
|Remove a driver for a hardware device|For a list of loaded drivers, run **sc query type= driver**. Then run **sc delete \<service_name\>**|
