---
title: Deploy Always On VPN - Configure Certification Authority templates
description: Learn how to create, enroll, and validate Certification Authority templates for Active Directory (AD) groups.
ms.topic: article
ms.assetid: ad748de2-d175-47bf-b05f-707dc48692cf
ms.author: anaharris
author: anaharris-ms
ms.date: 12/02/2022
---

# Deploy Always On VPN: Configure Certificate Authority templates

In this part of the Deploy Always On VPN tutorial, you'll create certificate templates and enroll or validate certificates for the Active Directory (AD) groups that you created in [Deploy Always On VPN - Setup the environment](tutorial-aovpn-deploy-setup.md):

You'll create the following templates:

- *User authentication template*. With a user authentication template, you can improve certificate security by selecting upgraded compatibility levels and choosing the Microsoft Platform Crypto Provider. With the Microsoft Platform Crypto Provider, you can use a Trusted Platform Module (TPM) on client computers to secure the certificate. For an overview of TPM, see [Trusted Platform Module Technology Overview](/windows/device-security/tpm/trusted-platform-module-overview).

- *VPN server authentication template*. With a VPN server authentication template, you can add the IP Security (IPsec) IKE Intermediate application policy to allows the server to filter certificates if more than one certificate is available with the server authentication extended key usage. Because VPN clients access this server from the public internet, the subject and alternative names are different than the internal server name. As a result, you won't configure the VPN server certificate for autoenrollment.

- *NPS server authentication template*. The NPS server authentication template is a simple copy of the RAS and IAS Server template secured to the NPS Server group that you created earlier in this section. You'll configure the NPS server certificate for autoenrollment.

>[!NOTE]
>Both user and NPS server authentication templates have been configured for autoenrollment and so only require verification. The VPN server template will be enrolled manually.

## Prerequisites

Before attempting the steps in this tutorial, you'll need to complete [Deploy Always On VPN - Setup the environment](tutorial-aovpn-deploy-setup.md).

## Create the user authentication template

1. On the CA server, open the Certification Authority snap-in.

2. In the left pane, right-click **Certificate Templates** and select **Manage**.

3. In the Certificate Templates console, right-click **User** and select **Duplicate Template**.

   >[!WARNING]
   >Do not select **Apply** or **OK** at any time prior to step 10.  If you select these buttons before entering ALL parameters, many choices become fixed and no longer editable. For example, on the **Cryptography** tab, if _Legacy Cryptographic Storage Provider_shows in the Provider Category field, it becomes disabled, preventing any further change. The only alternative is to delete the template and recreate it.

4. In the Properties of New Template dialog box, on the **General** tab, complete the following steps:

   1. In **Template display name**, type **VPN User Authentication**.

   2. Clear the **Publish certificate in Active Directory** check box.

5. On the **Security** tab, complete the following steps:

   1. Select **Add**.

   2. On the Select Users, Computers, Service Accounts, or Groups dialog box, enter **VPN Users**, then select **OK**.

   3. In **Group or user names**, select **VPN Users**.

   4. In **Permissions for VPN Users**, select the **Enroll** and **Autoenroll** check boxes in the **Allow** column.

      >[!IMPORTANT]
      >Make sure to keep the Read check box selected. You'll need Read permissions for enrollment.

   5. In **Group or user names**, select **Domain Users**, then select **Remove**.

6. On the **Compatibility** tab, complete the following steps:

   1. In **Certification Authority**, select **Windows Server 2016**.

   2. On the **Resulting changes** dialog box, select **OK**.

   3. In **Certificate recipient**, select **Windows 10/Windows Server 2016**.

   4. On the **Resulting changes** dialog box, select **OK**.

7. On the **Request Handling** tab, clear the **Allow private key to be exported** check box.

8. On the **Cryptography** tab, complete the following steps:

   1. In **Provider Category**, select **Key Storage Provider**.

   2. Select **Requests must use one of the following providers**.

   3. Select the **Microsoft Platform Crypto Provider** check box.

9. On the **Subject Name** tab, if you don't have an email address listed on all user accounts, clear the **Include e-mail name in subject name** and **E-mail name** check boxes.

10. Select **OK** to save the VPN User Authentication certificate template.

11. Close the Certificate Templates console.

