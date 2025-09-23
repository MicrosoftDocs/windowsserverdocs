---
title: Troubleshoot AD FS IdP-Initiated Sign-In
description: Learn how to use the sign-in page to troubleshoot Active Directory Federation Services (AD FS) authentication.
ms.date: 05/19/2023
ms.topic: troubleshooting-general
ms.custom: sfi-image-nochange
---

# Troubleshoot AD FS IdP-initiated sign-in

You can use the Active Directory Federation Services (AD FS) sign-in page to check if authentication is working. To do this test, you go to the page and sign in. Also, you can use the sign-in page to verify that all SAML 2.0 relying parties are listed.

## Enable the IdP-initiated sign-in page

By default, AD FS in Windows 2016 doesn't have the sign-in page enabled. To enable the page, use the PowerShell command `Set-AdfsProperties`. Use the following procedure to enable the page:

1. Open Windows PowerShell.
1. Enter `Get-AdfsProperties`.
1. Verify that the `EnableIdpInitiatedSignonPage` property is set to `False`.

    :::image type="content" source="media/ad-fs-tshoot-initiatedsignon/idp2.png" alt-text="Screenshot that shows PowerShell output highlighting that the EnableIdpInitiatedSignonPage property is set to false.":::

1. In PowerShell, enter `Set-AdfsProperties -EnableIdpInitiatedSignonPage $true`.
1. PowerShell doesn't provide a confirmation for the `Set-AdfsProperties` command. To confirm that the `EnableIdpInitatedSignonPage` property is set to `True`, enter the `Get-AdfsProperties` command again and check the value for the property.

    :::image type="content" source="media/ad-fs-tshoot-initiatedsignon/idp4.png" alt-text="Screenshot that shows PowerShell output highlighting that the EnableIdpInitiatedSignonPage property is set to True.":::

## Test authentication

Use the following procedure to test AD FS authentication with the Identity Provider (IdP)-initiated sign-in page.

1. Open a web browser, and go to the IdP sign-in page. Your URL might look like `https://sts.contoso.com/adfs/ls/idpinitiatedsignon.aspx`.
1. You're prompted to sign in. Enter your credentials.

    :::image type="content" source="media/ad-fs-tshoot-initiatedsignon/idp5.png" alt-text="Screenshot that shows the sign-in page and the dialog that prompts for credentials.":::

If the process succeeds, you're signed in.

## Test authentication with seamless sign-in

You can test the seamless sign-in experience by making sure that the URL for your AD FS servers is added to the local intranet zone of your internet options. Use the following procedure:

1. On a Windows 10 client, select **Start**, enter **internet options**, and select **Internet Options**.

1. Select the **Security** tab, and then select **Local intranet** > **Sites**.

    :::image type="content" source="media/ad-fs-tshoot-initiatedsignon/idp8.png" alt-text="Screenshot that shows the Security tab of the Internet Properties dialog that shows the Local intranet option highlighted.":::

1. Select **Advanced**.

1. Enter your URL, and then select **Add** > **Close**.

    ![Screenshot that shows the local intranet popup box requesting the URL to be added for authentication.](media/ad-fs-tshoot-initiatedsignon/idp9.png)

1. Select **OK**. Then select **OK** to close the internet options.

1. Open a web browser and go to the IdP sign-in page. Your URL might look like `https://sts.contoso.com/adfs/ls/idpinitiatedsignon.aspx`.

1. Select **Sign in**. You should automatically sign in and not be prompted for credentials.

    :::image type="content" source="media/ad-fs-tshoot-initiatedsignon/idp6.png" alt-text="Screenshot that shows the sign-in page showing that the user wasn't prompted for credentials.":::

## Known issues

The AD FS sign-in page can't be used to initiate a sign-in with a claims provider trust that's configured with a WS-Federation passive endpoint only.

## Related content

- [Troubleshooting AD FS](ad-fs-tshoot-overview.md)
