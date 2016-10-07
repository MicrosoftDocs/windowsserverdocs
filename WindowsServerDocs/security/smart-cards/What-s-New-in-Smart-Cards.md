---
title: What&#39;s New in Smart Cards
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-smart-cards
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7814aa0c-6e3a-46bf-a65b-83469e8c2c78
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# What&#39;s New in Smart Cards

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This document describes new smart card−related features on the  Windows Server 2012 , Windows 8, and Windows RT operating systems.

Smart cards together with personal identification numbers (PINs) are an increasingly popular, reliable, and cost-effective form of two-factor authentication. With the right controls in place, a user must have the smart card and know the PIN to gain access to network resources. The two-factor requirement significantly reduces the likelihood of unauthorized access to an organization’s network. Smart cards provide particularly effective security control for:

-   Authentication for scenarios such as remote access

-   Data integrity for scenarios such as document signing

-   Data confidentiality for scenarios that require encryption

Their use in additional scenarios, such as secure access to high-value applications, is likely to grow as organizations deploy a new generation of secure applications.

## What’s new in smart cards in Windows Server 2012, Windows 8, and Windows RT
The following changes have been made to smart card support in  Windows Server 2012 , Windows 8, and Windows RT:

-   [Virtual smart cards](#BKMK_VSC)

-   [Changes to the smart card sign-in experience](#BKMK_SignIn)

-   [Smart Card Service start and stop behavior](#BKMK_StartStop)

-   [Smart card transactions](#BKMK_Trans)

-   [Smart card support on Windows RT](#BKMK_WinRTsupport)

-   [Smart card support in Windows 8 applications](#BKMK_Win8AppSupport)

### <a name="BKMK_VSC"></a>Virtual smart cards
Virtual smart cards emulate the functionality of traditional smart cards, but they use the Trusted Platform Module (TPM) chip available on many organizations’ computers rather than requiring the use of a separate physical smart card and reader. Virtual smart cards involve technical, functional, security, and cost differences with conventional smart cards.

To the end user, the virtual smart card is a smart card that is always available on the computer. If a user needs to use more than one computer, a new virtual smart card must be issued to the user for each computer. Also, a computer that is shared among multiple users can host multiple virtual smart cards, one for each user.

Conventional smart cards and TPM virtual smart cards offer comparable levels of security. TPM virtual smart cards can be deployed with no additional material cost, as long as employees have computers with built-in TPMs. For more information, see [Understanding and Evaluating Virtual Smart Cards](http://go.microsoft.com/fwlink/?LinkId=243114).

### <a name="BKMK_SignIn"></a>Changes to the smart card sign-in experience
For end users, the sign-in experience on  Windows Server 2012  and Windows 8 has improved detection of whether a smart card reader was installed and whether a smart card or a password was used to sign in or unlock the computer the last time. If a smart card was not installed previously, and the user selects the smart card sign-in icon, a message appears telling the user to connect a smart card. After a card is connected, the smart card PIN dialog box appears. If the user does not want to use the sign-in option that automatically appears (if their smart card is not readily available, for example), a second message allows the user to select from different sign-in options.

### <a name="BKMK_StartStop"></a>Smart Card Service start and stop behavior
Smart card reader detection logic has been added so that the Smart Card Service runs only when appropriate. On  Windows Server 2012  and Windows 8, the Smart Card Service (scardsvr) automatically starts when the user connects a smart card reader and automatically stops when a user removes a smart card reader and no other smart card reader is connected to the computer. On startup, the Smart Card Service automatically starts if a reader was previously connected to the computer but a reader is not currently connected to the system. If no smart card readers are connected to the computer, the service will automatically shut down one minute after the last API call into the Smart Card Service. If a reader was never previously connected to the computer, the service will not start automatically.

### <a name="BKMK_Trans"></a>Smart card transactions
On  Windows Server 2012 , Windows 8, and Windows RT, if a transaction is held on the card for more than 5 seconds with no operations happening on the card, the card is reset. This is a change from the behavior in previous releases.

For more information about this behavior, see [SCardBeginTransaction function](http://msdn.microsoft.com/library/windows/desktop/aa379469(v=vs.85).aspx).

### <a name="BKMK_WinRTsupport"></a>Smart card support on Windows RT
Smart card support for Windows RT includes the following:

-   **Smart card readers**

    Only smart card readers that connect over USB and support the USB Chip/Smart Card Interface Devices (CCID) specification are allowed on Windows RT. Such smart card readers must use the USB CCID specification smart card reader class driver that comes with Windows RT.

-   **Smart cards**

    Only smart cards that support the Generic Identity Device Specification (GIDS) or the Personal Identity Verification (PIV) standard are supported on Windows RT. The class drivers for cards based upon these specifications are included within Windows.

### <a name="BKMK_Win8AppSupport"></a>Smart card support in Windows 8 applications
Windows 8 supports a number of new types of desktop applications. Developers who create applications that need the security benefits of smart cards must address the following requirements; otherwise, these applications cannot automatically use smart cards to support their functionality.

-   To use a smart card, applications running in AppContainer must have the SharedUserCertificates capability in their application manifest. Without this capability, the application will not be permitted to use a smart card for authentication, signing, or encryption. For information about this capability and how to include it in the manifest, see [Setting certificate store capabilities](http://msdn.microsoft.com/library/windows/apps/hh465025.aspx).

-   For Windows RT applications, smart card support is limited to SSL client authentication. For a sample application that demonstrates the use of smart cards for SSL client authentication, see [Windows Store app for banking: code walkthrough](http://msdn.microsoft.com/library/windows/apps/hh464943.aspx).

## See also

-   [Smart Card Overview](Smart-Card-Overview.md)

-   [What's New in Smart Cards in Windows Server 2008 R2](http://technet.microsoft.com/library/dd367851(v=ws.10).aspx)

-   [Understanding and Evaluating Virtual Smart Cards](http://go.microsoft.com/fwlink/?LinkId=243114)


