---
title: Configure the CDP and AIA Extensions on CA1
description: This topic is part of the guide Deploy Server Certificates for 802.1X Wired and Wireless Deployments
manager: dougkim
ms.topic: article
ms.assetid: f77a3989-9f92-41ef-92a8-031651dd73a8
ms.prod: windows-server
ms.technology: networking
ms.author: lizross
author: eross-msft
ms.date: 07/26/2018
---
# Configure the CDP and AIA Extensions on CA1

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this procedure to configure the Certificate Revocation List (CRL) Distribution Point (CDP) and the Authority Information Access (AIA) settings on CA1.  
  
To perform this procedure, you must be a member of Domain Admins.  
  
#### To configure the CDP and AIA extensions on CA1  
  
1.  In Server Manager, click **Tools** and then click **Certification Authority**.  
  
2.  In the Certification Authority console tree, right-click **corp-CA1-CA**, and then click **Properties**.  
  
    > [!NOTE]  
    > The name of your CA is different if you did not name the computer CA1 and your domain name is different than the one in this example. The CA name is in the format *domain*-*CAComputerName*-CA.  
  
3.  Click the **Extensions** tab. Ensure that **Select extension** is set to **CRL Distribution Point (CDP)**, and in the **Specify locations from which users can obtain a certificate revocation list (CRL)**, do the following:  
  
    1.  Select the entry `file://\\<ServerDNSName>\CertEnroll\<CaName><CRLNameSuffix><DeltaCRLAllowed>.crl`, and then click **Remove**. In **Confirm removal**, click **Yes**.  
  
    2.  Select the entry `http://<ServerDNSName>/CertEnroll/<CaName><CRLNameSuffix><DeltaCRLAllowed>.crl`, and then click **Remove**. In **Confirm removal**, click **Yes**.  
  
    3.  Select the entry that starts with the path `ldap:///CN=<CATruncatedName><CRLNameSuffix>,CN=<ServerShortName>`, and then click **Remove**. In **Confirm removal**, click **Yes**.  
  
4.  In **Specify locations from which users can obtain a certificate revocation list (CRL)**, click **Add**. The **Add Location** dialog box opens.  
  
5.  In **Add Location**, in **Location**, type `http://pki.corp.contoso.com/pki/<CaName><CRLNameSuffix><DeltaCRLAllowed>.crl`, and then click **OK**. This returns you to the CA properties dialog box.  
  
6.  On the **Extensions** tab, select the following check boxes:  
  
    -   **Include in CRLs. Clients use this to find the Delta CRL locations**  
  
    -   **Include in the CDP extension of issued certificates**  
  
7.  In **Specify locations from which users can obtain a certificate revocation list (CRL)**, click **Add**. The **Add Location** dialog box opens.  
  
8.  In **Add Location**, in **Location**, type `file://\\pki.corp.contoso.com\pki\<CaName><CRLNameSuffix><DeltaCRLAllowed>.crl`, and then click **OK**. This returns you to the CA properties dialog box.  
  
9. On the **Extensions** tab, select the following check boxes:  
  
    -   **Publish CRLs to this location**  
  
    -   **Publish Delta CRLs to this location**  
  
10. Change **Select extension** to **Authority Information Access (AIA)**, and in the **Specify locations from which users can obtain a certificate revocation list (CRL)**, do the following:  
  
    1.  Select the entry that starts with the path `ldap:///CN=<CATruncatedName>,CN=AIA,CN=Public Key Services`, and then click **Remove**. In **Confirm removal**, click **Yes**.  
  
    2.  Select the entry `http://<ServerDNSName>/CertEnroll/<ServerDNSName>_<CaName><CertificateName>.crt`, and then click **Remove**. In **Confirm removal**, click **Yes**.  
  
    3.  Select the entry `file://\\<ServerDNSName>\CertEnroll\<ServerDNSName><CaName><CertificateName>.crt`, and then click **Remove**. In **Confirm removal**, click **Yes**.  
  
11. In **Specify locations from which users can obtain the certificate for this CA**, click **Add**. The **Add Location** dialog box opens.  
  
12. In **Add Location**, in **Location**, type `http://pki.corp.contoso.com/pki/<ServerDNSName>_<CaName><CertificateName>.crt`, and then click **OK**. This returns you to the CA properties dialog box.  
  
13. On the **Extensions** tab, select **Include in the AIA of issued certificates**.  
  
14. When prompted to restart Active Directory Certificate Services, click **No**. You will restart the service later.  
  

