---
title: Configure the Always On VPN Server Infrastructure
description: This topic provides detailed instructions for deploying Always On VPN in Windows Server 2016.
ms.prod: windows-server-threshold
ms.technology: networking
ms.topic: article
ms.date: 
ms.assetid: d165822d-b65c-40a2-b440-af495ad22f42
manager: brianlic
ms.author: pashort
author: shortpatti
ms.date: 3/4/2018
---

# STEP 3: Configure the Server Infrastructure [this should be renamed to Configure authentication templates and enroll certificates]

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows 10

Configuring the server infrastructure is the first thing you do to deploy Always On VPN. This article provides instructions on how to install and configure the server-side components necessary to support the VPN. The server-side components include configuring:

-   PKI to distribute the certificates used by users, the VPN server, and the
    NPS.

-   RRAS to support IKEv2 connections.

-   NPS to perform authorization for the VPN connections.

## STEP 3.1: Configure certificate autoenrollment in Group Policy

By configuring certificate autoenrollment in Group Policy, VPN users automatically request and retrieve user certificates that authenticate VPN connections. Likewise, this policy allows the NPS to automatically request server authentication certificates.

>[!IMPORTANT]
>You must manually enroll certificates on VPN servers.

1.  On a domain controller, open Group Policy Management.

2.  In the navigation tree, right-click your domain, and click **Create a GPO in this domain, and Link it here**.<br><br>The New GPO dialog box opens.

3.  Type **Autoenrollment Policy** and click **OK**.

4.  In the navigation pane, right-click **Autoenrollment Policy**, and click **Edit**.<br><br>The Group Policy Management Editor opens.

5.  Configure _computer_ certificate autoenrollment by doing the following:

    1.  In the navigation pane, click **Computer onfiguration\\Policies\\Windows Settings\\Security Settings\\Public Key Policies**.
    
    2.  In the details pane, right-click **Certificate Services Client –
        Auto-Enrollment**, and click **Properties**.<br><br>The Certificate Services Client – Auto-Enrollment Properties dialog box opens.
    
    3.  In **Configuration Model**, click **Enabled** and select the following:<ul><li>**Renew expired certificates, update pending certificates, and remove revoked certificates**</li><li>**Update certificates that use certificate templates**</li></ul>
    
    4.  Click **OK** to close the Certificate Services Client - Auto-Enrollment Properties dialog box.

6.  Configure _user_ certificate autoenrollment by doing the following:
    7. In the navigation pane, click **User Configuration\\Policies\\Windows Settings\\Security Settings\\Public Key Policies**.
    8. In the details pane, right-click **Certificate Services Client – Auto-Enrollment**, and click **Properties**.<br><br>The Certificate Services Client – Auto-Enrollment Properties dialog box  opens.
    9. In **Configuration Model**, click **Enabled** and select the following:<ul><li>**Renew expired certificates, update pending certificates, and remove revoked certificates**</li><li>**Update certificates that use certificate templates**</li></ul>
    10. Click **OK**.

7.  Close Group Policy Management.

## STEP 3.2: Create the Users and Servers Groups

After you have configured certificate autoenrollment in Group Policy, you add the following three new Active Directory groups that contain:

-   **Users** allowed to use the VPN to connect to their corporate network.

-   **VPN servers** and **NPS servers** used to restrict certificate requests to their members.

By using a custom group, if you ever want to revoke a user’s VPN access, you can remove that user from the group.

1.  On a domain controller, open Active Directory Users and Computers.

    2.  Configure the **VPN Users** Group by doing the following:
    3. Right-click a container or organizational unit, click **New**, and click **Group**.
    4. In **Group name**, type **VPN Users**, and click **OK**.
    5. Right-click **VPN Users**, and click **Properties**.<br><br>The VPN Users Properties dialog box opens.
    6. Click the **Members** tab and click **Add**.<br><br>The Select Users dialog box opens.
    7. Add all the users who need VPN access and click **OK** to close the Select Users dialog box.
    8. Click **OK** to close the VPN Users Properties dialog box.

