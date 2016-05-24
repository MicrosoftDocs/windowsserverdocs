---
title: Verify Certificate Security
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: d9269050-802c-4adb-8db3-aa59a0eb8bb2
author: Femila
---
# Verify Certificate Security
  You can use this procedure to verify certificate security after you complete a domain rename operation. If you use enterprise certificates, perform all the following procedures after the domain rename operation is complete.  
  
## Preparing URLs for CRL distribution point and Authority Information Access \(AIA\) extensions after a domain rename  
 To ensure that the old certificates function properly after a domain rename operation, make an alias \(CNAME\) resource record Domain Name System \(DNS\) entry that redirects the old Hypertext Transfer Protocol \(HTTP\) server \(that services the Certificate Revocation List \(CRL\) of the certification authority \(CA\)\) name query to the new DNS name for the server. This redirection causes the HTTP URLs in the old certificates to be valid. Client computers can then obtain CRLs and CA certificates for verification.  
  
> [!NOTE]  
>  You can remove the alias \(CNAME\) resource record after you know that the existing certificates have been renewed.  
  
> [!NOTE]  
>  If you only have Lightweight Directory Access Protocol \(LDAP\) URLs in the certificates, all the previously issued certificates will no longer be validated. The only workaround for correcting the LDAP CRL distribution point and AIA pointers is to renew the entire CA hierarchy and reissue the End Entity certificates. Expect public key infrastructure \(PKI\) downtime until these issues are resolved.  
  
 Membership in **Account Operators**, **Domain Admins**, or **Enterprise Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To configure the redirecting alias DNS entry  
  
1.  Open the DNS Manager snap\-in. To open DNS Manager, click **Start**, click **Administrative Tools**, and then click **DNS**.  
  
2.  In the console tree, expand the DNS server node, and locate the old DNS zone.  
  
3.  Right\-click the old DNS zone, and then click **New Alias \(CNAME\)**.  
  
4.  In **Alias name**, type the original fully qualified domain name \(FQDN\) of the HTTP server.  
  
5.  In **Fully qualified domain name for target host**, type the new FQDN of the HTTP server, and then click **OK**.  
  
 At this point you can test the redirection by pinging the FQDN of the old HTTP server. The ping should be remapped to the new FQDN of the HTTP server.  
  
## Verifying the use of UPNs  
 Authentication protocols, such as Kerberos \(Smart Card Logon\), require the user principal name \(UPN\) in the user certificate to match the UPN in the user account \(implicitly or explicitly\) in Active Directory Domain Services \(AD DS\). You should be aware of the differences in behavior between implicit and explicit UPNs.  
  
-   **Implicit UPN**: If a user account in AD DS does not have an explicitly assigned value for its UPN attribute, it is assumed to have an implicit UPN for authentication purposes that is based on the DNS name of the domain in which the account exists. When the DNS name of a domain changes as a result of the domain rename operation, the implicit UPNs of all user accounts in the domain also change. Both the old and the new implicit UPN forms will be accepted for authentication until the attribute cleanup procedures are complete \(see [Perform Attribute Cleanup](../Topic/Perform-Attribute-Cleanup.md)\). After the attribute cleanup procedures are complete, only the new implicit UPN form will be accepted.  
  
    > [!NOTE]  
    >  This behavior implies that if you want to continue using implicit UPNs for user accounts, you must reissue all existing authentication certificates after the DNS name of a domain has changed and before you perform the attribute cleanup procedures.  
  
-   **Explicit UPN**: If a user account in AD DS has an explicitly assigned value for its UPN attribute, it is said to have an explicit UPN that can be used for authentication purposes. When the DNS name of a domain changes as a result of the domain rename operation, the explicit UPNs of user accounts in the domain are not affected. Therefore, if you are using explicit UPNs for user accounts, no maintenance is necessary after the domain rename operation.  
  
## Enabling certificate enrollment in a renamed domain  
  
