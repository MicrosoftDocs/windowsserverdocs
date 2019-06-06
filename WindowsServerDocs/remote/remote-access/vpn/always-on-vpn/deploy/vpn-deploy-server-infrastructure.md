---
title: Configure the Server Infrastructure
description: In this step, you install and configure the server-side components necessary to support the VPN. The server-side components include configuring PKI to distribute the certificates used by users, the VPN server, and the NPS server.  
ms.prod: windows-server-threshold
ms.technology: networking-ras
ms.topic: article
ms.assetid: 
ms.localizationpriority: medium 
ms.author: pashort
author: shortpatti
ms.date: 08/30/2018
ms.reviewer: deverette
---
# Step 2. Configure the server infrastructure

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows 10

- [**Previous:** Step 1. Plan the Always On VPN Deployment](always-on-vpn-deploy-planning.md)
- [**Next:** Step 3. Configure the Remote Access Server for Always On VPN](vpn-deploy-ras.md)

In this step, you'll install and configure the server-side components necessary to support the VPN. The server-side components include configuring PKI to distribute the certificates used by users, the VPN server, and the NPS server.  You also configure RRAS to support IKEv2 connections and the NPS server to perform authorization for the VPN connections.

## Configure certificate autoenrollment in Group Policy
In this procedure, you configure Group Policy on the domain controller so that domain members automatically request user and computer certificates. Doing so allows VPN users to request and retrieve user certificates that authenticate VPN connections automatically. Likewise, this policy allows NPS servers to request server authentication certificates automatically. 

You manually enroll certificates on VPN servers.

