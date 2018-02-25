---
title: Configure the Always On VPN Server Infrastructure
author: shortpatti
---

Configure the Server Infrastructure
===================================

>   Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016,
>   Windows Server 2012 R2, Windows 10

Configuring the server infrastructure is the first thing you do to deploy Always
On VPN. This topic provides instructions on how to install and configure the
server-side components necessary to support the VPN. The server-side components
includes configuring: \* PKI to distribute the certificates used by users, the
VPN server and the NPS.  
\* Configuring RRAS to support IKEv2 connections. \* Configuring the NPS to
perform authorization for the VPN connections.

STEP 1. Configure certificate autoenrollment in Group Policy
------------------------------------------------------------

By configuring certificate autoenrollment in Group Policy VPN users
automatically request and retrieve user certificates that authenticate VPN
connections. Likewise, this policy allows the NPS to automatically request
server authentication certificates.

**IMPORTANT.** You must manually enroll certificates on VPN servers.

1.  On a domain controller, open Group Policy Management.

2.  In the navigation pane, right-click your domain (e.g., corp.contoso.com),
    and click **Create a GPO in this domain, and Link it here**.  
      
    The New GPO dialog box opens.

3.  Type **Autoenrollment Policy** and click **OK**.

4.  In the navigation pane, right-click **Autoenrollment Policy**, and click
    **Edit**.  
      
    The Group Policy Management Editor opens.

5.  Configure computer certificate autoenrollment by doing the following:

    1.  In the navigation pane, click **Computer
        Configuration\\Policies\\Windows Settings\\Security Settings\\Public Key
        Policies**.

    2.  In the details pane, right-click **Certificate Services Client –
        Auto-Enrollment**, and click **Properties**.  
          
        The Certificate Services Client – Auto-Enrollment Properties dialog box
        opens.

    3.  In **Configuration Model**, click **Enabled** and select the following:

        -   **Renew expired certificates, update pending certificates, and
            remove revoked certificates**

        -   **Update certificates that use certificate templates**

    4.  Click **OK** to close the Certificate Services Client - Auto-Enrollment
        Properties dialog box.

6.  In the Group Policy Management Editor, configure user certificate
    autoenrollment by doing the following:

    1.  In the navigation pane, click **User Configuration\\Policies\\Windows
        Settings\\Security Settings\\Public Key Policies**.

    2.  In the details pane, right-click **Certificate Services Client –
        Auto-Enrollment**, and click **Properties**.  
          
        The Certificate Services Client – Auto-Enrollment Properties dialog box
        opens.

    3.  In **Configuration Model**, click **Enabled** and select the following:

        -   **Renew expired certificates, update pending certificates, and
            remove revoked certificates**

        -   **Update certificates that use certificate templates**

    4.  Click **OK**.

    5.  Close the Group Policy Management Editor.

7.  Close Group Policy Management.

STEP 2: Create the Users and Servers Groups
-------------------------------------------

After you have configred certificate autoenrollment in Group Policy, you add a
new Active Directory group that contains the users allowed to use the VPN to
connect to your organization network. The Active Directory group defines which
users:

-   Are allowed to autoenroll for the user certificates the VPN requires.

-   The NPS authorizes for VPN access.

By using a custom group, if you ever want to revoke a user’s VPN access, you can
simply remove that user from the group.

You will also add a group containing VPN servers and another group containing
NPS servers. You use these groups to restrict certificate requests to their
members.

1.  On a domain controller, open Active Directory Users and Computers.

2.  Right-click a container or organizational unit, click **New**, and click
    **Group**.

3.  Configure the VPN Users Group by doing the following:

    1.  In **Group name**, type **VPN Users**, and click **OK**.

    2.  Right-click **VPN Users**, and click **Properties**.  
          
        The VPN Users Properties dialog box opens.

    3.  Click the **Members** tab and click **Add**.  
          
        The Select Users dialog box opens.

    4.  Add all the users who need VPN access and click **OK** to close the
        Select Users dialog box.

    5.  Click **OK** to close the VPN Users Properties dialog box.

4.  Configure the VPN Servers and NPS Servers Groups by doing the following:

    1.  In **Group name**, type **VPN Servers**, and click **OK**.

    2.  Right-click **VPN Servers**, and click **Properties**.  
          
        The VPN Servers Properties dialog box opens.

    3.  Click the **Members** tab and click **Add**.

    4.  Click **Object Types**, select the **Computers** check box, and click
        **OK**.

    5.  In **Enter the object names to select**, type the names of your VPN
        servers, and click **OK**.

    6.  Click **OK** to close the VPN Servers Properties dialog box.

5.  Repeat the previous steps for the NPS Servers group.

6.  Close Active Directory Users and Computers.

STEP 3: Create the Authentication templates
-------------------------------------------

