---
title: AD FS Troubleshooting - Idp-Initiated Sign On
description: Learn how to use the sign-in page to troubleshoot Active Directory Federation Services (AD FS) authentication.
author: billmath
ms.author: billmath
manager: amycolannino
ms.date: 05/19/2023
ms.topic: article
---

# AD FS Troubleshooting - Idp-Initiated Sign On

The Active Directory Federation Services (AD FS) sign-on page can be used to test whether or not authentication is working. This test is done by navigating to the page and signing in. Also, you can use the sign-in page to verify that all SAML 2.0 relying parties are listed.

## Enable the Idp-Initiated Sign on page

By default, AD FS in Windows 2016 doesn't have the sign on page enabled. In order to enable it, you can use the PowerShell command `Set-AdfsProperties`. Use the following procedure to enable the page:

1. Open Windows PowerShell.
2. Enter `Get-AdfsProperties` and hit enter.
3. Verify that **EnableIdpInitiatedSignonPage** is set to false.
:::image type="content" source="media/ad-fs-tshoot-initiatedsignon/idp2.png" alt-text="Screenshot showing PowerShell output highlighting that the EnableIdpInitiatedSignonPage property is set to false.":::
4. In PowerShell, enter `Set-AdfsProperties -EnableIdpInitiatedSignonPage $true`.
5. PowerShell doesn't provide a confirmation, so enter Get-AdfsProperties again, and verify that **EnableIdpInitatedSignonPage** is set to true.
:::image type="content" source="media/ad-fs-tshoot-initiatedsignon/idp4.png" alt-text="Screenshot  PowerShell output highlighting that the EnableIdpInitiatedSignonPage property is set to true.":::

## Test authentication

Use the following procedure to test AD FS authentication with the Idp-Initiated Sign on page.

1. Open a web browser, and navigate to the Idp sign on page. Your URL might look like `https://sts.contoso.com/adfs/ls/idpinitiatedsignon.aspx`.
2. You should be prompted to sign-in. Enter your credentials.
:::image type="content" source="media/ad-fs-tshoot-initiatedsignon/idp5.png" alt-text="Screenshot showing the sign-in page and the dialog box prompting for credentials.":::
3. If this process was successful, you should be signed in.

## Test authentication using a seamless sign in experience

You can test the seamless sign-in experience by making sure that the URL for your AD FS servers is added to the local intranet zone of your internet options. Use the following procedure:

1. On a Windows 10 client, select **Start** and type *internet options* and select **Internet Options**.

1. Select the **Security** tab, select **Local intranet**, and then select **Sites**.

    :::image type="content" source="media/ad-fs-tshoot-initiatedsignon/idp8.png" alt-text="Screenshot of the Security tab of the Internet Properties dialog box showing the Local Intranet option highlighted.":::

1. Select **Advanced**.

1. Enter your URL and select **Add**. Select **Close**.

    ![Add url](media/ad-fs-tshoot-initiatedsignon/idp9.png)

1. Select **Ok**. Then select **Ok** to close the internet options.

1. Open a web browser and navigate to the Idp sign on page. Your URL might look like `https://sts.contoso.com/adfs/ls/idpinitiatedsignon.aspx`.

1. Select the **sign in** button. You should automatically sign in and not be prompted for credentials.

    :::image type="content" source="media/ad-fs-tshoot-initiatedsignon/idp6.png" alt-text="Screenshot of the Sign in page showing that the user wasn't prompted for credentials.":::

## Known Issues

The AD FS sign-on page can't be used to initiate a sign-on with a claims provider trust that is configured with a WS-Federation passive endpoint only. Register a relying party such as [ClaimsXRay](https://adfshelp.microsoft.com/ClaimsXray/TokenRequest) to verify that a WS-Federation claims provider trust works as intended.

## Next Steps

- [Troubleshooting AD FS](ad-fs-tshoot-overview.md)
