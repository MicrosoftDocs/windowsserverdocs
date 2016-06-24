---
title: Checklist: Implementing a Certificate-based Isolation Policy Design
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 220da245-8c70-47b4-8184-5b24f2a72786
---
# Checklist: Implementing a Certificate-based Isolation Policy Design
This parent checklist includes cross-reference links to important concepts about using certificates as an authentication option in either a domain isolation or server isolation design.

> [!NOTE]
> Complete the tasks in this checklist in order. When a reference link takes you to a procedure, return to this topic after you complete the steps in that procedure so that you can proceed with the remaining tasks in this checklist
> 
> The procedures in this section use the Group Policy MMC snap-in interfaces to configure the GPOs, but you can also use Windows PowerShell. For more information, see [Windows Firewall with Advanced Security Administration with Windows PowerShell](http://technet.microsoft.com/library/hh831755.aspx) at http://technet.microsoft.com/library/hh831755.aspx.

![](../../../media/Checklist--Implementing-a-Certificate-based-Isolation-Policy-Design/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif) **Checklist: Implementing certificate-based authentication**

||Task|Reference|
|-|--------|-------------|
|![](../../../media/Checklist--Implementing-a-Certificate-based-Isolation-Policy-Design/WFAS_icon_checkbox.gif)|Review important concepts and examples for certificate-based authentication to determine if this design meets your  deployment goals and the needs of your organization.|![](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Identifying Your Windows Firewall with Advanced Security Deployment Goals](../../plan/windows-firewall-design-guide/Identifying-Your-Windows-Firewall-with-Advanced-Security-Deployment-Goals.md)<br /><br />![](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Certificate-based Isolation Policy Design](Certificate-based-Isolation-Policy-Design.md)<br /><br />![](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Certificate-based Isolation Policy Design Example](Certificate-based-Isolation-Policy-Design-Example.md)<br /><br />![](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Planning Certificate-based Authentication](Planning-Certificate-based-Authentication.md)|
|![](../../../media/Checklist--Implementing-a-Certificate-based-Isolation-Policy-Design/WFAS_icon_checkbox.gif)|Install the Active Directory Certificate Services (AD CS) role as an enterprise root issuing certification authority (CA). This step is required only if you have not already deployed a CA on your network.|![](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Install Active Directory Certificate Services](Install-Active-Directory-Certificate-Services.md)|
|![](../../../media/Checklist--Implementing-a-Certificate-based-Isolation-Policy-Design/WFAS_icon_checkbox.gif)|Configure the certificate template for workstation authentication certificates.|![](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Configure the Workstation Authentication Certificate Template](Configure-the-Workstation-Authentication-Certificate-Template.md)|
|![](../../../media/Checklist--Implementing-a-Certificate-based-Isolation-Policy-Design/WFAS_icon_checkbox.gif)|Configure Group Policy to automatically deploy certificates based on your template to workstation computers.|![](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Configure Group Policy to Autoenroll and Deploy Certificates](Configure-Group-Policy-to-Autoenroll-and-Deploy-Certificates.md)|
|![](../../../media/Checklist--Implementing-a-Certificate-based-Isolation-Policy-Design/WFAS_icon_checkbox.gif)|On a test computer, refresh Group Policy and confirm that the certificate is installed.|![](media/15dd35b6-6cc6-421f-93f8-7109920e7144.gif)[Confirm That Certificates Are Deployed Correctly](Confirm-That-Certificates-Are-Deployed-Correctly.md)|


