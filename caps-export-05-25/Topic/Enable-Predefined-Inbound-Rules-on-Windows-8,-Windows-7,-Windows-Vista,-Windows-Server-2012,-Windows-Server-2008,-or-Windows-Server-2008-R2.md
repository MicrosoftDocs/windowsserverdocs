---
title: Enable Predefined Inbound Rules on Windows 8, Windows 7, Windows Vista, Windows Server 2012, Windows Server 2008, or Windows Server 2008 R2
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ccb27279-b4aa-47ca-840b-6c3c4e0980ee
author: vhorne
---
# Enable Predefined Inbound Rules on Windows 8, Windows 7, Windows Vista, Windows Server 2012, Windows Server 2008, or Windows Server 2008 R2
[!INCLUDE[wfas](../Token/wfas_md.md)] includes many predefined rules for common networking roles and functions. When you install a new server role on a computer or enable a network feature on a client computer, the installer typically enables the rules required for that role instead of creating new ones. When deploying firewall rules to the computers on the network, you can take advantage of these predefined rules instead of creating new ones. Doing this helps to ensure consistency and accuracy, because the rules have been thoroughly tested and are ready for use.  
  
**Administrative credentials**  
  
To complete these procedures, you must be a member of the Domain Administrators group, or otherwise be delegated permissions to modify the GPOs.  
  
### To deploy predefined firewall rules that allow inbound network traffic for common network functions  
  
1.  [Open the Group Policy Management Console to Windows Firewall with Advanced Security](../Topic/Open-the-Group-Policy-Management-Console-to-Windows-Firewall-with-Advanced-Security.md).  
  
2.  In the navigation pane, click **Inbound Rules**.  
  
3.  Click **Action**, and then click **New rule**.  
  
4.  On the **Rule Type** page of the New Inbound Rule Wizard, click **Predefined**, select the rule category from the list, and then click **Next**.  
  
5.  On the **Predefined Rules** page, the list of rules defined in the group is displayed. By default, they are all selected. For rules that you do not want to deploy, clear the check boxes next to the rules, and then click **Next**.  
  
6.  On the **Action** page, select **Allow the connection**, and then click **Finish**.  
  
    The selected rules are added to the GPO and applied to the computers to which the GPO is assigned the next time Group Policy is refreshed.  
  
    > [!NOTE]  
    > If this GPO is targeted at server computers running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] that never move, consider modifying the rules to apply to all network location type profiles. This prevents an unexpected change in the applied rules if the network location type changes due to the installation of a new network card or the disconnection of an existing network card’s cable. A disconnected network card is automatically assigned to the Public network location type.  
  
If you arrived at this page by clicking a link in a checklist, use your browser’s **Back** button to return to the checklist.  
  
