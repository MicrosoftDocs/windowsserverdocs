---
title: Tutorial - Deploy Always On VPN - Configure Certification Authority templates
description:  Learn how to create certificate templates and enroll and validate certificates for Always On VPN connections.
ms.topic: article
ms.assetid: ad748de2-d175-47bf-b05f-707dc48692cf
ms.author: anaharris
author: anaharris-ms
ms.date:  03/14/2023
---

# Tutorial: Deploy Always On VPN - Configure Certificate Authority templates

- [**Previous:** 1 - Setup infrastructure for Always On VPN](tutorial-aovpn-deploy-setup.md)
- [**Next:** 3 - Configure Always On VPN profile for Windows 10+ clients](tutorial-aovpn-deploy-configure-client.md)

In this part of the Deploy Always On VPN tutorial, you'll create certificate templates and enroll or validate certificates for the Active Directory (AD) groups that you created in [Deploy Always On VPN - Setup the environment](tutorial-aovpn-deploy-setup.md):

You'll create the following templates:

- *User authentication template*. With a user authentication template, you can improve certificate security by selecting upgraded compatibility levels and choosing the Microsoft Platform Crypto Provider. With the Microsoft Platform Crypto Provider, you can use a Trusted Platform Module (TPM) on client computers to secure the certificate. For an overview of TPM, see [Trusted Platform Module Technology Overview](/windows/device-security/tpm/trusted-platform-module-overview).  The user template will be configured for auto-enrollment.

- *VPN server authentication template*. With a VPN server authentication template, you'll add the IP Security (IPsec) IKE Intermediate application policy. The IP Security (IPsec) IKE Intermediate application policy determines how the certificate can be used, it can allow the server to filter certificates if more than one certificate is available. Because VPN clients access this server from the public internet, the subject and alternative names are different than the internal server name. As a result, you won't configure the VPN server certificate for auto-enrollment.

- *NPS server authentication template*. With an NPS server authentication template, you'll copy the standard RAS and IAS Servers template, and scope it for your NPS server. The new NPS server template includes the server authentication application policy.

## Prerequisites

1. Complete [Deploy Always On VPN - Setup the environment](tutorial-aovpn-deploy-setup.md).

## Create the user authentication template

1. On the CA server, which in this tutorial is the domain controller, open the Certification Authority snap-in.

1. In the left pane, right-click **Certificate Templates** and select **Manage**.

1. In the Certificate Templates console, right-click **User** and select **Duplicate Template**.

   >[!WARNING]
   >Do not select **Apply** or **OK** until you have completed entering information for all tabs.  Some choices can only be configured at template creation, if you select these buttons before entering ALL parameters you cannot change them. For example, on the **Cryptography** tab, if *Legacy Cryptographic Storage Provider* shows in the Provider Category field, it becomes disabled, preventing any further change. The only alternative is to delete the template and recreate it.

1. In the Properties of New Template dialog box, on the **General** tab, complete the following steps:

   1. In **Template display name**, enter *VPN User Authentication*.

   2. Clear the **Publish certificate in Active Directory** check box.

1. On the **Security** tab, complete the following steps:

   1. Select **Add**.

   2. On the Select Users, Computers, Service Accounts, or Groups dialog, enter **VPN Users**, then select **OK**.

   3. In **Group or user names**, select **VPN Users**.

   4. In **Permissions for VPN Users**, select the **Enroll** and **Autoenroll** check boxes in the **Allow** column.

      >[!IMPORTANT]
      >Make sure to keep the Read permission check box selected. You'll need Read permissions for enrollment.

   5. In **Group or user names**, select **Domain Users**, then select **Remove**.

1. On the **Compatibility** tab, complete the following steps:

   1. In **Certification Authority**, select *Windows Server 2016*.

   2. On the **Resulting changes** dialog, select **OK**.

   3. In **Certificate recipient**, select *Windows 10/Windows Server 2016*.

   4. On the **Resulting changes** dialog, select **OK**.

1. On the **Request Handling** tab, clear  **Allow private key to be exported** .

