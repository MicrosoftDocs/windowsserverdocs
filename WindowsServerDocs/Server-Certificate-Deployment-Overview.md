---
title: Server Certificate Deployment Overview
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ca5c3e04-ae25-4590-97f3-0376a9c2a9a2
---
# Server Certificate Deployment Overview
This topic contains the following sections.

-   [Server certificate deployment components](#bkmk_components)

-   [Server certificate deployment process overview](#bkmk_process)

## <a name="bkmk_components"></a>Server certificate deployment components
You can use this guide to install Active Directory® Certificate Services \(AD CS\) as an Enterprise root certification authority \(CA\) and to enroll server certificates to SDN infrastructure servers, as well as to servers that are running Network Policy Server \(NPS\), Routing and Remote Access service \(RRAS\), or both NPS and RRAS.

If you deploy SDN with certificate\-based authentication, servers are required to use a server certificate to prove their identities to other servers so that they achieve secure communications.

The following illustration shows the components that are required to deploy server certificates to servers in your SDN infrastructure.

![](media/server_cert_overview.png)

> [!NOTE]
> In the illustration above, multiple servers are depicted: DC1, CA1, WEB1, and many SDN servers. This guide provides instructions for deploying and configuring CA1 and WEB1, and for configuring DC1, which this guide assumes you have already installed on your network. If you have not already installed your Active Directory domain, you can do so by using the [Core Network Guide](https://technet.microsoft.com/library/mt604042.aspx) for Windows Server 2016.

For more information on each item depicted in the illustration above, see the following:

-   [CA1](#bkmk_ca1)

-   [WEB1](#bkmk_web1)

-   [DC1](#bkmk_dc1)

-   [SDN Infrastructure and other servers](#bkmk_nps1)

### <a name="bkmk_ca1"></a>CA1 running the AD CS server role
In this scenario, the Enterprise Root certification authority \(CA\) is also an issuing CA. The CA issues certificates to server computers that have the correct security permissions to enroll a certificate. Active Directory Certificate Services \(AD CS\) is installed on CA1.

For larger networks or where security concerns provide justification, you can separate the roles of root CA and issuing CA, and deploy subordinate CAs that are issuing CAs.

In the most secure deployments, the Enterprise Root CA is taken offline and physically secured. 

#### CAPolicy.inf
Before you install AD CS, you configure the CAPolicy.inf file with specific settings for your deployment.

#### Copy of the **RAS and IAS servers** certificate template
When you deploy server certificates, you make one or more copies of the **RAS and IAS servers** certificate template and then configure the template(s) according to your requirements and the instructions in this guide. 

You can configure one template copy with multiple Active Directory groups, and then assign certificate enrollment permissions to each group; or you can create multiple template copies, each with a different name and one or more groups configured on the template. 

You utilize a copy of the template rather than the original so that the configuration of the original template is preserved for possible future use. You configure the copy of the **RAS and IAS servers** template so that the CA can create server certificates that it issues to the groups in Active Directory Users and Computers that you specify.

#### Additional CA1 configuration
The CA publishes a certificate revocation list \(CRL\) that computers must check to ensure that certificates that are presented to them as proof of identity are valid certificates and have not been revoked. You must configure your CA with the correct location of the CRL so that computers know where to look for the CRL during the authentication process.

### <a name="bkmk_web1"></a>WEB1 running the Web Services \(IIS\) server role
On the computer that is running the Web Server \(IIS\) server role, WEB1, you must create a folder in Windows Explorer for use as the location for the CRL and AIA.

#### Virtual directory for the CRL and AIA
After you create a folder in Windows Explorer, you must configure the folder as a virtual directory in Internet Information Services \(IIS\) Manager, as well as configuring the access control list for the virtual directory to allow computers to access the AIA and CRL after they are published there.

### <a name="bkmk_dc1"></a>DC1 running the AD DS and DNS server roles
DC1 is the domain controller and DNS server on your network.

#### Group Policy default domain policy
After you configure the certificate template on the CA, you can configure the default domain policy in Group Policy so that certificates are autoenrolled to NPS servers. Group Policy is configured in AD DS on the server DC1.

#### Active Directory Group Accounts
You must create new Active Directory Group Accounts, or groups, for your SDN servers. You can create one group for all SDN servers, however it is recommended that you create one group for each type of SDN server. For example, you can create one group for computers or VMs that are running Network Controller, and a different group for computers or VMs that are Software Load Balancing Multiplexer (MUX) servers.

After you create new groups, you add servers as group members, and then these groups are configured on the certificate template on the CA to specify what servers receive autoenrolled certificates,

#### DNS alias \(CNAME\) resource record
You must create an alias \(CNAME\) resource record for the Web server to ensure that other computers can find the server, as well as the AIA and the CRL that are stored on the server. In addition, using an alias CNAME resource record provides flexibility so that you can use the Web server for other purposes, such as hosting Web and FTP sites.

### <a name="bkmk_nps1"></a>SDN Infrastructure and other servers
Before you perform the tasks in this guide, you should already have SDN and other servers installed on your network.

#### Group Policy applied and certificate enrolled to servers
After you have configured the certificate template and autoenrollment, you can refresh Group Policy on all target servers. At this time, the servers enroll the server certificate from CA1.

### <a name="bkmk_process"></a>Server certificate deployment process overview

> [!NOTE]
> The details of how to perform these steps are provided in the section [Server Certificate Deployment](Server-Certificate-Deployment.md).

The process of configuring server certificate enrollment occurs in these stages:

1.  On DC1, create one or more new SDN server groups in Active Directory Users and Computers, and then add servers to each group.

2.  On WEB1, install the Web Server \(IIS\) role.

3.  On DC1, create an alias \(CNAME\) record for your Web server, WEB1.

4.  Configure your Web server to host the CRL from the CA, then publish the CRL and copy the Enterprise Root CA certificate into the new virtual directory.

5.  On the computer where you are planning to install AD CS, assign the computer a static IP address, rename the computer, join the computer to the domain, and then log on to the computer with a user account that is a member of the Domain Admins and Enterprise Admins groups.

6.  On the computer where you are planning to install AD CS, configure the CAPolicy.inf file with settings that are specific to your deployment.

5.  Install the AD CS server role and perform additional configuration of the CA.

6.  Copy the CRL and CA certificate from CA1 to the share on the Web server WEB1.

7.  On the CA, configure one or more server certificate templates. The CA issues certificates based on a certificate template, so you must configure the template for the server certificate before the CA can issue a certificate.

8.  Configure server certificate autoenrollment in Group Policy. When you configure autoenrollment, all domain member SDN and other servers that you have specified with Active Directory group memberships automatically receive a server certificate when Group Policy on each server is refreshed. If you add more servers later, they will automatically receive a server certificate, too.

9. Refresh Group Policy on servers. When Group Policy is refreshed, the servers receive the server certificate, which is based on the template that you configured in the previous step. This certificate is used by the server to prove its identity to other servers during the authentication process.

    > [!NOTE]
    > All domain member computers automatically receive the Enterprise Root CA’s certificate without the configuration of autoenrollment. This certificate is different than the server certificate that you configure and distribute by using autoenrollment. The CA's certificate is automatically installed in the Trusted Root Certification Authorities certificate store for all domain member computers so that they will trust certificates that are issued by this CA. 

10. Verify that SDN and other servers enrolled a valid server certificate.


