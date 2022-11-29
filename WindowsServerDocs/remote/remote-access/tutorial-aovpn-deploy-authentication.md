---
title: Tutorial- Deploy Always On VPN
description: Learn how to deploy Always On VPN (AOV) connections for Windows 10+ client computers that are working offsite (for example, from home, a customer site, or a public wireless access point).
ms.topic: article
ms.assetid: ad748de2-d175-47bf-b05f-707dc48692cf
ms.author: anaharris
author: anaharris-ms
ms.date: 11/21/2022
---

# Tutorial: Step 1 - Deploy Always On VPN

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows 10, Windows 11

In this tutorial, you'll learn how to deploy Always On VPN (AOV) connections for Windows 10+ client computers that are working offsite (for example, from home, a customer site, or a public wireless access point).

<!-- Editorial note: We will bill not be using non domain joined servers in this tutorial. We recommend VPN servers that reside in the DMA/Perimeter not be domain-joined. However, if you prefer to have the VPN servers domain-joined for better manageability (Group Policies, Backup/Monitoring agent, no local users to manage, and so on), then add an AD group to the VPN server certificate template.

<!-- Editorial note: Emphasize that this is not production ready and has no security infrastructure such as firewalls, etc to protect the network.-->

## Setup the environment

For this tutorial, you'll need two Windows server machines. One will be the RAS server and the other the Domain Controller:

