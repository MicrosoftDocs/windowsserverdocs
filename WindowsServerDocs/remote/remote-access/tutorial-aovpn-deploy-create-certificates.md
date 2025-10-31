---
title: "Tutorial: Configure Certificate Authority Templates for Always On VPN"
description: Learn how to create certificate templates and enroll and validate certificates for users, VPN server, and NPS server to use with Always On VPN connections.
ms.topic: tutorial
ms.author: daknappe
author: dknappettmsft
ms.date: 05/08/2025
---

# Tutorial: Configure Certificate Authority templates for Always On VPN

This tutorial shows you how to configure the Certificate Authority (CA) templates for the Always On VPN deployment. It continues the series to deploy Always On VPN in a sample environment. Previously in the series, you [deployed a sample infrastructure](tutorial-aovpn-deploy-setup.md).

The CA templates are used to issue certificates to the VPN server, NPS server, and users. The certificates are used to authenticate the VPN server and NPS server to clients, and to authenticate users to the VPN server.

In this tutorial, you:

> [!div class="checklist"]
>
> - Create a user authentication template.
> - Create a VPN server authentication template.
> - Create a NPS server authentication template.
> - Enroll and validate the user certificate.
> - Enroll and validate the VPN server certificate.
> - Enroll and validate the NPS server certificate.

Here's a description of the different templates:

| Template | Description |
|---|---|
| **User authentication template** | This template is used to issue user certificates for VPN clients. The user certificate is used to authenticate the user to the VPN server.<br /><br />With a user authentication template, you can improve certificate security by selecting upgraded compatibility levels and choosing the Microsoft Platform Crypto Provider. With the Microsoft Platform Crypto Provider, you can use a [Trusted Platform Module (TPM)](/windows/device-security/tpm/trusted-platform-module-overview) on client computers to secure the certificate. The user template is configured for autoenrollment. |
| **VPN server authentication template** | This template is used to issue a server certificate for the VPN server. The server certificate is used to authenticate the VPN server to the client.<br /><br />With a VPN server authentication template, you add the IP Security (IPsec) IKE Intermediate application policy. The IP Security (IPsec) IKE Intermediate application policy determines how the certificate can be used, it can allow the server to filter certificates if more than one certificate is available. Because VPN clients access this server from the public internet, the subject and alternative names are different than the internal server name. As a result, you don't configure the VPN server certificate for autoenrollment. |
| **NPS server authentication template** | This template is used to issue a server certificate for the NPS server. The NPS server certificate is used to authenticate the NPS server to the VPN server.<br /><br />With an NPS server authentication template, you copy the standard RAS and IAS Servers template, and scope it for your NPS server. The new NPS server template includes the server authentication application policy. |

To learn more about Always On VPN, including supported integrations, security and connectivity features, see [Always On VPN Overview](overview-always-on-vpn.md).

## Prerequisites

To complete the steps in this tutorial, you need:

- To complete all the steps in the previous tutorial: [Deploy Always On VPN Infrastructure](tutorial-aovpn-deploy-setup.md).

- A Windows client device running a supported version of Windows to connect to Always On VPN that is joined to the Active Directory domain.

## Create the user authentication template

1. On the server with Active Directory Certificate Services installed, which in this tutorial is the domain controller, open the Certification Authority snap-in.

1. In the left pane, right-click **Certificate Templates** and select **Manage**.

1. In the Certificate Templates console, right-click **User** and select **Duplicate Template**. Don't select **Apply** or **OK** until you finish entering information for all tabs. Some choices can only be configured at template creation; if you select these buttons before entering all parameters you can't change them, otherwise you need to delete the template and recreate it.

1. In the Properties of **New Template** dialog box, on the **General** tab, complete the following steps:

   1. In **Template display name**, enter **VPN User Authentication**.

   1. Clear the **Publish certificate in Active Directory** check box.

