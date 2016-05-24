---
title: Walkthrough: Demonstrate IPAM in Windows Server 2012 R2
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: be6071c5-0c8d-4362-93bc-cf715a128cc3
---
# Walkthrough: Demonstrate IPAM in Windows Server 2012 R2
IPAM in [!INCLUDE[winblue_server_1](../Token/winblue_server_1_md.md)] provides a single console to plan, design and administer network services and IP address spaces, both physical and virtual. In this lab, you will learn more about how you can use IPAM in your organization to manage physical and virtual address space, delegate permissions in a multi\-user environment, perform advanced DHCP configuration tasks, and leverage Windows PowerShell cmdlets for IPAM to automate routine operations.  
  
## Prerequisites  
This lab has the following prerequisites:  
  
|Computer|Roles|Operating system|Notes|  
|------------|---------|--------------------|---------|  
|DC1|Domain controller, Active Directory\-integrated DNS server, and secondary DHCP server.|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]|The minimum required operating system to demonstrate DHCP failover is [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. You cannot install IPAM on a domain controller.|  
|IPAM1|IPAM server and IPAM client.|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]|IPAM1 must be running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] to demonstrate features in this lab.|  
|DHCP1|Primary DHCP server.|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]|The minimum required operating system to demonstrate DHCP failover is [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. Do not install IPAM on the same server with DHCP.<br /><br />This computer is required to demonstrate DHCP failover but optional for other lab objectives.|  
  
## Lab setup  
The following table summarizes procedures used to configure this lab. Perform the procedures to configure DC1 first, DHCP1 second, and IPAM1 third. If you are not using DHCP1 to demonstrate DHCP failover operations then skip these procedures.  
  
|Computer|Procedures|  
|------------|--------------|  
|DC1|1.  Assign an IP address and DNS server address of **192.168.0.1**, a host name of DC1, then reboot.<br />2.  Install Active Directory Domain Services, DNS Server, and DHCP Server roles.<br />3.  Promote the server to a domain controller for the **contoso.com** domain. The computer will reboot automatically.<br />4.  Sign in as CONTOSO\\Administrator.<br />5.  Complete DHCP configuration by authorizing the DHCP Server service in Active Directory.<br />6.  Create a new user account in contoso.com named **user1**.|  
|DHCP1|1.  Assign an IP address of **192.168.0.2**, a DNS server address of **192.168.0.1**, a host name of DHCP1, join the contoso.com domain, and then reboot.<br />2.  Sign in as CONTOSO\\Administrator.<br />3.  Install the DHCP Server role.<br />4.  Complete DHCP configuration by authorizing the DHCP Server service in Active Directory.|  
|IPAM1|1.  Assign an IP address of **192.168.0.3**, a DNS server address of **192.168.0.1**, a host name of IPAM1, join the  contoso.com domain, and then reboot.<br />2.  Sign in as CONTOSO\\Administrator.<br />3.  Install the IPAM Server feature. IPAM Client will also be installed by default.<br />4.  Provision the IPAM server to use Windows Internal Database \(WID\) and Group Policy Based provisioning with a GPO name prefix of IPAM1.<br />5.  Use the **Invoke\-IpamGpoProvisioning** cmdlet to create IPAM GPOs. Confirm the GPOs were successfully created.<br />6.  Configure IPAM server discovery by adding the contoso.com domain, and then start server discovery.<br />7.  When the server discovery task has completed, view the server inventory and mark DC1 and DHCP1 as managed servers.<br />8.  Update Group Policy; verify that IPAM GPOs are applied, and that DC1 and DHCP1 are unblocked.|  
  
For detailed procedures to install and configure IPAM, see the [Deploy IPAM](../Topic/Deploy-IPAM.md). Detailed steps for installing and configuring DHCP, DNS, and IPAM are also provided in [Walkthrough: Demonstrate IPAM in Windows Server 2012](../Topic/Walkthrough--Demonstrate-IPAM-in-Windows-Server-2012.md).  
  
> [!NOTE]  
> Procedures used for installation of IPAM and provisioning of managed servers procedures are identical in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] when IPAM is used with Windows Internal Database \(WID\). In [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], you can also use SQL Server 2012 to manage the IPAM database. This option is not demonstrated in this lab.  
  
## Objectives  
  
