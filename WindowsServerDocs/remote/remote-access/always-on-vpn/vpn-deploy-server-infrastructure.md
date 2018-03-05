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

# STEP 3: Configure the Server Infrastructure

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

    a.  In the navigation pane, click **Computer onfiguration\\Policies\\Windows Settings\\Security Settings\\Public Key Policies**.

    b.  In the details pane, right-click **Certificate Services Client –
        Auto-Enrollment**, and click **Properties**.  
          
        The Certificate Services Client – Auto-Enrollment Properties dialog box
        opens.

    c.  In **Configuration Model**, click **Enabled** and select the following:

        -   **Renew expired certificates, update pending certificates, and remove revoked certificates**
    
        -   **Update certificates that use certificate templates**

    d.  Click **OK** to close the Certificate Services Client - Auto-Enrollment
        Properties dialog box.

6.  Configure _user_ certificate autoenrollment by doing the following: 

    a.  In the navigation pane, click **User Configuration\\Policies\\Windows Settings\\Security Settings\\Public Key Policies**.

    b.  In the details pane, right-click **Certificate Services Client – Auto-Enrollment**, and click **Properties**.<br><br>The Certificate Services Client – Auto-Enrollment Properties dialog box  opens.

    c.  In **Configuration Model**, click **Enabled** and select the following:

        -   **Renew expired certificates, update pending certificates, and remove revoked certificates**
    
        -   **Update certificates that use certificate templates**

    d.  Click **OK**.

7.  Close Group Policy Management.

## STEP 3.2: Create the Users and Servers Groups

After you have configured certificate autoenrollment in Group Policy, you add the following three new Active Directory groups that contain:

-   **Users** allowed to use the VPN to connect to their corporate network.

-   **VPN servers** and **NPS servers** used to restrict certificate requests to their members.

By using a custom group, if you ever want to revoke a user’s VPN access, you can remove that user from the group.

1.  On a domain controller, open Active Directory Users and Computers.

2.  Configure the **VPN Users** Group by doing the following:

    a.  Right-click a container or organizational unit, click **New**, and click **Group**.

    b.  In **Group name**, type **VPN Users**, and click **OK**.

    c.  Right-click **VPN Users**, and click **Properties**.<br><br>The VPN Users Properties dialog box opens.

    d.  Click the **Members** tab and click **Add**.  
          
        The Select Users dialog box opens.

    e.  Add all the users who need VPN access and click **OK** to close the
        Select Users dialog box.

    f.  Click **OK** to close the VPN Users Properties dialog box.

3.  Configure the **VPN Servers** and **NPS Servers** Groups by doing the following:

    a.  Right-click a container or organizational unit, click **New**, and click **Group**.

    b.  In **Group name**, type **VPN Servers**, and click **OK**.

    c.  Right-click **VPN Servers**, and click **Properties**.<br><br>The VPN Servers Properties dialog box opens.

    d.  Click the **Members** tab and click **Add**.

    e.  Click **Object Types**, select the **Computers** check box, and click  **OK**.

    f.  In **Enter the object names to select**, type the names of your VPN servers, and click **OK**.

    g.  Click **OK** to close the VPN Servers Properties dialog box.

4.  Repeat the previous steps for the NPS Servers group.

5.  Close Active Directory Users and Computers.

## STEP 3.3: Create the Authentication templates

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

    a.  Right-click **User** and click **Duplicate Template**.<br><br>The Properties of New Template dialog box opens.

    b.  Click the **General** tab, in **Template display name**, type **VPN User Authentication**, and select the **Publish certificate in Active Directory** check box.

    c.  Click the **Security** tab, click **Add**.<br><br>The Select Users, Computers, Service Accounts, or Groups dialog box
        opens.

    e.  Type **VPN Users**, and click **OK**.

    f.  In Group or user names, click **VPN Users**.<br><br>The Permissions for VPN Users dialog opens.

    g.  In the Allow column, select the **Enroll** and **Autoenroll** check boxes, and click **OK**.

    h.  In Group or user names, click **Domain Users**, and click **Remove**.

    i.  Click the **Compatibility** tab, in Certification Authority, click **Windows Server 2012 R2,** and click **OK**.<br><br>The Resulting changes dialog box opens.

    k. In Certificate recipient, click **Windows 8.1/Windows Server 2012 R2** and click **OK**<br><br>The Resulting changes dialog box opens.

    m. Click the **Request Handling** tab, clear the **Allow private key to be exported** check box.

    n. Click the **Cryptography** tab, in Provider Category, click **Key Storage Provider**.

    p. Click **Requests must use one of the following providers** and select the **Microsoft Platform Crypto Provider** check box.

    r. (Optional) Click the **Subject Name** tab, if you do not have an email address listed on all user accounts, clear the **Include e-mail name in subject name** and **E-mail name** check boxes.

    s. Click **OK** to save the VPN User Authentication certificate.

