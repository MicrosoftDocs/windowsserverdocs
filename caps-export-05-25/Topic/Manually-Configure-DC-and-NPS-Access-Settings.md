---
title: Manually Configure DC and NPS Access Settings
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 434c8f6c-6b00-43d5-a61f-df6f55425071
---
# Manually Configure DC and NPS Access Settings
[Checklist: Deploy IPAM Server](../Topic/Checklist--Deploy-IPAM-Server.md) > [Install IPAM Server](../Topic/Install-IPAM-Server.md) > [Choose an IPAM Provisioning Method](../Topic/Choose-an-IPAM-Provisioning-Method.md) > [Configure Server Discovery](../Topic/Configure-Server-Discovery.md) > [Discover Servers on the Network](../Topic/Discover-Servers-on-the-Network.md) | [Manually Add a Server to Server Inventory](../Topic/Manually-Add-a-Server-to-Server-Inventory.md) > [Create IPAM Provisioning GPOs](../Topic/Create-IPAM-Provisioning-GPOs.md) | **Manually Configure DC and NPS Access Settings**  
  
If you have chosen the manual provisioning method, you must configure access permissions and settings individually on managed servers. Two general methods for configuring these settings are available:  
  
-   **Manual application of IPAM GPOs**: With this method, IPAM GPOs are created but are not automatically applied to managed servers. Application of GPOs is done manually by adding managed servers to GPO security filtering. To use this method, first perform the steps in [Create IPAM Provisioning GPOs](../Topic/Create-IPAM-Provisioning-GPOs.md). When you have created these GPOS, configure security filtering by performing the steps in [Configuring IPAM GPO security filtering](../Topic/Create-IPAM-Provisioning-GPOs.md#security_filtering).  
  
-   **Manual configuration of individual settings**: GPOs are not used with this method. Instead, access settings on each managed server are configured manually by an administrator. Steps to configure these access settings are provided in this topic.  
  
For more information about choosing an IPAM provisioning method, see [Choosing a provisioning method](../Topic/Getting-Started-with-IPAM.md#choose_method).  
  
Membership in the **Domain Admins** group, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
## Manually configure managed DC and NPS server access settings  
Use the following procedures to configure IPAM access settings on a managed domain controller or NPS server. If the server is also a managed DNS or DHCP server, and you have previously enabled IPAM access for these services, you have already enabled the necessary access. If you have not already enabled IPAM access using Windows Firewall and the Event Log Readers security group, perform the following procedures:  
  
-   [Configure Windows Firewall on a managed DC or NPS server](../Topic/Manually-Configure-DC-and-NPS-Access-Settings.md#WFAS)  
  
-   [Configure security groups on a managed DC or NPS server](../Topic/Manually-Configure-DC-and-NPS-Access-Settings.md#security_groups)  
  
A summary of required settings is provided in the table below.  
  
|Setting Type|Setting Name|Function|  
|----------------|----------------|------------|  
|Inbound firewall rule|Remote Event Log Management|Audit authentication events|  
|Security group|Event log monitoring|Audit authentication events|  
  
## <a name="WFAS"></a>Configure Windows Firewall on a managed DC or NPS server  
Use the following procedure to enable access by the IPAM server to inbound firewall ports on a managed domain controller or NPS server. If the managed server becomes unmanaged, delete these inbound firewall rules. All of the following procedures are performed on the managed server.  
  
#### To configure Windows Firewall on a managed DC or NPS server  
  
1.  On the Server Manager menu, click **Tools** and then click **Windows Firewall with Advanced Security**.  
  
2.  Right\-click **Inbound Rules**, and then click **New Rule**. The **New Inbound Rule Wizard** will launch.  
  
3.  In **Rule Type**, select **Predefined**, choose **Remote Event Log Management** from the list, and then click **Next**.  
  
4.  In **Predefined Rules**, under **Rules**, select the checkboxes next to the following rules:  
  
    -   **Remote Event Log Management \(RPC\-EPMAP\)**  
  
    -   **Remote Event Log Management \(RPC\)**  
  
5.  Click **Next**, choose **Allow the connection**, and then click **Finish**.  
  
6.  Close the Windows Firewall with Advanced Security console.  
  
## <a name="security_groups"></a>Configure security groups on a managed DC or NPS server  
To access configuration data and server event logs, the IPAM server must be a member of the domain IPAM Users Group \(IPAMUG\). The IPAM server must also be a member of the Event Log Readers security group.  
  
> [!WARNING]  
> If you have already created the IPAMUG security group in Active Directory and added the IPAM server as a member of the group, it is not necessary to perform this procedure again.  
>   
> The steps to add the IPAM server to the Event Log Readers security group is different on a managed domain controller than a managed NPS server. Both procedures are provided below. If the server is both a domain controller and NPS server, perform the procedures for a managed domain controller.  
  
After performing these procedures, refresh the server access status for the managed domain controller or NPS server in the server inventory view on the IPAM server.  
  
#### To configure the IPAMUG security group  
  
1.  On a domain controller, click **Tools** on the Server Manager menu, and then click **Active Directory Users and Computers**.  
  
2.  In the Active Directory Users and Computers console tree, right\-click the **Users** container under the managed DHCP server’s domain, point to **New**, and then click **Group**.  
  
3.  In the **New Object – Group** dialog box, under **Group name**, type **IPAMUG**.  
  
4.  Under **Group scope**, select **Universal** and under **Group type** select **Security**, and then click **OK**.  
  
    ![](../Image/IPAM_ipamug.gif)  
  
5.  Double\-click the IPAMUG group and then click the **Members** tab.  
  
6.  Click **Object Types**, select the **Computers** checkbox, and then click **OK**.  
  
7.  Under **Enter the object names to select**, type the name of the IPAM server and then click **OK**.  
  
8.  Verify that the correct IPAM server is displayed under **Name** and then click **OK**.  
  
#### To configure the Event Log Readers security group on a domain controller  
  
1.  On the managed domain controller, click **Tools** on the Server Manager menu and then click **Active Directory Users and Computers**.  
  
2.  In the navigation tree, click the **<domain>\\Builtin** container and then double\-click **Event Log Readers**.  
  
3.  On the **Members** tab, click **Add**.  
  
4.  Under **Enter the object names to select**, type **IPAMUG**, and then click **OK** twice.  
  
#### To configure the Event Log Readers security group on an NPS server  
  
1.  On the managed NPS server, click **Tools** on the Server Manager menu and then click **Computer Management**.  
  
2.  In the Computer Management navigation tree, click **Local Users and Groups** and then click **Groups**.  
  
3.  In the list of groups, double\-click **Event Log Readers** and then click **Add**.  
  
4.  Under **Enter the object names to select**, type **IPAMUG** and then click **OK**.  
  
5.  Verify that **<domain>\\IPAMUG** is displayed under **Members** and then click **OK**.  
  
## See Also  
[Manually Configure DHCP Access Settings](../Topic/Manually-Configure-DHCP-Access-Settings.md)  
[Manually Configure DNS Access Settings](../Topic/Manually-Configure-DNS-Access-Settings.md)  
  