1. On the **Security** tab, complete the following steps:

   1. Select **Add**.

   1. On the Select Users, Computers, Service Accounts, or Groups dialog, enter **VPN Users**, then select **OK**.

   1. In **Group or user names**, select **VPN Users**.

   1. In **Permissions for VPN Users**, select the **Enroll** and **Autoenroll** check boxes in the **Allow** column.

      > [!IMPORTANT]
      > Make sure to keep the **Read** permission check box selected. You need Read permissions for enrollment.

   1. In **Group or user names**, select **Domain Users**, then select **Remove**.

1. On the **Compatibility** tab, complete the following steps:

   1. In **Certification Authority**, select *Windows Server 2016*.

   1. On the **Resulting changes** dialog, select **OK**.

   1. In **Certificate recipient**, select *Windows 10/Windows Server 2016*.

   1. On the **Resulting changes** dialog, select **OK**.

1. On the **Request Handling** tab, clear  **Allow private key to be exported**.

1. On the **Cryptography** tab, complete the following steps:

   1. In **Provider Category**, select **Key Storage Provider**.

   1. Select **Requests must use one of the following providers**.

   1. Select both **Microsoft Platform Crypto Provider** and **Microsoft Software Key Storage Provider**.

1. On the **Subject Name** tab, clear the **Include e-mail name in subject name** and **E-mail name**.

1. Select **OK** to save the VPN User Authentication certificate template.

1. Close the Certificate Templates console.

1. In the left pane of the Certification Authority snap-in, right-click **Certificate Templates**, select **New** and then select **Certificate Template to Issue**.

1. Select **VPN User Authentication**, then select **OK**.

## Create the VPN Server authentication template

1. In the left pane of the Certification Authority snap-in, right-click **Certificate Templates** and select **Manage** to open the Certificate Templates console.

1. In the Certificate Templates console, right-click **RAS and IAS Server** and select **Duplicate Template**. Don't select **Apply** or **OK** until you finish entering information for all tabs. Some choices can only be configured at template creation; if you select these buttons before entering all parameters you can't change them, otherwise you need to delete the template and recreate it.

1. On the Properties of **New Template** dialog box, on the **General** tab, in **Template display name**, enter **VPN Server Authentication**.

1. On the **Extensions** tab, complete the following steps:

   1. Select **Application Policies**, then select **Edit**.

   1. In the **Edit Application Policies Extension** dialog, select **Add**.

   1. On the **Add Application Policy** dialog, select **IP security IKE intermediate**, then select **OK**.

   1. Select **OK** to return to the **Properties of New Template** dialog.

1. On the **Security** tab, complete the following steps:

   1. Select **Add**.

   1. On the **Select Users, Computers, Service Accounts, or Groups** dialog, enter **VPN Servers**, then select **OK**.

   1. In **Group or user names**, select **VPN Servers**.

   1. In **Permissions for VPN Servers**, select **Enroll** in the **Allow** column.

   1. In **Group or user names**, select **RAS and IAS Servers**, then select **Remove**.

1. On the **Subject Name** tab, complete the following steps:

    1. Select **Supply in the Request**.

    1. On the **Certificate Templates** warning dialog box, select **OK**.

1. Select **OK** to save the VPN Server certificate template.

1. Close the Certificate Templates console.

1. In the left pane of the Certificate Authority snap-in, right-click **Certificate Templates**. Select **New** and then select **Certificate Template to Issue**.

1. Select **VPN Server Authentication**, then select **OK**.

1. Restart the VPN server.

## Create the NPS Server authentication template

1. In the left pane of the Certification Authority snap-in, right-click **Certificate Templates** and select **Manage** to open the Certificate Templates console.

1. In the Certificate Templates console, right-click **RAS and IAS Server** and select **Duplicate Template**. Don't select **Apply** or **OK** until you finish entering information for all tabs. Some choices can only be configured at template creation; if you select these buttons before entering all parameters you can't change them, otherwise you need to delete the template and recreate it.
  
1. On the Properties of New Template dialog box, on the **General** tab, in **Template display name**, enter *NPS Server Authentication*.

1. On the **Security** tab, complete the following steps:

   1. Select **Add**.

   1. On the **Select Users, Computers, Service Accounts, or Groups** dialog, enter **NPS Servers**, then select **OK**.

   1. In **Group or user names**, select **NPS Servers**.

   1. In **Permissions for NPS Servers**, select **Enroll** in the **Allow** column.

   1. In **Group or user names**, select **RAS and IAS Servers**, then select **Remove**.

