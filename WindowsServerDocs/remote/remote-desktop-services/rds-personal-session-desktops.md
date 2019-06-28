---
title: Use personal session desktops with Remote Desktop Services
description: Learn how to share personalized, assigned desktops through RDS.
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
author: lizap
ms.author: elizapo
ms.date: 09/16/2016
manager: dongill
---
# Use personal session desktops with Remote Desktop Services

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016

You can deploy server-based personal desktops in a cloud-computing environment by using personal session desktops.  (A cloud-computing environment has a separation between the fabric Hyper-V servers and the guest virtual machines, such as Microsoft Azure Cloud or the Microsoft Cloud Platform.) The personal session desktop capability extends the session-based desktop deployment scenario in Remote Desktop Services to create a new type of session collection where each user is assigned to their own personal session host with administrative rights. 

Use the following information to create and manage a personal session desktop collection.

## Create a personal session desktop collection

Use the New-RDSessionCollection cmdlet to create a personal session desktop collection. The following three parameters provide the configuration information required for personal session desktops:

- **-PersonalUnmanaged** - Specifies the type of session collection that lets you assign users to a personal session host server. If you don't specify this parameter, then the collection is created as a traditional RD Session Host collection, where users are assigned to the next available session host when they sign in.
- **-GrantAdministrativePrivilege** - If you use **-PersonalUnmanaged**, specifies that the user assigned to the session host be given administrative privileges. If you don't use this parameter, users are granted only standard user privileges.
- **-AutoAssignUser** - If you use **-PersonalUnmanaged**, specifies that new users connecting through the RD Connection Broker are automatically assigned to an unassigned session host. If there are no unassigned session hosts in the collection, the user will see an error message. If you don't use this parameter, you have to [manually assign users to a session host](#manually-assign-a-user-to-a-personal-session-host) before they sign in.

## Manually assign a user to a personal session host
Use the **Set-RDPersonalSessionDesktopAssignment** cmdlet to manually assign a user to a personal session host server in the collection. The cmdlet supports the following parameters:

-CollectionName \<string\>

-ConnectionBroker \<string\> 

-User \<string\>

-Name \<string\>

- **–CollectionName** - specifies the name of the personal session desktop collection. This parameter is required.
- **–ConnectionBroker** - specifies the Remote Desktop Connection Broker (RD Connection Broker) server for your Remote Desktop deployment. If you don't supply a value, the cmdlet uses the fully qualified domain name (FQDN) of the local computer.
- **–User** - specifies the user account to associate with the personal session desktop, in DOMAIN\User format. This parameter is required.
- **–Name** - specifies the name of the session host server. This parameter is required. The session host identified here must be a member of the collection that the **-CollectionName** parameter specifies.

The **Import-RDPersonalSessionDesktopAssignment** cmdlet imports associations between user accounts and personal session desktops from a text file. The cmdlet supports the following parameters:

-CollectionName \<string\>

-ConnectionBroker \<string\>

-Path \<string>

**–Path** specifies the path and file name of a file to import.
 
## Removing a User Assignment from a Personal Session Host
Use the **Remove-RDPersonalSessionDesktopAssignment** cmdlet to remove the association between a personal session desktop and a user. The cmdlet supports the following parameters:

-CollectionName \<string\>

-ConnectionBroker \<string\>

-Force

-Name \<string\>

-User \<string\>

**–Force** forces the command to run without asking for user confirmation.

## Query user assignments
Use the **Get-RDPersonalSessionDesktopAssignment** cmdlet to get a list of personal session desktops and associated user accounts. The cmdlet supports the following parameters:

-CollectionName \<string\>

-ConnectionBroker \<string\>

-User \<string\>

-Name \<string\>

You can run the cmdlet to query by collection name, user name, or by session desktop name. If you specify only the **–CollectionName** parameter, the cmdlet returns a list of session hosts and associated users. If you also specify the **–User** parameter, the session host associated with that user is returned. If you provide the **–Name** parameter, the user associated with that session host is returned. 


The **Export-RDPersonalPersonalDesktopAssignment** cmdlet exports the current associations between users and personal virtual desktops to a text file. The cmdlet supports the following parameters:

-CollectionName \<string\>

-ConnectionBroker \<string\>

-Path \<string\>


All new cmdlets support the common parameters: -Verbose, -Debug, -ErrorAction, -ErrorVariable, -OutBuffer, and -OutVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/p/?LinkID=113216).

## Hardware accelerated graphics
Windows Server 2016 extends the RemoteFX 3D Graphics adapter (vGPU) technology to support OpenGL and supports single-user Windows Server 2016 guest VMs. You can combine personal session desktops with the new vGPU capabilities to provide support for hosted applications that require accelerated graphics. Alternatively, you can combine personal session desktops with the new Discrete Device Assignment (DDA) capability to also provide support for hosted applications that require accelerated graphics.
