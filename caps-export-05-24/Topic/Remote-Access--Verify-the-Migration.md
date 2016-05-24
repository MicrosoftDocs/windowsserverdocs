---
title: Remote Access: Verify the Migration
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 487899c9-1f78-4d3d-939b-17022326ad60
---
# Remote Access: Verify the Migration
After all the migration steps are completed, you can use the following procedure to verify that the migration of Remote Access was successful. If the migration failed, you can return to the previous valid configuration by following the roll\-back steps in [Remote Access: Post-migration Tasks](../Topic/Remote-Access--Post-migration-Tasks.md).  
  
## Verifying the destination server configuration  
Membership in the local **Administrators** group or equivalent is the minimum required to complete these procedures. If User Account Control \(UAC\) is enabled, then you might have to run the following steps by using the **Run as administrator** option.  
  
We recommend that you check the configuration of the destination Remote Access server, from the service start\-up to the detailed configuration of individual components. The following sections provide a list of items to check. Depending on which Remote Access components are enabled on your server, only some of these checks might be necessary.  
  
### Installation state of Remote Access  
The first verification step is to confirm that the Remote Access feature installed successfully.  
  
##### To verify that Remote Access installed on the destination server  
  
1.  Click **Windows Server Migration Tools** on the **Start** screen.  
  
2.  View the installation status of the Routing and Remote Access service by running the following command:  
  
    ```  
    Get-WindowsFeature RemoteAccess  
    ```  
  
    The check box on the left of the  **Remote Access** feature name is selected if the service is installed on the destination server. If it is not installed, the check box is clear.  
  
### Status of Remote Access Service  
Verify that the Remote Access service is running.  
  
##### To verify that the Routing and Remote Access service is running on the destination server  
  
1.  Click **Windows Server Migration Tools** on the **Start** screen.  
  
2.  View the service status of the Routing and Remote Access service by running the following command:  
  
    ```  
    Get-service RemoteAccess  
    ```  
  
3.  Examine the **Status** column. It should read **Running**.  
  
### Remote access Operations Status  
Verify the operations status of the deployment.  
  
##### To verify the Remote Access operations status  
  
1.  In **Server Manager** click **Tools** and then click **Remote Access Management**.  
  
2.  Click **OPERATIONS STATUS** to navigate to **Operations Status** in the **Remote Access Management Console**.  **Operations Status** lists the server operational status and that of all its components.  
  
### DirectAccess configuration  
Verify the operations status of the deployment.  
  
##### To verify the DirectAccess configuration settings  
  
1.  In **Server Manager** click **Tools** and then click **Remote Access Management**.  
  
2.  Click **CONFIGURATION** to navigate to Configuration tab in **Remote Access Management console**. Step through each of the wizards to ensure that the configuration has been migrated successfully.  
  
### VPN configuration  
Confirm the configuration settings for the Remote Access server and ports.  
  
##### To verify the Remote Access configuration settings  
  
1.  Start Server Manager.  
  
2.  In **Tools**, click **Routing and Remote Access**.  
  
3.  Right\-click the Remote Access server node, and then click **Properties**.  
  
    On each tab, confirm that the destination server is configured the same as the source server, and then click **OK**.  
  
4.  In the navigation pane, select **Ports**.  
  
    Confirm that any modem or ISDN devices that are attached to the computer are included in the list.  
  
5.  In the navigation pane, right\-click **Remote Access Logging and Policies**, and then click **Launch NPS**. In the Network Policy Server navigation pane, select **Network Policies**.  
  
    Confirm that the NPS policies that are currently configured are those required for your environment. If you migrated them from an NPS source server to an NPS destination server, confirm that you are connected to the destination server and that the policies migrated successfully.  
  
### Dial\-up configuration  
You must confirm that the correct phone lines are attached to the modems or ISDN ports on the destination server.  
  
### Demand\-dial VPN configuration  
Examine all of your demand\-dial VPN connections to ensure that they migrated with the correct settings.  
  
##### To verify the settings for a demand\-dial VPN connection  
  
1.  Start Server Manager.  
  
2.  Click **Routing and Remote Access**, and then select **Network Interfaces**.  
  
3.  In the details pane, right\-click a demand\-dial interface, and then click **Properties**.  
  
    On each tab, confirm that the connection is configured the same as the source server, and then click **OK**.  
  
### Router settings  
Confirm that the router components installed, and verify that each is configured correctly. The available routing components include:  
  
-   **IPv4:** Static Routes, DHCP Relay Agent, IGMP, NAT, and RIPv2  
  
-   **IPv6:** Static Routes and DHCPv6 Relay Agent  
  
##### To verify the routing components  
  
1.  Start Server Manager.  
  
