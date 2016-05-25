---
title: Procedure: Deploy IPsec Policy to DNS Servers
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 07cc26a3-e5f2-471c-8f3d-0a27105578c6
author: vhorne
---
# Procedure: Deploy IPsec Policy to DNS Servers
Use the following procedure to configure IP Security \(IPsec\) rules for the DNS servers in your organization that will provide DNS resolution for client computers. IPsec rules are configured to request authentication for all DNS queries.  
  
You can deploy IPsec rules through one of the following mechanisms:  
  
-   **Domain Controllers organizational unit \(OU\):** If the DNS servers in your domain are Active Directory\-integrated, you can deploy IPsec policy settings using the Domain Controllers OU. This option is recommended to make configuration and deployment easier.  
  
-   **DNS Server OU or security group:** If you have DNS servers that are not domain controllers, then consider creating a separate OU or a security group with the computer accounts of your DNS servers.  
  
-   **Local firewall configuration:** Use this option if you have DNS servers that are not domain members or if you have a small number of DNS servers that you want to configure locally.  
  
Use the following procedure to deploy IPsec policy to the Domain Controllers OU. If you wish to deploy IPsec policy to a different group of computers, use a different OU or create a security group and use security group filtering to apply IPsec settings to your DNSSEC Group Policy object \(GPO\).  
  
Membership in the **Domain Admins** group, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
## Configure IPsec policy  
  
