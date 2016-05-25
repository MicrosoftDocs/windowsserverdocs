---
title: Connections to Public Wi-Fi Hotspots
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 758f92a4-6a70-409f-8633-b226de2ad1b7
author: vhorne
---
# Connections to Public Wi-Fi Hotspots
In [!INCLUDE[win8_client_1](../Token/win8_client_1_md.md)], there are many improvements to 802.1X authenticated wireless access, especially for circumstances where the computer or other device is connecting for the first time to a secure network that does not use captive portals.  
  
Making 802.1X wireless connections on computers that are running [!INCLUDE[firstref_client_7](../Token/firstref_client_7_md.md)] and earlier operating systems is difficult because the default settings provide no automatic way for authentication to occur when Extensible Authentication Protocol \(EAP\)\-based authentication methods are required for the connection.  
  
For example, when you try to connect an organization\-managed, domain joined [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)] computer to a public wireless hotspot,  [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)] automatically provides domain credentials as proof of identity to the public hotspot's wireless access point \(WAP\). Because the public hotspot is not part of the organization’s domain, it cannot authenticate the client computer, and authentication fails. In this circumstance, you must determine the authentication protocol that the WAP requires, and then follow a complex set of steps to select and configure the protocol in the Wireless profile on your computer.  
  
### Connections to public Wi\-Fi hotspots  
When you encounter a wireless access signal using a computer or other device that is running [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], Windows informs you that a wireless network is available. If you select a network and click Connect, the following dialog box opens.  
  
![](../Image/wifi_networks.jpg)  
  
This dialog box provides the ability to log on to the network using different credential types. Windows presents credential options that are based on the types of credentials that it finds on the computer.  
  
The following types of credentials are supported:  
  
-   User name and password. In addition to standard credentials that you type in the fields provided, the following types of user name and password are supported:  
  
    -   One Time Password \(OTP\) user name and token codes are accepted in the form of user name and password. In this circumstance, the password consists of your personal identification number \(PIN\) and token.  
  
    -   **Use Windows Logon Credentials**. When you select this check\-box, [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] automatically fills **UserName** and **Password** with your Windows logon credentials.  
  
-   Registry certificates that are stored in the certificate store on the local computer. Smart Card certificates are not supported.  
  
-   Global System for Mobile Communications \(GSM\) subscriber identity module \(SIM\) cards.  
  
By default, the ability to type user name and password is provided because password\-based authentication is the most popular authentication method that is used by Wi\-Fi hotspots and other organizations.  
  
If [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] finds other forms of credentials on the computer, Windows provides a link that you can click to use these credentials; however this link is not displayed if the operating system does not find other types of credentials on the computer or device, and you must type a user name and password or Windows logon credentials for authentication.  
  
In the illustration above, Windows 8 has discovered alternate credential types on the local computer \- both a certificate and SIM card are found \- so the **Other ways to connect** link is displayed.  
  
When you click the link, a new dialog box opens, and you are provided options to authenticate the wireless connection by using a certificate or a SIM card.  
  
> [!NOTE]  
> -   If [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] finds only a registry certificate on the computer, the link is named **Connect using a certificate**.  
> -   If [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] finds only a SIM card on the computer, the link is named **Connect using a SIM card**.  
  
If you choose one of these alternate credential types, you are prompted to enter additional credential information through an appropriate dialog box, if required, such as a certificate password or a SIM card PIN.  
  
The credentials that you provide are then used for authentication to the wireless network.  
  
### Selecting the Authentication Protocol  
When you select the type of credential that you want to use to authenticate to the wireless network, [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] automatically selects the appropriate authentication protocol to use for the connection. The following steps provide details on how this process works.  
  
1.  Windows checks all installed EAP methods in the operating system, including the built\-in EAP methods and third party methods, and creates a list, called a *short list*, of authentication methods that match the credential type that you selected.  
  
    -   PEAP with Tunneled Transport Layer Security \(TTLS\), or PEAP\-TTLS, is mapped to password\-based methods, as are third party OTP\-based methods. The authentication methods EAP with Message\-Digest Algorithm \(MD5\), or EAP\-MD5, as well as EAP with Microsoft Challenge Handshake Authentication Protocol version 2 \(MS\-CHAP v2\), or EAP\-MS\-CHAP v2, are always ignored because, for security purposes, the Windows 8 wireless client does not use them.  
  
    -   Microsoft built\-in methods are always preferred over third party implementations. For example, if a third party implementation of PEAP is found Windows will still pick only the built\-in Microsoft implementation when short\-listing the protocols.  
  
    -   In case of SIM\-based authentication Windows short lists only those protocols that are supported by your SIM card.  
  
2.  Windows uses this protocol list and negotiates the final protocol with the Remote Authentication Dial In User Service \(RADIUS\) server that is processing the connection request and performing authentication and authorization, such as a server that is running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] with Network Policy Server \(NPS\) installed and configured as a RADIUS server.  
  
    -   Based on credential type, Windows proposes the protocols to the RADIUS server in the order provided in the table below.  
  
    -   For PEAP and TTLS only EAP\-MS\-CHAP v2 and Password Authentication Protocol \(PAP\) are negotiated as inner methods.  
  
**Protocol order**  
  
|Credential type|Order|  
|-------------------|---------|  
|Password|<EAP\-PEAP> \- <EAP\-TTLS> \- <other password\-based and OTP\-based protocols third party methods in the order in which they were short\-listed>|  
|Certificate|<EAP\-TLS> \- <other certificate\-based third party methods in the order in which they were short\-listed>|  
|SIM|<EAP\-AKA’> \- <EAP\-AKA> \- <EAP\-SIM>|  
  
For more information, see [Extensible Authentication Protocol \(EAP\) for Network Access Overview](http://technet.microsoft.com/library/hh945105) at http:\/\/technet.microsoft.com\/library\/hh945105.  
  
> [!NOTE]  
> **AKA** is an acronym for UMTS Authentication and Key Agreement, which is described in the Internet Engineering Task Force \(IETF\) request for comments 4187, [Extensible Authentication Protocol Method for 3rd Generation Authentication and Key Agreement \(EAP\-AKA\)](http://tools.ietf.org/html/rfc4187).  
>   
> **AKA’** is the EAP AKA prime protocol, which is described in the IETF request for comments 5448, [Improved Extensible Authentication Protocol Method for 3rd Generation Authentication and Key Agreement \(EAP\-AKA'\)](http://tools.ietf.org/html/rfc5448).  
  
### Caveats for third party authentication methods  
A third party method is short\-listed by Windows for authentication protocol negotiation only if it provides a mechanism to generate the method configuration blob. Following are the options that are available to generate this blob.  
  
-   The third party method can implement a new application programming interface \(API\) exposed by EAPHost that generates the user blob and the configuration blob of the method when passed the credential type and the actual credentials. Details of the API can be found on [MSDN](http://msdn.microsoft.com/library/windows/desktop/hh706635(v=vs.85).aspx) at http:\/\/msdn.microsoft.com\/library\/windows\/desktop\/hh706635\(v\=vs.85\).aspx.  
  
-   If the method is password\-based then Windows can still use the method’s X2B API to generate the configuration blob. If the method has implemented the QueryCredential API, then a user blob can also be generated.  
  
After an EAP method is negotiated with the server, Windows uses the method’s blobs for authentication. The configuration blob is needed at that time so that the method doesn’t have to launch its own dialog box to collect user credentials again.  
  
