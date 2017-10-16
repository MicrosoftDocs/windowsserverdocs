---
title: Register an NPS Server in an Active Directory Domain
description: You can use this topic to register a server running Network Policy Server in Windows Server 2016 in the NPS server default domain or in another domain.
manager: brianlic
ms.prod: windows-server-threshold
ms.technology: networking
ms.topic: article
ms.assetid: 2de954fd-a7d8-4cc6-85b1-b0c3c06f788f
ms.author: jamesmci 
author: jamesmci
---

# Register an NPS Server in an Active Directory Domain

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this topic to register a server running Network Policy Server in Windows Server 2016 in the NPS server default domain or in another domain.

## Register an NPS Server in its Default Domain

You can use this procedure to register an NPS server in the domain where the server is a domain member. 

NPS servers must be registered in Active Directory so that they have permission to read the dial-in properties of user accounts during the authorization process. Registering an NPS server adds the server to the **RAS and IAS Servers** group in Active Directory.

Membership in **Administrators**, or equivalent, is the minimum required to perform these procedures.

### To register an NPS server in its default domain


1. On the NPS server, in Server Manager, click **Tools**, and then click **Network Policy Server**. The Network Policy Server console opens.

2. Right-click **NPS (Local)**, and then click **Register Server in Active Directory**. The **Network Policy Server** dialog box opens.

3. In **Network Policy Server**, click **OK**, and then click **OK** again.

## Register an NPS Server in Another Domain

To provide an NPS server with permission to read the dial-in properties of user accounts in Active Directory, the NPS server must be registered in the domain where the accounts reside.

You can use this procedure to register an NPS server in a domain where the NPS server is not a domain member.

Membership in **Administrators**, or equivalent, is the minimum required to perform these procedures.

### To register an NPS server in another domain

1. On the domain controller, in Server Manager, click **Tools**, and then click **Active Directory Users and Computers**. The Active Directory Users and Computers console opens.

2. In the console tree, navigate to the domain where you want the NPS server to read user account information, and then click the **Users** folder. 

3. In the details pane, right-click **RAS and IAS Servers**, and then click **Properties**. The **RAS and IAS Servers Properties** dialog box opens.

4. In the **RAS and IAS Servers Properties** dialog box, click the **Members** tab, add each of the NPS servers that you want to register in the domain, and then click **OK**.


### To register an NPS server in another domain by using Netsh commands for NPS

1. Open Command Prompt or windows PowerShell. 

2. Type the following at the command prompt: **netsh nps add registeredserver** &nbsp;*domain* &nbsp;*server*, and then press ENTER.

>[!NOTE]
>In the preceding command, *domain* is the DNS domain name of the domain where you want to register the NPS server, and *server* is the name of the NPS server computer.

