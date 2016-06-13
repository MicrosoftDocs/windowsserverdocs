---
title: Change Rules from Request to Require Mode
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 30804191-c258-4fd3-8b42-4d9922fc2d05
---
# Change Rules from Request to Require Mode
After you confirm that network traffic is being correctly protected by using IPsec, you can change the rules for the domain isolation and encryption zones to require, instead of request, authentication. Do not change the rules for the boundary zone; they must stay in request mode so that computers in the boundary zone can continue to accept connections from computers that are not part of the isolated domain.

**Administrative credentials**

To complete these procedures, you must be a member of the Domain Administrators group, or otherwise be delegated permissions to modify the GPOs.

In this topic:

-   [Convert a rule in a GPO for Windows 8, Windows 7, Windows Vista, Windows Server 2012, Windows Server 2008, or Windows Server 2008 R2](#bkmk_section1)

-   [Convert a rule for an earlier version of Windows](#bkmk_section2)

-   [Refresh policy on the client computers to receive the modified GPOs](#bkmk_section3)

## <a name="bkmk_Section1"></a>
#### To convert a rule from request to require mode for Windows 8, Windows 7, Windows Vista, Windows Server 2012, Windows Server 2008, or Windows Server 2008 R2

1.  [Open the Group Policy Management Console to Windows Firewall with Advanced Security](Open-the-Group-Policy-Management-Console-to-Windows-Firewall-with-Advanced-Security.md).

2.  In the navigation pane, click **Connection Security Rules**.

3.  In the details pane, double\-click the connection security rule that you want to modify.

4.  Click the **Authentication** tab.

5.  In the **Requirements** section, change **Authenticated mode** to **Require inbound and request outbound**, and then click **OK**.

## <a name="bkmk_Section3"></a>
#### To apply the modified GPOs to the client computers

1.  The next time each computer refreshes its Group Policy, it will receive the updated GPO and apply the modified rule. To force an immediate refresh, [Start a Command Prompt as an Administrator](Start-a-Command-Prompt-as-an-Administrator.md) and run the following command:

    ```
    gpupdate /force
    ```

2.  To verify that the modified GPO is correctly applied to the client computers, you can run one of the following commands:

    On computers that are running Windows 8,  Windows 7 , Windows Vista,  Windows Server 2012 ,  Windows Server 2008 , or  Windows Server 2008 R2 , run the following command:

    ```
    gpresult /r /scope computer
    ```

3.  Examine the command output for the list of GPOs that are applied to the computer, and make sure that the list contains the GPOs you expect to see on that computer.