1. Select **OK** to save the NPS Server certificate template.

1. Close the Certificate Templates console.

1. In the left pane of the Certificate Authority snap-in, right-click **Certificate Templates**. Select **New** and then select **Certificate Template to Issue**.

1. Select **NPS Server Authentication**, then select **OK**.

Now you created the certificate templates you need to enroll and validate the certificates.

## Enroll and validate the user certificate

Group Policy is configured to autoenroll user certificates, so once the policy is applied to Windows client devices, they automatically enroll the user account for the correct certificate. You can then validate the certificate in the **Certificates** console on the local device.

To check the policy is applied and the certificate is enrolled:

1. Sign in to the Windows client device as the user that you created for the **VPN Users** group.

1. Open Command Prompt and run the following command. Alternatively, restart the Windows client device.

   ```cmd
   gpupdate /force
   ```

1. On the Start menu, type **certmgr.msc**, and press ENTER.

1. In the Certificates snap-in, under **Personal**, select **Certificates**. Your certificates appear in the details pane.

1. Right-click the certificate that has your current domain username, and then select **Open**.

1. On the **General** tab, confirm that the date listed under **Valid from** is today's date. If it isn't, you might have selected the wrong certificate.

1. Select **OK**, and close the Certificates snap-in.

## Enroll and validate the VPN server certificate

To enroll the VPN server's certificate:

1. On the VPN server's Start menu, type **certlm.msc** to open the Certificates snap-in, and press ENTER.

1. Right-click **Personal**, select **All Tasks** and then select **Request New Certificate** to start the Certificate Enrollment Wizard.

1. On the Before You Begin page, select **Next**.

1. On the Select Certificate Enrollment Policy page, select **Next**.

1. On the Request Certificates page, select **VPN Server Authentication**.

1. Under the VPN server check box, select **More information is required** to open the Certificate Properties dialog box.

1. Select the **Subject** tab and enter the following information in the **Subject name** section:

   1. For **Type** select *Common Name*.  
   1. For **Value**, enter the name of the external domain that clients use to connect to the VPN (for example, vpn.contoso.com).
   1. Select **Add**.

1. Select **OK** to close Certificate Properties.

1. Select **Enroll**.

1. Select **Finish**.

To validate the VPN server certificate:

1. In the Certificates snap-in, under **Personal**, select **Certificates**. Your listed certificates should appear in the details pane.

1. Right-click the certificate that has your VPN server's name, and then select **Open**.

1. On the **General** tab, confirm that the date listed under **Valid from** is today's date. If it isn't, you might have selected the wrong certificate.

1. On the **Details** tab, select **Enhanced Key Usage**, and verify that **IP security IKE intermediate** and **Server Authentication** display in the list.

1. Select **OK** to close the certificate.

## Enroll and validate the NPS certificate

To enroll the NPS certificate:

1. On the NPS server's Start menu, type **certlm.msc** to open the Certificates snap-in, and press ENTER.

1. Right-click **Personal**, select **All Tasks** and then select **Request New Certificate** to start the Certificate Enrollment Wizard.

1. On the Before You Begin page, select **Next**.

1. On the Select Certificate Enrollment Policy page, select **Next**.

1. On the Request Certificates page, select **NPS Server Authentication**.

1. Select **Enroll**.

1. Select **Finish**.

To validate the NPS certificate:

1. In the Certificates snap-in, under **Personal**, select **Certificates**. Your listed certificates should appear in the details pane.

1. Right-click the certificate that has your NPS server's name, and then select **Open**.

1. On the **General** tab, confirm that the date listed under **Valid from** is today's date. If it isn't, you might have selected the wrong certificate.

1. Select **OK**, and close the Certificates snap-in.

## Next step

Now you created the certificate templates and enrolled the certificates, you can configure a Windows client device to use the Always On VPN connection.

> [!div class="nextstepaction"]
> [Tutorial: Create an Always On VPN connection for Windows client devices](tutorial-aovpn-deploy-configure-client.md)