2.  Click **Routing and Remote Access**.  
  
3.  Expand **IPv4**. Examine the list of installed routing components, and ensure that the components required for your deployment are installed.  
  
4.  Expand **IPv6** and follow the same process as the previous step.  
  
5.  In the navigation pane, under **IPv4**, click **General**.  
  
    The details pane identifies the interfaces that are configured to route packets for each version of IP. Confirm that the list contains the expected interfaces, including configured demand\-dial interfaces.  
  
6.  In the navigation pane, under **IPv6**, click **General** and follow the same process as the previous step.  
  
7.  In the details pane for **General** under **IPv4**, right\-click each interface and select **Properties**.  
  
    On each tab confirm that the interface is configured as required for its routing role on the server.  
  
8.  Follow the same process as described in the previous step for the interfaces listed on the under **IPv6** \/ **General**.  
  
9. Under **IPv4** select **Static Routes** and confirm that the routes to destination networks are correctly configured with the associated interface and destination gateway address.  
  
10. Follow the same process as described in the previous step for the **Static Routes** under **IPv6**.  
  
11. Under **IPv4**, select **NAT**. The details pane shows the interfaces that NAT is configured to use. Right\-click each interface and click **Properties**.  
  
    -   Confirm that each interface is configured correctly for NAT. There should be at least two interfaces enabled for NAT, one configured as the **Private** interface, and one configured as the **Public** interface.  
  
    -   If NAT is responsible for providing IPv4 addresses to clients on the private network, then on **NAT Properties** page, on the **Address Assignment** tab, select the **Automatically assign IP addresses by using the DHCP allocator** check box and enter the address information to be used.  
  
    -   If your ISP has provided a pool of addresses to be used by the NAT public interface, ensure that they are configured correctly. The addresses are under **NAT**, on the **Properties** page for the interface, on the **Address Pool** tab. If the addresses that were migrated are not applicable to the target computer, modify the list to use the correct addresses.  
  
    -   For each interface under **NAT**, on the interface’s **Properties** page on the **Services and Ports** tab, examine the port mappings for services that must be routed to a specific server IP address. Confirm that each service that is to be mapped has the correct address pool entry, private IP address, and port settings configured.  
  
12. Under **IPv4**, select each enabled routing protocol. The details pane shows the interfaces on which the selected routing protocol is enabled. Right\-click each interface, and then click **Properties**.  
  
    Confirm that each interface is configured correctly for the selected routing protocol. For example, under **IPv4**\/**NAT**, there should be at least two interfaces, one configured as the **Private** interface, and one configured as the **Public** interface.  
  
13. Under **IPv6**, select each enabled routing protocol and follow the same process described in the previous step.  
  
14. Under **IPv4**, right\-click each routing protocol, and then select **Properties** to examine the global configuration for that routing protocol.  
  
    Confirm that each protocol is configured correctly for your environment. For example, ensure that the **DHCP Relay Agent** has a list of DHCP server addresses to which it can forward DHCP requests from clients.  
  
15. Under **IPv6**, select each enabled routing protocol and follow the same process described in the previous step.  
  
### User and Group accounts  
If you migrated the user and group accounts by using the [Local User and Group Migration Guide](http://go.microsoft.com/fwlink/?linkid=163774) \(http:\/\/go.microsoft.com\/fwlink\/?linkid\=163774\), follow the procedures in its verification section to confirm that the required users and group were migrated successfully.  
  
If you instead used the **\-user** and **\-group** parameters on the **Import\-SmigServerSetting** command, you can manually verify the accounts by using the **Local Users and Groups** MMC snap\-in to examine the user and group accounts and confirm that the properties for the accounts are set properly.  
  
### Final checks  
  
-   If your computer is configured to host VPN\/DirectAccess connections, test each type of supported connection to confirm that users can connect.  
  
-   If your server is configured to host dial\-up connections, verify that client computers can successfully dial\-in and connect to the server by using the modems that are installed.  
  
-   If your server is configured as an IPv4 or IPv6 router, verify that clients on each attached network can connect through the router to computers on all of the other attached networks. If you use the **ping** command for this test, ensure that Windows Firewall on the router and the client computers is configured to allow ICMP Echo Request and ICMP Echo Reply messages.  
  
## See Also  
[Migrate Remote Access to Windows Server 2012](../Topic/Migrate-Remote-Access-to-Windows-Server-2012.md)  
[Remote Access: Prepare to Migrate](../Topic/Remote-Access--Prepare-to-Migrate.md)  
[Remote Access: Migrate Remote Access](../Topic/Remote-Access--Migrate-Remote-Access.md)  
[Remote Access: Post-migration Tasks](../Topic/Remote-Access--Post-migration-Tasks.md)  
  
