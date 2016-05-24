---
title: Configure a Server Core Server
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - server-general
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 041c2763-3a15-4444-aed8-0d82f356f8f3
author: jaimeo
---
# Configure a Server Core Server
This topic explains how to accomplish common server configuration tasks, such as setting passwords, configuring Windows Firewall, joining a domain, and activating the server, all while the server is in Server Core mode.  
  
This topic assumes that you have installed the server in Server Core mode initially and are proceeding directly to these configuration tasks. If you have installed the server in Server with a GUI mode and have since switched to Server Core mode, these steps still apply.  
  
> [!NOTE]  
> If you close all command prompts, you will have no way to manage the server in Server Core mode. To recover, you can press CTRL\+ALT\+DELETE, click Start Task Manager, click File, click Start New Task, and then type cmd.exe. Alternatively, you can log off and log back on again.  
  
> [!NOTE]  
> Because there is no Web browser in Server Core mode, you cannot access the Internet or activate the product through a proxy server that requires users to log on. If you have a proxy server that requires users to log on, you can switch the server to Server with a GUI mode, activate the server, and then switch back to Server Core mode.  
  
|Task|Description|  
|--------|---------------|  
|[1.1. Set the administrative password](../Topic/Configure-a-Server-Core-Server.md#BKMK_1.1)|Set the administrative password|  
|[1.2. Set a static IP address](../Topic/Configure-a-Server-Core-Server.md#BKMK_1.2)|Set a static IP address|  
|[1.3 Join a domain](../Topic/Configure-a-Server-Core-Server.md#BKMK_1.3)|Join a domain|  
|[1.4 Rename the server](../Topic/Configure-a-Server-Core-Server.md#BKMK_1.4)|Rename the server|  
|[1.5 Activate the server](../Topic/Configure-a-Server-Core-Server.md#BKMK_1.5)|Activate the server|  
|[1.6 Configure Windows Firewall](../Topic/Configure-a-Server-Core-Server.md#BKMK_1.6)|Configure Windows Firewall|  
|[1.7. Enable Windows PowerShell remoting](../Topic/Configure-a-Server-Core-Server.md#BKMK_1.7)|Enable remote use of Windows PowerShell|  
  
> [!NOTE]  
> [!INCLUDE[wps_howtorun](../Token/wps_howtorun_md.md)]  
  
## <a name="BKMK_1.1"></a>1.1. Set the administrative password  
  
#### To set the administrative password  
  
1.  When your computer starts for the first time after the installation completes, you will be prompted to enter a new password.  
  
2.  Type an appropriate administrative password.  
  
You can later change the administrative password. To do this, log in and press CTRL\+ALT\+DELETE, and then choose **Change Password** from the Windows Security menu.  
  
## <a name="BKMK_1.2"></a>1.2. Set a static IP address  
  
> [!NOTE]  
> A DHCP address is provided by default. You should perform this procedure only if you need a static IP address.  
  
To view your current network configuration use the `Get-NetIPConfiguration` Windows PowerShell cmdlet.  
  
To view the IP addresses you are already using, use the `Get-NetIPAddress` Windows PowerShell cmdlet.  
  
For a complete reference on Windows PowerShell cmdlets for Net TCP\/IP, see [http:\/\/technet.microsoft.com\/library\/hh826150.aspx](http://technet.microsoft.com/library/hh826150.aspx).  
  
#### To set a static IP address  
  
1.  In Windows PowerShell, run `Get-NetIPInterface`.  
  
2.  Make a note of the number shown in the **IfIndex** column of the output for your IP interface or the **InterfaceDescription** string. If your computer has more than one network adapter, make a note of the number or string corresponding to the interface for which you wish to set a static IP address.  
  
3.  In Windows PowerShell, run `New-NetIPAddress –InterfaceIndex 12 –IPAddress -192.0.2.2 –PrefixLength 24 –DefaultGateway -192.0.2.1`  
  
    Where:  
  
    `InterfaceIndex` is the value of **IfIndex** from Step 2 \(in this example, 12\)  
  
    `IPAddress` is the static IP address you intend to set \(in this example, 192.0.2.2\)  
  
    `PrefixLength` is the prefix length \(another form of subnet mask\) for the IP address you intend to set \(in this example, 24\)  
  
    `DefaultGateway` is the default gateway \(in this example, 192.0.2.1\)  
  
4.  In Windows PowerShell, run `Set-DNSClientServerAddress –InterfaceIndex 12 -ServerAddresses 192.0.2.4`  
  
    Where:  
  
    `InterfaceIndex` is the value of **IfIndex** from Step 2  
  
    `ServerAddresses` is the IP address of your DNS server  
  
5.  To add multiple DNS servers, run `Set-DNSClientServerAddress –InterfaceIndex 12 -ServerAddresses 192.0.2.4,192.0.2.5`  
  
    Where in this example, 192.0.2.4, 192.0.2.5 are both IP addresses of DNS servers  
  
If you need to switch to using DHCP, use the Windows PowerShell command `Set-DnsClientServerAddress –InterfaceIndex 12 –ResetServerAddresses`.  
  
## <a name="BKMK_1.3"></a>1.3 Join a domain  
  
#### To join a domain  
  
1.  In Windows PowerShell, run `Add-Computer`. You will be prompted for both credentials to join the domain and the domain name.  
  
2.  If you need to add a domain user account to the local Administrators group, either use the Windows PowerShell cmdlets documented at [http:\/\/technet.microsoft.com\/library\/hh826150.aspx](http://technet.microsoft.com/library/hh826150.aspx), or at a command prompt, run the following command:  
  
    **net localgroup administrators \/add <DomainName>\\<UserName>**  
  
3.  Restart the computer. You can do this in Windows PowerShell with the command `Restart-Computer`.  
  
## <a name="BKMK_1.4"></a>1.4 Rename the server  
  
#### To rename the server  
  
1.  Determine the current name of the server with the **hostname** or **ipconfig** command.  
  
2.  In Windows PowerShell, run `Rename-Computer`.  
  
3.  Restart the computer.  
  
## <a name="BKMK_1.5"></a>1.5 Activate the server  
In Windows PowerShell, run `slmgr.vbs –ipk<productkey>`. Then run `slmgr.vbs –ato`. If activation is successful, no message will return.  
  
> [!NOTE]  
> You can also activate the server by phone, using a Key Management Service \(KMS\) server, or remotely. To activate remotely, from a computer that is running Windows Vista, Windows 7, Windows Server 2008, Windows Server 2008 R2, [!INCLUDE[win8_client_1](../Token/win8_client_1_md.md)], or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], use Windows PowerShell to run `cscript windows\system32\slmgr.vbs <ServerName> <UserName> <password>:-ato`.  
  
## <a name="BKMK_1.6"></a>1.6 Configure Windows Firewall  
You can configure Windows Firewall locally on the Server Core computer using Windows PowerShell cmdlets and scripts. See [http:\/\/technet.microsoft.com\/library\/hh831755.aspx](http://technet.microsoft.com/library/hh831755.aspx) for documentation of basic Windows Firewall tasks using Windows PowerShell.  
  
## <a name="BKMK_1.7"></a>1.7. Enable Windows PowerShell remoting  
You can enable Windows PowerShell Remoting, in which commands typed in Windows PowerShell on one computer run on another computer. Enable Windows PowerShell Remoting with `Enable-PSRemoting`.  
  
For more information, see [http:\/\/go.microsoft.com\/fwlink\/?LinkID\=135183](http://go.microsoft.com/fwlink/?LinkID=135183)  
  
## <a name="BKMK_Links"></a>See also  
  
-   [Install Server Roles and Features on a Server Core Server](../Topic/Install-Server-Roles-and-Features-on-a-Server-Core-Server.md)  
  
-   [Deploy a Server Core Server](../Topic/Deploy-a-Server-Core-Server.md)  
  
-   [Configure and Manage Server Core Installations](../Topic/Configure-and-Manage-Server-Core-Installations.md)  
  
-   [Windows Server Installation Options](../Topic/Windows-Server-Installation-Options.md)  
  
-   [Evaluation Versions and Upgrade Options for Windows Server 2012](http://go.microsoft.com/fwlink/?LinkId=260917)  
  