-   [To configure IPsec policy using DNS Manager](../Topic/Procedure--Deploy-IPsec-Policy-to-DNS-Servers.md#DNSMgr)  
  
-   [To configure IPsec policy using the command line](../Topic/Procedure--Deploy-IPsec-Policy-to-DNS-Servers.md#Cmd)  
  
In the following procedure, IPsec policy is deployed on all domain controllers because it is assumed that domain controllers are also DNS servers. To deploy this policy on DNS servers that are not domain controllers, create and use a custom OU or security group. To deploy this policy on computers that are not domain members, use the Local Group Policy Editor to perform the following procedures.  
  
> [!NOTE]  
> Complete the following procedure twice. First, create a rule for UDP connections, and then create a rule for TCP connections.  
  
### <a name="DNSMgr"></a>To configure IPsec policy using DNS Manager  
  
1.  On a domain controller or a computer with the Group Policy Management feature installed, click **Start**, click **Run**, type **gpme.msc**, and then press Enter.  
  
2.  In the **Browse for a Group Policy Object** dialog box, double\-click **Domain Controllers.<domain.com>**, click **Default Domain Controllers Policy**, and then click **OK**. The Group Policy Management Editor opens.  
  
3.  In the console tree, open **Computer Configuration\\Policies\\Windows Settings\\Security Settings\\Windows Firewall with Advanced Security\\Windows Firewall with Advanced Security \- LDAP**.  
  
4.  Right\-click **Connection Security Rules**, and then click **New Rule**. The New Connection Security Rule Wizard opens.  
  
5.  On the **Rule Type** page, choose **Custom**, and then click **Next**.  
  
6.  On the **Endpoints** page, choose **Any IP address** for endpoint 1 and **Any IP Address** for endpoint 2, and then click **Next**.  
  
7.  On the **Requirements** page, choose **Request authentication for inbound and outbound connections**, and then click **Next**.  
  
8.  On the **Authentication Method** page, choose **Advanced**, and then click **Customize**.  
  
9. In the **Customize Advanced Authentication Methods** dialog box, under **First authentication**, click **Add**.  
  
10. In the **Add First Authentication Method** dialog box, choose **Computer certificate from this certification authority \(CA\)**.  Verify that **Signing algorithm** is **RSA** and **Certificate store type** corresponds to the type of CA you are using, either **Root CA** or **Intermediate CA**. Click **Browse**, and select the name of the CA that you used in the previous procedure to create and deploy a certificate for DNS server authentication, and then click **OK**.  
  
    > [!IMPORTANT]  
    > If multiple certificates from the same CA are present on the DNS server, IPsec authentication might fail due to an incorrect certificate being chosen. For more information, see [Certificate Selection](../Topic/Procedure--Deploy-IPsec-Policy-to-DNS-Servers.md#BKMK_certificateselection).  
  
11. Click **OK** to close the **Add First Authentication Method** dialog box, click **OK** in **Customize Advanced Authentication Methods**, and then click **Next**.  
  
12. On the **Protocol and Ports** page, next to **Protocol type**, choose **UDP**. Next to **Endpoint 1 port**, choose **Specific ports**, and then type **53**. Next to **Endpoint 2 port**, choose **All ports**, and then click **Next**.  
  
13. On the **Profile** page, verify that the **Domain**, **Private**, and **Public** check boxes are selected, and then click **Next**.  
  
14. Type a name and description for the rule. Use a name that will be easy to recognize, for example, **DNSSEC UDP**.  
  
15. Click **Finish** to create the rule.  
  
Next, create an identical rule for DNS TCP connections by repeating this procedure and using TCP as the protocol type. You can also create a new rule using an existing rule as a template. To duplicate a rule, right\-click an existing rule, click **Copy**, right\-click inside the console details pane, and then click **Paste**. Edit the duplicate rule to provide a unique name and settings.  
  
### <a name="Cmd"></a>To configure IPsec policy using the command line  
  
1.  Open an elevated command prompt.  
  
2.  Enter the following command twice.  
  
    ```  
    netsh advfirewall consec add rule name="DNSSEC UDP" endpoint1=any endpoint2=any action=requestinrequestout port1=53 port2=any protocol=<protocol> auth1=computerkerb,computercert auth1ca=<CaName>  
    ```  
  
    The first time that you enter this command, replace <protocol> with **UDP**, and replace <CaName> with the name of the CA that is used. The second time that you enter the command, use a different rule name such as ”DNSSEC TCP”, replace <protocol> with **TCP** and replace <CaName> with the name of the CA that is used. See the following examples.  
  
Example UDP rule:  
  
```  
netsh advfirewall consec add rule name="DNSSEC UDP" endpoint1=any endpoint2=any action=requestinrequestout port1=53 port2=any protocol=UDP auth1=computerkerb,computercert auth1ca=”DC=com, DC=woodgrovebank, CN=woodgrovebank-DC1-CA”  
```  
  
Example TCP rule:  
  
```  
netsh advfirewall consec add rule name="DNSSEC TCP" endpoint1=any endpoint2=any action=requestinrequestout port1=53 port2=any protocol=TCP auth1=computerkerb,computercert auth1ca=” DC=com, DC=woodgrovebank, CN=woodgrovebank-DC1-CA”  
```  
  
Use the following command to verify that rules were created successfully.  
  
```  
netsh advfirewall consec show rule name=all type=dynamic  
```  
  
## <a name="BKMK_certificateselection"></a>Certificate Selection  
The following options are available to ensure that the correct certificate on a DNS server is selected for IPsec authentication. For information about deploying this certificate, see [Procedure: Deploy Certificates for DNS Server Authentication](../Topic/Procedure--Deploy-Certificates-for-DNS-Server-Authentication.md).  
  
-   Use a different CA to issue DNS server certificates than the one used to issue other certificates. To accomplish this, install Active Directory Certificate Services \(AD CS\) on a domain controller or member server and use this CA only for issuing DNS server authentication certificates.  
  
-   If you have deployed Network Access Protection \(NAP\) on your network, you can add the **Domain Name System \(DNS\) Server Trust**, **IP security IKE intermediate**, and **Server Authentication** application policies to NAP exemption certificates that are provisioned on DNS servers. To use a NAP exemption certificate with DNS server authentication, choose the **Computer health certificate from this certification authority \(CA\)** option instead of the **Computer certificate from this certification authority \(CA\)**.  
  
-   If you have not deployed NAP, you can still add the **System Health Authentication** application policy to the certificate that you use for DNS server authentication, and then configure IPsec policy to require a computer health certificate. You should only use this method if you must use the same CA to issue multiple certificates to your DNS servers.  
  
## See also  
[DNSSEC in Windows](../Topic/DNSSEC-in-Windows.md)  
  
[DNSSEC Deployment Planning](../Topic/DNSSEC-Deployment-Planning.md)  
  
