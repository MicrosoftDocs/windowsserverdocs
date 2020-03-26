---
title: "Join computers to the new Windows Server Essentials network1"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d94de050-3300-4323-a5ea-c824cb9cecc9
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Join computers to the new Windows Server Essentials network1

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

##  <a name="BKMK_JoinComputers"></a>   
 The next step in the migration process is to join client computers to the new  Windows Server Essentials network and update Group Policy settings.  
  
### Domain-joined client computers  
 Browse to **http://**<em>destination-servername</em>**/connect** and install the Windows Server Connector software as if this was a new computer. The installation process is the same for domain-joined or non-domain-joined client computers.  
  
> [!NOTE]
>  The Windows Server Connector software does not support computers that are running Windows XP or Windows Vista. If you have computers running Windows XP or Windows Vista that are already joined to the domain, you can skip this step.  
  
### Non-domain-joined client computers  
 Browse to **http://**<em>destination-servername</em>**/connect** and install the Windows Server Connector software as if this was a new computer. The installation process is the same for domain joined or non-domain joined client computers.  
  
> [!NOTE]
>  The Windows Server Connector software does not support computers that are running Windows XP or Windows Vista. If you have computers running Windows XP or Windows Vista that are already joined to the domain, you can skip this step.  
  
### Ensure that Group Policy has updated  
  
> [!NOTE]
>  This is an optional step, and it is only required if the Source Server was configured with custom Group Policy settings such as Folder Redirection.  
  
 While the Source Server and the Destination Server are still online, you should ensure that the Group Policy settings have replicated from the Destination Server to the client computers. Perform the following steps on each client computer:  
  
1.  Open a Command Prompt window.  
  
2.  At the command prompt, type **GPRESULT /R**, and then press ENTER.  
  
3.  Review the resulting output for the section Group Policy was applied from: and ensure it lists the Destination Server, such as **DestinationSrv.Domain.local**. For example:  
  
    ```  
    USER SETTINGS  
    --------------  
        CN=User,OU=Users,DC=DOMAIN,DC=Local  
        Last time Group Policy was applied: 1/24/2011 at 1:26:27 PM  
        Group Policy was applied from:      DestinationSrv.Domain.local  
        Group Policy slow link threshold:   500 kbps  
        Domain Name:                        Domain  
        Domain Type:                        Windows 2008  
  
    ```  
  
4.  If the Destination Server is not listed, at a command prompt, type **gpupdate /force**, and then press ENTER to refresh the Group Policy settings. Then perform the previous procedure again.  
  
5.  If the Destination Server still does not appear, there may be an error in the Group Policy settings or an error in applying them to this specific client computer. If the Destination Server does not appear, perform the following steps:  
  
    1.  Click **Start**, click **Run**, type **rsop.msc** (Resultant Set of Policy), and then press ENTER.  
  
    2.  Expand the tree with the X on it until you get to a node.  
  
    3.  Right-click the node, and click **View Error** for information about why the Group Policy settings are failing on the computer listed.
