---
title: TLS - SSL (Schannel SSP) Overview
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1b7b0432-1bef-4912-8c9a-8989d47a4da9
---
# TLS - SSL (Schannel SSP) Overview
This topic for the IT professional introduces the TLS\/SSL implementation in Windows using the Schannel Security Service Provider \(SSP\) by describing practical applications, changes in Microsoft’s implementation, and software requirements, plus additional resources for [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)].  
  
**Did you mean…**  
  
-   [The Schannel security package](http://msdn.microsoft.com/library/ms678421(VS.85).aspx)  
  
-   [Secure Channel](http://msdn.microsoft.com/library/windows/desktop/aa380123(v=VS.85).aspx)  
  
-   [Transport Layer Security Protocol](http://msdn.microsoft.com/library/windows/desktop/aa380516(v=vs.85).aspx)  
  
## <a name="BKMK_OVER"></a>TLS\/SSL \(Schannel\) description  
Schannel is a Security Support Provider \(SSP\) that implements the Secure Sockets Layer \(SSL\) and Transport Layer Security \(TLS\) Internet standard authentication protocols.  
  
The Security Support Provider Interface \(SSPI\) is an API used by Windows systems to perform security\-related functions including authentication. The SSPI functions as a common interface to several Security Support Providers \(SSPs\), including the Schannel SSP.  
  
The Transport Layer Security \(TLS\) protocol versions 1.0, 1.1, and 1.2, Secure Sockets Layer \(SSL\) protocol, versions 2.0 and 3.0, Datagram Transport Layer Security \(DTLS\) version 1.0, and the Private Communications Transport \(PCT\) protocol are based on public key cryptography. The Security Channel \(Schannel\) authentication protocol suite provides these protocols. All Schannel protocols use a client\/server model.  
  
## <a name="BKMK_APP"></a>Practical applications  
One problem when you administer a network is securing data that is being sent between applications across an untrusted network. You can use TLS\/SSL to authenticate servers and client computers and then use the protocol to encrypt messages between the authenticated parties.  
  
For example, you can use TLS\/SSL for:  
  
-   SSL\-secured transactions with an e\-commerce website  
  
-   Authenticated client access to an SSL\-secured website  
  
-   Remote access  
  
-   SQL access  
  
-   E\-mail  
  
## <a name="BKMK_NEW"></a>New and changed functionality  
The following table notes the changes to the Schannel SSP to allow for the Datagram Transport Layer Security \(DTLS\) \(RFC 4347\), Server Name Indicator, configurable hints for certificates, and ability to configure the Schannel provider to use specific trusted root stores.  
  
|Feature\/functionality|Windows Server 2008 R2|[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]|  
|--------------------------|--------------------------|-----------------------------------------------------------|  
|Inclusion of TLS 1.2|X|X|  
|Inclusion of DTLS||X|  
|TLS support for Server Name Indicator \(SNI\) extensions||X|  
|Manageability improvements to configure a list of certificate roots to be used by a website as the trust anchors for the purposes of validating a client certificate||X|  
|Manageability improvements to configure a list of certificates hints for eventual selection by the client computer||X|  
  
For information about these changes in functionality for TLS\/SSL, see [What's New in TLS - SSL &#40;Schannel SSP&#41;](../Topic/What-s-New-in-TLS---SSL--Schannel-SSP-.md).  
  
## <a name="BKMK_DEP"></a>Deprecated functionality  
In the Schannel SSP for [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], there are no deprecated features or functionality. The Private Communications Transport \(PCT\) protocol is disabled by default, as it was in the past version.  
  
## <a name="BKMK_SOFT"></a>Software requirements  
The TLS\/SSL protocol use a client\/server model and are based on certificate authentication, which requires a Public Key Infrastructure.  
  
## <a name="BKMK_INSTALL"></a>Server Manager information  
There are no configuration steps necessary to implement TLS, SSL or Schannel using Server Manager or the Add Features feature.  
  
## <a name="BKMK_LINKS"></a>See also  
The following table provides links to additional resources related to TLS, SSL and the Schannel SSP.  
  
|Content type|References|  
|----------------|--------------|  
|**Product evaluation**|[What's New in TLS - SSL &#40;Schannel SSP&#41;](../Topic/What-s-New-in-TLS---SSL--Schannel-SSP-.md)|  
|**Planning**|[TLS\/SSL Technical Reference \(2003\)](http://technet.microsoft.com/library/cc784149(v=ws.10).aspx)|  
|**Deployment**|Not yet available|  
|**Operations**|Not yet available|  
|**Troubleshooting**|Not yet available|  
|**Security**|Not yet available|  
|**Tools and settings**|Not yet available|  
|**Community resources**|[Private Cloud Security Model \- Wrapper Functionality](http://social.technet.microsoft.com/wiki/contents/articles/6756.private-cloud-security-model-wrapper-functionality.aspx)|  
|**Related technologies**|[Active Directory Certificate Services \(AD CS\)](assetId:///d375a1de-aa43-482a-ad7c-b378aa04394c)|  
  
