---
title: Configure the Always On VPN Server Infrastructure
description: This topic provides detailed instructions for deploying Always On VPN in Windows Server 2016.
ms.prod: windows-server-threshold
ms.technology: networking
ms.topic: article
ms.assetid: 8223117a-96f3-4ae9-96e8-67a3a2b8d462
manager: brianlic
ms.author: jamesmci
author: jamesmci
---
# Configure the Server Infrastructure

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows 10

In this section, you install and configure the server-side components necessary to support the VPN, including configuring PKI to distribute the certificates used by users, the VPN server, and the NPS server; configuring RRAS to support IKEv2 connections; and configuring the NPS server to perform authorization for the VPN connections.

## Configure certificate autoenrollment in Group Policy

Configure Group Policy on the domain controller so that domain members automatically request user and computer certificates. Doing so allows VPN users to automatically request and retrieve user certificates that authenticate VPN connections. Likewise, this policy allows NPS servers to automatically request server authentication certificates. (You will manually enroll certificates on VPN servers.)

**To enable certificate autoenrollment in Group Policy**

1. On a domain controller, open Group Policy Management.

2. In the navigation pane, right-click your domain (e.g., corp.contoso.com), and click **Create a GPO in this domain, and Link it here**.

3. On the New GPO dialog box, type **Autoenrollment Policy**, and click **OK**.

4. In the navigation pane, right-click **Autoenrollment Policy**, and click **Edit**.

5. In the Group Policy Management Editor, complete the following steps to configure computer certificate autoenrollment:

    1. In the navigation pane, click **Computer Configuration\\Policies\\Windows Settings\\Security Settings\\Public Key Policies**.

    2. In the details pane, right-click **Certificate Services Client – Auto-Enrollment**, and click **Properties**.

    3. On the Certificate Services Client – Auto-Enrollment Properties dialog box, in **Configuration Model**, click **Enabled**.

    4. Select **Renew expired certificates, update pending certificates, and remove revoked certificates** and **Update certificates that use certificate templates**.

    5.  Click **OK**.

6.  In the Group Policy Management Editor, complete the following steps to configure user certificate autoenrollment:

    1.  In the navigation pane, click **User Configuration\\Policies\\Windows Settings\\Security Settings\\Public Key Policies**.

    2.  In the details pane, right-click **Certificate Services Client – Auto-Enrollment**, and click **Properties**.

    3.  On the Certificate Services Client – Auto-Enrollment Properties dialog box, in **Configuration Model**, click **Enabled**.

    4.  Select **Renew expired certificates, update pending certificates, and remove revoked certificates** and **Update certificates that use certificate templates**.

    5.  Click **OK**.

    6.  Close the Group Policy Management Editor.

7.  Close Group Policy Management.

## Create the VPN Users, VPN Servers, and NPS Servers Groups

With this step you add a new Active Directory group that contains the users allowed to use the VPN to connect to your organization network. This group serves two purposes:

- It defines which users are allowed to autoenroll for the user certificates the VPN requires.

- It defines which users the NPS authorizes for VPN access.

By using a custom group, if you ever want to revoke a user’s VPN access, you can simply remove that user from the group.

You will also add a group containing VPN servers and another group containing NPS servers. You use these groups to restrict certificate requests to their members. 

**To configure the VPN Users group**

1.  On a domain controller, open Active Directory Users and Computers.

2.  Right-click a container or organizational unit, click **New**, and click **Group**.

3.  In **Group name**, type **VPN Users**, and click **OK**.

4.  Right-click **VPN Users**, and click **Properties**.

5.  On the **Members** tab of the VPN Users Properties dialog box, click **Add**.

6.  On the Select Users dialog box, add all the users who need VPN access, and click **OK**.

7.  Close Active Directory Users and Computers.

**To configure the VPN Servers and NPS Servers groups**

1.  On a domain controller, open Active Directory Users and Computers.

2.  Right-click a container or organizational unit, click **New**, and click **Group**.

3.  In **Group name**, type **VPN Servers**, and click **OK**.

4.  Right-click **VPN Servers**, and click **Properties**.

5.  On the **Members** tab of the VPN Servers Properties dialog box, click **Add**.

6.  Click **Object Types**, select the **Computers** check box, and click **OK**.

7.  In **Enter the object names to select**, type the names of your VPN servers, and click **OK**.

8.  Click **OK** to close the VPN Servers Properties dialog box.

9.  Repeat the previous steps for the NPS Servers group.

10. Close Active Directory Users and Computers.

