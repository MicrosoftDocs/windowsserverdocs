---
description: "Learn more about: Create a Non-Claims-Aware Relying Party Trust"
ms.assetid: 7b7ae389-5032-44f7-9c0a-94398c3e4d88
title: Create a Non-Claims Aware Relying Party Trust
author: billmath
ms.author: billmath
manager: amycolannino
ms.date: 08/15/2023
ms.topic: article
---


# Create a Non-Claims-Aware Relying Party Trust


In the AD FS Management snap\-in, non\-claims\-aware relying party trusts are objects that are created to represent the trust between the federation service and a single web\-based application that is not claims\-aware and that is accessed through the Web Application Proxy.

A non\-claims\-aware relying party trust is a relying party trust which consists of identifiers, names, and rules for authentication and authorization when the relying party trust is accessed through the Web Application Proxy. These web\-based applications that do not rely on claims, in other words, these Integrated Windows Authentication\-based applications, can have authorization rules that enforce access that is based on claims when the access is external to the corporate network through the Web Application Proxy.

To add a new non\-claims\-aware relying party trust, by using the AD FS Management snap\-in, perform the following procedure.

Membership in **Administrators**, or equivalent, on the local computer is the minimum required to complete this procedure.  Review details about using the appropriate accounts and group memberships at [Local and Domain Default Groups](/previous-versions/orphan-topics/ws.10/dd728026(v=ws.10)).

## To create a non-claims aware Relying Party Trust manually
1. In Server Manager, click **Tools**, and then select **AD FS Management**.

2.  Under **Actions**, click **Add Relying Party Trust**.
![Screenshot that highlights the Add Relying Party Trust action.](media/Create-a-Relying-Party-Trust/addtrust1.PNG)

3.  On the **Welcome** page, choose **Non claims aware** and click **Start**.
![Screenshot that highlights the Non claims aware option.](media/Create-a-Non-Claims-Aware-Relying-Party-Trust/addnon1.PNG)

4.  On the **Specify Display Name** page, type a name in **Display name**, under **Notes** type a description for this relying party trust, and then click **Next**.
![Screenshot that shows where to specify the name for the relying party trust.](media/Create-a-Non-Claims-Aware-Relying-Party-Trust/addnon2.PNG)

5. On the **Configure Identifiers** page, specify one or more identifiers for this relying party, click **Add** to add them to the list, and then click **Next**.
![Screenshot that shows where to specify one or more identifiers for the relying party trust.](media/Create-a-Non-Claims-Aware-Relying-Party-Trust/addnon3.PNG)

6.  On the **Choose Access Control Policy** select a policy and click **Next**.  For more information about Access Control Policies, see [Access Control Policies in AD FS](Access-Control-Policies-in-AD-FS.md).
![Screenshot that shows where to select an Access Control Policy for the relying party trust.](media/Create-a-Non-Claims-Aware-Relying-Party-Trust/addnon4.PNG)

7. On the **Ready to Add Trust** page, review the settings, and then click **Next** to save your relying party trust information.
   ![Screenshot that shows how to save your relying party trust information.](media/Create-a-Non-Claims-Aware-Relying-Party-Trust/addnon5.PNG)

8. On the **Finish** page, click **Close**. This action automatically displays the **Edit Claim Rules** dialog box.
![relying party](media/Create-a-Non-Claims-Aware-Relying-Party-Trust/addnon6.PNG)

## See Also
[AD FS Operations](../ad-fs-operations.md)