-   To enable certificate enrollment using either autoenrollment or the Certificates Microsoft Management Console \(MMC\) snap\-in in the new domain, you have to make a small change in AD DS to the Enrollment Services Container in the configuration directory partition \(cn\=Enrollment Services,cn\=Public Key Services, cn\=Services,cn\=Configuration,dc\=ForestRootDomain\). The CA object in this container has a **dNSHostName** attribute that still contains the old DNS name of the CA computer. You can use the following Microsoft Visual Basic® script to change the value of this attribute, as follows:  
  
    ```  
    Container = “LDAP://CN=YOURCA,CN=Enrollment Services,CN=Public Key Services, CN=Services,CN=Configuration,DC=YoursubDomain,DC=YourDomain,DC=com”  
    Set obj = GetObject(container)  
    Obj.dnshostname = “NEWDNSNAMEOFTHECAMACHINE”  
    Obj.setinfo  
    ```  
  
    > [!NOTE]  
    >  You must perform this procedure for all the CAs in your domain. Also note that the container name depends on your domain configuration.  
  
-   You must also change the registry on the CA computer to reflect the new DNS name for the CA computer.  
  
    > [!CAUTION]  
    >  Incorrectly editing the registry may severely damage your system. Before making changes to the registry, you should back up any valued data on the computer.  
  
     Membership in **Account Operators**, **Domain Admins**, or **Enterprise Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
-   #### To update the DNS name of the CA computer  
  
    1.  On the CA computer, click **Start**, click **Run**, type **regedit** to open the Registry Editor, and then locate the entry **CAServerName** under **HKLM\\System\\CurrentControlSet\\CertSvc\\Configuration\\YourCAName**.  
  
    2.  Change the value in **CAServerName** to correspond to the new DNS host name.  
  
-   To enable proper Web enrollment for the user, you must also update the file that is used by the Active Server Pages \(ASPs\) for Web enrollment. The following change must be made on all the CA computers in your domain.  
  
     Membership in **Account Operators**, **Domain Admins**, or **Enterprise Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
    #### To update the Web enrollment file  
  
    1.  On the CA computer, search for the Certdat.inc file. If you have used default installation settings, this file should be located in %windir%\\system32\\certsrv directory.  
  
    2.  Open the file, which appears as follows:  
  
        ```  
        <%' CODEPAGE=65001 'UTF-8%>  
        <%' certdat.inc - (CERT)srv web - global (DAT)a  
          ' Copyright (C) Microsoft Corporation, 1998 - 1999 %>  
        <%' default values for the certificate request  
        sDefaultCompany=""  
        sDefaultOrgUnit=""  
        sDefaultLocality=""  
        sDefaultState=""  
        sDefaultCountry=""  
  
        ' global state  
        sServerType="Enterprise" 'vs StandAlone  
        sServerConfig="OLDDNSNAME\YourCAName"  
        sServerDisplayName="YourCAName"  
        nPendingTimeoutDays=10  
        ```  
  
    3.  Change the SServerConfig entry so that it has the NewDNSName of the CA computer.  
  
-   If the CA was installed with the shared folder option \(which is available only if the server was upgraded to [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]from Windows Server 2003\), the file Certsrv.txt \(under the shared folder\) should be edited to reflect the new DNS name of the CA computer. Save a copy of this file before you edit it, open the file by using Notepad.exe, make the change to the DNS name of the CA computer, and then save the file.  
  
-   If you have a Web proxy computer \(for CA Web pages\) whose DNS host name changed as a result of the domain rename operation, you have to make changes to the following registry key:  
  
     **HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\CertSvc\\Configuration**  
  
     Under this key there is a value named **WebClientCAMachine** that holds the DNS name of the CA computer. Change this value to correspond to the new DNS name.  
  
 To update the Netscape revocation check mechanism  
  
-   On all computers where Web pages for the CA reside \(for example, on the Web proxy and the CA computers\) there is a file named nsrev\_CANAME.asp that contains the DNS host name of the CA computer that is used by the Netscape revocation checking mechanism. Search for this file, and change the DNS host name of the CA computer that is embedded in the file.  
  
     If you have used the default installations settings, this file will be in the folder %Windir%\\system32\\certsrv\\certenroll and its content looks like the following.  
  
    ```  
    <%   
    Response.ContentType = "application/x-netscape-revocation"   
    serialnumber = Request.QueryString  
    set Admin = Server.CreateObject("CertificateAuthority.Admin")  
    stat = Admin.IsValidCertificate("CAMachineDnsHostname\CANAME", serialnumber)  
    if stat = 3 then Response.Write("0") else Response.Write("1") end if  
    %>  
    ```  
  
     Open this file with Notepad.exe, and change CAMachineDnsHostName to correspond to the new DNS host name.  
  
