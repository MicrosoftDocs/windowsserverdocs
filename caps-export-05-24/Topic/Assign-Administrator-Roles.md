---
title: Assign Administrator Roles
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c3676f7f-c417-4a49-9ddd-deb48fec8841
---
# Assign Administrator Roles
[Checklist: Assign Roles](../Topic/Checklist--Assign-Roles.md) > [Configure IPAM Server Roles](../Topic/Configure-IPAM-Server-Roles.md) > **Assign Administrator Roles**  
  
> [!IMPORTANT]  
> IPAM in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] includes a role based access control feature that enables detailed control of the procedures that IPAM users are able to perform. Role based access control adds permissions to the user’s existing access permissions. You cannot deny permission for a user with an access policy. If a user already has permission granted to perform a procedure because they are a member of one or more IPAM administrator groups, they will continue to have that permission even if they have only limited rights granted by role based access polices.  
>   
> If you have deployed IPAM on [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], it is recommended to use the new access control feature available in this version of IPAM. Do not assign IPAM administrator roles using the procedures in this topic unless you do not need to enable fine\-grained access control for IPAM tasks. For more information, see [Access Control](../Topic/Access-Control.md).  
  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
## Assigning IPAM administrator roles  
Use the following procedures to assign IPAM administrator roles using built\-in local security groups on the IPAM server:  
  
### <a name="scope_of_discovery"></a>To assign IPAM administrator roles  
  
1.  On the IPAM server, click **Tools** on the Server Manager menu and then click **Computer Management**.  
  
2.  In the Computer Management console tree, open **Local Users and Groups** and then click **Groups**. The following local IPAM security groups are displayed:  
  
    -   **IPAM Administrators**: IPAM administrators can view all IPAM data and manage all IPAM features.  
  
    -   **IPAM ASM Administrators**: IPAM address space management \(ASM\) administrators can manage IP address blocks, ranges, and addresses.  
  
    -   **IPAM IP Audit Administrators**: IPAM IP audit administrators can view IP address tracking data.  
  
    -   **IPAM MSM Administrators**: IPAM multi\-server management \(MSM\) administrators can manage DNS and DHCP servers.  
  
    -   **IPAM Users**: IPAM users can view information in IPAM, but cannot manage IPAM features or view IP address tracking data.  
  
3.  To add a user or group to the group, double\-click the group, click **Add**, type the username under **Enter the object names to select**, and then click **OK**.  
  
4.  Verify that the user you added is displayed under **Members**.  
  
    ![](../Image/IPAM_admin.gif)  
  
5.  To remove a user or group from the group, click the user under **Members** and then click **Remove**.  
  
6.  To add or remove another user or group, repeat this procedure.  
  
7.  Click **OK** when you are finished, and then close the Computer Management console.  
  
The following table summarizes IPAM actions and functions that are permitted or denied with membership in the specified security group. Access rights are additive if a user or group is a member of multiple security groups.  
  
|Security Group|Server Inventory|IP Address Space|Monitor and Manage|Event Catalog|IP Address Tracking|Common Management Tasks|  
|------------------|--------------------|--------------------|----------------------|-----------------|-----------------------|---------------------------|  
|IPAM Administrators|Manage|Manage|Manage|View|View|Manage|  
|IPAM ASM Administrators|Manage\*|Manage|View|View|Denied|Manage|  
|IPAM IP Audit Administrators|Manage\*|View|View|View|View|Manage|  
|IPAM MSM Administrators|Manage\*|View|Manage|View|Denied|Manage|  
|IPAM Users|View|View|View|View|Denied|View|  
  
\*If the Group Policy\-based automatic provisioning method is used, GPO access permission must be delegated to add or remove servers from GPO security filtering.  
  
Common management tasks include:  
  
-   Connect to an IPAM server  
  
-   IPAM settings:  
  
    -   Configure server discovery  
  
    -   Configure custom fields  
  
    -   Configure utilization threshold  
  
-   Starts server discovery  
  
-   Retrieve all server data  
  
Members of the local **Administrators** group on the IPAM server also have permission to modify the server inventory and perform common management tasks.  
  
If a user does not have sufficient privileges to perform an action, they will receive an alert that is unique to the action they are attempting to perform.  
  
![](../Image/IPAM_priv.gif)  
  
## See Also  
[IPAM Server](../Topic/IPAM-Architecture.md#server)  
  
