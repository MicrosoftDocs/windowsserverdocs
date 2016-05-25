---
title: Configure DHCP Failover using the DHCP Console
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e1346253-6bd5-4c95-8da7-c412b3476c65
---
# Configure DHCP Failover using the DHCP Console
Use the following procedures to configure DHCP failover using the DHCP console. When you have completed the procedures in this topic, return to the parent checklist: [Checklist: Deploy DHCP Failover](../Topic/Checklist--Deploy-DHCP-Failover.md).  
  
[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and later operating systems adds the item **Configure Failover** to the list of selections you can make when you right\-click the IPv4 node or right\-click an individual scope in the console tree, and the **Configure Failover** wizard is provided to guide you through the configuration process.  
  
If DHCP failover is already configured on a scope, choices of **Deconfigure Failover**, **Replicate Scope**, and **Replicate Relationship** are available. In addition, when you right\-click the IPv4 node or right\-click an individual scope in the console tree and then select **Properties**, the **Failover** is available, where you can view or edit DHCP failover settings. The **Failover** tab is not available for a scope if the scope is not configured for DHCP failover. For more information viewing and editing DHCP failover settings, see [DHCP Failover Relationships](../Topic/DHCP-Failover-Relationships.md).  
  
Use the following procedures to configure DHCP failover using the DHCP console. To configure DHCP failover using the command line instead, see [Configure DHCP Failover using the Command Line](../Topic/Configure-DHCP-Failover-using-the-Command-Line.md).  
  
**Additional considerations:**  
  
-   When you configure DHCP failover, you can accept default values for several parameters, or you can specify custom values. For more information about DHCP failover settings, see [DHCP Failover Settings](../Topic/DHCP-Failover-Settings.md).  
  
-   DHCP failover can be configured on a single DHCP scope, or you can configure multiple scopes simultaneously if they will all use the same failover relationship. The procedures below describe how to specify a new failover relationship for use with a single DHCP scope. To configure multiple scopes using the DHCP console, choose these scopes in the **Configure Failover** wizard under **Available scopes**. Scopes that are available must be present on the local DHCP server and not already enabled for DHCP failover.  
  
To configure DHCP failover, you must choose load balance or hot standby mode:  
  
-   [Configure DHCP failover in load balance mode using the DHCP console](../Topic/Configure-DHCP-Failover-using-the-DHCP-Console.md#windows_ui)  
  
-   [Configure DHCP failover in hot standby mode using the DHCP console](../Topic/Configure-DHCP-Failover-using-the-DHCP-Console.md#hot_standby)  
  
## <a name="windows_ui"></a>Configure DHCP failover in load balance mode using the DHCP console  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### <a name="load_balance_ui"></a>To configure DHCP failover in load balance mode using the DHCP console  
  
1.  On a DHCP server, open Server Manager, click **Tools** and then click **DHCP**.  
  
2.  In the DHCP console, right\-click **IPv4**, and then click **Configure Failover**.  
  
3.  A list of available DHCP scopes is displayed. You can choose multiple scopes if desired. In this example, a single DHCP scope will be configured using a new failover relationship.  
  
4.  To configure failover on a single scope, clear the **Select all** checkbox and then click the scope ID of the scope you wish to configure for failover under **Available scopes**. Do not clear this checkbox if you wish to configure failover on all scopes. Alternatively, you can clear the checkbox and then choose multiple, selected scopes.  
  
    ![](../Image/DHCP_pick_scopes.gif)  
  
5.  Click **Next**, and then on the **Specify the partner server to use for failover page**, next to **Partner Server** type the name or IP address of the failover partner DHCP server. You can also use the drop\-down list to choose from a list of authorized DHCP servers in the domain.  
  
6.  To reuse an existing DHCP failover relationship, click **Next**. Alternatively, to create a new DHCP failover relationship, clear the **Reuse existing failover relationships…** checkbox, and then click **Next**.  
  
    > [!IMPORTANT]  
    > A maximum of 31 DHCP failover relationships can be configured. Reuse existing failover relationships to avoid exceeding this limit. When you reuse existing failover relationships and more than one failover relationship exists between the local DHCP server and the failover partner that was chosen, you are prompted to select a relationship name from the list of available relationships. Choosing a relationship name will display parameters for that failover relationship. If only one relationship is configured, this relationship is automatically used.  
  
7.  On the **Create a new failover relationship page**, type a name for the failover relationship next to **Relationship Name** or accept the default name.  
  
8.  Confirm that **Load balance** is displayed by default next to **Mode**.  
  
9. By default, the **Enable Message Authentication** checkbox is enabled. Clear this checkbox if you do not wish to use a shared secret. Otherwise, type a shared secret next to **Shared Secret**. By default, load balancing is set to 50% for both the local server and the partner server. You can adjust these values if desired.  
  
    ![](../Image/DHCP_failover_relation.gif)  
  
10. Click **Next**, click **Finish**, verify that the status of all the tasks displayed is **Successful**, and then click **Close**.  
  
## <a name="hot_standby"></a>Configure DHCP failover in hot standby mode using the DHCP console  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### <a name="hot_standby2"></a>To configure DHCP failover in hot standby mode using the DHCP console  
  
1.  On a DHCP server, open Server Manager, click **Tools** and then click **DHCP**.  
  
2.  In the DHCP console, right\-click **IPv4**, and then click **Configure Failover**.  
  
3.  A list of available DHCP scopes is displayed. You can choose multiple scopes if desired. In this example, a single DHCP scope will be configured using a new failover relationship.  
  
4.  Clear the **Select all** checkbox and then click the scope ID of the scope you wish to configure for failover under **Available scopes**. Do not clear this checkbox if you wish to configure failover on all scopes. Alternatively, you can clear the checkbox and then choose multiple, selected scopes.  
  
5.  Click **Next**, and then on the **Specify the partner server to use for failover page**, next to **Partner Server** type the name or IP address of the failover partner DHCP server. You can also use the drop\-down list to choose from a list of authorized DHCP servers in the domain.  
  
6.  To reuse an existing DHCP failover relationship, click **Next**. Alternatively, to create a new DHCP failover relationship, clear the **Reuse existing failover relationships…** checkbox, and then click **Next**.  
  
    > [!IMPORTANT]  
    > A maximum of 31 DHCP failover relationships can be configured. Reuse existing failover relationships to avoid exceeding this limit. When you reuse existing failover relationships and more than one failover relationship exists between the local DHCP server and the failover partner that was chosen, you are prompted to select a relationship name from the list of available relationships. Choosing a relationship name will display parameters for that failover relationship. If only one relationship is configured, this relationship is automatically used.  
  
7.  On the **Create a new failover relationship page**, type a name for the failover relationship next to **Relationship Name** or accept the default name.  
  
8.  Choose **Hot standby** from the drop\-down list next to **Mode**.  
  
9. By default, the **Enable Message Authentication** checkbox is enabled. Clear this checkbox if you do not wish to use a shared secret. Otherwise, type a shared secret next to **Shared Secret**.  
  
    ![](../Image/DHCP_failover_relation2.jpg)  
  
10. Click **Next**, click **Finish**, verify that the status of all the tasks displayed is **Successful**, and then click **Close**.  
  
## See also  
[What is DHCP Failover?](../Topic/What-is-DHCP-Failover-.md)  
  
[Deploy DHCP Failover](../Topic/Deploy-DHCP-Failover.md)  
  
[Step-by-Step: Configure DHCP for Failover](../Topic/Step-by-Step--Configure-DHCP-for-Failover.md)  
  