## Verifying the validity of CRL distribution point and AIA extensions  
 CRL distribution point  and AIA extensions can be hard coded. Therefore, the extension URLs will not reflect the new DNS name of the CA computer. First, check to see whether the extensions are hard coded, and, if they are, you must change the URL to reflect the new DNS name.  
  
 You must perform this procedure on every CA computer in each renamed domain.  
  
 The **Manage CA** permission on the CA computer is the minimum required to complete this procedure. **Manage CA** is a special privilege that you can configure with the Certification Authority snap\-in.  
  
#### To check whether the CRL distribution point and AIA extensions are flexible  
  
1.  Open the Certification Authority snap\-in. To open Certification Authority, see Add the Certificates Snap\-in to an MMC \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=124114](http://go.microsoft.com/fwlink/?LinkId=124114)\).  
  
2.  Right\-click the CA name, and then click **Properties**.  
  
3.  On the **Extensions** tab, check the flexibility of the CRL distribution point and AIA extensions, as follows:  
  
    1.  Flexible extensions have the following format:  
  
         http:\/\/\<ServerDNSName\>\/CertEnroll\/\<CAName\>\<CRLNameSuffix\>\<DeltaCRLAllowed\>.crl  
  
    2.  Hard\-coded extensions have the following format:  
  
         http:\/\/mydnsname.mycompanyname.com\/certenroll\/\<CAName\>\<CRLNameSuffix\>\<DeltaCRLAllowed\>.crl  
  
4.  If the CRL distribution point and AIA extensions are flexible, you do not have to change the extensions.  
  
5.  If the CRL distribution point and AIA extensions are not flexible, change the extension URLs to reflect the new DNS name of the CA computer.  
  
6.  Repeat this procedure for every CA computer in the domain.  
  
## Renewing subordinate and issuing CA certificates  
 After all the preceding CA\-related procedures have been performed on all CA computers, you can renew certificates to update the CRL distribution point  and AIA locations in the CA certificate. Renew all subordinate and issuing CA certificates in hierarchical order. In addition, update Group Policy on all the computers to ensure that they have new root CA certificates.  
  
## Publish new CRLs  
 To publish new Delta and Base CRLs, run the following command on all the CA computers in the renamed domain:  
  
 `Certutil.exe –crl`  
  
## Updating domain controller certificates  
 The domain controller certificates have to be updated so that any authentication mechanism that is based on certificates \(for example, replication and Smart Card through Kerberos\) continues to work. To update these certificates, if template\-based autoenrollment is set before the domain rename operation, increment the version number for Domain Controller Authentication and Directory E\-mail Replication Certificate templates to force re\-enrollment. Otherwise, use Group Policy to set Machine Based Autoenrollment. The domain controllers will re\-enroll and supersede the existing V1 Domain Controller Certificate.  
  
 You might also want to increase the version number on other templates \(particularly the templates that are related with authentication\) to set autoenrollment for the users and their computers.  
  
 Fix Cross and Qualified Subordination Certificates and name constraints. For more information, see Planning and Implementing Cross\-Certification and Qualified Subordination Using Windows Server 2003 \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=123176](http://go.microsoft.com/fwlink/?LinkID=123176)\).  
  
## Changing the user identity for the NDES add\-on  
 If the Network Device Enrollment Services \(NDES\) add\-on for Microsoft Certificate Services is installed, you might have to change the identity of the user under whose context the NDES process was created. For example, if NDES was originally running with the identity OriginalDomainName\\UserName, after domain rename operation, Internet Information Services \(IIS\) will attempt to start the process with the same identity. \(The IIS metabase is not altered during the domain rename operation.\) You can change this identity in IIS.  
  
#### To change the user identity for NDES in IIS  
  
1.  In the IIS MMC snap\-in, browse to **Application pools**.  
  
2.  Under **Application pools**, right\-click the folder for NDES, and then click **Properties**.  
  
3.  On the **Identity** tab, change the identity for NDES to correspond to the new domain name.  
  
  