1. On the **Cryptography** tab, complete the following steps:

   1. In **Provider Category**, select **Key Storage Provider**.

   2. Select **Requests must use one of the following providers**.

   3. Select both **Microsoft Platform Crypto Provider** and **Microsoft Software Key Storage Provider**.

1. On the **Subject Name** tab, clear the **Include e-mail name in subject name** and **E-mail name** .

1. Select **OK** to save the VPN User Authentication certificate template.

1. Close the Certificate Templates console.

1. In the left pane of the Certification Authority snap-in, right-click **Certificate Templates**, select **New** and then select **Certificate Template to Issue**.

1. Select **VPN User Authentication**, then select **OK**.

## Create the VPN Server authentication template

1. In the left pane of the Certification Authority snap-in, right-click **Certificate Templates** and select **Manage** to open the Certificate Templates console.

1. In the Certificate Templates console, right-click **RAS and IAS Server** and select **Duplicate Template**.

   >[!WARNING]
   >Do not select **Apply** or **OK** until you have completed entering information for all tabs.  Some choices can only be configured at template creation, if you select these buttons before entering ALL parameters you cannot change them. For example, on the **Cryptography** tab, if *Legacy Cryptographic Storage Provider* shows in the Provider Category field, it becomes disabled, preventing any further change. The only alternative is to delete the template and recreate it.

1. On the Properties of New Template dialog box, on the **General** tab, in **Template display name**, enter *VPN Server Authentication*.

1. On the **Extensions** tab, complete the following steps:

    1. Select **Application Policies**, then select **Edit**.

    2. In the **Edit Application Policies Extension** dialog, select **Add**.

    3. On the **Add Application Policy** dialog, select **IP security IKE intermediate**, then select **OK**.

    4. Select **OK** to return to the **Properties of New Template** dialog.

1. On the **Security** tab, complete the following steps:

    1. Select **Add**.

    2. On the **Select Users, Computers, Service Accounts, or Groups** dialog, enter **VPN Servers**, then select **OK**.

    3. In **Group or user names**, select **VPN Servers**.

    4. In **Permissions for VPN Servers**, select **Enroll** in the **Allow** column.

    5. In **Group or user names**, select **RAS and IAS Servers**, then select **Remove**.

1. On the **Subject Name** tab, complete the following steps:

    1. Select **Supply in the Request**.

    2. On the **Certificate Templates** warning dialog box, select **OK**.

1. Select **OK** to save the VPN Server certificate template.

1. Close the Certificate Templates console.

1. In the left pane of the Certificate Authority snap-in, right-click **Certificate Templates**. Select **New** and then select **Certificate Template to Issue**.

1. Select **VPN Server Authentication**, then select **OK**.

1. Reboot the VPN server.

## Create the NPS Server authentication template

1. In the left pane of the Certification Authority snap-in, right-click **Certificate Templates** and select **Manage** to open the Certificate Templates console.

1. In the Certificate Templates console, right-click **RAS and IAS Server** and select **Duplicate Template**.
  
   >[!WARNING]
   >Do not select **Apply** or **OK** until you have completed entering information for all tabs.  Some choices can only be configured at template creation, if you select these buttons before entering ALL parameters you cannot change them. For example, on the **Cryptography** tab, if *Legacy Cryptographic Storage Provider* shows in the Provider Category field, it becomes disabled, preventing any further change. The only alternative is to delete the template and recreate it.

1. On the Properties of New Template dialog box, on the **General** tab, in **Template display name**, enter *NPS Server Authentication*.

1. On the **Security** tab, complete the following steps:

    1. Select **Add**.

    2. On the **Select Users, Computers, Service Accounts, or Groups** dialog, enter **NPS Servers**, then select **OK**.

    3. In **Group or user names**, select **NPS Servers**.

    4. In **Permissions for NPS Servers**, select **Enroll** in the **Allow** column.

    5. In **Group or user names**, select **RAS and IAS Servers**, then select **Remove**.

1. Select **OK** to save the NPS Server certificate template.

1. Close the Certificate Templates console.