-   [Objective 1: Demonstrate role based access control and delegated administration](../Topic/Walkthrough--Demonstrate-IPAM-in-Windows-Server-2012-R2.md#obj1)  
  
-   [Objective 2: Manage DHCP policy based assignment with IPAM](../Topic/Walkthrough--Demonstrate-IPAM-in-Windows-Server-2012-R2.md#obj2)  
  
-   [Objective 3: Automate IP address lifecycle management](../Topic/Walkthrough--Demonstrate-IPAM-in-Windows-Server-2012-R2.md#obj3)  
  
-   [Objective 4: Administer DHCP failover with IPAM](../Topic/Walkthrough--Demonstrate-IPAM-in-Windows-Server-2012-R2.md#obj4)  
  
-   [Objective 5: Manage DHCP MAC address filters with IPAM](../Topic/Walkthrough--Demonstrate-IPAM-in-Windows-Server-2012-R2.md#obj5)  
  
-   [Objective 6: Manage DHCP superscopes with IPAM](../Topic/Walkthrough--Demonstrate-IPAM-in-Windows-Server-2012-R2.md#obj6)  
  
### <a name="obj1"></a>Objective 1: Demonstrate role based access control and delegated administration  
  
#### Concepts  
Role based access control is new in IPAM in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. Role based access control is comprised of roles, access scopes, and access policies:  
  
-   Roles: A role is a collection of IPAM operations. You can associate a role with a user or group in Windows using an access policy. Several built\-in roles are provided, but you can also create customized roles to meet your business requirements.  
  
-   Access scopes: An access scope determines the objects that a user has access to. You can use access scopes to define administrative domains in IPAM. For example, you might create access scopes based on geographical location. By default, IPAM includes an access scope of Global. All other access scopes are subsets of the Global access scope. Users or groups that are assigned to the Global access scope have access to all objects in IPAM that are permitted by their assigned role.  
  
-   Access policies: An access policy combines a role with an access scope to assign permission to a user or group. For example, you might define an access policy for user1 with a role of IP Block Admin and an access scope of Global\\Asia. Therefore, user1 will have permission to edit and delete IP address blocks that are associated to the Asia access scope. This user will not have permission to edit or delete any other IP address blocks in IPAM.  
  
#### Procedures  
  
1.  [Create a new DHCP Scope named Lab DHCP Scope](../Topic/Walkthrough--Demonstrate-IPAM-in-Windows-Server-2012-R2.md#create_scope)  
  
2.  [Create a second DHCP Scope named Contoso DHCP Scope](../Topic/Walkthrough--Demonstrate-IPAM-in-Windows-Server-2012-R2.md#create_scope2)  
  
3.  [Create new user role named DHCP Scope Editor with only Edit DHCP Scope permission](../Topic/Walkthrough--Demonstrate-IPAM-in-Windows-Server-2012-R2.md#create_role)  
  
4.  [Create a new access scope named Test Lab under the Global access scope](../Topic/Walkthrough--Demonstrate-IPAM-in-Windows-Server-2012-R2.md#create_access_scope)  
  
5.  [Set the Test Lab access scope on the Lab DHCP Scope](../Topic/Walkthrough--Demonstrate-IPAM-in-Windows-Server-2012-R2.md#assign_scope)  
  
6.  [Create an access policy for the user contoso\\user1 and assign the DHCP Scope Editor role and Test Lab access scope](../Topic/Walkthrough--Demonstrate-IPAM-in-Windows-Server-2012-R2.md#create_policy)  
  
7.  [Sign in as contoso\\user1 and verify that this user is only able to perform the operations assigned by the DHCP Scope Editor role and only on the DHCP Scope: Test Lab DHCP Scope](../Topic/Walkthrough--Demonstrate-IPAM-in-Windows-Server-2012-R2.md#test_policy)  
  
##### <a name="create_scope"></a>Create a new DHCP Scope named Lab DHCP Scope  
  
1.  Click **DNS and DHCP Servers**, right\-click DHCP1, and then click **Create DHCP Scope**.  
  
2.  Type **Lab DHCP Scope** next to **Scope name**.  
  
3.  Type **40.40.1.0** and **40.40.1.100** next to **Start IP address** and **End IP address**, respectively.  
  
4.  Leave the subnet mask unchanged, and click **OK**.  
  
##### <a name="create_scope2"></a>Create a second DHCP Scope named Contoso DHCP Scope  
  
1.  Click **DNS and DHCP Servers**, right\-click DHCP1, and then click **Create DHCP Scope**.  
  
2.  Type **Contoso DHCP Scope** next to **Scope name**.  
  
3.  Type **50.50.1.0** and **50.50.1.100** next to **Start IP address** and **End IP address**, respectively.  
  
4.  Leave the subnet mask unchanged, and click **OK**.  
  
##### <a name="create_role"></a>Create new user role named DHCP Scope Editor with only Edit DHCP Scope permission  
  
1.  Click **ACCESS CONTROL**, right\-click **Roles**, and then click **Add User Role**.  
  
2.  Type **DHCP Scope Editor** next to **Name**.  
  
3.  Expand **DHCP scope operations** to view the list of all available operations.  
  
4.  Select only the **Edit DHCP scope** operation, and then click **OK**.  
  
##### <a name="create_access_scope"></a>Create a new access scope named Test Lab under the Global access scope  
  
1.  Right\-click **Access Scopes** and then click **Add Access Scope**.  
  
2.  Click **New**, type **Test Lab** next to **Name**, click **Add**, and then click **OK**.  
  
##### <a name="assign_scope"></a>Set the Test Lab access scope on the Lab DHCP Scope  
  
1.  Click **DHCP Scopes**, right\-click the **Lab DHCP Scope**, and then click **Set Access Scope**.  
  
2.  Clear the **Inherit access scope** from parent checkbox.  
  
3.  Click the **Test Lab** access scope under **Global**, and then click **OK**.  
  
4.  Verify that **\\Global\\Test Lab** is displayed under **Access Scope**.  
  
##### <a name="create_policy"></a>Create an access policy for the user contoso\\user1 and assign the DHCP Scope Editor role and Test Lab access scope  
  
1.  Click **ACCESS CONTROL**, right\-click **Access Policies**, and then click **Add Access Policy**.  
  
2.  Click **Add**, type **contoso\\user1**, and then click **OK**.  
  
    > [!TIP]  
    > If you didn’t create a user1 account in contoso.com, create it before proceeding.  
  
3.  Under **Access Settings**, click **New**.  
  
4.  Under **Select role**, choose **DHCP Scope Editor**.  
  
5.  Under **Select the access scope for the role**, click **Test Lab**, click **Add Setting**, and then click **OK**.  
  
##### <a name="test_policy"></a>Sign in as contoso\\user1 and verify that this user is only able to perform the operations assigned by the DHCP Scope Editor role and only on the DHCP Scope: Test Lab DHCP Scope  
  
1.  Sign out on the IPAM server, and then sign in with the user1 account you created earlier.  
  
2.  Launch Server Manager and click **IPAM**.  
  
3.  Click **DHCP Scopes**, right\-click the **Lab DHCP Scope**, and then click **Deactivate DHCP Scope**.  
  
4.  Review the error message displayed.  
  
5.  Right\-click the **Contoso DHCP Scope** and click **Edit DHCP Scope**.  
  
6.  Change the **End IP address** to **50.50.1.101** and then click **OK**.  
  
7.  Review the error message displayed, and then click **Cancel**.  
  
8.  Edit the Lab DHCP Scope and change the End IP address to 40.40.1.101.  
  
9. Verify that the operation is successful.  
  
10. Sign out and then sign in again as contoso\\administrator.  
  
### <a name="obj2"></a>Objective 2: Manage DHCP policy based assignment with IPAM  
  
#### Concepts  
DHCP Policy Based Assignment \(PBA\) is a powerful feature for IPV4 networks that was first introduced in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] for the DHCP server role. PBA enables control over the network and the devices accessing it. DHCP policies can be used to identify and group together devices based on attributes like MAC Address, Vendor Class and User Class. You can then control the leases and DHCP options that are assigned to these devices. For example, you can use DHCP policies to match the MAC address of clients and thus ensure that all virtual machines accessing your network are assigned addresses from a specific IP address range, or are assigned specific DHCP options.  
  
DHCP policies can be configured at server level or the scope \(subnet\) level. Previously, policies were accessible only for individual DHCP servers by using the DHCP management console or with Windows PowerShell. Using IPAM in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], you can create and manage policies centrally across multiple DHCP servers. You can create a policy for multiple servers or scopes in a single operation. You can also copy policies from one server or scope to another.  
  
The following procedures demonstrate how IPAM enables you to centrally manage DHCP policies in an efficient manner.  
  
#### Procedures  
  
1.  [Configure new DHCP policies and import existing DHCP policies](../Topic/Walkthrough--Demonstrate-IPAM-in-Windows-Server-2012-R2.md#config_policies)  
  
2.  [Manage existing DHCP policies in IPAM](../Topic/Walkthrough--Demonstrate-IPAM-in-Windows-Server-2012-R2.md#manage_policies)  
  
##### <a name="config_policies"></a>Configure new DHCP policies and import existing DHCP policies  
  
1.  Click **DNS and DHCP Servers**.  
  
2.  Right\-click DHCP1 and then click **Configure DHCP Policy**.  
  
3.  Next to **Name**, type **Printer Policy**.  
  
4.  Under **Policy Conditions**, click **New**.  
  
5.  Under **New Condition**, next to **Criteria**, choose **Fully Qualified Domain Name**.  
  
6.  Next to **Value**, type **PRN**, select the **Use wildcard** checkbox, choose **Append** from the drop\-down list, click **Add**, click **Add Condition**, and then click **OK**.  
  
7.  In the **DNS and DHCP Servers** view, choose **DHCP** next to **Server Type** and then choose **Policies** next to View.  
  
8.  In the **Details View**, click the **Conditions** tab to view details about the policy.  
  
9. Choose **Server Properties** next to **View**, right\-click DC1, and then click **Import DHCP Policy**.  
  
10. Choose **dhcp1.contoso.com** next to **Select server**, choose the **Printer Policy** to import, and then click **OK**.  
  
11. Choose **Policies** next to **View** and verify that **Printer Policy** is present on both DC1 and DHCP1.  
  
##### <a name="manage_policies"></a>Manage existing DHCP policies in IPAM  
  
1.  Create another policy on DHCP1 called **Workgroup Policy** using the **Fully Qualified Domain Name** criteria and the **Is Single Label** operator.  
  
2.  Using the **Policies** view, right\-click **Workgroup Policy** and then click **Edit DHCP Policy**.  
  
3.  Under **DNS Dynamic Updates**, next to **Enable DNS dynamic updates**, choose **Yes**.  
  
4.  Next to **Enable name protection**, choose **No**.  
  
5.  Next to **Dynamically update DNS records**, choose **Always**.  
  
6.  Next to **Discard DNS records when lease is deleted**, choose **Yes**.  
  
7.  Next to **Dynamically update DNS records for DHCP clients that do not request updates**, choose **Yes**.  
  
8.  Next to **Disable dynamic updates for DNS PTR records**, choose **No**.  
  
9. Next to **Register DHCP clients using a different DNS suffix**, choose **Yes**.  
  
10. Type **contoso.com** next to **Use the following DNS suffix**, and then click **OK**.  
  
11. Right\-click **Workgroup Policy** and then click **Move Up Processing Order**.  
  
### <a name="obj3"></a>Objective 3: Automate IP address lifecycle management  
  
#### Concepts  
New Windows PowerShell cmdlets for IPAM make it easier to automate IP address lifecycle management. A rich set of cmdlets are available that enable you to perform all management functions for your IP addresses, ranges and blocks. You can leverage these cmdlets to write scripts and integrate IPAM with various physical and virtual devices or servers. This saves time, eliminates manual intervention, and reduces operating cost.  
  
#### Procedures  
  
1.  [Create an IP address range in IPAM](../Topic/Walkthrough--Demonstrate-IPAM-in-Windows-Server-2012-R2.md#create_ip)  
  
2.  [View IP address ranges in IPAM](../Topic/Walkthrough--Demonstrate-IPAM-in-Windows-Server-2012-R2.md#view_range)  
  
3.  [Track utilization of IP ranges](../Topic/Walkthrough--Demonstrate-IPAM-in-Windows-Server-2012-R2.md#track)  
  
4.  [Find a free IP address and assign it to a new printer](../Topic/Walkthrough--Demonstrate-IPAM-in-Windows-Server-2012-R2.md#find_free)  
  
5.  [Deprovision the added printer and reclaim the IP address](../Topic/Walkthrough--Demonstrate-IPAM-in-Windows-Server-2012-R2.md#deprovision)  
  
##### <a name="create_ip"></a>Create an IP address range in IPAM  
  
1.  Type the following command at a Windows PowerShell prompt and press ENTER:  
  
    ```  
    PS C:\>Add-IpamRange –NetworkId 192.168.0.0/24 –StartIPAddress 192.168.0.1 –EndIPAddress 192.168.0.254 -CreateSubnetIfNotFound  
    ```  
  
    This command creates an IP address range for servers in the test lab. Also use the next command to add individual IP addresses for the three computers used in this lab.  
  
2.  Type the following command at a Windows PowerShell prompt and press ENTER:  
  
    ```  
    PS C:\>Add-IpamAddress –IpAddress 192.168.0.1  
    PS C:\>Add-IpamAddress –IpAddress 192.168.0.2  
    PS C:\>Add-IpamAddress –IpAddress 192.168.0.3  
    ```  
  
##### <a name="view_range"></a>View IP address ranges in IPAM  
  
1.  Type the following command at a Windows PowerShell prompt and press ENTER:  
  
    ```  
    PS C:\>Get-IpamRange –AddressFamily IPv4 –AddressCategory Private  
    ```  
  
2.  Verify that the IP address range that was recently added is displayed. Also try specifying an AddressCategory of Public to view the two public IP address ranges used for DHCP scopes.  
  
3.  To view more detailed information, type the following commands at a Windows PowerShell prompt and press ENTER:  
  
    ```  
    PS C:\>$a= Get-IpamRange –AddressFamily IPv4 –AddressCategory Private  
    PS C:\>$a[0]|fl *  
    ```  
  
##### <a name="track"></a>Track utilization of IP ranges  
  
1.  Type the following command at a Windows PowerShell prompt and press ENTER:  
  
    ```  
    PS C:\>Get-IpamRange –AddressFamily IPv4 –AddressCategory Private|where-object {$_.PercentageUtilized –gt 80}  
    ```  
  
    This command will display IP address ranges where the utilization is over 80%.  
  
2.  Type the following commands at a Windows PowerShell prompt and press ENTER:  
  
    ```  
    PS C:\> Get-IpamRange –AddressFamily IPv4 –AddressCategory Private|where-object {$_.PercentageUtilized –gt 80}|Export-Csv –Path “C:\Users\Administrator\Desktop\OverUtilizedRanges.csv” –NoTypeInformation -Force   
    PS C:\>notepad “C:\Users\Administrator\Desktop\OverUtilizedRanges.csv”  
    ```  
  
    This will open a notepad file containing all the over\-utilized public IPv4 address ranges \(currently blank\).  
  
3.  Type the following command at a Windows PowerShell prompt and press ENTER:  
  
    ```  
    PS C:\> Get-IpamRange –AddressFamily IPv4 –AddressCategory Private|where-object {$_.Overlapping –eq “True”}  
    ```  
  
    The previous command will display any overlapping IP address ranges, if they exist.  
  
##### <a name="find_free"></a>Find a free IP address and assign it to a new printer  
  
1.  Type the following command at a Windows PowerShell prompt and press ENTER:  
  
    ```  
    PS C:\>$range = Get-IpamRange –StartIPAddress 192.168.0.1 -EndIPAddress 192.168.0.254   
    PS C:\>Find-IpamFreeAddress –InputObject $range -TestReachability  
    ```  
  
2.  Confirm that the first available IP address is 192.168.0.4.  
  
3.  Type the following command at a Windows PowerShell prompt and press ENTER:  
  
    ```  
    PS C:>$range = Get-IpamRange –StartIPAddress 192.168.0.1 -EndIPAddress 192.168.0.254   
    PS C:\>$freeip = Find-IpamFreeAddress –InputObject $range –TestReachability   
    PS C:\>$ip = Add-IpamAddress –IpAddress $freeIp.Address –ManagedByService $range.ManagedByService –ServiceInstance $range.ServiceInstance –DeviceType Printer –AssignmentType Dynamic –MacAddress ”AA-BB-CC-DD-EE-FF” –ReservationServer $range.DhcpServerName –ReservationName “B3_F1_Printer_HP” –ReservationType Both –ReservationDescription “Reservation for printer on first floor of building 3” -PassThru   
    PS C:\>$ip|fl *  
    ```  
  
4.  Verify that the 192.168.0.4 IP address is assigned to a printer.  
  
In this case, the IP address range does not correspond to a DHCP scope it is not possible to add this reservation to a DHCP scope. If this scope were present on DC1 or DHCP2, you can use the Add\-DhcpServerv4Reservation cmdlet to add this IP address. See the following example:  
  
```  
PS C:>Add-DhcpServerv4Reservation –ComputerName $ip.ReservationServer –IPAddress $ip.IPAddress –ClientId $ip.MacAddress –ScopeId $ip.ReservationScopeDetails –Name $ip.ReservationName –Description $ip.ReservationDescription -PassThru  
```  
  
Use the following command to delete the reservation:  
  
```  
PS C:\> Remove-DhcpServerv4Reservation –ComputerName $ip.ReservationServer –IPAddress $ip.IPAddress -PassThru  
```  
  
##### <a name="deprovision"></a>Deprovision the added printer and reclaim the IP address  
  
1.  To delete the IP address from IPAM, type the following command at a Windows PowerShell prompt and press ENTER:  
  
    ```  
    PS C:\>Remove-IpamAddress –InputObject $ip -Force  
    ```  
  
### <a name="obj4"></a>Objective 4: Administer DHCP failover with IPAM  
  
#### Concepts  
IPAM enables you to view, monitor, and manage DHCP failover relationships in the managed network. DHCP failover is a new feature introduced with [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. For more information about DHCP failover, see [Step-by-Step: Configure DHCP for Failover](../Topic/Step-by-Step--Configure-DHCP-for-Failover.md).  
  
#### Procedures  
  
1.  [Create a failover relationship](../Topic/Walkthrough--Demonstrate-IPAM-in-Windows-Server-2012-R2.md#create_fail)  
  
2.  [View the details of a failover relationship](../Topic/Walkthrough--Demonstrate-IPAM-in-Windows-Server-2012-R2.md#view_fail)  
  
3.  [Edit a failover relationship](../Topic/Walkthrough--Demonstrate-IPAM-in-Windows-Server-2012-R2.md#edit_fail)  
  
4.  [Replicate Scopes](../Topic/Walkthrough--Demonstrate-IPAM-in-Windows-Server-2012-R2.md#replicate)  
  
5.  [Demonstrate auto\-sync](../Topic/Walkthrough--Demonstrate-IPAM-in-Windows-Server-2012-R2.md#auto_sync)  
  
6.  [Remove scopes from a failover relationship](../Topic/Walkthrough--Demonstrate-IPAM-in-Windows-Server-2012-R2.md#remove_scopes)  
  
7.  [Delete a failover relationship](../Topic/Walkthrough--Demonstrate-IPAM-in-Windows-Server-2012-R2.md#delete_fail)  
  
##### <a name="create_fail"></a>Create a failover relationship  
  
1.  Click **DHCP Scopes** and choose **Scope Properties** next to **Current view**.  
  
2.  Select both the **Contoso DHCP Scope** and the **Lab DHCP Scope** \(using CTRL or SHIFT\), right\-click these scopes and then click **Configure DHCP Failover**.  
  
3.  Next to **Partner server**, choose **DC1.contoso.com**.  
  
4.  Next to **Relationship name**, type **DHCP1\-DC1**.  
  
5.  Next to **Relationship name**, type **DHCP1\-DC1**.  
  
6.  Next to **Secret**, type a shared secret, for example: **secret**.  
  
7.  The **Load Balance** mode is chosen by default with 50% of leases being issued by each DHCP server. Click **OK** to accept these parameters.  
  
8.  Verify that two new scopes have been created with **DC1.contoso.com** displayed in the **Server Name** column.  
  
##### <a name="view_fail"></a>View the details of a failover relationship  
  
1.  Click **DNS and DHCP Servers**, choose **DHCP** next to **Server Type**, and choose **Failover Relationships** next to **View**.  
  
2.  In the **Details View**, review information on the **Relationship Properties** tab and the **DHCP Scopes** tab.  
  
##### <a name="edit_fail"></a>Edit a failover relationship  
  
1.  Right\-click the **DHCP1\-DC1** failover relationship and click **Edit DHCP Failover Relationship**.  
  
2.  Under **Mode**, choose **Hot Standby**, and then click **Apply**.  
  
3.  Verify that **Success** is displayed under **Status**, and then click **OK**.  
  
4.  Verify that **Hot Standby** is displayed in the **Mode** column for this failover relationship.  
  
##### <a name="replicate"></a>Replicate Scopes  
  
1.  Right\-click the **DHCP1\-DC1** failover relationship and then click **Replicate DHCP Failover Relationship**.  
  
2.  In the **Replicate Failover Relationship** dialog box, choose **dhcp1.contoso.com** as the originating server for replication, and then click **OK**. This action replicates all scopes in the failover relationship.  
  
3.  Since no changes have been made to DHCP scopes on DC1 or DHCP1, the information displayed under **Replicate progress** will indicate that scopes are identical.  Click **Close**.  
  
4.  Choose **Server Properties** next to **View**.  
  
5.  Right\-click DHCP1 and then click **Replicate DHCP Server**. This action replicates all scopes in all DHCP failover relationships on the server. Click **OK** to continue with the replication process.  
  
6.  Review the information under **Replicate progress**, and then click **Close**.  
  
7.  Choose **Scope Properties** next to **View**.  
  
8.  Right click a single scope and then click **Replicate DHCP Scope**. You can also choose multiple scopes to replicate but all scopes must belong to the same DHCP server.  
  
9. Click **OK** to confirm the replication and then click **Close**.  
  
##### <a name="auto_sync"></a>Demonstrate auto\-sync  
  
1.  Right\-click the column header in **Scope Properties** view and select the **Failover Config Sync Status** header.  
  
2.  Choose **Server Properties** next to **View**.  
  
3.  Choose **Server Properties** next to **View**.  
  
4.  Right\-click DHCP1 and then click **Launch MMC**.  
  
5.  Click **dhcp1.contoso.com** once, then right\-click **dhcp1.contoso.com**, point to **All Tasks**, and then click **Stop**.  
  
6.  In IPAM, right\-click DHCP1, and click **Retrieve Server Data**.  
  
7.  When the **IPAM ServerAvailability** task has completed running, refresh the console view and verify that DHCP1 displays **Stopped** in the **Server Availability** column.  
  
8.  Choose **Scope Properties** next to **View**, right\-click the **Lab DHCP Scope** on DC1 and then click **Edit DHCP Scope**.  
  
9. Change the **Lease duration for DHCP clients** from 8 days to 7 days and then click **OK**. Since the scope is part of a DHCP failover relationship and the partner server is down, an error is displayed.  
  
10. View the **Failover Config Sync Status** column and verify that **Out of sync** is displayed for the Lab DHCP Scope on DC1.  
  
11. Start the DHCP Server service on DHCP1 and **Retrieve Server Data** again.  
  
12. Refresh the IPAM console view and verify that DHCP1 displays **Running** again under **Server Availability**.  
  
13. Choose **Scope Properties** view, right\-click the **Lab DHCP Scope** on DC1, and then click **Replicate DHCP Scope**.  
  
14. Under **Replicate progress**, verify that the new option values were replicated successfully, and then click **Close**. You also have the option of editing the scope on the partner server manually and then clearing the config sync error.  
  
##### <a name="remove_scopes"></a>Remove scopes from a failover relationship  
  
1.  Click **DHCP Scopes**, right\-click the column header, point to **Group by**, and then click **Server Name**. This is a useful way of displaying scopes on a per\-server basis.  
  
2.  Right\-click the **Lab DHCP Scope** on DHCP1 and then click **Remove DHCP Failover Configuration**. Click **OK** to confirm the removal. This will keep the scope on DHCP1 and remove it from the failover partner \(DC1\).  
  
    > [!TIP]  
    > Under **Progress of Failover configuration removal**, verify that all processes are successful, and then click **Close**.  
  
3.  Verify that no **Failover Relationship Name** is displayed for the **Lab DHCP Scope** on DHCP1 and the scope no longer exists on DC1.  
  
##### <a name="delete_fail"></a>Delete a failover relationship  
  
1.  Click **DNS and DHCP Servers** and switch to **Failover Relationships** view.  
  
2.  Right\-click the **DHCP1\-DC1** failover relationship and then click **Delete**.  
  
3.  Next to **Select server**, choose the server that will keep the scopes that are still associated to this failover relationship. By default, the primary DHCP server is selected \(DHCP1\).  
  
4.  Click **OK** and verify that the remaining scope was deleted from DC1.  
  
5.  Click **Close** and verify that the failover relationship was deleted.  
  
### <a name="obj5"></a>Objective 5: Manage DHCP MAC address filters with IPAM  
  
#### Concepts  
Media access control \(MAC\) address based filtering or link layer\-based filtering for DHCP enables you to control network access based on MAC addresses, providing a low\-level security method. You can create MAC address based filters to specify which MAC addresses are allowed on the network and which are denied access.  
  
A DHCP server maintains **Allow** and **Deny** lists of MAC addresses. If you add MAC addresses to the allow list and enable the list, only these MAC addresses will be granted an IP address by the DHCP server. If you add MAC addresses to deny list and enable the list, these MAC addresses will be denied service by the DHCP server. You can enable both allow and deny lists, in which case the deny list takes precedence. This means that the DHCP server provides DHCP services only to clients whose MAC addresses are in the allow list, provided that no corresponding matches are in the deny list.  
  
You can use wildcards to allow or deny network access based on vendor MAC prefixes. Link layer filtering is currently available for IPv4 address only.  
  
This section demonstrates how IPAM allows you to centrally manage MAC address filters.  
  
#### Procedures  
  
1.  [Add DHCP MAC address filters](../Topic/Walkthrough--Demonstrate-IPAM-in-Windows-Server-2012-R2.md#add_MAC)  
  
2.  [Manage DHCP MAC address filters in IPAM](../Topic/Walkthrough--Demonstrate-IPAM-in-Windows-Server-2012-R2.md#Manage_MAC)  
  
##### <a name="add_MAC"></a>Add DHCP MAC address filters  
  
1.  Click **DNS and DHCP Servers**, choose **DHCP** next to **Server Type** and choose **Server Properties** next to **View**.  
  
2.  Verify that the **Server Properties** tab in **Details View** shows that both the **Allow** and **Deny MAC Address Filters** are currently **Disabled**.  
  
3.  Select one or both DHCP servers, right\-click and then click **Edit DHCP Server Properties**.  
  
4.  Click **MAC Address Filters** and notice that you can enable or disable MAC address filter lists here. Click **OK**.  
  
5.  Right\-click DHCP1 and then click **Add DHCP MAC Address Filter**.  
  
6.  Next to **Filter Type** choose **Deny**.  
  
7.  Next to **MAC Address** type **AA\-BB\-CC\-\***.  
  
8.  Click **Add MAC Address Filter** and then click **OK**.  
  
9. Choose **Filters** next to View and verify that a **Deny** filter was added to **dhcp1.contoso.com** for the **MAC Address** of **AA\-BB\-CC\-\*\-\*\-\***.  
  
##### <a name="Manage_MAC"></a>Manage DHCP MAC address filters in IPAM  
  
1.  Right\-click the MAC address filter created in the previous procedure and then click **Move to Allow**.  
  
2.  Verify that the **Filter Type** changes to **Allow**.  
  
3.  Right\-click the filter and then click **Delete**.  
  
### <a name="obj6"></a>Objective 6: Manage DHCP superscopes with IPAM  
  
#### Concepts  
Consider the scenario where the available IP addresses in currently active scopes are nearly depleted, but more computers are expected to be added to the network. In this scenario, you can use superscopes to allow a DHCP server to provide leases to clients from more than one scope on a single physical network. DHCP scopes in the same superscope can share IP addresses and gives leases to clients on each other’s subnet.  
  
Superscopes can also help you resolve deployment issues such as migrating clients to a new scope \(for example, when renumbering the network\). Superscopes are available for IPv4 address only.  
  
This section demonstrates how IPAM enables you to create and manage DHCP superscopes.  
  
#### Procedures  
  
1.  [Adding scopes to a superscopes](../Topic/Walkthrough--Demonstrate-IPAM-in-Windows-Server-2012-R2.md#add_super)  
  
2.  [Manage DHCP superscopes](../Topic/Walkthrough--Demonstrate-IPAM-in-Windows-Server-2012-R2.md#manage_super)  
  
##### <a name="add_super"></a>Adding scopes to a superscopes  
  
1.  Click DNS and DHCP Servers, and choose DHCP next to Server Type and Scope Properties next to View.  
  
2.  On the **Scope Properties** tab in **Details View**, the names of superscopes are displayed next to **Superscope Name**. This is also displayed in the **Superscope Name** column. Verify that currently this field is blank for all scopes.  
  
3.  Right\-click the **Lab DHCP Scope** and then click **Add to DHCP Superscope**.  
  
4.  Next to **Superscope name**, type **Lab Superscope** and then click **OK**.  
  
5.  Verify that **Lab Superscope** is displayed next to **Superscope Name**.  
  
6.  Right\-click the **Contoso DHCP Scope** and then click **Add to DHCP Superscope**.  
  
7.  Choose **Use existing superscope**, select **Lab Superscope**, and then click **OK**.  
  
8.  To remove a scope, Right\-click the scope and then click **Remove from DHCP Superscope** If all scopes are removed from a superscope, it is automatically deleted.  
  
##### <a name="manage_super"></a>Manage DHCP superscopes  
  
1.  Next to **View**, choose **Superscope Properties**.  
  
2.  Review information in the **Details View** using the **Superscope Properties** tab and the **DHCP Scopes** tab.  
  
3.  Right\-click a superscope to perform several management actions.  
  