You can use this section to configure a custom client–server authentication
template.

This template is required because you want to improve the certificate’s overall
security by selecting upgraded compatibility levels and choosing the Microsoft
Platform Crypto Provider. Microsoft Platform Crypto Provider lets you use the
Trusted Platform Module (TPM) on client computers to secure the certificate.

>   [!NOTE] For more information about TPM, see [Trusted Platform Module
>   Technology
>   Overview](https://docs.microsoft.com/windows/device-security/tpm/trusted-platform-module-overview).

With this step you can configure a new Server Authentication template for your
VPN server.

Adding the IP Security (IPsec) IKE Intermediate application policy allows the
server to filter certificates if more than one certificate is available with the
Server Authentication extended key usage.

[!IMPORTANT] Because VPN clients access this server from the public Internet,
the subject and alternative names are different than the internal server name.
As a result, you cannot autoenroll this certificate on VPN servers.

The third and last certificate template to create is the NPS Server
Authentication template. The NPS Server Authentication template is a simple copy
of the RAS and IAS Server template secured to the NPS Server group that you
created earlier in this section.

You will configure this certificate for autoenrollment.

1.  On the CA, open Certification Authority.

2.  In the navigation pane, right-click **Certificate Templates**, and
    click **Manage**. The Certificate Templates console opens.

3.  Configure the User Authentication template by doing the following:

    1.  Right-click **User** and click **Duplicate Template**. The Properties of
        New Template dialog box opens.

    2.  Click the **General** tab, in **Template display name**, type **VPN User
        Authentication**, and select the **Publish certificate in Active
        Directory** check box.

    3.  Click the **Security** tab, complete the following steps:

        1.  Click **Add**. The Select Users, Computers, Service Accounts, or
            Groups dialog box opens.

        2.  Type **VPN Users**, and click **OK**.

        3.  In **Group or user names**, click **VPN Users**. The Permissions for
            VPN Users dialog opens.

        4.  In the Allow column, select the **Enroll** and **Autoenroll** check
            boxes, and click **OK**.

        5.  In **Group or user names**, click **Domain Users**, and click
            **Remove**.

    4.  Click the **Compatibility** tab, complete the following steps:

        1.  In **Certification Authority**, click **Windows Server 2012 R2**.
            The Resulting changes dialog box opens.

        2.  Click **OK**.

        3.  In **Certificate recipient**, click **Windows 8.1/Windows
            Server 2012 R2**. The Resulting changes dialog box opens.

        4.  Click **OK**.

4.  Click the **Request Handling** tab, clear the **Allow private key to be
    exported** check box.

5.  Click the **Cryptography** tab, complete the following steps:

    1.  In **Provider Category**, click **Key Storage Provider**.

    2.  Click **Requests must use one of the following providers**.

    3.  Select the **Microsoft Platform Crypto Provider** check box.

6.  (Optional) Click the **Subject Name** tab, if you do not have an email
    address listed on all user accounts, clear the **Include e-mail name in
    subject name** and **E-mail name** check boxes.

7.  Click **OK** to save the VPN User Authentication certificate.

8.  Configure VPN Server Authentication template by doing the following:

    1.  Right-click **RAS and IAS Server**, and click **Duplicate Template**.
        The Properties of New Template dialog box opens.

9.  Click the **General** tab, in **Template display name**, type **VPN Server
    Authentication**.

10. Click the **Extensions** tab, complete the following steps:

    1.  Click **Application Policies**, and click **Edit**.

    2.  On the **Edit Application Policies Extension** dialog box,
        click **Add**.

    3.  On the **Add Application Policy** dialog box, click **IP security IKE
        intermediate**, and click **OK**.

    4.  Click **OK** to return to the **Properties of New Template** dialog box.

11. Click the **Security** tab, complete the following steps:

    1.  Click **Add**.

    2.  On the **Select Users, Computers, Service Accounts, or Groups** dialog
        box, type **VPN Servers**, and click **OK**.

    3.  In **Group or user names**, click **VPN Servers**.

    4.  In **Permissions for VPN Servers**, select the **Enroll** check box in
        the **Allow** column.

    5.  In **Group or user names**, click **RAS and IAS Servers**, and click
        **Remove**.

12. Click the **Subject Name** tab, click **Supply in the Request** and **OK**
    on the Certificate Templates warning dialog box.

13. Click **OK** to save the VPN Server certificate template.

14. Configure VPN Server Authentication template by doing the following:

15. Right-click **RAS and IAS Server**, and click **Duplicate Template**. The
    Properties of New Template dialog box opens.

16. Clkick the **General** tab, in **Template display name**, type **NPS Server
    Authentication**.

17. On the **Security** tab, complete the following steps:

    1.  Click **Add**.

    2.  On the **Select Users, Computers, Service Accounts, or Groups** dialog
        box, type **NPS Servers**, and click **OK**.

    3.  In **Group or user names**, click **NPS Servers**.

    4.  In **Permissions for NPS Servers**, select the **Enroll** and
        **Autoenroll** check boxes in the **Allow** column.

    5.  In **Group or user names**, click **RAS and IAS Servers**, and click
        **Remove**.

18. Click **OK** to save the NPS Server certificate template.

19. Close the Certificate Templates console.

20. In the navigation pane of the Certification Authority snap-in,
    right-click **Certificate Templates**, click **New**, and
    click **Certificate Template to Issue**.

    1.  Click **VPN User Authentication**, and click **OK**.

    2.  Click **VPN Server Authentication**, and click **OK**.

    3.  Click **VPN Server Authentication**, and click **OK**.

21. Close the Certification Authority snap-in.

STEP 4: Enroll and validate the user certificate
------------------------------------------------

Because you’re using Group Policy to autoenroll user certificates, you need only
update the policy, and Windows 10 will automatically enroll the user account for
the correct certificate. You can then validate the certificate in the
Certificates console.

1.  Sign in to a domain-joined client computer as a member of the **VPN Users**
    group.

2.  Press Windows key + R, type **gpupdate /force**, and press Enter.

3.  On the Start menu, type **certmgr.msc**, and press Enter. The Certificates
    snap-in opens.

4.  Under **Personal**, click **Certificates**. Your certificates appear in the
    details pane.

5.  Right-click the certificate that has your current domain user name, and
    click **Open**.

6.  Click the **General** tab, confirm that the date listed under **Valid from**
    is today’s date. If it isn’t, you might have selected the wrong certificate.

7.  Click **OK**, and close the Certificates snap-in.

STEP 5: Enroll and validate the VPN server certificates
-------------------------------------------------------

Unlike the user certificate, you must manually enroll the VPN server’s
certificate. After you’ve enrolled it, validate it by using the same process you
used for the user certificate. Like the user certificate, the NPS server will
automatically enroll its authentication certificate, so all you need to do is
validate it.

>   [!NOTE] You might need to restart the VPN and NPS servers to allow them to
>   update their group memberships before you can complete these steps.

1.  On the VPN server’s Start menu, type **certlm.msc**, and press Enter.

2.  Right-click **Personal**, click **All Tasks**, and click **Request New
    Certificate** to start the Certificate Enrollment Wizard.

3.  On the Before You Begin page, click **Next**.

4.  On the Select Certificate Enrollment Policy page, click **Next**.

5.  On the Request Certificates page, select the **VPN Server Authentication**
    check box.

6.  Under the **VPN Server Authentication** check box, click **More information
    is required** to open the Certificate Properties dialog box, and complete
    the following steps:

    1.  Under **Subject name**, in **Type**, click **Common Name**.

    2.  Under **Subject name**, in **Value**, type the name of the external
        domain clients will use to connect to the VPN (e.g., vpn.contoso.com),
        and click **Add**.

    3.  Under **Alternative Name**, in **Type**, click **DNS**.

    4.  Under **Alternative Name**, in **Value**, type the name of the external
        domain clients will use to connect to the VPN (e.g., vpn.contoso.com),
        and click **Add**.

    5.  Click **OK**.

7.  Click **Enroll**.

8.  Click **Finish**.

9.  In the Certificates snap-in, under **Personal**, click **Certificates**.
    Your certificates are listed in the details pane.

10. Right-click the certificate that has your VPN server’s name, and click
    **Open**.

11. On the **General** tab, confirm that the date listed under **Valid from** is
    today’s date. If it isn’t, you might have selected the incorrect
    certificate.

12. On the **Details** tab, click **Enhanced Key Usage**, and verify that **IP
    security IKE intermediate** and **Server Authentication** are listed.

13. Click **OK** to close the certificate.

14. Close the Certificates snap-in.

STEP 6: Enroll and validate the NPS certificate
-----------------------------------------------

1.  Restart the NPS server.

2.  On the NPS server’s Start menu, type **certlm.msc**, and press Enter.

3.  In the Certificates snap-in, under **Personal**, click **Certificates**.
    Your certificates are listed in the details pane.

4.  Right-click the certificate that has your NPS server’s name, and click
    **Open**.

5.  On the **General** tab, confirm that the date listed under **Valid from** is
    today’s date. If it isn’t, you might have selected the incorrect
    certificate.

6.  Click **OK** to close the certificate.

7.  Close the Certificates snap-in.

Next steps
----------

[Configure the Remote Access Server for Always On VPN](vpn-deploy-ras.md).
Install and configure the Remote Access server role on the computer or virtual
machine (VM) that you want to use as your VPN server.
