---
title: Server Certificate Deployment Planning
description: This topic is part of the guide Deploy Server Certificates for 802.1X Wired and Wireless Deployments
manager: brianlic
ms.topic: article
ms.assetid: 7eb746e0-1046-4123-b532-77d5683ded44
ms.prod: windows-server-threshold
ms.technology: networking
ms.author: pashort
author: shortpatti
---
# Server Certificate Deployment Planning

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

Before you deploy server certificates, you must plan the following items:  
  
-   [Plan basic server configuration](#bkmk_basic)  
  
-   [Plan domain access](#bkmk_domain)  
  
-   [Plan the location and name of the virtual directory on your Web server](#bkmk_virtual)  
  
-   [Plan a DNS alias (CNAME) record for your Web server](#bkmk_cname)  
  
-   [Plan configuration of CAPolicy.inf](#bkmk_capolicy)  
  
-   [Plan configuration of the CDP and AIA extensions on CA1](#bkmk_cdp)  
  
-   [Plan the copy operation between the CA and the Web server](#bkmk_copy)  
  
-   [Plan the configuration of the server certificate template on the CA](#bkmk_template)  
  
## <a name="bkmk_basic"></a>Plan basic server configuration  
After you install  Windows Server 2016 on the computers that you are planning to use as your certification authority and Web server, you must rename the computer and assign and configure a static IP address for the local computer.  
  
For more information, see the  Windows Server 2016 [Core Network Guide](../../../core-network-guide/Core-Network-Guide.md).  
  
## <a name="bkmk_domain"></a>Plan domain access  
To log on to the domain, the computer must be a domain member computer and the user account must be created in AD DS before the logon attempt. In addition, most procedures in this guide require that the user account is a member of the Enterprise Admins or Domain Admins groups in Active Directory Users and Computers, so you must log on to the CA with an account that has the appropriate group membership.  
  
For more information, see the  Windows Server 2016 [Core Network Guide](../../../core-network-guide/Core-Network-Guide.md).  
  
## <a name="bkmk_virtual"></a>Plan the location and name of the virtual directory on your Web server  
To provide access to the CRL and the CA certificate to other computers, you must store these items in a virtual directory on your Web server. In this guide, the virtual directory is located on the Web server WEB1. This folder is on the "C:" drive and is named "pki." You can locate your virtual directory on your Web server at any folder location that is appropriate for your deployment.  
  
## <a name="bkmk_cname"></a>Plan a DNS alias (CNAME) record for your Web server  
Alias (CNAME) resource records are also sometimes called canonical name resource records. With these records, you can use more than one name to point to a single host, making it easy to do such things as host both a File Transfer Protocol (FTP) server and a Web server on the same computer. For example, the well-known server names (ftp, www) are registered using alias (CNAME) resource records that map to the Domain Name System (DNS) host name, such as WEB1, for the server computer that hosts these services.  
  
This guide provides instructions for configuring your Web server to host the certificate revocation list (CRL) for your certification authority (CA). Because you might also want to use your Web server for other purposes, such as to host an FTP or Web site, it's a good idea to create an alias resource record in DNS for your Web server. In this guide, the CNAME record is named "pki," but you can choose a name that is appropriate for your deployment.  
  
## <a name="bkmk_capolicy"></a>Plan configuration of CAPolicy.inf  
Before you install AD CS, you must configure CAPolicy.inf on the CA with information that is correct for your deployment. A CAPolicy.inf file contains the following information:  
  
```  
[Version]  
Signature="$Windows NT$"  
[PolicyStatementExtension]  
Policies=InternalPolicy  
[InternalPolicy]  
OID=1.2.3.4.1455.67.89.5  
Notice="Legal Policy Statement"  
URL=https://pki.corp.contoso.com/pki/cps.txt  
[Certsrv_Server]  
RenewalKeyLength=2048  
RenewalValidityPeriod=Years  
RenewalValidityPeriodUnits=5  
CRLPeriod=weeks  
CRLPeriodUnits=1  
LoadDefaultTemplates=0  
AlternateSignatureAlgorithm=1  
```  
You must plan the following items for this file:  
  
-   **URL**. The example CAPolicy.inf file has a URL value of **https://pki.corp.contoso.com/pki/cps.txt**. This is because the Web server in this guide is named WEB1 and has a DNS CNAME resource record of pki. The Web server is also joined to the corp.contoso.com domain. In addition, there is a virtual directory on the Web server named "pki" where the certificate revocation list is stored. Ensure that the value that you provide for URL in your CAPolicy.inf file points to a virtual directory on your Web server in your domain.  
  
-   **RenewalKeyLength**. The default renewal key length for AD CS in  Windows Server 2012  is 2048. The key length that you select should be as long as possible while still providing compatibility with the applications that you intend to use.  
  
-   **RenewalValidityPeriodUnits**. The example CAPolicy.inf file has a RenewalValidityPeriodUnits value of 5 years. This is because the expected lifespan of the CA is around ten years. The value of RenewalValidityPeriodUnits should reflect the overall validity period of the CA or the highest number of years for which you want to provide enrollment.  
  
-   **CRLPeriodUnits**. The example CAPolicy.inf file has a CRLPeriodUnits value of 1. This is because the example refresh interval for the certificate revocation list in this guide is 1 week. At the interval value that you specify with this setting, you must publish the CRL on the CA to the Web server virtual directory where you store the CRL and provide access to it for computers that are in the authentication process.  
  
-   **AlternateSignatureAlgorithm**. This CAPolicy.inf implements an improved security mechanism by implementing alternate signature formats. You should not implement this setting if you still have Windows XP clients that require certificates from this CA.  
  
If you do not plan on adding any subordinate CAs to your public key infrastructure at a later time, and if you want to prevent the addition of any subordinate CAs, you can add the PathLength key to your CAPolicy.inf file with a value of 0. To add this key, copy and paste the following code into your file:  
  
```  
[BasicConstraintsExtension]  
PathLength=0  
Critical=Yes  
```  
  
> [!IMPORTANT]  
> It is not recommended that you change any other settings in the CAPolicy.inf file unless you have a specific reason for doing so.  
  
## <a name="bkmk_cdp"></a>Plan configuration of the CDP and AIA extensions on CA1  
When you configure the Certificate Revocation List (CRL) Distribution Point (CDP) and the Authority Information Access (AIA) settings on CA1, you need the name of your Web server and your domain name. You also need the name of the virtual directory that you create on your Web server where the certificate revocation list (CRL) and the certification authority certificate are stored.  
  
The CDP location that you must enter during this deployment step has the format:  
      
    `http:\/\/*DNSAlias\(CNAME\)RecordName*.*Domain*.com\/*VirtualDirectoryName*\/<CaName><CRLNameSuffix><DeltaCRLAllowed>.crl.`  
      
For example, if your Web server is named WEB1 and your DNS alias CNAME record for the Web server is "pki," your domain is corp.contoso.com, and your virtual directory is named pki, the CDP location is:  
      
    `http:\/\/pki.corp.contoso.com\/pki\/<CaName><CRLNameSuffix><DeltaCRLAllowed>.crl`  
      
The AIA location that you must enter has the format:  
      
    `http:\/\/*DNSAlias\(CNAME\)RecordName*.*Domain*.com\/*VirtualDirectoryName*\/<ServerDNSName>\_<CaName><CertificateName>.crt.`  
      
For example, if your Web server is named WEB1 and your DNS alias CNAME record for the Web server is "pki," your domain is corp.contoso.com, and your virtual directory is named pki, the AIA location is:  
      
    `http:\/\/pki.corp.contoso.com\/pki\/<ServerDNSName>\_<CaName><CertificateName>.crt`  
      
## <a name="bkmk_copy"></a>Plan the copy operation between the CA and the Web server  
To publish the CRL and CA certificate from the CA to the Web server virtual directory, you can run the certutil -crl command after you configure the CDP and AIA locations on the CA. Ensure that you configure the correct paths on the CA Properties **Extensions** tab before you run this command using the instructions in this guide. In addition, to copy the Enterprise CA certificate to the Web server, you must have already created the virtual directory on the Web server and configured the folder as a shared folder.  
  
## <a name="bkmk_template"></a>Plan the configuration of the server certificate template on the CA  
To deploy autoenrolled server certificates, you must copy the certificate template named **RAS and IAS Server**. By default, this copy is named **Copy of RAS and IAS Server**. If you want to rename this template copy, plan the name that you want to use during this deployment step.  
  
> [!NOTE]  
> The last three deployment sections in this guide - which allow you to configure server certificate autoenrollment, refresh Group Policy on servers, and verify that the servers have received a valid server certificate from the CA - do not require additional planning steps.  
  


