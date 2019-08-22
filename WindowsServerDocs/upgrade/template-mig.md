---
title: Upgrade content - Windows Server
description: Upgrade content
services: windows-server
author: ChJenk

ms.service: server-general
ms.topic: upgrade
ms.date: 06/20/2019
ms.author: v-chjenk
---

# Migrating Steps

## Converting a current evaluation version to a current retail version

You can convert the evaluation version of Windows Server 2016 Standard to either Windows Server 2016 Standard (retail) or Datacenter (retail). Similarly, you can convert the evaluation version of Windows Server 2016 Datacenter to the retail version.

> [!IMPORTANT]  
> For releases of Windows Server 2016 prior to 14393.0.161119-1705.RS1_REFRESH, you can only perform this conversion from evaluation to retail with Windows Server 2016 that has been installed by using the Desktop Experience option (not the Server Core option). Starting with version 14393.0.161119-1705.RS1_REFRESH and later releases, you can convert evaluation editions to retail regardless of the installation option used.

Before you attempt to convert from evaluation to retail, verify that your server is actually running an evaluation version. To do this, do either of the following:

- From an elevated command prompt, run **slmgr.vbs /dlv**; evaluation versions will include “EVAL” in the output.
- From the Start screen, open **Control Panel**. Open **System and Security**, and then **System**. View Windows activation status in the Windows activation area of the **System** page. Click **View details** in Windows activation for more information about your Windows activation status.

If you have already activated Windows, the Desktop shows the time remaining in the evaluation period.

If the server is running a retail version instead of an evaluation version, see the “Upgrading previous retail versions of Windows Server to Windows Server 2016” section of this topic for instructions to upgrade to Windows Server 2016.

For **Windows Server 2016 Essentials**: You can convert to the full retail version by entering a retail, volume license, or OEM key in the command **slmgr.vbs**.

If the server is running an evaluation version of Windows Server 2016 Standard or Windows Server 2016 Datacenter, you can convert it to a retail version as follows:

1.	If the server is a **domain controller**, you cannot convert it to a retail version. In this case, install an additional domain controller on a server that runs a retail version and remove AD DS from the domain controller that runs on the evaluation version. For more information, see [Upgrade Domain Controllers to Windows Server 2012 R2 and Windows Server 2012](https://technet.microsoft.com/library/hh994618.aspx).
2.	Read the license terms.
3.	From an elevated command prompt, determine the current edition name with the command **DISM /online /Get-CurrentEdition**. Make note of the edition ID, an abbreviated form of the edition name. Then run **DISM /online /Set-Edition:\<edition ID\> /ProductKey:XXXXX-XXXXX-XXXXX-XXXXX-XXXXX /AcceptEula**, providing the edition ID and a retail product key. The server will restart twice.

For the evaluation version of Windows Server 2016 Standard, you can also convert to the retail version of Windows Server 2016 Datacenter in one step using this same command and the appropriate product key.

> [!TIP]
> For more information about Dism.exe, see [DISM Command-line options](https://go.microsoft.com/fwlink/?LinkId=192466).

## Converting a current retail edition to a different current retail edition

At any time after installing Windows Server 2016, you can run Setup to repair the installation (sometimes called “repair in place”) or, in certain cases, to convert to a different edition.

You can run Setup to perform a “repair in place” on any edition of Windows Server 2016; the result will be the same edition you started with.

For Windows Server 2016 Standard, you can convert the system to Windows Server 2016 Datacenter as follows: From an elevated command prompt, determine the current edition name with the command **DISM /online /Get-CurrentEdition**. For Windows Server 2016 Standard this will be `ServerStandard`. Run the command **DISM /online /Get-TargetEditions** to get the ID of the edition you can upgrade to. Make note of this edition ID, an abbreviated form of the edition name. Then run **DISM /online /Set-Edition:\<edition ID\> /ProductKey:XXXXX-XXXXX-XXXXX-XXXXX-XXXXX /AcceptEula**, providing the edition ID of your target and its retail product key. The server will restart twice.

## Converting a current retail version to a current volume-licensed version

At any time after installing Windows Server 2016, you can freely convert it between a retail version, a volume-licensed version, or an OEM version. The edition remains the same during this conversion. If you are starting with an evaluation version, convert it to the retail version first, and then you can inter-convert as described here.

To do this, from an elevated command prompt, run:

**slmgr /ipk \<key\>**

Where \<key\> is the appropriate volume-license, retail, or OEM product key.
