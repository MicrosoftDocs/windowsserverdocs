---
title: Step 1: Set up the cluster nodes for your file server
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 86e4d75d-6b84-4d39-85ff-09ec38f010df
---
# Step 1: Set up the cluster nodes for your file server
This topic describes the first steps in setting up a file server cluster that uses Storage Spaces with shared SAS storage enclosures. These steps include designing your software\-defined storage solution, setting up the hardware, using Group Policy to specify some basic domain settings, enabling remote access, configuring networking, installing server roles, and configuring MPIO. After completing these steps, you'll be ready to cluster the nodes together and create storage pools.  
  
## Step 1: Design your storage solution  
The first step is to design your storage solution, including what hardware to use, and the details of your storage spaces and file shares. To design your storage solution, see the [Software-Defined Storage Design Considerations Guide](../Topic/Software-Defined-Storage-Design-Considerations-Guide.md).  
  
## Step 2: Set up your hardware and install Windows Server  
After you've designed your storage solution and acquired the hardware, it's time to rack and cable it, and deploy an operating system.  
  
1.  Rack all nodes that you want to use in your file server cluster, as well as the storage enclosures \(also known as just\-a\-bunch\-of\-disks or JBODs\).  
  
2.  Connect the file server nodes to the storage enclosures according to instructions provided by your solution vendor \(the company from which you buy the servers and all disks\) .  
  
    Each node of the file server should have one or more  SAS cables connected to each of the storage enclosures \(or equivalent paths via interconnected storage enclosures, if this topology is supported by your hardware provider\).  
  
3.  Connect the file server nodes to your network switches .  
  
    Use Table 1 to help track which ports are hooked up to which subnet.  
  
    |||||  
    |-|-|-|-|  
    |Node|Network port|IP subnet|VLAN address|  
    |Node 1|10 Gb RDMA port 1|<Storage Subnet 1>||  
    ||10 Gb RDMA port 2|<Storage Subnet 2>||  
    ||BMC port|<BMC and switch management subnet>||  
    |Node 2, etc.||||  
  
    **Table 1** Network wiring worksheet  
  
4.  Install Windows Server on a local disk of each node.  
  
    Here are the important points to consider when installing Windows Server:  
  
    -   You might want to use the Server Graphical Shell installation option to make the initial server setup easier, but if you do, we suggest removing it after the cluster is set up. Removing it yields a Server Core installation, which reduces the amount of software updates that apply to the servers.  
  
    -   You can deploy the file server nodes by using System Center Virtual Machine Manager \(SC VMM\), Windows Deployment System \(WDS\), Microsoft Deployment Toolkit \(MDT\), or another OS deployment solution.  
  
    -   Consider updating the master operating system image you use to deploy servers before deploying Windows Server \- it's critical that you have all of the latest updates on each node.  
  
## Step 3: Use Group Policy \(or another tool\) to configure the cluster nodes  
There are lots of different ways to do the initial configuration of the cluster nodes:  
  
-   Use Group Policy  
  
-   Use Server Manager  
  
-   Use Windows PowerShell and\/or the Sconfig command \(which helps manage servers that use the Server Core option\)  
  
-   Add settings to an unattend file that's run during Windows Setup  
  
Any of these methods work, but Group Policy provides a relatively easy and quick way to control some basic system settings on all servers that you add to the domain \(assuming that you have Domain Admin permissions\), so we cover it below.  
  
#### To create a Group Policy Object \(GPO\) for your servers  
  
1.  Open Server Manager on a management computer in your domain that has Group Policy Management installed.  
  
    To install the Group Policy Management feature, use the Add Roles and Features Wizard in Server Manager.  
  
2.  Go to **Tools** > **Group Policy Management**.  
  
3.  Right\-click the domain or OU in which you're going to create your file server cluster and then click **Create a GPO in this domain, and Link it here**.  
  
4.  In the **New GPO** dialog box, type a name for the GPO \(for example, **Remote Access Settings**\).  
  