12. In the navigation pane of the Certification Authority snap-in, right-click **Certificate Templates**, select **New** and then select **Certificate Template to Issue**.

13. Select **VPN User Authentication**, then select **OK**.

14. Close the the Certification Authority snap-in.

## Create the VPN Server authentication template

1. On the CA, open the Certification Authority snap-in.

2. In the left pane, right-click **Certificate Templates** and select **Manage**.

3. In the Certificate Templates console, right-click **RAS and IAS Server** and select **Duplicate Template**.

   >[!WARNING]
   >Do not select **Apply** or **OK** at any time prior to step 10.  If you select these buttons before entering ALL parameters, many choices become fixed and no longer editable. For example, on the **Cryptography** tab, if _Legacy Cryptographic Storage Provider_shows in the Provider Category field, it becomes disabled, preventing any further change. The only alternative is to delete the template and recreate it.

4. On the Properties of New Template dialog box, on the **General** tab, in **Template display name**, enter a descriptive name for the VPN server, for example, *VPN Server Authentication* or *RADIUS Server*.

5. On the **Extensions** tab, complete the following steps:

    1. Select **Application Policies**, then select **Edit**.

    2. In the **Edit Application Policies Extension** dialog box, select **Add**.

    3. On the **Add Application Policy** dialog box, select **IP security IKE intermediate**, then select **OK**.

        >[!TIP]
        >Add IP security IKE intermediate to the EKU in scenarios where more than one server authentication certificate exists on the VPN server. When IP security IKE intermediate is present, IPSec only uses the certificate with both EKU options. Without this, IKEv2 authentication could fail with Error 13801: IKE authentication credentials are unacceptable.

    4. Select **OK** to return to the **Properties of New Template** dialog box.

6. On the **Security** tab, complete the following steps:

    1. Select **Add**.

    2. On the **Select Users, Computers, Service Accounts, or Groups** dialog box, enter **VPN Servers**, then select **OK**.

    3. In **Group or user names**, select **VPN Servers**.

    4. In **Permissions for VPN Servers**, select the **Enroll** check box in the **Allow** column.

    5. In **Group or user names**, select **RAS and IAS Servers**, then select **Remove**.

7. On the **Subject Name** tab, complete the following steps:

    1. Select **Supply in the Request**.

    2. On the **Certificate Templates** warning dialog box, select **OK**.

8. (Optional) If you're configuring conditional access for VPN connectivity, select the **Request Handling** tab, then select **Allow private key to be exported**.

9. Select **OK** to save the VPN Server certificate template.

10. Close the Certificate Templates console.

11. Restart the Certificate Authority services. You can restart the CA service by running the following command in CMD:

    ```dos
    net stop "certsvc"
    net start "certsvc"
    ```

12. One the CA, re-open Certificate Authority.

13. In the left pane, right-click **Certificate Templates**. Select **New** and then select **Certificate Template to Issue**.

14. Select the name you chose in step 4 above, and click **OK**.

15. Close the Certification Authority snap-in.

## Create the NPS Server authentication template

1. On the CA, open the Certification Authority snap-in.

2. In the left pane, right-click **Certificate Templates** and select **Manage**.

3. In the Certificate Templates console, right-click **RAS and IAS Server**, and select **Duplicate Template**.

   >[!WARNING]
   >Do not select **Apply** or **OK** at any time prior to step 10.  If you select these buttons before entering ALL parameters, many choices become fixed and no longer editable. For example, on the **Cryptography** tab, if _Legacy Cryptographic Storage Provider_shows in the Provider Category field, it becomes disabled, preventing any further change. The only alternative is to delete the template and recreate it.

4. In the Properties of New Template dialog box, on the **General** tab, in **Template display name**, enter *NPS Server Authentication*.

5. On the **Security** tab, complete the following steps:

    1. Select **Add**.

    2. On the **Select Users, Computers, Service Accounts, or Groups** dialog box, enter **NPS Servers**, then select **OK**.

    3. In **Group or user names**, select **NPS Servers**.

    4. In **Permissions for NPS Servers**, select the **Enroll** and **Autoenroll** check boxes in the **Allow** column.

    5. In **Group or user names**, select **RAS and IAS Servers**, then select **Remove**.

6. Select **OK** to save the NPS Server certificate template.

7. Close the Certificate Templates console.