3.  Configure the **VPN Servers** and **NPS Servers** Groups by doing the following:
    4. Right-click a container or organizational unit, click **New**, and click **Group**.
    5. In **Group name**, type **VPN Servers**, and click **OK**.
    6. Right-click **VPN Servers**, and click **Properties**.<br><br>The VPN Servers Properties dialog box opens.
    7. d.  Click the **Members** tab and click **Add**.
    8. Click **Object Types**, select the **Computers** check box, and click  **OK**.
    9. In **Enter the object names to select**, type the names of your VPN servers, and click **OK**.
    10. Click **OK** to close the VPN Servers Properties dialog box.

4.  Repeat the previous steps for the NPS Servers group.

5.  Close Active Directory Users and Computers.

## STEP 3.3: (Optional) Create and deploy root certificates with Azure AD
Azure AD uses the VPN certificate to sign certificates issued to Windows 10 clients when authenticating to Azure AD for VPN connectivity. The token that the Windows 10 client requests is a certificate that it then presents to the application, which in this case is the VPN server.

In the Azure portal, you can create two certificates to manage the transition when one certificate is about to expire. When you create a certificate, you can choose whether it is the primary certificate, which is used during the authentication to sign the certificate for the connection.

**Procedure**
1.  Sign in to your [Azure portal](https://portal.azure.com) as a global administrator.
1.  On the left menu, click **Azure Active Directory**.
1.  On the Azure Active Directory page, in the **Manage** section, click **Conditional access**.
1.  On the Conditional access page, in the Manage section, click **VPN connectivity (preview)**.
1.  On the VPN connectivity page, click **New certificate**.
1.  On the New page, perform the following steps:
    1.  For **Select duration**, select  1 or 2 years.<br><br>You can add up to two certificates to manage transitions when the certificate is about to expire. You can choose which one is the primary (the one used during authentication to sign the certificate for connectivity).
    2.  For **Primary**, select **Yes**.
    3.  Click **Create**.
1.  On the VPN connectivity page, click **Download certificate**.<br><br>The **Download base64 certificate** option is available for some configurations that require base64 certificates for deployment.
2. On your VPN server, add the downloaded certificate as a *trusted root CA for VPN authentication*.
3. (Optional) For Windows RRAS-based deployments, on your NPS server, add the root certificate into the *Enterprise NTauth* store by running the following commands:
    1.  `certutil -dspublish <CACERT> RootCA`
    2.  `certutil -dspublish <CACERT> NtAuthCA`
4. On the VPN Server, sign in as **Enterprise Administrator**, open Windows PowerShell as **Administrator**, and run the following commands:
    
    |Command  |Description  |
    |---------|---------|
    |`certutil -dspublish -f VpnCert.cer RootCA`     |Creates two **Microsoft VPN root CA gen 1** containers under the **CN=AIA** and **CN=Certification Authorities** containers, and publishes each root certificate as a value on the _cACertificate_ attribute of both **Microsoft VPN root CA gen 1** containers.         |
    |`certutil -dspublish -f VpnCert.cer NTAuthCA`     |Creates one **CN=NTAuthCertificates** container under the **CN=AIA** and **CN=Certification Authorities** containers, and publishes each root certificate as a value on the _cACertificate_ attribute of the **CN=NTAuthCertificates** container.         |
    |`gpupdate /force`     |Expedites adding the root certificates to the Windows server and client computers. \@Reviewer: since this is part of the "Enroll and validate the user certificate" section        |
     
    These commands publish the root certificate to the **CN=Certification Authorities** and **CN=AIA** containers in the Configuration naming context. Once the CN=Configuration naming context has replicated to all domain controllers in the forest, Windows 10 clients add the root certificate to their trusted root authorities container when Group Policy refreshes. 
1. Verify that the root certificates are present and show as trusted:
    a.  On the VPN server's Start menu, type **pkiview.msc** to open the Enterprise PKI dialog. 
    b. Right-click **Enterprise PKI** and select **Manage AD Containers**.
    c. Verify that each Microsoft VPN root CA gen 1 certificate is present under:
        - NTAuthCertificates
        - AIA Container
        - Certificate Authorities Container

## STEP 3.4: Create the Authentication templates

After you have created the users and servers group, you create one of three authentication templates:

-   **User Authentication template**. Choose Microsoft Platform Crypto Provider to improve the certificate's overall security. Microsoft Platform Crypto Provider lets you use the Trusted Platform Module (TPM) on client computers to secure the certificate. For more information, see [Trusted Platform Module Technology Overview](https://docs.microsoft.com/windows/device-security/tpm/trusted-platform-module-overview).

-   **VPN Server Authentication template**. Adding the IP Security (IPsec) IKE Intermediate application policy allows the server to filter certificates if more than one certificate is available with the Server Authentication extended key usage.

    >[!IMPORTANT] 
    >Because VPN clients access this server from the public Internet, the subject and alternative names are different than the internal server name. As a result, you cannot autoenroll this certificate on VPN servers.

-   **NPS Server Authentication template**. A simple copy of the RAS and IAS Server template secured to the NPS Server group that you created earlier in this section. You will configure this certificate for autoenrollment.

**Procedure:**

1.  On the AD CA, open Certification Authority.

2.  In the navigation pane, right-click **Certificate Templates**, and click **Manage**.<br><br>The Certificate Templates console opens.

3.  **Configure the User Authentication template** by doing the following:
    4. Right-click **User** and click **Duplicate Template**.<br><br>The Properties of New Template dialog box opens.
    5. Click the **General** tab, in **Template display name**, type **VPN User Authentication**, and select the **Publish certificate in Active Directory** check box.
    6. Click the **Security** tab, click **Add**.<br><br>The Select Users, Computers, Service Accounts, or Groups dialog box opens.
    7. Type **VPN Users**, and click **OK**.
    8. In Group or user names, click **VPN Users**.<br><br>The Permissions for VPN Users dialog opens.
    9. In the Allow column, select the **Enroll** and **Autoenroll** check boxes, and click **OK**.
    10. In Group or user names, click **Domain Users**, and click **Remove**.
    11. Click the **Compatibility** tab, in Certification Authority, click **Windows Server 2012 R2,** and click **OK**.<br><br>The Resulting changes dialog box opens.
    12. In Certificate recipient, click **Windows 8.1/Windows Server 2012 R2** and click **OK**<br><br>The Resulting changes dialog box opens.
    13. Click the **Request Handling** tab, clear the **Allow private key to be exported** check box.
    14. Click the **Cryptography** tab, in Provider Category, click **Key Storage Provider**.
    15. Click **Requests must use one of the following providers** and select the **Microsoft Platform Crypto Provider** check box.
    16. (Optional) Click the **Subject Name** tab, if you do not have an email address listed on all user accounts, clear the **Include e-mail name in subject name** and **E-mail name** check boxes.
    17. Click **OK** to save the VPN User Authentication certificate.

4.  **Configure VPN Server Authentication template** by doing the following:
    5. Right-click **RAS and IAS Server**, and click **Duplicate Template**.<br><br>The Properties of New Template dialog box opens.
    6. Click the **General** tab, in **Template display name**, type **VPN Server Authentication**.
    7. Click the **Extensions** tab, click **Application Policies**, and click **Edit**.<br><br>The Edit Application Policies Extension dialog opens.
    8. Click **Add**.<br><br>The Add Application Policy dialog box opens.
    9. Click **IP security IKE intermediate** and click **OK**.
    10. Click **OK**.
    11. Click the **Security** tab and click **Add**.<br><br>The Select Users, Computers, Service Accounts, or Groups dialog box opens.
    12. Type **VPN Servers** and click **OK**.
    13. In Group or user names, click **VPN Servers**.
    14. In Permissions for VPN Servers, in the Allow column, select the **Enroll** check box.
    15. In Group or user names, click **RAS and IAS Servers**, and click **Remove**.
    16. Click the **Subject Name** tab, click Supply in the Request, and click **OK** on the Certificate Templates warning dialog box.
    17. Click **OK** to save the VPN Server certificate template.

5.  **Configure VPN Server Authentication template** by doing the following:

    1.  Right-click **RAS and IAS Server**, and click **Duplicate Template**.<br><br>The Properties of New Template dialog box opens.

    2.  Click the **General** tab, in Template display name, type **NPS Server Authentication**.

    3.  On the **Security** tab, click **Add**.<br><br>The Select Users, Computers, Service Accounts, or Groups dialog box opens.

    5.  Type **NPS Servers**, and click **OK**.

    6.  In Group or user names, click **NPS Servers**.

    7.  In Permissions for NPS Servers, in the Allow column, select the **Enroll** and **Autoenroll** check boxes.

    8.  In Group or user names, click **RAS and IAS Servers**, and click **Remove**.

    9.  Click **OK** to save the NPS Server certificate template.

6.  Close the Certificate Templates console.

7.  In the navigation pane of the Certification Authority snap-in, right-click **Certificate Templates**, click **New**, and click **Certificate Template to Issue**.

    1.  Click **VPN User Authentication**, and click **OK**.

    2.  Click **VPN Server Authentication**, and click **OK**.

    3.  Click **VPN Server Authentication**, and click **OK**.

8.  Close the Certification Authority snap-in.

## STEP 3.5: Enroll and validate the user certificate

Because you are using Group Policy to autoenroll user certificates, you need only update the policy, and Windows 10 automatically enrolls the user account for the correct certificate. You can then validate the certificate in the Certificates console.

**Procedure:**

1.  Sign in to a domain-joined client computer as a member of the **VPN Users** group.

2.  Open **Windows PowerShell (Admin)**, type **gpupdate /force** and press Enter.

3.  On the Start menu, type **certmgr.msc**, and press Enter. <br><br>The Certificates dialog opens.

4.  In the navigation pane, expand **Personal** and click **Certificates**.<br><br>Your certificates appear in the details pane.

5.  Right-click the certificate that has your current domain user name, and click **Open**.<br><br>The Certificate dialog opens.

6.  On the **General** tab, confirm that the date listed under **Valid from** is today’s date.<br><br>If the Valid from date is not today's date, you might have selected the wrong certificate. Therefore, select another certificate before continuing.

7.  Click **OK** to close the Certificate dialog.

8.  Close the Certificates dialog.

## STEP 3.6: Enroll and validate the VPN server certificates

Unlike the user certificate, you must manually enroll the VPN server’s certificate.

**Procedure:**

1.  On the VPN server’s Start menu, type **certlm.msc**, and press Enter.

2.  Right-click **Personal**, click **All Tasks**, and click **Request New Certificate** to start the Certificate Enrollment Wizard.

3.  On the Before You Begin page, click **Next**.

4.  On the Select Certificate Enrollment Policy page, click **Next**.

5.  On the Request Certificates page, select the **VPN Server Authentication** check box.

6.  Under the **VPN Server Authentication** check box, click **More information is required** to open the Certificate Properties dialog box, and complete the following steps:
    7. Under **Subject name**, in **Type**, click **Common Name**.
    8. Under **Subject name**, in **Value**, type the name of the external domain clients will use to connect to the VPN (for example, vpn.contoso.com), and click **Add**.
    9. Under **Alternative Name**, in **Type**, click **DNS**.
    10. Under **Alternative Name**, in **Value**, type the name of the external domain clients will use to connect to the VPN (for example, vpn.contoso.com), and click **Add**.
    11. lick **OK**.

7.  Click **Enroll** and click **Finish**.

9.  In the Certificates snap-in, under **Personal**, click **Certificates**.<br><br>Your certificates are listed in the details pane.

10. Right-click the certificate that has your VPN server’s name, and click  **Open**.

11. On the **General** tab, confirm that the date listed under **Valid from** is today’s date.<br><br>If the Valid from date is not today's date, then select another certificate before continuing.

12. On the **Details** tab, click **Enhanced Key Usage**, and verify that **IP security IKE intermediate** and **Server Authentication** are listed.

13. Click **OK** to close the certificate.

14. Close the Certificates snap-in.

15. Restart the VPN server to allow the group memberships to update.

## STEP 3.7: Validate the NPS certificate

Like the user certificate, the NPS server automatically enrolls its authentication certificate, so all you need to do is validate it.

**Procedure:**

1.  Restart the NPS server.

2.  On the NPS server’s Start menu, type **certlm.msc** and press Enter.

3.  In the Certificates snap-in, under **Personal**, click **Certificates**.<br><br>Your certificates are listed in the details pane.

4.  Right-click the certificate that has your NPS server’s name, and click **Open**.

5.  On the **General** tab, confirm that the date listed under **Valid from** is today’s date.<br><br>If the Valid from date is not today's date, then select another certificate before continuing.

6.  Click **OK** to close the certificate.

7.  Close the Certificates snap-in.

## Next steps

[STEP 4: Configure the Remote Access Server for Always On VPN](vpn-deploy-ras.md). Install and configure the Remote Access server role on the computer or virtual machine (VM) that you want to use as your VPN server.