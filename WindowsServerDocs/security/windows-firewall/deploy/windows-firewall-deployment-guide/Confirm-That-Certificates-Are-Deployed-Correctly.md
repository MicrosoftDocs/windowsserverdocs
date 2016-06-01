---
title: Confirm That Certificates Are Deployed Correctly
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 380025da-4220-4c2b-8f4f-195e25fb9a3d
---
# Confirm That Certificates Are Deployed Correctly
After configuring your certificates and autoenrollment in Group Policy, you can confirm that the policy is being applied as expected, and that the certificates are being properly installed on the workstation computers.

In these procedures, you refresh Group Policy on a client computer, and then confirm that the certificate is deployed correctly.

**Administrative credentials**

To complete these procedures, you must be a member of the Domain Administrators group, or otherwise be delegated permissions to modify the GPOs.

In this topic:

-   [Refresh Group Policy on a computer](#bkmk_TorefreshGroupPolicyonacomputer)

-   [Verify that a certificate is installed](#bkmk_Toverifythatacertificateisinstalled)

## <a name="bkmk_TorefreshGroupPolicyonacomputer"></a>
#### To refresh Group Policy on a computer

1.  On a computer running [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)], [!INCLUDE[nextref_client_7](includes/nextref_client_7_md.md)], [!INCLUDE[nextref_vista](includes/nextref_vista_md.md)], [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)], [!INCLUDE[nextref_longhorn](includes/nextref_longhorn_md.md)], or [!INCLUDE[nextref_server_7](includes/nextref_server_7_md.md)], [Start a Command Prompt as an Administrator](Start-a-Command-Prompt-as-an-Administrator.md), and then type the following command:

    ```
    gpupdate /target:computer /force
    ```

After Group Policy is refreshed, you can see which GPOs are currently applied to the computer.

## <a name="bkmk_Toverifythatacertificateisinstalled"></a>
#### To verify that a certificate is installed

1.  Click the **Start** charm, type **certmgr.msc**, and then press ENTER.

2.  In the navigation pane, expand **Trusted Root Certification Authorities**, and then click **Certificates**.

    The CA that you created appears in the list.


