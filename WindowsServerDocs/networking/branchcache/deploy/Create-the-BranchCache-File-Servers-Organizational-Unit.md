---
title: Create the BranchCache File Servers Organizational Unit
description: Learn how to create an organizational unit (OU) in Active Directory Domain Services (AD DS) for BranchCache file servers.
manager: brianlic
ms.topic: how-to
ms.assetid: 2cda192f-6b45-4e6c-88d9-70ca179ddb94
ms.author: jgerend
author: JasonGerend
ms.date: 01/05/2021
---
# Create the BranchCache File Servers Organizational Unit

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

You can use this procedure to create an organizational unit (OU) in Active Directory Domain Services (AD DS) for BranchCache file servers.

Membership in **Domain Admins**, or equivalent is the minimum required to perform this procedure.

### To create the BranchCache file servers organizational unit

1.  On a computer where AD DS is installed, in Server Manager, click **Tools**, and then click **Active Directory Users and Computers**. The Active Directory Users and Computers console opens.

2.  In the Active Directory Users and Computers console, right-click the domain to which you want to add an OU. For example, if your domain is named example.com, right click **example.com**. Point to **New**, and then click **Organizational Unit**. The **New Object - Organizational Unit** dialog box opens.

3.  In the **New Object - Organizational Unit** dialog box, in **Name**, type a name for the new OU. For example, if you want to name the OU BranchCache file servers, type **BranchCache file servers**, and then click **OK**.



