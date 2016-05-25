---
title: Improvements to Certificate-based Authentication
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: fceac4dd-d165-4bcd-8f7a-a1413546d6a7
author: vhorne
---
# Improvements to Certificate-based Authentication
In [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], there are many improvements in how you can manage the use of certificates for authentication and in how Windows selects certificates during the authentication process.  
  
In [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)] and earlier operating systems, using certificates for user or computer authentication for wireless and virtual private network \(VPN\) connections is a complex and non\-intuitive experience due to the following issues:  
  
-   **Manual certificate selection is frequently required**. In many cases, you must manually select a certificate. Often it is unclear which certificate to select, causing a circumstance where you must employ a trial and error method to make the right selection.  
  
-   **Windows can have difficulty filtering the list of certificates**. Windows uses some basic rules to filter out some of the certificates, such as ignoring expired or revoked certificates, however if there are multiple certificates that have the same subject name and issuer name, Windows takes a different action depending on whether the certificate is a user certificate or a computer certificate. For user certificates, Windows prompts the user to make a manual selection of which certificate to use. For computer certificates, the certificate with the highest weight is selected. If the selected certificate is the incorrect certificate for the connection, authentication fails. These filtering mechanisms are very rudimentary and user intervention is still required in most cases.  
  
-   **Problems selecting certificates on smart cards**. If there are multiple certificates present on a smart card, Windows enumerates a list of the certificates and then always picks the last certificate from the list. In many cases, this is not the correct certificate to use for the authentication attempt. This is problematic when the same smart card is used for multiple purposes and contains a separate certificate for every case. There is no workaround available to select the right certificate.  
  
-   **Registry certificates cannot be used for two factor authentication**. Although certificates are ideal candidates for two\-factor authentication, registry certificates – which are protected by a strong private key and are the most appropriate certificates for two\-factor authentication \- cannot be used. The reason for this is that Windows does not support registry certificates and completely ignores them. As a result, organizations must deploy and manage complex and expensive smart card solutions rather than using registry based certificates.  
  
In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], certificate filtering provides Windows with the ability to select the correct certificate for use with certificate\-based authentication during the network connection process.  
  
### Certificate filtering  
Certificate filtering allows you to configure rules during the process of creating either Wireless or VPN profiles on [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. When a Wireless or VPN profile is applied to a computer running [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], these rules limit the number of certificates that Windows 8 can choose during the authentication process.  
  
You can configure certificate filtering in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] so that computers that are running [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] that are selecting a certificate for an authentication attempt can automatically eliminate all certificates from consideration except for the certificate that you want them to choose. This certificate filtering therefore assists client computers in achieving a higher number of successful authentication attempts, because [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] selects the correct certificate for the attempt.  
  
The certificate filtering criteria that you select can apply to registry, smart card, and client computer certificates.  
  
While you are configuring a Wireless or VPN profile in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], you can use the following new filters:  
  
-   **Certificate Issuer**. When you configure the certificate issuer filter, you can specify that computers that are running [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] must select a certificate that is issued by a specific CA. When you configure this filter, the filter enumerates the root and intermediate root certification authorities \(CAs\) for all certificates that are present in the certificate store on the local computer, and allows you to select the correct CA from the list.  
  
-   **Extended Key Usage \(EKU\)**. The EKU filter allows you to choose which EKUs must be present in the certificate. When you configure the EKU filter, you can specify that computers that are running [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] must enumerate all EKU properties for all certificates that are present in the certificate store on the local computer. You can also add a custom EKU to the filtering rule by specifying the object identifier \(OID\) of the EKU.  
  
> [!NOTE]  
> Extended Key Usage extensions are also commonly called Enhanced Key Usage extensions, and the acronym for both terms is EKU.  
  
The illustration below depicts the **Configure Certificate Selection** dialog box where you can apply certificate filtering.  
  
![](../Image/wifi_configure_cert_selection.jpg)  
  
When a Wireless profile where these rules are configured is applied to a computer running [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] and the client attempts to connect to a network, Windows applies the filtering rules and selects one or more certificates that match all of the rules. If multiple compliant certificates are found, Windows displays a dialog box that lists the certificates so that you can choose one. This dialog box is displayed for registry, smart card, and client computer certificates.  
  
### Certificate weight as a filtering mechanism  
When a Smart Card certificate is used for Pre\-Logon\-Access Provider \(PLAP\) scenarios, the weight of the certificate is also used for filtering. The weight of a certificate is determined by the certificate revocation list Distribution Point \(CDP\) and by the Authority Information Access \(AIA\) properties that are present in the certificate. AIA has a weight of 2 and CDP has a weight of 1. If both properties are present then Windows adds their weights together to determine the certificate weight. After this process, Windows selects and uses the certificate that has the highest weight value.  
  
### Private Key Protected Registry Certificates  
[!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] recognizes private key protected registry certificates that are present in the Current User certificate store on the local computer, and these certificates can be used for two\-factor authentication. Windows does not look for private key protected certificates in any other certificate store.  
  
### Certificate filtering compatibility information  
Wireless and VPN profiles created on [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] that contain certificate filters can be applied to computers that are running operating systems earlier than [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], such as [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)] and [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)], however the filters cannot be parsed by these earlier operating systems and only the legacy rudimentary filtering is applied during the authentication process.  
  