8. In the left pane of the Certification Authority snap-in, right-click **Certificate Templates**, select **New** and then select **Certificate Template to Issue**.

9. Select **NPS Server Authentication**, and select **OK**.

10. Close the Certification Authority snap-in.

11. Restart the VPN and NPS server.

## Enroll and validate certificates

### Validate the user certificate

Because we're using Group Policy to autoenroll user certificates, Windows 10 will automatically enroll the user accounts for the correct certificates. Once enrolled, you can then validate the certificates in the Certificates console.

>[!IMPORTANT]
>Microsoft Platform Crypto Provider" requires a TPM chip. If, while trying to manually enroll a certificate on a VM, you get the following error: "Cannot find a valid CSP in the local machine" do ensure that "Microsoft Software Key Storage Provider" is second in order after "Microsoft Platform Crypto Provider" in the Cryptography tab of the certificate Properties.

1. Sign in to a domain-joined client computer as a member of the **VPN Users** group.

2. Press Windows key + R. Type **gpupdate /force**, and press Enter key.

3. On the Start menu, type **certmgr.msc** to open the Certificates snap-in, and press Enter key.

4. In the Certificates snap-in, select **Personal** **>** **Certificates**. Your certificates should appear in the details pane.

5. Right-click the certificate that has your current domain username, and then select **Open**.

6. On the **General** tab, confirm that the date listed under **Valid from** is today's date. If it isn't, you might have selected the wrong certificate.

7. Select **OK**, and close the Certificates snap-in.

### Enroll and validate the VPN server certificates

Unlike the user certificate, you must manually enroll the VPN server's certificate. After you've enrolled it, you'll validate it by using the same process as for the user certificate. 

>[!NOTE]
>You might need to restart the VPN and NPS servers to allow them to update their group memberships before you can complete these steps.

1. On the VPN server's Start menu, type **certlm.msc** to open the Certificates snap-in, and press Enter.

2. Right-click **Personal**, select **All Tasks** and then select **Request New Certificate** to start the Certificate Enrollment Wizard.

3. On the Before You Begin page, select **Next**.

4. On the Select Certificate Enrollment Policy page, select **Next**.

5. On the Request Certificates page, select **VPN Server Authentication**.

6. Under the VPN server check box, select **More information is required** to open the Certificate Properties dialog box and complete the following steps:

    1. Select the **Subject** tab. In the **Subject name** section, for **Type** select *Common Name*. 

    2. In the **Subject name** section, for **Value**, enter the name of the external domain that clients use to connect to the VPN(for example, vpn.contoso.com). Then, select **Add**.

    3. In the **Alternative Name** section, for **Type**, select *DNS*.

    4. In the **Alternative Name** section, for **Value**, enter all server names that clients use to connect to the VPN, for example, vpn.contoso.com, vpn, 132.64.86.2.

    5. Select **Add** after entering each name.

    6. Select **OK** when finished.

7. Select **Enroll**.

8. Select **Finish**.

9. In the Certificates snap-in, under **Personal**, select **Certificates**.

    Your listed certificates appear in the details pane.

10. Right-click the certificate that has your VPN server's name, and then select **Open**.

11. On the **General** tab, confirm that the date listed under **Valid from** is today's date. If it isn't, you might have selected the incorrect certificate.

12. On the **Details** tab, select **Enhanced Key Usage**, and verify that **IP security IKE intermediate** and **Server Authentication** display in the list.

13. Select **OK** to close the certificate.

14. Close the Certificates snap-in.

### Validate the NPS server certificate

Like the user certificate, the NPS server automatically enrolls its authentication certificate, so all you need to do is validate it.

1. Restart the NPS server.

2. On the NPS server's Start menu, type **certlm.msc** to open the Certificates snap-in, and press Enter.

3. In the Certificates snap-in, under **Personal**, select **Certificates**.

    Your listed certificates should appear in the details pane.

4. Right-click the NPS Server Authentication certificate, and then select **Open**.

5. On the **General** tab, confirm that the date listed under **Valid from** is today's date. If it isn't, you might have selected the incorrect certificate.

6. Select **OK** to close the certificate.

7. Close the Certificates snap-in.

## Next steps

- [Deploy Always On VPN Tutorial: Configure Windows 10 Always On VPN client connections](tutorial-aovpn-deploy-configure-client.md)