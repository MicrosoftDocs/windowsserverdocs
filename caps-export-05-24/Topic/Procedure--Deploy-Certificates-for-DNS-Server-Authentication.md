---
title: Procedure: Deploy Certificates for DNS Server Authentication
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c497032b-5663-4f13-b2e1-b84dcd46ab2c
---
# Procedure: Deploy Certificates for DNS Server Authentication
Use the following procedures to configure and publish server certificates for IPsec authentication, and to enable certificate auto\-enrollment on your DNS servers.  
  
> [!IMPORTANT]  
> When choosing a certification authority \(CA\) to issue certificates for IPsec authentication, it is important that you consider whether or not other certificates will be issued by the same CA. For more information, see [Certificate Selection](../Topic/Procedure--Deploy-IPsec-Policy-to-DNS-Servers.md#BKMK_certificateselection).  
  
You can deploy certificates to DNS servers through one of the following mechanisms:  
  
-   **Domain Controllers organizational unit \(OU\)**: If the DNS servers in your domain are Active Directory\-integrated, you can deploy IPsec policy settings using the Domain Controllers OU. This option is recommended to make configuration and deployment easier.  
  
-   **DNS Server OU or security group**: If you have DNS servers that are not domain controllers, then consider creating a separate OU or a security group with the machine accounts of your DNS servers.  
  
-   **Local firewall configuration**: Use this option if you have DNS servers that are not domain members or if you have a small number of DNS servers that you want to configure locally.  
  
Use the following procedures to deploy DNS server certificates to the Domain Controllers OU using auto\-enrollment. If you wish to deploy DNS server certificates manually or issue certificates to a different group of computers, modify the permission settings on the **Security** tab in certificate template properties.  
  
Membership in the **Domain Admins** group, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
## Configure certificate templates  
A certificate template must be created to provide authentication of DNSSEC\-protected communications. This certificate template will be configured with the Domain Name System \(DNS\) Server Trust application policy.  
  
> [!IMPORTANT]  
> To configure and publish a certificate template for DNSSEC, the computer must be configured as an Enterprise certification authority \(CA\).  
  
#### To configure a certificate template  
  
1.  Click **Start**, click **Run**, type **certtmpl.msc**, and then press Enter.  
  
2.  In the details pane, right\-click **RAS and IAS Server**, and then click **Duplicate Template**.  
  
3.  Select **Windows Server 2003 Enterprise**, and then click **OK**.  
  
4.  Under **Template display name**, type **DNS Server**, and then select the **Publish certificate in Active Directory** check box.  
  
5.  Click the **Request Handling** tab, and then select the **Allow private key to be exported** check box.  
  
6.  Click the **Extensions** tab, and then click **Application Policies**.  
  
7.  If the certification authority is running [!INCLUDE[firstref_server_7](../Token/firstref_server_7_md.md)]:  
  
    1.  Click **Edit**, click **Add**, click **Domain Name System \(DNS\) Server Trust**, and then click **OK**.  
  
8.  If the certification authority is running [!INCLUDE[firstref_longhorn](../Token/firstref_longhorn_md.md)] or an earlier operating system:  
  
    1.  Click **Edit**, click **Add**, and then click **New**.  
  
    2.  In the **New Application Policy** dialog box, under **Name**, type **Domain Name System \(DNS\) Server Trust**, and under **Object identifier**, type **1.3.6.1.4.1.311.64.1.1**, and then click **OK** twice.  
  
    > [!IMPORTANT]  
    > Ensure that you enter the object identifier exactly as specified. This is required for servers to successfully negotiate IPsec with clients.  
  
9. Click **Add**, click **IP security IKE intermediate**, and then click **OK**.  
  
10. In **Edit Application Policies Extension**, verify that the following are listed under **Application policies**:  
  
    -   Client Authentication  
  
    -   Domain Name System \(DNS\) Server Trust  
  
    -   IP security IKE intermediate  
  
    -   Server Authentication  
  
11. Click **OK**, click **Key Usage**, and then click the **Edit**.  
  
12. Under **Signature**, select the **Digital signature** and **Signature is proof or origin \(nonrepudiation\)** check boxes.  
  
13. Under **Encryption**, choose **Allow key exchange only with key encryption \(key encipherment\)**, select the **Allow encryption of user data** and **Make this extension critical** check boxes, and then click **OK**.  
  
14. Click the **Security** tab, click **RAS and IAS Servers**, and then click **Remove**.  
  
15. Click **Add**, type **Domain Controllers**, and then click **OK**. Alternatively, type the name of the OU or security group you will use to deploy DNSSEC server policy.  
  
16. Select the **Allow** permission for **Enroll** and **Autoenroll** for the **Domain Controllers** security group or another security group you will use to deploy DNSSEC server policy.  
  
17. Click **OK**, and then close the certificate templates console.  
  
## Publish certificate templates  
Use the following procedure to allow the CA to issue the new certificate template.  
  
#### To publish certificate templates  
  
1.  Click **Start**, click **Run**, type **certsrv.msc**, and then press Enter.  
  
2.  In the console tree, right\-click **Certificate Templates**, point to **New**, and then click **Certificate Template to Issue**.  
  
3.  Click **DNS Server**, and then click **OK**.  
  
4.  In the console tree, click **Certificate Templates**, and in the details pane under **Name**, verify that **DNS Server** is displayed.  
  
5.  Close the certification authority console.  
  
## Enable certificate auto\-enrollment  
If you will use auto\-enrollment to issue certificates for IPsec authentication, you must enable auto\-enrollment in Group Policy. You do not need to perform this procedure to enroll certificates manually on your DNS servers.  
  
#### To enable certificate auto\-enrollment  
  
1.  On a domain controller or a computer with the Group Policy Management feature installed, click **Start**, click **Run**, type **gpme.msc**, and then press Enter.  
  
2.  In the **Browse for a Group Policy Object** dialog box, double\-click **Domain Controllers.<domain.com>**, click **Default Domain Controllers Policy**, and then click **OK**. The Group Policy Management Editor opens.  
  
    > [!IMPORTANT]  
    > If you use a different GPO to manage DNSSEC settings for your DNS servers, then enable certificate auto\-enrollment in this GPO instead.  
  
3.  In the console tree, open **Computer Configuration\\Policies\\Windows Settings\\Security Settings\\Public Key Policies**.  
  
4.  In the details pane, double\-click **Certificate Services Client – Auto\-Enrollment**.  
  
5.  In the **Certificate Services Client – Auto\-Enrollment Properties** dialog box, next to **Configuration Model** select **Enabled** from the drop\-down menu, select the check boxes next to **Renew expired certificates, update pending certificates, and remove revoked certificates** and **Update certificates that use certificate templates**, and then click **OK**.  
  
6.  Close the Group Policy Management Editor.  
  
## See also  
[DNSSEC in Windows](../Topic/DNSSEC-in-Windows.md)  
  
[DNSSEC Deployment Planning](../Topic/DNSSEC-Deployment-Planning.md)  
  
