---
title: Checklist: Creating Rules for Clients of a Standalone Isolated Server Zone
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 571a4809-f758-4caf-8bc9-28c208b3b5d5
---
# Checklist: Creating Rules for Clients of a Standalone Isolated Server Zone
This checklist includes tasks for configuring connection security rules and IPsec settings in the GPOs for client computers that must connect to servers in an isolated server zone.

## <a name="bkmk_section1"></a>![](media/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif)**Checklist: Configuring isolated server zone client rules for computers running Windows 8, Windows 7, Windows Vista, Windows Server 2012, Windows Server 2008, or Windows Server 2008 R2**

> [!NOTE]
> The GPOs for computers running [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)], [!INCLUDE[nextref_client_7](includes/nextref_client_7_md.md)], [!INCLUDE[nextref_vista](includes/nextref_vista_md.md)], [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)], [!INCLUDE[nextref_longhorn](includes/nextref_longhorn_md.md)], and [!INCLUDE[nextref_server_7](includes/nextref_server_7_md.md)] are usually similar. If this is true for your design, create one GPO, configure it by using the tasks in this checklist, and then create a copy of the GPO. For example, create and configure the GPO for [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)], create a copy of it for [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)], and then follow the steps in this checklist to make the required changes \(if any\) to the copy.

||Task|Reference|
|-|--------|-------------|
|![](media/WFAS_icon_checkbox.gif)|Create a GPO for the client computers that must connect to servers in the isolated server zone, and that are running one of the versions of Windows. After you have finished the tasks in this checklist, you can make a copy of it.|![](media/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)[Checklist: Creating Group Policy Objects](Checklist--Creating-Group-Policy-Objects.md)<br /><br />![](media/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)[Copy a GPO to Create a New GPO](Copy-a-GPO-to-Create-a-New-GPO.md)|
|![](media/WFAS_icon_checkbox.gif)|To determine which computers receive the GPO, assign the NAG for the isolated servers to the security group filter for the GPO. Make sure that each GPO has the WMI filter for the correct version of Windows.|![](media/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)[Modify GPO Filters to Apply to a Different Zone or Version of Windows](Modify-GPO-Filters-to-Apply-to-a-Different-Zone-or-Version-of-Windows.md)|
|![](media/WFAS_icon_checkbox.gif)|Configure IPsec to exempt all ICMP network traffic from IPsec protection.|![](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Exempt ICMP from Authentication on Windows 8, Windows 7, Windows Vista, Windows Server 2012, Windows Server 2008, and Windows Server 2008 R2](Exempt-ICMP-from-Authentication-on-Windows-8,-Windows-7,-Windows-Vista,-Windows-Server-2012,-Windows-Server-2008,-and-Windows-Server-2008-R2.md)|
|![](media/WFAS_icon_checkbox.gif)|Create a rule that exempts all network traffic to and from computers on the exemption list from IPsec.|![](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Create an Authentication Exemption List Rule on Windows 8, Windows 7, Windows Vista, Windows Server 2012, Windows Server 2008, and Windows Server 2008 R2](Create-an-Authentication-Exemption-List-Rule-on-Windows-8,-Windows-7,-Windows-Vista,-Windows-Server-2012,-Windows-Server-2008,-and-Windows-Server-2008-R2.md)|
|![](media/WFAS_icon_checkbox.gif)|Configure the key exchange \(main mode\) security methods and algorithms to be used.|![](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Configure Key Exchange &#40;Main Mode&#41; Settings on Windows 8, Windows 7, Windows Vista, Windows Server 2012, Windows Server 2008, and Windows Server 2008 R2](Configure-Key-Exchange--Main-Mode--Settings-on-Windows-8,-Windows-7,-Windows-Vista,-Windows-Server-2012,-Windows-Server-2008,-and-Windows-Server-2008-R2.md)|
|![](media/WFAS_icon_checkbox.gif)|Configure the data protection \(quick mode\) algorithm combinations to be used.|![](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Configure Data Protection &#40;Quick Mode&#41; Settings on Windows 8, Windows 7, Windows Vista, Windows Server 2012, Windows Server 2008, and Windows Server 2008 R2](Configure-Data-Protection--Quick-Mode--Settings-on-Windows-8,-Windows-7,-Windows-Vista,-Windows-Server-2012,-Windows-Server-2008,-and-Windows-Server-2008-R2.md)|
|![](media/WFAS_icon_checkbox.gif)|Configure the authentication methods to be used.|![](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Configure Authentication Methods on Windows 8, Windows 7, Windows Vista, Windows Server 2012, Windows Server 2008, and Windows Server 2008 R2](Configure-Authentication-Methods-on-Windows-8,-Windows-7,-Windows-Vista,-Windows-Server-2012,-Windows-Server-2008,-and-Windows-Server-2008-R2.md)|
|![](media/WFAS_icon_checkbox.gif)|Create a rule that requests authentication for network traffic. Because fallback\-to\-clear behavior in [!INCLUDE[nextref_vista](includes/nextref_vista_md.md)] and [!INCLUDE[nextref_longhorn](includes/nextref_longhorn_md.md)] has no delay when communicating with computers that cannot use IPsec, you can use the same any\-to\-any rule used in an isolated domain.|![](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Create an Authentication Request Rule on Windows 8, Windows 7, Windows Vista, Windows Server 2012, Windows Server 2008, and Windows Server 2008 R2](Create-an-Authentication-Request-Rule-on-Windows-8,-Windows-7,-Windows-Vista,-Windows-Server-2012,-Windows-Server-2008,-and-Windows-Server-2008-R2.md)|
|![](media/WFAS_icon_checkbox.gif)|Link the GPO to the domain level of the Active Directory organizational unit hierarchy.|![](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Link the GPO to the Domain](Link-the-GPO-to-the-Domain.md)|
|![](media/WFAS_icon_checkbox.gif)|Add your test computers to the NAG for the isolated server zone. Be sure to add at least one for each operating system supported by a different GPO in the group.|![](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Add Test Computers to the Membership Group for a Zone](Add-Test-Computers-to-the-Membership-Group-for-a-Zone.md)|


