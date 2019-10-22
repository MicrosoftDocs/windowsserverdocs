---
title: Rebuild the Tokens.dat file
description: How to rebuild the Tokens.dat file when you troubleshoot Windows activation issues
ms.topic: troubleshooting
ms.date: 09/18/2019
ms.technology: server-general
author: Teresa-Motiv
ms.author: v-tea
manager: dcscontentpm
ms.localizationpriority: medium
---

# Rebuild the Tokens.dat file

When you troubleshoot Windows activation issues, you may have to rebuild the Tokens.dat file. This article describes in detail how to do this.

## Resolution

To rebuild the Tokens.dat file, follow these steps:

1. Open an elevated Command Prompt window:  
   **For Windows 10**

   1. Open the **Start** menu, and enter **cmd**.
   1. In the search results, right-click **Command Prompt**, and the select **Run as administrator**.  

   **For Windows 8.1**
   1. Swipe in from the right edge of the screen, and then tap **Search**. Or, if you are using a mouse, point to the lower-right corner of the screen, and then select **Search**.
   1. In the search box, enter **cmd**.
   1. Swipe across or right-click the displayed **Command Prompt** icon.
   1. Tap or click **Run as administrator**.

   **For Windows 7**
   1. Open the **Start** menu, and enter **cmd**.
   1. In the search results, right-click **cmd.exe**, and the select **Run as administrator**.

1. Enter the list of commands that is appropriate for your operating system.  

   For Windows 10, Windows Server 2016 and later versions of Windows, enter the following commands in sequence:
   ```cmd
   net stop sppsvc
   cd %windir%\system32\spp\store\2.0
   ren tokens.dat tokens.bar
   net start sppsvc
   cscript.exe %windir%\system32\slmgr.vbs /rilc
   ```
   For Windows 8.1, Windows Server 2012 and Windows Server 2012 R2, enter the following commands in sequence:
   ```cmd
   net stop sppsvc
   cd %windir%\ServiceProfiles\LocalService\AppData\Local\Microsoft\WSLicense
   ren tokens.dat tokens.bar
   net start sppsvc
   cscript.exe %windir%\system32\slmgr.vbs /rilc
   ```
   For Windows 7, Windows Server 2008 and Windows Server 2008 R2, enter the following commands in sequence:
   ```cmd
   net stop sppsvc
   cd %windir%\ServiceProfiles\NetworkService\AppData\Roaming\Microsoft\SoftwareProtectionPlatform
   ren tokens.dat tokens.bar
   net start sppsvc
   cscript.exe %windir%\system32\slmgr.vbs /rilc
   ```
1. Restart the computer.

## More information

After you rebuild the Tokens.dat file, you must reinstall your product key by using one of the following methods:

- At the same elevated prompt command, type the following command, and then press Enter:

   ```cmd
   cscript.exe %windir%\system32\slmgr.vbs /ipk <Product key>
   ```

  > [!IMPORTANT]
  > Do not use the **/upk** switch to uninstall a product key. To install a product key over an existing product key, use the **/ipk** switch.
- Right-click **My Computer**, select **Properties**, and then select **Change product key**.

For more information about KMS client setup keys, see [KMS client setup keys](kmsclientkeys.md).