5.  Right\-click the GPO, click **Edit**, and then configure the appropriate settings. Table 2 includes a list of settings you probably want to use.  
  
    |||||  
    |-|-|-|-|  
    |Setting|Location|Value|Rationale|  
    |Remote Desktop access|Computer Configuration > Policies >Administrative Templates > Windows Components > Remote Desktop Services > Remote Desktop Session Host > Connections > Allow users to connect remotely by using Remote Desktop Services|Enabled|Enables infrastructure servers and VMs to accept Remote Desktop connections for management|  
    |Firewall Rule: Remote Desktop|Computer Configuration > Policies > Windows Settings > Security Settings> Windows Firewall with Advanced Security > Windows Firewall with Advanced Security > Inbound Rules|Predefined > Remote Desktop > Allow the connection|Opens firewall ports to allow Remote Desktop management|  
    |Firewall Rule: Windows Management Instrumentation \(WMI\)|Computer Configuration > Policies > Windows Settings > Security Settings> Windows Firewall with Advanced Security > Windows Firewall with Advanced Security > Inbound Rules|Predefined > Windows Management Instrumentation \(WMI\) > Allow the connection|Open firewall ports to all management via GUIs that use WMI, such as Failover Cluster Manager, and Windows PowerShell scripts that query WMI|  
    |File and Printer Sharing over SMB Direct?||||  
    |Firewall Rule: File and Printer Sharing|Computer Configuration > Policies > Windows Settings > Security Settings> Windows Firewall with Advanced Security > Windows Firewall with Advanced Security > Inbound Rules|Predefined > Remote Desktop > Allow the connection||  
  
    **Table 2** Group Policy settings to enable remote access and management  
  