## Create the User Authentication template
Next, configure a custom client–server authentication template. This template is required because you want to improve the certificate’s overall security by selecting upgraded compatibility levels and choosing the Microsoft Platform Crypto Provider. This last change lets you use the TPM on the client computers to secure the certificate. For an overview of the TPM, see [Trusted Platform Module Technology Overview](https://docs.microsoft.com/windows/device-security/tpm/trusted-platform-module-overview).

**To configure the User Authentication template**

1.  On the CA, open Certification Authority.

2.  In the navigation pane, right-click **Certificate Templates**, and click **Manage**.

3.  In the Certificate Templates console, right-click **User**, and click **Duplicate Template**.

4.  On the Properties of New Template dialog box, on the **General** tab, complete the following steps:

    1.  In **Template display name**, type **VPN User Authentication**.

    2.  Clear the **Publish certificate in Active Directory** check box.

5.  On the **Security** tab, complete the following steps:

    1.  Click **Add**.

    2.  On the Select Users, Computers, Service Accounts, or Groups dialog box, type **VPN Users**, and click **OK**.

    3.  In **Group or user names**, click **VPN Users**.

    4.  In **Permissions for VPN Users**, select the **Enroll** and **Autoenroll** check boxes in the **Allow** column.

    5.  In **Group or user names**, click **Domain Users**, and click **Remove**.

6.  On the **Compatibility** tab, complete the following steps:

    1.  In **Certification Authority**, click **Windows Server 2012 R2**.

    2.  On the **Resulting changes** dialog box, click **OK**.

    3.  In **Certificate recipient**, click **Windows 8.1/Windows Server 2012 R2**.

    4.  On the **Resulting changes** dialog box, click **OK**.

7.  On the **Request Handling** tab, clear the **Allow private key to be exported** check box.

8.  On the **Cryptography** tab, complete the following steps:

    1.  In **Provider Category**, click **Key Storage Provider**.

    2.  Click **Requests must use one of the following providers**.

    3.  Select the **Microsoft Platform Crypto Provider** check box.

9.  On the **Subject Name** tab, if you don’t have an email address listed on all user accounts, clear the **Include e-mail name in subject name** and **E-mail name** check boxes.

10. Click **OK** to save the VPN User Authentication certificate template.

11. Close the Certificate Templates console.

12. In navigation pane of the Certification Authority snap-in, right-click **Certificate Templates**, click **New**, and click **Certificate Template to Issue**.

13. Click **VPN User Authentication**, and click **OK**.

14. Close the Certification Authority snap-in.

## Create the VPN Server Authentication template

Next, you must configure a new Server Authentication template for your VPN server. Adding the IP Security (IPsec) IKE Intermediate application policy allows the server to filter certificates if more than one certificate is available with the Server Authentication extended key usage. 

>[!IMPORTANT]
>Because VPN clients access this server from the public Internet, the subject and alternative names are different than the internal server name. As a result, you cannot autoenroll this certificate on VPN servers.

**To configure the VPN Server Authentication template**
The following steps apply to VPN servers that are domain joined. 

1.  On the CA, open Certification Authority.

2.  In the navigation pane, right-click **Certificate Templates**, and click **Manage**.

3.  In the Certificate Templates console, right-click **RAS and IAS Server**, and click **Duplicate Template**.

4.  On the Properties of New Template dialog box, on the **General** tab, in **Template display name**, enter a descriptive name for the VPN server, for example, **VPN Server Authentication** or **RADIUS Server**.

5.  On the **Extensions** tab, complete the following steps:

    1.  Click **Application Policies**, and click **Edit**.

    2.  On the **Edit Application Policies Extension** dialog box, click **Add**.

    3.  On the **Add Application Policy** dialog box, click **IP security IKE intermediate**, and click **OK**. Adding IP security IKE intermediate to the EKU helps in scenarios where more than one server authentication certificate exist on the VPN server. When IP security IKE intermediate is present, IPSec only uses the certificate with both EKU options. Without this, IKEv2 authentication could fail with Error 13801: IKE authentication credentials are unacceptable. 

    4.  Click **OK** to return to the **Properties of New Template** dialog box.

6.  On the **Security** tab, complete the following steps:

    1.  Click **Add**.

    2.  On the **Select Users, Computers, Service Accounts, or Groups** dialog box, type **VPN Servers**, and click **OK**.

    3.  In **Group or user names**, click **VPN Servers**.

    4.  In **Permissions for VPN Servers**, select the **Enroll** check box in the **Allow** column.

    5.  In **Group or user names**, click **RAS and IAS Servers**, and click **Remove**.

7.  On the **Subject Name** tab, complete the following steps:

    1.  Click **Supply in the Request**.

    2.  On the **Certificate Templates** warning dialog box, click **OK**.

5. (Conditional Access step) If you are configuring conditional access for VPN connectivity, click the **Request Handling** tab, and click **Allow private key to be exported** to select it.  @Reviewer: what happens if this option is not selected and left unchecked?

8.  Click **OK** to save the VPN Server certificate template.

9.  Close the Certificate Templates console.

10. In the navigation pane of the Certification Authority snap-in, right-click **Certificate Templates**, click **New**, and click **Certificate Template to Issue**.

11. Restart the Certificate Authority services.

11. Select the **RADIUS server**, and click **OK**.

12. Close the Certification Authority snap-in.

## Create the NPS Server Authentication template

The third and last certificate template to create is the NPS Server Authentication template. The NPS Server Authentication template is a simple copy of the RAS and IAS Server template secured to the NPS Server group that you created earlier in this section. 

You will configure this certificate for autoenrollment.

**To configure the NPS Server Authentication template**

1.  On the CA, open Certification Authority.

2.  In the navigation pane, right-click **Certificate Templates**, and click **Manage**.

3.  In the Certificate Templates console, right-click **RAS and IAS Server**, and click **Duplicate Template**.

4.  On the Properties of New Template dialog box, on the **General** tab, in **Template display name**, type **NPS Server Authentication**.

5.  On the **Security** tab, complete the following steps:

    1.  Click **Add**.

    2.  On the **Select Users, Computers, Service Accounts, or Groups** dialog box, type **NPS Servers**, and click **OK**.

    3.  In **Group or user names**, click **NPS Servers**.

    4.  In **Permissions for NPS Servers**, select the **Enroll** and **Autoenroll** check boxes in the **Allow** column.

    5.  In **Group or user names**, click **RAS and IAS Servers**, and click **Remove**.

6.  Click **OK** to save the NPS Server certificate template.

7.  Close the Certificate Templates console.

8.  In the navigation pane of the Certification Authority snap-in, right-click **Certificate Templates**, click **New**, and click **Certificate Template to Issue**.

9.  Click **NPS Server Authentication**, and click **OK**.

10. Close the Certification Authority snap-in.

## Enroll and validate the user certificate

Because you’re using Group Policy to autoenroll user certificates, you need only update the policy, and Windows 10 will automatically enroll the user account for the correct certificate. You can then validate the certificate in the Certificates console.

**To enroll and validate the user certificate**

1.  Sign in to a domain-joined client computer as a member of the **VPN Users** group.

2.  Press Windows key + R, type **gpupdate /force**, and press Enter.

3.  On the Start menu, type **certmgr.msc**, and press Enter.

4.  In the Certificates snap-in, under **Personal**, click **Certificates**. Your certificates appear in the details pane.

5.  Right-click the certificate that has your current domain user name, and click **Open**.

6.  On the **General** tab, confirm that the date listed under **Valid from** is today’s date. If it isn’t, you might have selected the wrong certificate.

7.  Click **OK**, and close the Certificates snap-in.

## Enroll and validate the server certificates

Unlike the user certificate, you must manually enroll the VPN server’s certificate. After you’ve enrolled it, validate it by using the same process you used for the user certificate. Like the user certificate, the NPS server will automatically enroll its authentication certificate, so all you need to do is validate it.

>[!NOTE]
>You might need to restart the VPN and NPS servers to allow them to update their group memberships before you can complete these steps.

**To enroll and validate the VPN server certificate**

1.  On the VPN server’s Start menu, type **certlm.msc**, and press Enter.

2.  Right-click **Personal**, click **All Tasks**, and click **Request New Certificate** to start the Certificate Enrollment Wizard.

3.  On the Before You Begin page, click **Next**.

4.  On the Select Certificate Enrollment Policy page, click **Next**.

5.  On the Request Certificates page, click the check box next to the VPN server to select it.

6.  Under the VPN server check box, click **More information is required** to open the Certificate Properties dialog box, and complete the following steps:

    1.  Click the **Subject** tab, click **Common Name** under **Subject name**, in **Type**.

    2.  Under **Subject name**, in **Value**, enter the name of the external domain clients will use to connect to the VPN (e.g., vpn.contoso.com), and click **Add**.

    3.  Under **Alternative Name**, in **Type**, click **DNS**.

    4.  Under **Alternative Name**, in **Value**, enter every possible FQDN the server could be addressed by, including IP addresses and NetBIOS names (e.g., vpn.contoso.com). The last name entered in the list of names appear as the Display name in **certlm.msc**. For this reason, it is suggested to add the FQDN or NetBIOS name of the server as the last entry in the SAN instead of an IP address.

    1.  Click **Add** and click **OK**.

7.  Click **Enroll**.

8.  Click **Finish**.

9.  In the Certificates snap-in, under **Personal**, click **Certificates**. Your certificates are listed in the details pane.

10. Right-click the certificate that has your VPN server’s name, and click **Open**.

11. On the **General** tab, confirm that the date listed under **Valid from** is today’s date. If it isn’t, you might have selected the incorrect certificate.

12. On the **Details** tab, click **Enhanced Key Usage**, and verify that **IP security IKE intermediate** and **Server Authentication** are listed.

13. Click **OK** to close the certificate.

14. Close the Certificates snap-in.

**To validate the NPS server certificate**

1.  Restart the NPS server.

2.  On the NPS server’s Start menu, type **certlm.msc**, and press Enter.

3.  In the Certificates snap-in, under **Personal**, click **Certificates**. Your certificates are listed in the details pane.

4.  Right-click the certificate that has your NPS server’s name, and click **Open**.

5.  On the **General** tab, confirm that the date listed under **Valid from** is today’s date. If it isn’t, you might have selected the incorrect certificate.

6.  Click **OK** to close the certificate.

7.  Close the Certificates snap-in.

For the next Always On VPN deployment steps, see [Configure the Remote Access Server for Always On VPN](vpn-deploy-ras.md).

