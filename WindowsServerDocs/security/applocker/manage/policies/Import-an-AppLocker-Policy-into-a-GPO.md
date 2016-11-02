---
title: Import an applocker Policy into a GPO
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-applocker
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 968f62f9-4d9a-4274-8ab0-69ed1aadabaf
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Import an applocker Policy into a GPO

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This topic describes the steps to import an applocker policy into a Group Policy Object (GPO) in  Windows Server 2012  and Windows 8.

applocker policies can be created as local security policies and modified like any other local security policy, or they can be created as part of a GPO and managed by using Group Policy. You can create applocker policies on any supported computer. For information about which Windows editions are supported, see [Requirements to Use applocker](http://technet.microsoft.com/library/ee424382(WS.10).aspx).

> [!IMPORTANT]
> Follow your organization's standard procedures for updating GPOs. For information about specific steps to follow for applocker policies, see [Maintain applocker Policies](../maintain-applocker-policies.md).

To complete this procedure, you must have Edit Setting permission to edit a GPO. By default, members of the **Domain Admins** group, the **Enterprise Admins** group, and the **Group Policy Creator Owners** group have this permission.

#### To import an applocker policy into a GPO

1.  In the Group Policy Management Console (GPMC), open the GPO that you want to edit.

2.  In the console tree under **Computer Configuration\Policies\Windows Settings\Security Settings\Application Control Policies**, click **applocker**.

3.  Right-click **applocker**, and then click **Import Policy**.

4.  In the **Import Policy** dialog box, locate the XML policy file, and click **Open**.

5.  The **applocker** dialog box will notify you of how many rules were imported. Click **OK**.