4.  **Configure VPN Server Authentication template** by doing the following:

    a.  Right-click **RAS and IAS Server**, and click **Duplicate Template**.<br><br>The Properties of New Template dialog box opens.

    b.  Click the **General** tab, in **Template display name**, type **VPN Server Authentication**.

    c.  Click the **Extensions** tab, click **Application Policies**, and click **Edit**.<br><br>The Edit Application Policies Extension dialog opens.

    d.  Click **Add**.<br><br>The Add Application Policy dialog box opens.

    e.  Click **IP security IKE intermediate** and click **OK**.

    f.  Click **OK**.

    g.  Click the **Security** tab and click **Add**.<br><br>The Select Users, Computers, Service Accounts, or Groups dialog box opens.

    h. Type **VPN Servers** and click **OK**.

    i. In Group or user names, click **VPN Servers**.

    j. In Permissions for VPN Servers, in the Allow column, select the **Enroll** check box.

    k. In Group or user names, click **RAS and IAS Servers**, and click **Remove**.

    l. Click the **Subject Name** tab, click Supply in the Request, and click **OK** on the Certificate Templates warning dialog box.

    m. Click **OK** to save the VPN Server certificate template.

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

## STEP 3.4: Enroll and validate the user certificate

Because you are using Group Policy to autoenroll user certificates, you need only update the policy, and Windows 10 automatically enrolls the user account for the correct certificate. You can then validate the certificate in the Certificates console.

**Procedure:**

1.  Sign in to a domain-joined client computer as a member of the **VPN Users** group.

2.  Press Windows key + R, type **gpupdate /force**, and press Enter.

3.  On the Start menu, type **certmgr.msc**, and press Enter. <br><br>The Certificates snap-in opens.

4.  In the navigation pane, expand **Personal** and click **Certificates**.<br><br>Your certificates appear in the details pane.

5.  Right-click the certificate that has your current domain user name, and click **Open**.<br><br>The Certificate dialog opens.

6.  On the **General** tab, confirm that the date listed under **Valid from** is today’s date.<br><br>If the Valid from date is not today's date, you might have selected the wrong certificate. Therefore, select another certificate before continuing.

7.  Click **OK** to close the Certificate dialog.

8.  Close the Certificates snap-in.

## STEP 3.5: Enroll and validate the VPN server certificates

Unlike the user certificate, you must manually enroll the VPN server’s certificate.

**Procedure:**

1.  On the VPN server’s Start menu, type **certlm.msc**, and press Enter.

2.  Right-click **Personal**, click **All Tasks**, and click **Request New Certificate** to start the Certificate Enrollment Wizard.

3.  On the Before You Begin page, click **Next**.

4.  On the Select Certificate Enrollment Policy page, click **Next**.

5.  On the Request Certificates page, select the **VPN Server Authentication** check box.

6.  Under the **VPN Server Authentication** check box, click **More information is required** to open the Certificate Properties dialog box, and complete the following steps:

    a.  Under **Subject name**, in **Type**, click **Common Name**.

    b.  Under **Subject name**, in **Value**, type the name of the external domain clients will use to connect to the VPN (for example, vpn.contoso.com),
        and click **Add**.

    c.  Under **Alternative Name**, in **Type**, click **DNS**.

    d.  Under **Alternative Name**, in **Value**, type the name of the external domain clients will use to connect to the VPN (for example, vpn.contoso.com), and click **Add**.

    e.  Click **OK**.

7.  Click **Enroll** and click **Finish**.

9.  In the Certificates snap-in, under **Personal**, click **Certificates**.<br><br>Your certificates are listed in the details pane.

10. Right-click the certificate that has your VPN server’s name, and click  **Open**.

11. On the **General** tab, confirm that the date listed under **Valid from** is today’s date.<br><br>If the Valid from date is not today's date, then select another certificate before continuing.

12. On the **Details** tab, click **Enhanced Key Usage**, and verify that **IP security IKE intermediate** and **Server Authentication** are listed.

13. Click **OK** to close the certificate.

14. Close the Certificates snap-in.

15. Restart the VPN server to allow the group memberships to update.

## STEP 3.6: Validate the NPS certificate

Like the user certificate, the NPS server automatically enrolls its authentication certificate, so all you need to do is validate it.

**Procedure:**

1.  Restart the NPS server.

2.  On the NPS server’s Start menu, type **certlm.msc**, and press Enter.

3.  In the Certificates snap-in, under **Personal**, click **Certificates**.<br><br>Your certificates are listed in the details pane.

4.  Right-click the certificate that has your NPS server’s name, and click **Open**.

5.  On the **General** tab, confirm that the date listed under **Valid from** is today’s date.<br><br>If the Valid from date is not today's date, then select another certificate before continuing.

6.  Click **OK** to close the certificate.

7.  Close the Certificates snap-in.

## Next steps

[STEP 4: Configure the Remote Access Server for Always On VPN](vpn-deploy-ras.md). Install and configure the Remote Access server role on the computer or virtual machine (VM) that you want to use as your VPN server.