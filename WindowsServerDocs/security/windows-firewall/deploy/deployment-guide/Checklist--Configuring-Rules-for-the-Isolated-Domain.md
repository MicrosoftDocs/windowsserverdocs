---
title: Checklist: Configuring Rules for the Isolated Domain
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3679b6f0-61ec-4e35-aef1-adcff9ecd963
---
# Checklist: Configuring Rules for the Isolated Domain
The following checklists include tasks for configuring connection security rules and IPsec settings in your GPOs to implement the main zone in the isolated domain.

## <a name="bkmk_section1"></a>![](../../../media/Checklist--Configuring-Rules-for-the-Isolated-Domain/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif)**Checklist: Configuring isolated domain rules for computers running Windows 8, Windows 7, Windows Vista, Windows Server 2012, Windows Server 2008, or Windows Server 2008 R2**

> [!NOTE]
> The GPOs for computers running Windows 8,  Windows 7 , Windows Vista,  Windows Server 2012 ,  Windows Server 2008 , and  Windows Server 2008 R2  are usually similar. If this is true for your design, create one GPO, configure it by using the tasks in this checklist, and then make a copy of the GPO for the other operating system. For example, create and configure the GPO for Windows 8, make a copy of it for  Windows Server 2012 , and then follow the steps in this checklist to make the few required changes to the copy.

||Task|Reference|
|-|--------|-------------|
|![](../../../media/Checklist--Configuring-Rules-for-the-Isolated-Domain/WFAS_icon_checkbox.gif)|Create a GPO for the computers in the isolated domain running one of the operating systems. After you have finished the tasks in this checklist and configured the GPO for that version of Windows, you can create a copy of it.|![](media/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)[Checklist: Creating Group Policy Objects](Checklist--Creating-Group-Policy-Objects.md)<br /><br />![](media/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)[Copy a GPO to Create a New GPO](Copy-a-GPO-to-Create-a-New-GPO.md)|
|![](../../../media/Checklist--Configuring-Rules-for-the-Isolated-Domain/WFAS_icon_checkbox.gif)|If you are working on a GPO that was copied from another GPO, modify the group memberships and WMI filters so that they are correct for the isolated domain zone and the version of Windows for which this GPO is intended.|![](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Modify GPO Filters to Apply to a Different Zone or Version of Windows](Modify-GPO-Filters-to-Apply-to-a-Different-Zone-or-Version-of-Windows.md)|
|![](../../../media/Checklist--Configuring-Rules-for-the-Isolated-Domain/WFAS_icon_checkbox.gif)|Configure IPsec to exempt all ICMP network traffic from IPsec protection.|![](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Exempt ICMP from Authentication on Windows 8, Windows 7, Windows Vista, Windows Server 2012, Windows Server 2008, and Windows Server 2008 R2](Exempt-ICMP-from-Authentication-on-Windows-8,-Windows-7,-Windows-Vista,-Windows-Server-2012,-Windows-Server-2008,-and-Windows-Server-2008-R2.md)|
|![](../../../media/Checklist--Configuring-Rules-for-the-Isolated-Domain/WFAS_icon_checkbox.gif)|Create a rule that exempts all network traffic to and from computers on the exemption list from IPsec.|![](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Create an Authentication Exemption List Rule on Windows 8, Windows 7, Windows Vista, Windows Server 2012, Windows Server 2008, and Windows Server 2008 R2](Create-an-Authentication-Exemption-List-Rule-on-Windows-8,-Windows-7,-Windows-Vista,-Windows-Server-2012,-Windows-Server-2008,-and-Windows-Server-2008-R2.md)|
|![](../../../media/Checklist--Configuring-Rules-for-the-Isolated-Domain/WFAS_icon_checkbox.gif)|Configure the key exchange \(main mode\) security methods and algorithms to be used.|![](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Configure Key Exchange &#40;Main Mode&#41; Settings on Windows 8, Windows 7, Windows Vista, Windows Server 2012, Windows Server 2008, and Windows Server 2008 R2](Configure-Key-Exchange--Main-Mode--Settings-on-Windows-8,-Windows-7,-Windows-Vista,-Windows-Server-2012,-Windows-Server-2008,-and-Windows-Server-2008-R2.md)|
|![](../../../media/Checklist--Configuring-Rules-for-the-Isolated-Domain/WFAS_icon_checkbox.gif)|Configure the data protection \(quick mode\) algorithm combinations to be used.|![](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Configure Data Protection &#40;Quick Mode&#41; Settings on Windows 8, Windows 7, Windows Vista, Windows Server 2012, Windows Server 2008, and Windows Server 2008 R2](Configure-Data-Protection--Quick-Mode--Settings-on-Windows-8,-Windows-7,-Windows-Vista,-Windows-Server-2012,-Windows-Server-2008,-and-Windows-Server-2008-R2.md)|
|![](../../../media/Checklist--Configuring-Rules-for-the-Isolated-Domain/WFAS_icon_checkbox.gif)|Configure the authentication methods to be used.|![](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Configure Authentication Methods on Windows 8, Windows 7, Windows Vista, Windows Server 2012, Windows Server 2008, and Windows Server 2008 R2](Configure-Authentication-Methods-on-Windows-8,-Windows-7,-Windows-Vista,-Windows-Server-2012,-Windows-Server-2008,-and-Windows-Server-2008-R2.md)|
|![](../../../media/Checklist--Configuring-Rules-for-the-Isolated-Domain/WFAS_icon_checkbox.gif)|Create the rule that requests authentication for all inbound network traffic.|![](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Create an Authentication Request Rule on Windows 8, Windows 7, Windows Vista, Windows Server 2012, Windows Server 2008, and Windows Server 2008 R2](Create-an-Authentication-Request-Rule-on-Windows-8,-Windows-7,-Windows-Vista,-Windows-Server-2012,-Windows-Server-2008,-and-Windows-Server-2008-R2.md)|
|![](../../../media/Checklist--Configuring-Rules-for-the-Isolated-Domain/WFAS_icon_checkbox.gif)|Link the GPO to the domain level of the AD DS organizational unit hierarchy.|![](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Link the GPO to the Domain](Link-the-GPO-to-the-Domain.md)|
|![](../../../media/Checklist--Configuring-Rules-for-the-Isolated-Domain/WFAS_icon_checkbox.gif)|Add your test computers to the membership group for the isolated domain. Be sure to add at least one for each operating system supported by a different GPO in the group.|![](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Add Test Computers to the Membership Group for a Zone](Add-Test-Computers-to-the-Membership-Group-for-a-Zone.md)|
|![](../../../media/Checklist--Configuring-Rules-for-the-Isolated-Domain/WFAS_icon_checkbox.gif)|Verify that the connection security rules are protecting network traffic to and from the test computers.|![](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Verify That Network Traffic Is Authenticated](Verify-That-Network-Traffic-Is-Authenticated.md)|

Do not change the rules for any of your zones to require authentication until all of the zones have been set up and are operating correctly.