6.  If you haven't already created a GPO for Windows Server Update Services \(WSUS\), you might want to do that now as well so that your file servers nodes can get software updates from your WSUS server \(if you're using one\), as shown in Table 3.  
  
    |||||  
    |-|-|-|-|  
    |Setting|Location|Value|Rationale|  
    |Automatic Updates|Computer Configuration > Policies > Administrative Templates > Windows Components > Windows Update > Configure Automatic Updates|3 \- Auto download and notify for install \(Suggested \- you'll probably want to use Cluster Aware Updating to install updates\)|Tells all servers to download updates but wait for an admin to install them during a maintenance window|  
    |WSUS Server|Computer Configuration > Policies > Administrative Templates > Windows Components > Windows Update >Specify intranet Microsoft update service location|<https:\/\/wsus\_servername> \(Replace with the name of your WSUS server\)|Tells all servers the WSUS server from which to download updates|  
  
    **Table 3** Group Policy settings to configure Windows Server Update Services for the specified computers  
  
## Step 4: Join a domain, enable remote access, and configure updates  
If you're using System Center Virtual Machine Manager to set up your file server cluster, you can do most of the initial configuration automatically on all nodes at once.  
  
Otherwise, you can use Server Manager \(if configuring a small number of nodes\) or Windows PowerShell to join the nodes to a domain, enable remote access, and configure updates.  
  
### To join a domain, enable remote access, and configure updates by using Server Manager  
  
1.  Join the nodes to your management domain, if you haven't already.  
  
    To do so,  perform the following procedure on each node:  
  
    1.  Open Server Manager, and on the Dashboard page, click **Configure this local server**.  
  
    2.  Click the name of the workgroup or domain to which the computer is currently joined.  
  
    3.  In the System Properties dialog, click **Change**, and then specify the computer name to use for the node as well as the domain to join, but don't restart the computer just yet.  
  
2.  If your storage administrator account isn't a member of the Domain Admins group, you'll need to add your storage administrator account to the local Administrators group \- or better yet, add the group you use for storage administrators.  
  
    To do so, in Server Manager, go to **Tools** > **Computer Management**, then go to **Local Users and Groups** > **Groups** > **Administrators**, and add the appropriate groups. Then restart the computer.  
  
3.  Manually check for new updates.  
  
    If you don't want to wait 24 hours for the node to check for new updates from the Windows Server Update Services \(WSUS\) server specified by your GPO, in Server Manager, go to **Local server** > **Last installed updates** > **Never** and then use the Windows Update Control Panel to manually check for updates.  
  
4.  Deploy all applicable driver updates and firmware updates.  
  
    For info on how to add hardware to a server in Server Core mode, see [1.6 Add hardware and manage drivers locally](http://technet.microsoft.com/en-us/library/jj574205.aspx).  
  
5.  Install the storage enclosure management software update described in [KB2913766](http://support.microsoft.com/kb/2913766). After you install the update, you will be able to manage enclosures by using Windows PowerShell cmdlets such as [Get\-StorageEnclosure](http://technet.microsoft.com/library/dn642497.aspx).  
  
6.  Update the firmware for your storage enclosures, disks, servers, network switches, and HBAs to the versions approved by your solution vendor.  
  
Verify that everything is set up properly by using the following steps:  
  
1.  Connect to each node by using Remote Desktop and your storage administrator domain user account.  
  
2.  On your management computer, add each computer to Server Manager.  
  
    To do so, in Server Manager go to **Manage** > **Add Servers**. If the management computer is in a different domain without a trust relationship, add each node by its fully qualified domain name to make sure Server Manager can connect to each node.  
  
3.  In Server Manager, go to **All Servers** and confirm that each computer is listed as **Online**, and that you can see Events and Services for each computer.  
  
> [!NOTE]  
> You'll probably find it easiest to use a management computer in the same domain as the file server cluster, but if you have to use a management computer that's not in a trusted domain, after adding the servers to Server Manager, go to **All Servers**, right\-click each server, click **Manage as…**, and then enter the appropriate credentials.  
  
### To join a domain, enable remote access, and configure updates by using Windows PowerShell  
  
1.  Open a Windows PowerShell session with administrative credentials on the node that you want to manage. Until you get the nodes added to your domain and firewall rules applied, this might be easiest done locally on each node.  
  
    Remote access via Windows PowerShell is enabled by default on Windows Server 2012 R2 as long as you're using a management computer on the same subnet as the remote server \(you'll need to edit the firewall rules to allow more distant Windows PowerShell connections\).  
  
    For example, you could use this command to establish a remote Windows PowerShell session, where <computername> is the name of the computer to connect to, and <username> is an admin account on the computer.  
  
    ```  
    Enter-PSSession -ComputerName <computername> -Credential (Get-Credential -Credential <username>)  
    ```  
  
    > [!TIP]  
    > If you're using a management computer that's not joined to the same domain as your file server cluster, you might get the following error when you try to connect to the nodes by using Windows PowerShell.  
    >   
    > `Connecting to remote server <Node1> failed with the following error message : WinRM cannot process the request. The following error with errorcode 0x80090311 occurred while using Kerberos authentication: There are currently no logon servers available to service the logon request.`  
    >   
    > To fix this, use Windows PowerShell to add each node to the Trusted Hosts list on your management computer. Here's how \(if your nodes all share a common prefix, you can use a wildcard, as shown below\):  
    >   
    > `Set-Item WSMAN:\Localhost\Client\TrustedHosts -Value Node* -Force`  
    >   
    > To view your Trusted Hosts list, type `Get-Item WSMAN:\Localhost\Client\TrustedHosts`.  
    >   
    > To empty the list, type `Clear-Item WSMAN:\Localhost\Client\TrustedHost`.  
  
2.  Join the nodes to your management domain, if you haven't already. To do so, use the following example code, substituting your own computer name, domain name, and domain credentials:  
  
    ```  
    Add-Computer -NewName "FileNode1" -DomainName "contoso.com" -Credential "CONTOSO\GAppel" -Restart -Force  
    ```  
  
3.  If your storage administrator account isn't a member of the Domain Admins group, you'll need to add your storage administrator account to the local Administrators group \- or better yet, add the group you use for storage administrators.  You can use the following command \(you can also write a Windows PowerShell function to do so \- see [Use PowerShell to Add Domain Users to a Local Group](http://blogs.technet.com/b/heyscriptingguy/archive/2010/08/19/use-powershell-to-add-domain-users-to-a-local-group.aspx) for more info\):  
  
    ```  
    net localgroup Administrators /add CONTOSO\GAppel  
    ```  
  
4.  Manually check for new updates.  
  
    If you don't want to wait 24 hours for the node to check for new updates from the Windows Server Update Services \(WSUS\) server specified by your GPO, use the following steps:  
  
    1.  At an administrative Windows PowerShell session or command prompt window, type `SConfig`.  
  
    2.  Type `6` to download updates.  
  
    3.  Type `A` to search for all updates.  
  
    4.  Type `A` to download and install all updates.  
  
5.  Install the storage enclosure management software update described in [KB2913766](http://support.microsoft.com/kb/2913766). After you install the update, you will be able to manage enclosures by using Windows PowerShell cmdlets such as [Get\-StorageEnclosure](http://technet.microsoft.com/library/dn642497.aspx).  
  
6.  Update the firmware for your storage enclosures, disks, servers, network switches, and HBAs to the versions approved by your solution vendor.  
  
To use Windows PowerShell to verify that the computers are properly joined to the domain and that Remote Desktop is enabled, open a Windows PowerShell session with administrative credentials on the computer that you want to manage \(as discussed above\) and then use the following example commands, replacing "*FS01*" and "*FS02*" with the names of the computers that you want to check:  
  
```  
$ComputerName = "FS01","FS02"  
Get-WmiObject -Class Win32_ComputerSystem -ComputerName $ComputerName | Format-Table  
Get-WmiObject -Class Win32_TerminalServiceSetting -Namespace root\cimv2\terminalservices -ComputerName $ComputerName | Format-Table -Property PSComputerName,AllowTsConnections   
```  
  
> [!NOTE]  
> If you get an error stating that "The RPC server is unavailable", make sure that the Windows Management Instrumentation firewall rule is enabled on each of the nodes, as discussed in Step 3: Use Group Policy \(or another tool\) to configure the cluster nodes.  
  
## Step 5: Configure networking  
Once again, if you're using System Center Virtual Machine Manager, you'll probably want to configure networking for your file server nodes using VMM; otherwise you can use the UI on each individual node, or use Windows PowerShell.  
  
### To configure networking by using the UI  
From a management computer on one of the subnets connected to the nodes, do the following:  
  
1.  Connect to the file server node via a Remote Desktop connection.  
  
2.  In **Control Panel**, go to **View network status and task > Change adapter settings**.  
  
3.  If you have any disconnected network adapters, disable them.  
  
4.  Optionally rename the network adapters for easier management.  
  
5.  Set static IP addresses for each network adapter on a separate subnet, using the IP addressing settings according to your network design.  
  
6.  Repeat this procedure for each of the remaining nodes in the file server cluster.  
  
> [!NOTE]  
> If you use a router \(instead of layer 3 switches that can route traffic between subnets\) to provide connectivity between the subnets carrying your storage traffic and the subnets to which your management computers or virtual machines are connected, set the default gateway to point to your router address on each network adapter, not including headless management adapters. When you do so, you'll see a warning about multiple default gateways \- make sure that you're following your network design, then go ahead and ignore it.  
  
### To configure networking by using Windows PowerShell  
From a management computer on one of the same subnets as the file server nodes, open a Windows PowerShell session and then use the following steps:  
  
1.  If you have any disconnected network adapters that you aren't using, disable them to make it easier to see the network adapters you are using. To do so,  run this command, replacing "*FS01,FS02,FS03,FS04*" with the names of the computers that you want to check:  
  
    ```  
    Invoke-Command -ComputerName FS01,FS02,FS03,FS04 -ScriptBlock {  
    Get-NetAdapter |   
    Where-Object -Property Status -EQ Disconnected |  
    Disable-NetAdapter -Confirm}  
    ```  
  
    If you need to enable the disabled adapters, run this command, replacing "*FS01*,*FS02,FS03,FS04*" with the names of the computers that you want to check:  
  
    ```  
    Invoke-Command -ComputerName FS01,FS02,FS03,FS04 -ScriptBlock {  
    Get-NetAdapter -IncludeHidden |   
    Where-object -Property Status -EQ Disabled |  
    Enable-NetAdapter}  
    ```  
  
2.  If you're going to rename your network adapters, first get a list of network adapters. To do so, use the `Get-NetAdapter` cmdlet from each node.  
  
3.  Optionally rename the network adapters for easier management  
  
    To do so, modify the following commands to match your hardware, and then run them in the same Windows PowerShell session \(remove the `-Confirm` parameters if you don't want to confirm each action\).  
  
    ```  
    # Specify on which computers you want to rename network ports  
    [string[]]$ComputerName = "FS01","FS02"  
  
    Invoke-Command -ComputerName $ComputerName -ScriptBlock {  
    # Specify the current NIC names  
    $RDMA_NICName1 = "Ethernet01"  
    $RDMA_NICName2 = "Ethernet02"  
  
    # Specify new NIC names  
    $NewRDMA_NICName1 = "DatacenterNetwork Port 1"  
    $NewRDMA_NICName2 = "DatacenterNetwork Port 2"  
  
    # Rename each NIC  
    Rename-NetAdapter –Name $RDMA_NICName1 –NewName $NewRDMA_NICName1 -Confirm  
    Rename-NetAdapter –Name $RDMA_NICName2 –NewName $NewRDMA_NICName2 -Confirm  
  
    Get-NetAdapter | Sort-Object -Property Name,Status,LinkSpeed | Format-Table   
    }  
    ```  
  
## Step 6: Install server roles and features  
The next step is to install the following server roles and features on all of the nodes:  
  
-   Data Deduplication \(optional depending on your storage design\)  
  
-   Failover Clustering  
  
-   File Server  
  
-   Multipath I\/O \(if you have multiple SAS connections to each storage enclosure\)  
  
-   RSAT\-Clustering\-PowerShell  
  
### To install server roles by using Server Manager  
  
1.  In Server Manager click **Manage** > **Add Roles and Features**.  
  
2.  On the **Select destination server** page of the wizard, select the first node, and then use the **Server Roles** and **Features** pages to install the server roles and features listed above.  
  
3.  Repeat on the rest of the file server nodes.  
  
### To install server roles by using Windows PowerShell  
To install the necessary roles and features by using Windows PowerShell, use this command on a session connected to each node:  
  
```  
Install-WindowsFeature -Name Multipath-IO,FS-FileServer,FS-Data-Deduplication, Failover-Clustering, RSAT-Clustering-PowerShell -Confirm -Restart   
```  
  
## Step 7: Configure MPIO  
If you have multiple SAS connections to your storage enclosures \(which is a good idea for fault tolerance\), the next step is configure MPIO to add support for SAS devices.  
  
### To configure MPIO by using Server Manager  
  
1.  In Server Manager, go to **Tools** > **MPIO**.  
  
2.  In MPIO Properties, click the **Discover Multi\-Paths** tab, and then select the **Add support for SAS devices** checkbox, as shown in Figure 1.  
  
    ![](../Image/The-Discover-Multi-Paths-tab-of-the-MPIO-Properties-dialog-box.png)  
  
    **Figure 1** \- The Discover Multi\-Paths tab of the MPIO Properties dialog box.  
  
3.  Click **Add** and then restart the server.  
  
4.  If see multiple instances of the same disk, or other disk issues, double check that you have the latest firmware updates installed on your disks, and are using disks that are approved by your storage enclosure vendor. Cluster Validation will confirm that MPIO is properly set up later in this process.  
  
### To configure MPIO by using Windows PowerShell  
To configure MPIO by using Windows PowerShell, use the following commands in a session connected to each node.  
  
```  
Update-HostStorageCache  
Get-MPIOAvailableHw  
New-MSDSMSupportedHW -AllApplicable   
Update-MpioclaimedHW -Confirm:$false  
Get-MPIOAvailableHw  
Restart-Computer -Confirm -Force  
```  
  
If MPIO is properly set up, the second time you run the `Get-MPIOAvailableHw` cmdlet, you'll see the **isMultipathed** column show **True**. Cluster Validation will also confirm that MPIO is properly set up before creating the cluster.  
  
## See Also  
[Service Updates on a Server Core Server](../Topic/Service-Updates-on-a-Server-Core-Server.md)  
[Manage a Server Core Server](../Topic/Manage-a-Server-Core-Server.md)  
[Group Policy Overview](../Topic/Group-Policy-Overview.md)  
[Windows Update PowerShell Module](http://gallery.technet.microsoft.com/scriptcenter/2d191bcd-3308-4edd-9de2-88dff796b0bc)  
  