>[!TIP]
>For non-domained joined computers, see [CA configuration for non-domain joined computers](#ca-configuration-for-non-domain-joined-computers). Since the RRAS server is not domain joined, autoenrollment cannot be used to enroll the VPN gateway certificate.  Therefore, use an offline certificate request procedure.

1. On a domain controller, open Group Policy Management.

2. In the navigation pane, right-click your domain (for example, corp.contoso.com), then select **Create a GPO in this domain, and Link it here**.

3. On the New GPO dialog box, enter **Autoenrollment Policy**, then select **OK**.

4. In the navigation pane, right-click **Autoenrollment Policy**, then select **Edit**.

5. In the Group Policy Management Editor, complete the following steps to configure computer certificate autoenrollment:

    1. In the navigation pane, go to **Computer Configuration** > **Policies** > **Windows Settings** > **Security Settings** > **Public Key Policies**.

    2. In the details pane, right-click **Certificate Services Client – Auto-Enrollment**, then select **Properties**.

    3. On the Certificate Services Client – Auto-Enrollment Properties dialog box, in **Configuration Model**, select **Enabled**.

    4. Select **Renew expired certificates, update pending certificates, and remove revoked certificates** and **Update certificates that use certificate templates**.

    5. Select **OK**.

6. In the Group Policy Management Editor, complete the following steps to Configure user certificate autoenrollment:

    1. In the navigation pane, go to **User Configuration** > **Policies** > **Windows Settings** > **Security Settings** > **Public Key Policies**.

    2. In the details pane, right-click **Certificate Services Client – Auto-Enrollment** and select **Properties**.

    3. On the Certificate Services Client – Auto-Enrollment Properties dialog box, in **Configuration Model**, select **Enabled**.

    4. Select **Renew expired certificates, update pending certificates, and remove revoked certificates** and **Update certificates that use certificate templates**.

    5. Select **OK**.

    6. Close the Group Policy Management Editor.

7. Close Group Policy Management.

### CA configuration for non-domain joined computers

Since the RRAS server is not domain joined, autoenrollment cannot be used to enroll the VPN gateway certificate.  Therefore, use an offline certificate request procedure.

1. On the RRAS server, generate a file called **VPNGateway.inf** based upon the example certificate policy request provided in Appendix A (section 0) and customize the following entries:

   - In the [NewRequest] section, replace vpn.contoso.com used for the Subject Name with the chosen [_Customer_] VPN endpoint FQDN.

   - In the [Extensions] section, replace vpn.contoso.com used for the Subject Alternate Name with the chosen [_Customer_] VPN endpoint FQDN.

2. Save or copy the **VPNGateway.inf** file to a chosen location.

3. From an elevated command prompt, navigate to the folder that contains the **VPNGateway.inf** file and type:

   ```
   certreq -new VPNGateway.inf VPNGateway.req
   ```

4. Copy the newly created **VPNGateway.req** output file to a Certification Authority server, or Privileged Access Workstation (PAW).

5. Save or copy the **VPNGateway.req** file to a chosen location on the Certification Authority server, or Privileged Access Workstation (PAW).

6. From an elevated command prompt, navigate to the folder that contains the VPNGateway.req file created in the previous step and type:

   ```
   certreq -attrib “CertificateTemplate:[Customer]VPNGateway” -submit VPNgateway.req VPNgateway.cer
   ```

7. If prompted by the Certification Authority List window, select the appropriate Enterprise CA to service the certificate request.

8. Copy the newly created **VPNGateway.cer** output file to the RRAS server. 

9. Save or copy the **VPNGateway.cer** file to a chosen location on the RRAS server.

10. From an elevated command prompt, navigate to the folder that contains the VPNGateway.cer file created in the previous step and type:

    ```
    certreq -accept VPNGateway.cer
    ```

11. Run the Certificates MMC snap-in as described [here](https://docs.microsoft.com/dotnet/framework/wcf/feature-details/how-to-view-certificates-with-the-mmc-snap-in) selecting the **Computer account** option.

12. Ensure that a valid certificate exists for the RRAS server with the following properties:

    - **Intended Purposes:** Server Authentication, IP security IKE intermediate 

    - **Certificate Template:** [_Customer_] VPN Server

#### Example: VPNGateway.inf script

Here you can see an example script of a certificate request policy used to request a VPN gateway certificate using an out-of-band process.

>[!TIP]
>You can find a copy of the VPNGateway.inf script in the VPN Offering IP Kit under the Certificate Request Policies folder. Only update the 'Subject' and '\_continue\_' with customer-specific values.

```
[Version] 

Signature="$Windows NT$"

[NewRequest]
Subject = "CN=vpn.contoso.com"
Exportable = FALSE   
KeyLength = 2048     
KeySpec = 1          
KeyUsage = 0xA0      
MachineKeySet = True
ProviderName = "Microsoft RSA SChannel Cryptographic Provider"
RequestType = PKCS10 

[Extensions]
2.5.29.17 = "{text}"
_continue_ = "dns=vpn.contoso.com&"
```

## Create the VPN Users, VPN Servers, and NPS Servers Groups

In this procedure, you can add a new Active Directory (AD) group that contains the users allowed to use the VPN to connect to your organization network.

This group serves two purposes:

- It defines which users are allowed to autoenroll for the user certificates the VPN requires.

- It defines which users the NPS authorizes for VPN access.

By using a custom group, if you ever want to revoke a user’s VPN access, you can remove that user from the group.

You also add a group containing VPN servers and another group containing NPS servers. You use these groups to restrict certificate requests to their members.

>[!NOTE]
>We recommend VPN servers that reside in the DMA/Perimeter not be domain-joined. However, if you prefer to have the VPN servers domain-joined for better manageability (Group Policies, Backup/Monitoring agent, no local users to manage, and so on), then add an AD group to the VPN server certificate template.

### Configure the VPN Users group

1. On a domain controller, open Active Directory Users and Computers.

2. Right-click a container or organizational unit, select **New**, then select **Group**.

3. In **Group name**, enter **VPN Users**, then select **OK**.

4. Right-click **VPN Users** and select **Properties**.

5. On the **Members** tab of the VPN Users Properties dialog box, select **Add**.

6. On the Select Users dialog box, add all the users who need VPN access and select **OK**.

7. Close Active Directory Users and Computers.

### Configure the VPN Servers and NPS Servers groups

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

## Create the User Authentication template

In this procedure, you configure a custom client-server authentication template. This template is required because you want to improve the certificate’s overall security by selecting upgraded compatibility levels and choosing the Microsoft Platform Crypto Provider. This last change lets you use the TPM on the client computers to secure the certificate. For an overview of the TPM, see [Trusted Platform Module Technology Overview](https://docs.microsoft.com/windows/device-security/tpm/trusted-platform-module-overview).

**Procedure:**

1. On the CA, open Certification Authority.

2. In the navigation pane, right-click **Certificate Templates** and select **Manage**.

3. In the Certificate Templates console, right-click **User** and select **Duplicate Template**.

   >[!WARNING]
   >Do not select **Apply** or **OK** at any time prior to step 10.  If you select these buttons before entering ALL parameters, many choices become fixed and no longer editable. For example, on the **Cryptography** tab, if _Legacy Cryptographic Storage Provider_ shows in the Provider Category field, it becomes disabled, preventing any further change. The only alternative is to delete the template and recreate it.  

4. On the Properties of New Template dialog box, on the **General** tab, complete the following steps:

   1. In **Template display name**, type **VPN User Authentication**.

   2. Clear the **Publish certificate in Active Directory** check box.

5. On the **Security** tab, complete the following steps:

   1. Select **Add**.

   2. On the Select Users, Computers, Service Accounts, or Groups dialog box, enter **VPN Users**, then select **OK**.

   3. In **Group or user names**, select **VPN Users**.

   4. In **Permissions for VPN Users**, select the **Enroll** and **Autoenroll** check boxes in the **Allow** column.

      >[!TIP]
      >Make sure to keep the Read check box selected. In other words, you need the Read permissions for enrollment. 

   5. In **Group or user names**, select **Domain Users**, then select **Remove**.

6. On the **Compatibility** tab, complete the following steps:

   1. In **Certification Authority**, select **Windows Server 2012 R2**.

   2. On the **Resulting changes** dialog box, select **OK**.

   3. In **Certificate recipient**, select **Windows 8.1/Windows Server 2012 R2**.

   4. On the **Resulting changes** dialog box, select **OK**.

7. On the **Request Handling** tab, clear the **Allow private key to be exported** check box.

8. On the **Cryptography** tab, complete the following steps:

   1. In **Provider Category**, select **Key Storage Provider**.

   2. Select **Requests must use one of the following providers**.

   3. Select the **Microsoft Platform Crypto Provider** check box.

9. On the **Subject Name** tab, if you don’t have an email address listed on all user accounts, clear the **Include e-mail name in subject name** and **E-mail name** check boxes.

10. Select **OK** to save the VPN User Authentication certificate template.

11. Close the Certificate Templates console.

12. In the navigation pane of the Certification Authority snap-in, right-click **Certificate Templates**, select **New** and then select **Certificate Template to Issue**.

13. Select **VPN User Authentication**, then select **OK**.

14. Close the Certification Authority snap-in.

## Create the VPN Server Authentication template

In this procedure, you can configure a new Server Authentication template for your VPN server. Adding the IP Security (IPsec) IKE Intermediate application policy allows the server to filter certificates if more than one certificate is available with the Server Authentication extended key usage.

>[!IMPORTANT]
>Because VPN clients access this server from the public Internet, the subject and alternative names are different than the internal server name. As a result, you cannot autoenroll this certificate on VPN servers.

**Prerequisites:**

Domain-joined VPN servers

**Procedure:**

1. On the CA, open Certification Authority.

2. In the navigation pane, right-click **Certificate Templates** and select **Manage**.

3. In the Certificate Templates console, right-click **RAS and IAS Server** and select **Duplicate Template**.

4. On the Properties of New Template dialog box, on the **General** tab, in **Template display name**, enter a descriptive name for the VPN server, for example, **VPN Server Authentication** or **RADIUS Server**.

5. On the **Extensions** tab, complete the following steps:

    1. Select **Application Policies**, then select **Edit**.

    2. In the **Edit Application Policies Extension** dialog box, select **Add**.

    3. On the **Add Application Policy** dialog box, select **IP security IKE intermediate**, then select **OK**.
   
        Adding IP security IKE intermediate to the EKU helps in scenarios where more than one server authentication certificate exists on the VPN server. When IP security IKE intermediate is present, IPSec only uses the certificate with both EKU options. Without this, IKEv2 authentication could fail with Error 13801: IKE authentication credentials are unacceptable.

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

11. In the navigation pane of the Certification Authority snap-in, right-click **Certificate Templates**, select **New** and then select **Certificate Template to Issue**.

12. Select the name you chose in step 4 above, and click **OK**.

13. Close the Certification Authority snap-in.

## Create the NPS Server Authentication template

The third and last certificate template to create is the NPS Server Authentication template. The NPS Server Authentication template is a simple copy of the RAS and IAS Server template secured to the NPS Server group that you created earlier in this section.

You will configure this certificate for autoenrollment.

**Procedure:**

1. On the CA, open Certification Authority.

2. In the navigation pane, right-click **Certificate Templates** and select **Manage**.

3. In the Certificate Templates console, right-click **RAS and IAS Server**, and select **Duplicate Template**.

4. On the Properties of New Template dialog box, on the **General** tab, in **Template display name**, type **NPS Server Authentication**.

5. On the **Security** tab, complete the following steps:

    1. Select **Add**.

    2. On the **Select Users, Computers, Service Accounts, or Groups** dialog box, enter **NPS Servers**, then select **OK**.

    3. In **Group or user names**, select **NPS Servers**.

    4. In **Permissions for NPS Servers**, select the **Enroll** and **Autoenroll** check boxes in the **Allow** column.

    5. In **Group or user names**, select **RAS and IAS Servers**, then select **Remove**.

6. Select **OK** to save the NPS Server certificate template.

7. Close the Certificate Templates console.

8. In the navigation pane of the Certification Authority snap-in, right-click **Certificate Templates**, select **New** and then select **Certificate Template to Issue**.

9. Select **NPS Server Authentication**, and select **OK**.

10. Close the Certification Authority snap-in.

## Enroll and validate the user certificate

Because you’re using Group Policy to autoenroll user certificates, you need only update the policy, and Windows 10 will automatically enroll the user account for the correct certificate. You can then validate the certificate in the Certificates console.

**Procedure:**

1. Sign in to a domain-joined client computer as a member of the **VPN Users** group.

2. Press Windows key + R, type **gpupdate /force**, and press Enter.

3. On the Start menu, type **certmgr.msc**, and press Enter.

4. In the Certificates snap-in, under **Personal**, select **Certificates**. Your certificates appear in the details pane.

5. Right-click the certificate that has your current domain username, and then select **Open**.

6. On the **General** tab, confirm that the date listed under **Valid from** is today’s date. If it isn’t, you might have selected the wrong certificate.

7. Select **OK**, and close the Certificates snap-in.

## Enroll and validate the server certificates

Unlike the user certificate, you must manually enroll the VPN server’s certificate. After you’ve enrolled it, validate it by using the same process you used for the user certificate. Like the user certificate, the NPS server automatically enrolls its authentication certificate, so all you need to do is validate it.

>[!NOTE]
>You might need to restart the VPN and NPS servers to allow them to update their group memberships before you can complete these steps.

### Enroll and validate the VPN server certificate

1. On the VPN server’s Start menu, type **certlm.msc**, and press Enter.

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

10. Right-click the certificate that has your VPN server’s name, and then select **Open**.

11. On the **General** tab, confirm that the date listed under **Valid from** is today’s date. If it isn’t, you might have selected the incorrect certificate.

12. On the **Details** tab, select **Enhanced Key Usage**, and verify that **IP security IKE intermediate** and **Server Authentication** display in the list.

13. Select **OK** to close the certificate.

14. Close the Certificates snap-in.

### Validate the NPS server certificate

1. Restart the NPS server.

2. On the NPS server’s Start menu, type **certlm.msc**, and press Enter.

3. In the Certificates snap-in, under **Personal**, select **Certificates**.

    Your listed certificates appear in the details pane.

4. Right-click the certificate that has your NPS server’s name, and then select **Open**.

5. On the **General** tab, confirm that the date listed under **Valid from** is today’s date. If it isn’t, you might have selected the incorrect certificate.

6. Select **OK** to close the certificate.

7. Close the Certificates snap-in.

## Next steps

[Step 3. Configure the Remote Access Server for Always On VPN](vpn-deploy-ras.md): In this step, you configure Remote Access VPN to allow IKEv2 VPN connections, deny connections from other VPN protocols, and assign a static IP address pool for issuance of IP addresses to connecting authorized VPN clients.
