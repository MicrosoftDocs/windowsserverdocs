---
title: Troubleshoot Active Directory Federation Services Idp-initiated sign-on
description: Learn how to use the sign-in page to troubleshoot Active Directory Federation Services (AD FS) authentication.
author: billmath
ms.author: wscontent
ms.date: 05/19/2023
ms.topic: article
---

# Troubleshoot Active Directory Federation Services Idp-initiated sign-on

The Active Directory Federation Services (AD FS) sign-on page can be used to check if authentication is working. This test is done by navigating to the page and signing in. Also, you can use the sign-in page to verify that all SAML 2.0 relying parties are listed.

## Enable the Idp-initiated sign on page

By default, AD FS in Windows 2016 doesn't have the sign on page enabled. To enable the page, you can use the PowerShell command `Set-AdfsProperties`. Use the following procedure to enable the page:

1. Open Windows PowerShell.
1. Enter `Get-AdfsProperties` and hit enter.
1. Verify the **EnableIdpInitiatedSignonPage** property is set to false.

    :::image type="content" source="media/ad-fs-tshoot-initiatedsignon/idp2.png" alt-text="Screenshot showing PowerShell output highlighting that the EnableIdpInitiatedSignonPage property is set to false.":::

1. In PowerShell, enter `Set-AdfsProperties -EnableIdpInitiatedSignonPage $true`.
1. PowerShell doesn't provide a confirmation for the `Set-AdfsProperties` command. To confirm the **EnableIdpInitatedSignonPage** property is set to true, enter the `Get-AdfsProperties` command again and check the value for the property.

    :::image type="content" source="media/ad-fs-tshoot-initiatedsignon/idp4.png" alt-text="Screenshot  PowerShell output highlighting that the EnableIdpInitiatedSignonPage property is set to true.":::

## Test authentication

Use the following procedure to test AD FS authentication with the Idp-initiated sign on page.

1. Open a web browser, and go to the Idp sign on page. Your URL might look like `https://sts.contoso.com/adfs/ls/idpinitiatedsignon.aspx`.
1. You should be prompted to sign-in. Enter your credentials.

    :::image type="content" source="media/ad-fs-tshoot-initiatedsignon/idp5.png" alt-text="Screenshot showing the sign-in page and the dialog box prompting for credentials.":::

1. If the process succeeds, you’re signed in.

## Test authentication with seamless sign in

You can test the seamless sign-in experience by making sure the URL for your AD FS servers is added to the local intranet zone of your internet options. Use the following procedure:

1. On a Windows 10 client, select **Start** and enter *internet options* and select **Internet Options**.

1. Select the **Security** tab, select **Local intranet**, and then select **Sites**.

    :::image type="content" source="media/ad-fs-tshoot-initiatedsignon/idp8.png" alt-text="Screenshot of the Security tab of the Internet Properties dialog box showing the Local Intranet option highlighted.":::

1. Select **Advanced**.

1. Enter your URL and select **Add**. Select **Close**.

    ![A screenshot of the local intranet popup box requesting the URL to be added for authentication.](media/ad-fs-tshoot-initiatedsignon/idp9.png)

1. Select **Ok**. Then select **Ok** to close the internet options.

1. Open a web browser and go to the Idp sign on page. Your URL might look like `https://sts.contoso.com/adfs/ls/idpinitiatedsignon.aspx`.

1. Select the **sign in** button. You should automatically sign in and not be prompted for credentials.

    :::image type="content" source="media/ad-fs-tshoot-initiatedsignon/idp6.png" alt-text="Screenshot of the Sign in page showing that the user wasn't prompted for credentials.":::

## Known Issues

The AD FS sign-on page can't be used to initiate a sign in with a claims provider trust that's configured with a WS-Federation passive endpoint only. Register a relying party such as [ClaimsXRay](https://adfshelp.microsoft.com/ClaimsXray/TokenRequest) to verify that a WS-Federation claims provider trust works as intended.

## Next Steps

- [Troubleshooting AD FS](ad-fs-tshoot-overview.md)
