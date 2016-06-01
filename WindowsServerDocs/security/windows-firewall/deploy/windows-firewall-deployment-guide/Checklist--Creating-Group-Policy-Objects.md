---
title: Checklist: Creating Group Policy Objects
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 67bb8774-3a0f-4b73-b049-ca0b718b7e96
---
# Checklist: Creating Group Policy Objects
To deploy firewall or IPsec settings or firewall or connection security rules, we recommend that you use Group Policy in AD DS. This section describes a tested, efficient method that requires some up\-front work, but serves an administrator well in the long run by making GPO assignments as easy as dropping a computer into a membership group.

The checklists for firewall, domain isolation, and server isolation include a link to this checklist.

## About membership groups
For most GPO deployment tasks, you must determine which computers must receive and apply which GPOs. Because different versions of Windows can support different settings and rules to achieve similar behavior, you might need multiple GPOs: one for each operating system that has settings different from the others to achieve the same result. For example, [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)], [!INCLUDE[nextref_client_7](includes/nextref_client_7_md.md)], [!INCLUDE[nextref_vista](includes/nextref_vista_md.md)], [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)], [!INCLUDE[nextref_longhorn](includes/nextref_longhorn_md.md)], and [!INCLUDE[nextref_server_7](includes/nextref_server_7_md.md)] use rules and settings that are incompatible with Windows 2000, Windows XP, and Windows Server 2003. Therefore, if your network included those older operating systems you would need to create a GPO for each set of operating systems that can share common settings. To deploy typical domain isolation settings and rules, you might have five different GPOs for the versions of Windows discussed in this guide. By following the procedures in this guide, you only need one membership group to manage all five GPOs. The membership group is identified in the security group filter for all five GPOs. To apply the settings to a computer, you make that computer's account a member of the membership group. WMI filters are used to ensure that the correct GPO is applied.

## About exclusion groups
A [!INCLUDE[wfas](includes/wfas_md.md)] design must often take into account domain\-joined computers on the network that cannot or must not apply the rules and settings in the GPOs. Because these computers are typically fewer in number than the computers that must apply the GPO, it is easier to use the Domain Members group in the GPO membership group, and then place these exception computers into an exclusion group that is denied Apply Group Policy permissions on the GPO. Because deny permissions take precedence over allow permissions, a computer that is a member of both the membership group and the exception group is prevented from applying the GPO. Computers typically found in a GPO exclusion group for domain isolation include the domain controllers, DHCP servers, and DNS servers.

You can also use a membership group for one zone as an exclusion group for another zone. For example, computers in the boundary and encryption zones are technically in the main domain isolation zone, but must apply only the GPO for their assigned role. To do this, the GPOs for the main isolation zone deny Apply Group Policy permissions to members of the boundary and encryption zones.

![](media/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif)**Checklist: Creating Group Policy objects**

||Task|Reference|
|-|--------|-------------|
|![](media/WFAS_icon_checkbox.gif)|Review important concepts and examples for deploying GPOs in a way that best meets the needs of your organization.|![](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Identifying Your Windows Firewall with Advanced Security Deployment Goals](Identifying-Your-Windows-Firewall-with-Advanced-Security-Deployment-Goals.md)<br /><br />![](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Planning Group Policy Deployment for Your Isolation Zones](Planning-Group-Policy-Deployment-for-Your-Isolation-Zones.md)|
|![](media/WFAS_icon_checkbox.gif)|Create the membership group in AD DS that will be used to contain computer accounts that must receive the GPO.<br /><br />If some computers in the membership group are running an operating system that does not support WMI filters, such as Windows 2000, create an exclusion group to contain the computer accounts for the computers that cannot be blocked by using a WMI filter.|![](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Create a Group Account in Active Directory](Create-a-Group-Account-in-Active-Directory.md)|
|![](media/WFAS_icon_checkbox.gif)|Create a GPO for each version of Windows that has different implementation requirements.|![](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Create a Group Policy Object](Create-a-Group-Policy-Object.md)|
|![](media/WFAS_icon_checkbox.gif)|Create security group filters to limit the GPO to only computers that are members of the membership group and to exclude computers that are members of the exclusion group.|![](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Assign Security Group Filters to the GPO](Assign-Security-Group-Filters-to-the-GPO.md)|
|![](media/WFAS_icon_checkbox.gif)|Create WMI filters to limit each GPO to only the computers that match the criteria in the filter.|![](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Create WMI Filters for the GPO](Create-WMI-Filters-for-the-GPO.md)|
|![](media/WFAS_icon_checkbox.gif)|If you are working on a GPO that was copied from another, modify the group memberships and WMI filters so that they are correct for the new zone or version of Windows for which this GPO is intended.|![](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Modify GPO Filters to Apply to a Different Zone or Version of Windows](Modify-GPO-Filters-to-Apply-to-a-Different-Zone-or-Version-of-Windows.md)|
|![](media/WFAS_icon_checkbox.gif)|Link the GPO to the domain level of the Active Directory organizational unit hierarchy.|![](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Link the GPO to the Domain](Link-the-GPO-to-the-Domain.md)|
|![](media/WFAS_icon_checkbox.gif)|Before adding any rules or configuring the GPO, add a few test computers to the membership group, and make sure that the correct GPO is received and applied to each member of the group.|![](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Add Test Computers to the Membership Group for a Zone](Add-Test-Computers-to-the-Membership-Group-for-a-Zone.md)|


