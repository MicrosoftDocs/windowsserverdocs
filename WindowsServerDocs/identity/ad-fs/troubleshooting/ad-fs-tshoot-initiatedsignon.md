---
title: AD FS Troubleshooting - Idp-Initiated Sign On
description:  This document describes how to troubleshoot the AD FS sign on page.
author: billmath
ms.author: billmath
manager: mtillman
ms.date: 01/03/2017
ms.topic: article
---

# AD FS Troubleshooting - Idp-Initiated Sign On
The AD FS sign-on page can be used to test whether or not authentication is working.  This is done by navigating to the page and signing in.  Also, we can use the sign-in page to verify that all SAML 2.0 relying parties are listed.

## Enable the Idp-Initiated Sign on page
By default, AD FS in Windows 2016 does not have the sign on page enabled.  In order to enable it you can use the PowerShell command Set-AdfsProperties.  Use the following procedure to enable the page:

1.  Open Windows PowerShell
2.  Enter:  `Get-AdfsProperties` and hit enter
3.  Verify that **EnableIdpInitiatedSignonPage** is set to false
![False](media/ad-fs-tshoot-initiatedsignon/idp2.png)
4.  In PowerShell, enter:  `Set-AdfsProperties -EnableIdpInitiatedSignonPage $true`
5.  You will not see a confirmation so enter Get-AdfsProperties again and verify that **EnableIdpInitatedSignonPage** is set to true.
![True](media/ad-fs-tshoot-initiatedsignon/idp4.png)

## Test authentication
Use the following procedure to test AD FS authentication with the Idp-Initiated Sign on page.

1.  Open a web browser and navigate to the Idp sign on page.  Example:  https://sts.contoso.com/adfs/ls/idpinitiatedsignon.aspx
2.  You should be prompted to sign-in.  Enter your credentials.
![Sign-on](media/ad-fs-tshoot-initiatedsignon/idp5.png)
3.  If this was successful you should be signed in.


## Test authentication using a seamless logon experience

You can test the seamless logon experience by making sure that the URL for your AD FS servers are added the local intranet zone of your internet options.  Use the following procedure:

1. On a Windows 10 client, click start and type internet options and select internet options.

1. Click the security tab, click on local intranet, and click the sites button.

    ![Screenshot of the Security tab of the Internet Properties dialog box showing the Local Intranet option highlighted.](media/ad-fs-tshoot-initiatedsignon/idp8.png)

1. Click Advanced.

1. Enter your url and click Add.  Click close.

    ![Add url](media/ad-fs-tshoot-initiatedsignon/idp9.png)

1. Click Ok.  Click Ok.  This should close the internet options.

1. Open a web browser and navigate to the Idp sign on page.  Example:  https://sts.contoso.com/adfs/ls/idpinitiatedsignon.aspx

1. Click the sign in button.  You should automatically sign in and not be prompted for credentials.

    ![Screenshot of the Sign in page showing that the user wasn't prompted for credentials.](media/ad-fs-tshoot-initiatedsignon/idp6.png)

## Next Steps

- [AD FS Troubleshooting](ad-fs-tshoot-overview.md)