1. In the left pane of the Certificate Authority snap-in, right-click **Certificate Templates**. Select **New** and then select **Certificate Template to Issue**.

1. Select **NPS Server Authentication**, then select **OK**.


## Enroll and validate the user certificate

Because you're using Group Policy to autoenroll user certificates, you only need to update the policy, and Windows 10 will automatically enroll the user account for the correct certificate. You can then validate the certificate in the Certificates console.

**To validate the user certificate:**

1. Sign in to the VPN Windows client as the user that you created for the **VPN Users** group.

2. Press Windows key + R, type **gpupdate /force**, and press ENTER.

3. On the Start menu, type **certmgr.msc**, and press ENTER.

4. In the Certificates snap-in, under **Personal**, select **Certificates**. Your certificates appear in the details pane.

5. Right-click the certificate that has your current domain username, and then select **Open**.

6. On the **General** tab, confirm that the date listed under **Valid from** is today's date. If it isn't, you might have selected the wrong certificate.

7. Select **OK**, and close the Certificates snap-in.

### Enroll and validate the VPN server certificate

Unlike the user certificate, you must manually enroll the VPN server's certificate.

**To enroll the VPN server's certificate:**

1. On the VPN server's Start menu, type **certlm.msc** to open the Certificates snap-in, and press ENTER.

1. Right-click **Personal**, select **All Tasks** and then select **Request New Certificate** to start the Certificate Enrollment Wizard.

1. On the Before You Begin page, select **Next**.

1. On the Select Certificate Enrollment Policy page, select **Next**.

1. On the Request Certificates page, select **VPN Server Authentication**.

1. Under the VPN server check box, select **More information is required** to open the Certificate Properties dialog box.

1. Select the **Subject** tab and enter the following information:

    *In the **Subject name** section:*

    1. For **Type** select *Common Name*.  
    1. For **Value**, enter the name of the external domain that clients use to connect to the VPN (for example, vpn.contoso.com).
    1. Select **Add**.

1. Select **OK** to close Certificate Properties.

1. Select **Enroll**.

1. Select **Finish**.

**To validate the VPN server certificate:**

1. In the Certificates snap-in, under **Personal**, select **Certificates**.

    Your listed certificates should appear in the details pane.

1. Right-click the certificate that has your VPN server's name, and then select **Open**.

1. On the **General** tab, confirm that the date listed under **Valid from** is today's date. If it isn't, you might have selected the wrong certificate.

1. On the **Details** tab, select **Enhanced Key Usage**, and verify that **IP security IKE intermediate** and **Server Authentication** display in the list.

1. Select **OK** to close the certificate.

## Enroll and validate the NPS certificate

Because you're using Group Policy to autoenroll NPS certificates, you only need to update the policy, and Windows server will automatically enroll the NPS server for the correct certificate. You can then validate the certificate in the Certificates console.

**To enroll the NPS certificate:**

1. On the NPS server's Start menu, type **certlm.msc** to open the Certificates snap-in, and press ENTER.

1. Right-click **Personal**, select **All Tasks** and then select **Request New Certificate** to start the Certificate Enrollment Wizard.

1. On the Before You Begin page, select **Next**.

1. On the Select Certificate Enrollment Policy page, select **Next**.

1. On the Request Certificates page, select **NPS Server Authentication**.

1. Select **Enroll**.

1. Select **Finish**.

**To validate the NPS certificate:**

1. In the Certificates snap-in, under **Personal**, select **Certificates**.

    Your listed certificates should appear in the details pane.

1. Right-click the certificate that has your NPS server's name, and then select **Open**.

1. On the **General** tab, confirm that the date listed under **Valid from** is today's date. If it isn't, you might have selected the wrong certificate.

1. Select **OK**, and close the Certificates snap-in.

## Next steps

- [Deploy Always On VPN Tutorial: Configure Windows client Always On VPN connections](tutorial-aovpn-deploy-configure-client.md)

- [Troubleshoot Always On VPN](/troubleshoot/windows-server/networking/troubleshoot-always-on-vpn)
