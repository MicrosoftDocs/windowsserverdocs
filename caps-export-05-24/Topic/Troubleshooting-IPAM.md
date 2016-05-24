---
title: Troubleshooting IPAM
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 25f715f8-6ce6-4917-96e8-708618ea65f9
---
# Troubleshooting IPAM
See the following sections in this topic.  
  
-   [Event logs](../Topic/Troubleshooting-IPAM.md#event_logs)  
  
-   [Common problems and solutions](../Topic/Troubleshooting-IPAM.md#common_prob)  
  
    -   [Connecting to the IPAM server](../Topic/Troubleshooting-IPAM.md#connect)  
  
    -   [Server access](../Topic/Troubleshooting-IPAM.md#access)  
  
    -   [Server discovery](../Topic/Troubleshooting-IPAM.md#discovery)  
  
    -   [IP address space management](../Topic/Troubleshooting-IPAM.md#ip_mgmt)  
  
    -   [Monitoring and management](../Topic/Troubleshooting-IPAM.md#msm)  
  
## <a name="event_logs"></a>Event logs  
IPAM event logs are available in Event Viewer using the following path: Application and Services Logs > Microsoft > Windows > IPAM. The following log channels are available:  
  
-   **Admin**: This channel captures events that are related to IPAM user actions and IPAM periodic tasks.  
  
-   **ConfigurationChange**: This channel captures events that are related to configuration changes made to the IPAM server.  
  
-   **Operational**: This channel captures informational events that are related to IPAM periodic tasks. Event logging on this channel is disabled by default.  
  
-   **Analytic and Debug**: These channels are hidden and disabled by default. Use these channels for debugging purposes. To show them, click **View** and then click **Show Analytic and Debug Logs**.  
  
Events in the Admin and Operational channels can also be viewed from the IPAM tile in the Server Manager Dashboard.  
  
## <a name="common_prob"></a>Common problems and solutions  
The following section lists common problems and solutions for IPAM.  
  
### <a name="connect"></a>Connecting to the IPAM server  
  
-   Problem: You are not able to connect to the IPAM server.  
  
-   Solution: View the **Description** field on Task Manager’s **Services** tab, and verify that the following services are running on the IPAM server:  
  
    -   Windows Process Activation Service  
  
    -   Windows Internal Database  
  
    If they are not running, start these services. Also verify that you are a signed in as a domain user and that you are a member of either the local Administrators security group on the IPAM server, or a member of the appropriate IPAM security group on the IPAM server.  
  
### <a name="access"></a>Server access  
  
-   Problem: The access status of a managed server does not change to Unblocked after completing IPAM provisioning.  
  
-   Solution: Review the details pane in Server Inventory view to identify the types of access status that are blocked. If you are using the manual IPAM provisioning method, verify that the access settings that correspond to this status are enabled. For Group Policy\-based provisioning, verify that the required GPOs have been created and linked, and that the managed server is a member of the security filter list of appropriate GPOs. This issue can also occur if Group Policy has not been updated on the target servers. Open an elevated command prompt on the managed server and type **gpupdate \/force** to force the application of Group Policy.  
  
-   Problem: You are unable to add a managed server to an IPAM GPO.  
  
-   Solution: Verify that you are signed in as a member of the Domain Admins security group, or higher, or that you have been delegated privileges to edit the GPO. GPO delegation for users or groups can be enabled from the IPAM **Invoke\-IpamGpoProvisioning** cmdlet at the time the GPO is created, or from the Group Policy Management Console if the GPO is already created.  
  
### <a name="discovery"></a>Server discovery  
  
-   Problem: You are unable to configure server discovery.  
  
-   Solution: Verify that you are signed in as a domain user and not as a local user on the IPAM server.  
  
-   Problem: A DNS server is not discovered.  
  
-   Solution: Verify that the DNS server configured on the IPAM server’s network interface can query name server \(NS\) records for the domain zone, and that an NS record exists for the DNS server. All NS records for the domain zone and NS records for allowed DNS suffixes are queried during the DNS server discovery operation.  
  
-   Problem: A DHCP server is not discovered.  
  
-   Solution: Verify that the DHCP server role is not installed on the IPAM server. Verify that at least one IPv4 scope is configured on a DHCP server, and that the IPAM server has a TCP\/IP connection to the DHCP server. Also verify that DHCP INFORM request messages sent by IPAM server are not filtered on the network.  
  
-   Problem: You are unable to manually add a server to IPAM.  
  
-   Solution: Verify DNS resolution of the IP address of the server. Also verify that the server name is present in the Active Directory Global Catalog.  
  
### <a name="ip_mgmt"></a>IP address space management  
  
-   Problem: You are unable to find an available IP address from a Microsoft DHCP\-managed IP address range.  
  
-   Solution: Verify that DHCP RPC firewall ports are enabled on the target DHCP server, and that your user account is a member of the DHCP Users group on the DHCP server.  
  
-   Problem: You are unable to import a comma\-separated value file with IP address records into IPAM.  
  
-   Solution: Verify that all the header field names in the file match the existing built\-in and custom field names in IPAM. Create new custom field names in IPAM if required.  
  
-   Problem: Importing records from a comma\-separated value file is successful, but some of the records are not displayed in IPAM.  
  
-   Solution: Review the error log for the import operation. By default, this log is created in the Documents folder, and it contains details of any records that failed to import. Use the error information provided to fix each failed record instance, and then repeat the import operation.  
  
-   Problem: You are unable to select DHCP servers or DNS zones in the IP address add or edit dialog box.  
  
-   Solution: Verify that the DHCP and DNS servers that are hosting the scope or zone are managed by IPAM. Also verify that you have administrative privileges on the target DHCP or DNS server.  
  
### <a name="msm"></a>Monitoring and management  
  
-   Problem: A managed server availability state is not reachable.  
  
-   Solution: Verify TCP\/IP connectivity between the IPAM server and the target server. Verify that the DNS Server service or DHCP Server service is running on the target server, and that the IPAM server has been successfully provisioned with Read access on the service ACLs. Also verify that remote service management ports are open on the target server.  
  
-   Problem: You are unable to make configuration changes on a DHCP server or scope.  
  
-   Solution: Verify that DHCP RPC firewall ports are enabled on the target DHCP server, and that you are signed in with an account that has DHCP Administrators privileges on the target DHCP server.  
  
## See also  
[Best Practices](../Topic/Best-Practices.md)  
  
