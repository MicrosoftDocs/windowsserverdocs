---
title: Implementing Your Windows Firewall with Advanced Security Design Plan
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 60b68634-73bd-4310-84aa-e4ccf8194509
---
# Implementing Your Windows Firewall with Advanced Security Design Plan
The following are important factors in the implementation of your [!INCLUDE[wfas](includes/wfas_md.md)] design plan:

-   **Group Policy**. The [!INCLUDE[wfas](includes/wfas_md.md)] designs make extensive use of Group Policy deployed by Active Directory Domain Services \(AD DS\). A sound Group Policy infrastructure is required to successfully deploy the firewall and IPsec settings and rules to the computers on your network. [Group Policy Analysis and Troubleshooting Overview](http://technet.microsoft.com/library/jj134223.aspx) \(http:\/\/technet.microsoft.com\/library\/jj134223.aspx\) can help you review and change, if necessary, your Group Policy infrastructure.

-   **Perimeter firewall**. Most organizations use a perimeter firewall to help protect the computers on the network from potentially malicious network traffic from outside of the organization's network boundaries. If you plan a deployment that includes a boundary zone to enable external computers to connect to computers in that zone, then you must allow that traffic through the perimeter firewall to the computers in the boundary zone.

-   **Computers running operating systems other than Windows**. If your network includes computers that are not running the Windows operating system, then you must make sure that required communication with those computers is not blocked by the restrictions put in place by your design. You must do one of the following:

    -   Include those computers in the isolated domain or zone by adding certificate\-based authentication to your design. Many other operating systems can participate in an isolated domain or isolated server scenario, as long as certificate\-based authentication is used.

    -   Include the computer in the authentication exemption list included in your design. You can choose this option if for any reason the computer cannot participate in the isolated domain design.

## How to implement your Windows Firewall with Advanced Security design using this guide
The next step in implementing your design is to determine in what order each of the deployment steps must be performed. This guide uses checklists to help you accomplish the various deployment tasks that are required to implement your design plan. As the following diagram shows, checklists and subchecklists are used as necessary to provide the end\-to\-end procedure for deploying a design.

![](media/WFAS-Implement.gif)

Use the following parent checklists in this section of the guide to become familiar with the deployment tasks for implementing your organization's [!INCLUDE[wfas](includes/wfas_md.md)] design.

-   [Checklist: Implementing a Basic Firewall Policy Design](Checklist--Implementing-a-Basic-Firewall-Policy-Design.md)

-   [Checklist: Implementing a Domain Isolation Policy Design](Checklist--Implementing-a-Domain-Isolation-Policy-Design.md)

-   [Checklist: Implementing a Domain Isolation Policy Design](Checklist--Implementing-a-Domain-Isolation-Policy-Design.md)

-   [Checklist: Implementing a Certificate-based Isolation Policy Design](Checklist--Implementing-a-Certificate-based-Isolation-Policy-Design.md)

The procedures in these checklists use the Group Policy MMC snap\-in interfaces to configure firewall and connection security rules in GPOs, but you can also use Windows PowerShell. For more information, see [Windows Firewall with Advanced Security Administration with Windows PowerShell](Windows-Firewall-with-Advanced-Security-Administration-with-Windows-PowerShell.md). This guide recommends using GPOs in a specific way to deploy the rules and settings for your design. For information about deploying your GPOs, see [Planning Group Policy Deployment for Your Isolation Zones](Planning-Group-Policy-Deployment-for-Your-Isolation-Zones.md) and the checklist [Checklist: Creating Group Policy Objects](Checklist--Creating-Group-Policy-Objects.md).