1. Create the Domain Controller. On one Windows server, install and configure Active Directory Domain Services (AD DS) on a Windows Server. For information on how to install and configure AD DS, see [AD DS Role Installation](/windows-server/identity/ad-ds/deploy/install-a-new-windows-server-2012-active-directory-forest--level-200-#ad-ds-role-installation).

1. On the domain controller server, install and configure the following roles:
    - [Network Policy and Access Services (NPS)](../../networking/technologies/nps/nps-top.md).
    - [Active Directory Certificate Services (AD CS)](../../identity/ad-cs/index.yml). Install the Certification Authority role service.

1. Create the RAS server.  On a separate machine running Windows Server install:
     - [Remote Access (RAS)](remote-access.md). Install the DirectAccess and VPN(RAS) role service.

1. Ensure that the RAS server has one physical Ethernet network adapter that faces the internet.

1. Join the RAS server to your domain.

1. Configure your firewalls:
    - Configure your firewalls to allow RADIUS traffic. For more information on how to configure firewalls for RADIUS traffic, see [Configure firewalls for RADIUS traffic](../../networking/technologies/nps/nps-firewalls-configure.md).

    - Configure your firewalls to allow VPN traffic by opening User Datagram Protocol (UDP) ports 500 and 4500 on the external perimeter network adapter.

<!-- Editorial note: Is this still true? -->
>[!IMPORTANT]
>Don't attempt to deploy Remote Access on a virtual machine (VM) in Microsoft Azure. Using Remote Access in Microsoft Azure is not supported, including both Remote Access VPN and DirectAccess. For more information, see [Microsoft server software support for Microsoft Azure virtual machines](https://support.microsoft.com/help/2721672/microsoft-server-software-support-for-microsoft-azure-virtual-machines).

## Setup Active Directory authentication

### Configure Active Directory Group Policy

In this section, you'll configure Group Policy on the domain controller so that domain members automatically request user and computer certificates. Doing so lets VPN users request and retrieve user certificates that authenticate VPN connections automatically. Also, this policy allows NPS servers to request server authentication certificates automatically.

1. On the domain controller, open Group Policy Management.

2. In the left pane, right-click your domain (for example, corp.contoso.com). Select **Create a GPO in this domain, and Link it here**.

3. On the New GPO dialog box, for **Name**, enter *Autoenrollment Policy*. Select **OK**.

4. In the left pane, right-click **Autoenrollment Policy**. Select **Edit** to open the **Group Policy Management Editor**.

5. In the **Group Policy Management Editor**, complete the following steps to configure computer certificate autoenrollment:

    1. In the left pane, go to **Computer Configuration** > **Policies** > **Windows Settings** > **Security Settings** > **Public Key Policies**.

    2. In the details pane, right-click **Certificate Services Client – Auto-Enrollment**. Select **Properties**.

    3. On the Certificate Services Client – Auto-Enrollment Properties dialog box, for **Configuration Model**, select **Enabled**.

    4. Select **Renew expired certificates, update pending certificates, and remove revoked certificates** and **Update certificates that use certificate templates**.

    5. Select **OK**.

6. In the **Group Policy Management Editor**, complete the following steps to Configure user certificate autoenrollment:

    1. In the left pane, go to **User Configuration** > **Policies** > **Windows Settings** > **Security Settings** > **Public Key Policies**.

    2. In the details pane, right-click **Certificate Services Client – Auto-Enrollment** and select **Properties**.

    3. On the Certificate Services Client – Auto-Enrollment Properties dialog box, in **Configuration Model**, select **Enabled**.

    4. Select **Renew expired certificates, update pending certificates, and remove revoked certificates** and **Update certificates that use certificate templates**.

    5. Select **OK**.

    6. Close the Group Policy Management Editor.

7. Close Group Policy Management.

### Create Active Directory groups

In this section, you'll add three new Active Directory (AD) groups:

- *VPN Users group*. VPN Users group serves two purposes:
    
    - It defines which users are allowed to autoenroll for the user certificates the VPN requires.
    - It defines which users the NPS authorizes for VPN access.
    - It allows you to revoke a user's VPN access by removing that user from the group.

- *VPN Servers group*. The VPN Servers group contains the VPN servers that are allowed to request certificates.

- *NPS Servers group*. The NPS Servers group contains the NPS servers that are allowed to request certificates.

**Create VPN Users group:**

1. On a domain controller, open Active Directory Users and Computers.

2. Right-click a container or organizational unit (for example, *Users*), select **New**, then select **Group**.

3. In **Group name**, enter **VPN Users**, then select **OK**.

4. Right-click **VPN Users** and select **Properties**.

5. On the **Members** tab of the VPN Users Properties dialog box, select **Add**.

6. On the Select Users dialog box, add all the users who need VPN access and select **OK**.

7. Close Active Directory Users and Computers.

**Create VPN Servers and NPS Servers groups:**

1. On a domain controller, open Active Directory Users and Computers.

2. Right-click a container or organizational unit, select **New**, then select **Group**.

3. In **Group name**, enter **VPN Servers**, then select **OK**.

4. Right-click **VPN Servers** and select **Properties**.

5. On the **Members** tab of the VPN Servers Properties dialog box, select **Add**.

6. select **Object Types**, select the **Computers** check box, then select **OK**.

7. In **Enter the object names to select**, enter the names of your VPN servers, then select **OK**.

8. Select **OK** to close the VPN Servers Properties dialog box.

9. Repeat the previous steps for the NPS Servers group.

10. Close Active Directory Users and Computers.

## Setup Certification Authority templates

In this section, you'll configure three authentication templates on the Certification Authority server:

- *User authentication template*. With a user authentication template, you can improve certificate security by selecting upgraded compatibility levels and choosing the Microsoft Platform Crypto Provider. With the Microsoft Platform Crypto Provider, you can use a Trusted Platform Module (TPM) on client computers to secure the certificate. For an overview of TPM, see [Trusted Platform Module Technology Overview](/windows/device-security/tpm/trusted-platform-module-overview).

- *VPN server authentication template*. With a VPN server authentication template, you can add the IP Security (IPsec) IKE Intermediate application policy to allows the server to filter certificates if more than one certificate is available with the server authentication extended key usage. Because VPN clients access this server from the public internet, the subject and alternative names are different than the internal server name. As a result, you won't configure the VPN server certificate for autoenrollment.

- *NPS server authentication template*. The NPS server authentication template is a simple copy of the RAS and IAS Server template secured to the NPS Server group that you created earlier in this section. You'll configure the NPS server certificate for autoenrollment.

**Create the user authentication template:**

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

**Create the VPN Server Authentication template:**

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
        >Adding IP security IKE intermediate to the EKU helps in scenarios where more than one server authentication certificate exists on the VPN server. When IP security IKE intermediate is present, IPSec only uses the certificate with both EKU options. Without this, IKEv2 authentication could fail with Error 13801: IKE authentication credentials are unacceptable.

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

**Create the NPS Server Authentication template:**

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

**Enroll and validate the user certificate:**

Because you're using Group Policy to autoenroll user certificates, you'll update only the policy. Windows 10 will automatically enroll the user account for the correct certificate. You can then validate the certificate in the Certificates console.

>[!IMPORTANT]
>Microsoft Platform Crypto Provider" requires a TPM chip. If, while trying to manually enroll a certificate on a VM, you get the following error: "Cannot find a valid CSP in the local machine" do ensure that "Microsoft Software Key Storage Provider" is second in order after "Microsoft Platform Crypto Provider" in the Cryptography tab of the certificate Properties.

1. Sign in to a domain-joined client computer as a member of the **VPN Users** group.

2. Press Windows key + R, type **gpupdate /force**, and press Enter.

3. On the Start menu, type **certmgr.msc**, and press Enter.

4. In the Certificates snap-in, under **Personal**, select **Certificates**. Your certificates appear in the details pane.

5. Right-click the certificate that has your current domain username, and then select **Open**.

6. On the **General** tab, confirm that the date listed under **Valid from** is today's date. If it isn't, you might have selected the wrong certificate.

7. Select **OK**, and close the Certificates snap-in.


**Enroll and validate the VPN server certificates:**

Unlike the user certificate, you must manually enroll the VPN server's certificate. After you've enrolled it, validate it by using the same process you used for the user certificate. Like the user certificate, the NPS server automatically enrolls its authentication certificate, so all you need to do is validate it.

>[!NOTE]
>You might need to restart the VPN and NPS servers to allow them to update their group memberships before you can complete these steps.

**Enroll and validate the VPN server certificate:**

1. On the VPN server's Start menu, type **certlm.msc**, and press Enter.

2. Right-click **Personal**, select **All Tasks** and then select **Request New Certificate** to start the Certificate Enrollment Wizard.

3. On the Before You Begin page, select **Next**.

4. On the Select Certificate Enrollment Policy page, select **Next**.

5. On the Request Certificates page, select the check box next to the VPN server to select it.

6. Under the VPN server check box, select **More information is required** to open the Certificate Properties dialog box and complete the following steps:

    1. Select the **Subject** tab, select **Common Name** under **Subject name**, in **Type**.

    2. Under **Subject name**, in **Value**, enter the name of the external domain clients used to connect to the VPN, for example, vpn.contoso.com, then select **Add**.

    3. Under **Alternative Name**, in **Type**, select **DNS**.

    4. Under **Alternative Name**, in **Value**, enter all of the server names clients use to connect to the VPN, for example, vpn.contoso.com, vpn, 132.64.86.2.

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

**Validate the NPS server certificate:**

1. Restart the NPS server.

2. On the NPS server's Start menu, type **certlm.msc**, and press Enter.

3. In the Certificates snap-in, under **Personal**, select **Certificates**.

    Your listed certificates appear in the details pane.

4. Right-click the certificate that has your NPS server's name, and then select **Open**.

5. On the **General** tab, confirm that the date listed under **Valid from** is today's date. If it isn't, you might have selected the incorrect certificate.

6. Select **OK** to close the certificate.

7. Close the Certificates snap-in.

## Next steps

[Step 2. Configure the Remote Access Server for Always On VPN](vpn-deploy-ras.md): In this step, you configure Remote Access VPN to allow IKEv2 VPN connections, deny connections from other VPN protocols, and assign a static IP address pool for issuance of IP addresses to connecting authorized VPN clients.