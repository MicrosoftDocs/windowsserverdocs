---
title: Open Windows Firewall with Advanced Security
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 57195ded-f214-4c8b-9d15-23132810ece2
---
# Open Windows Firewall with Advanced Security
This procedure shows you how to open the Windows Firewall with Advanced Security MMC snap\-in.

**Administrative credentials**

To complete this procedure, you must be a member of the Administrators group. For more information, see Additional considerations.

## Opening Windows Firewall with Advanced Security

-   [Using the Windows interface](#bkmk_proc1)

-   [Using a command line](#bkmk_proc2)

## <a name="bkmk_proc1"></a>
#### To open Windows Firewall with Advanced Security by using the Windows interface

-   Click the **Start** charm, right\-click the Start page, click **All Apps**, and then click the **Windows Firewall with Advanced Security** tile.

## <a name="bkmk_proc2"></a>
#### To open Windows Firewall with Advanced Security from a command prompt

1.  Open a command prompt window.

2.  At the command prompt, type:

    ```
    wf.msc
    ```

**Additional considerations**

Although standard users can start the Windows Firewall with Advanced Security MMC snap\-in, to change most settings the user must be a member of a group with the permissions to modify those settings, such as Administrators.


