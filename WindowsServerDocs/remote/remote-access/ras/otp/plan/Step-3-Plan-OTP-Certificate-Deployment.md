---
title: Step 3 Plan OTP Certificate Deployment
description: This topic is part of the guide Deploy Remote Access with OTP Authentication in Windows Server 2016.
manager: brianlic
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: networking-ras
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: eca02eeb-d92d-463e-aae0-1f7038ba26fe
ms.author: lizross
author: eross-msft
---
# Step 3 Plan OTP Certificate Deployment

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

After planning the RADIUS server, you must plan for certification authority (CA) requirements, including the CA that will issue one-time password (OTP) certificates, the OTP certificate template, and the registration authority certificate used by the Remote Access server to sign all DirectAccess client OTP certificate requests. These certificates are used as follows:  
  
1.  The DirectAccess client requests an OTP certificate, and the Remote Access server receives the request.  
  
2.  The Remote access server verifies the OTP credentials and if they are valid, the server acts as a registration authority, and signs the OTP certificate enrollment request using a short-lived signing certificate.  
  
3.  The Remote Access server sends the signed certificate enrollment request back to the DirectAccess client  
  
4.  The client then enrolls the OTP certificate from the CA using the certificate enrollment requests signed by the server.  
  
5.  The CA verifies the credentials and the request.  
  
|Task|Description|  
|----|--------|  
|[3.1 Plan the OTP CA](#bkmk_3_1_CA)|Plan the certification authority (CA) to use to issue certificates to DirectAccess clients for OTP authentication.|  
|[3.2 Plan the OTP certificate template](#bkmk_3_2_OTP_Cert)|Plan the OTP certificate template.|
|[3.3 Plan the registration authority certificate](#bkmk_33RACert)|Plan the registration authority certificate to sign all OTP authentication certificate requests.|

## <a name="bkmk_3_1_CA"></a>3.1 Plan the OTP CA  
To deploy DirectAccess using one-time password authentication (OTP), you require an internal CA to issue the OTP authentication certificates to DirectAccess client computers. For this purpose, you can use the same internal CA that you use to issue the certificates that are used for regular IPsec computer authentication.  
  
## <a name="bkmk_3_2_OTP_Cert"></a>3.2 Plan the OTP certificate template  
Each DirectAccess client requires an OTP authentication certificate in order to gain access to the internal network. You must configure a template on your internal CA for the OTP certificate. Note the following when configuring the OTP certificate template:  
  
-   All users who need to perform OTP authentication must have read and enroll permissions for this template.  
  
-   The subject name should be built from Active Directory information, to ensure that the subject name matches the OTP user name, and not the name of the Remote Access server that performs the certificate request. The subject name must be in the fully distinguished name format, and the subject alternative name must be in UPN format. This ensures that the enrolled OTP certificate is valid for Smartcard Kerberos authentication.  
  
-   The intended purpose of the certificate must be Smart Card Logon  
  
-   Issuance must require one authorized signature. The signature must be configured with the predefined DirectAccess OTP Application Policy set in the registration authority signing certificate template.  
  
-   The validity period should be set to one hour.  
  
    > [!NOTE]  
    > In situations where the CA server is a Windows Server 2003 computer, then the template must be configured on a different computer. This is due to the fact that setting the **Validity period** in hours is not possible when running Windows versions prior to 2008/Vista. If the computer that you use to configure the template does not have the Certification Service role installed, or it is a client computer, then you may need to install the Certificate Templates snap-in. For more information on this subject click [here](https://technet.microsoft.com/library/cc732445.aspx).  
  
-   The renewal period should be set to 0.  
  
-   (Optional) Certificates and requests should not be stored in the CA database.  
  
-   The certificate Enhanced Key Usage parameter must be set correctly, as follows:  
  
    -   For the DirectAccess registration signing certificate template use the key 1.3.6.1.4.1.311.81.1.1.  
  
    -   For the OTP authentication certificate template use the key 1.3.6.1.4.1.311.20.2.2 key.  
  
## <a name="bkmk_33RACert"></a>3.3 Plan the registration authority certificate  
When DirectAccess clients request an OTP certificate, the Remote Access server receives the request from the client. The Remote Access server signs all OTP certificate requests from clients using the registration authority certificate. The CA issues certificates only if the request is signed by the registration authority certificate on the Remote Access server. The certificate must be issued by an internal CA, the certificate cannot be self-signed. It does not have to be issued by the CA that issued the OTP certificates but the CA that issues the OTP certificates must trust the CA that issues the registration authority signing certificate.  
  
## <a name="BKMK_Links"></a>See also  
  
-   [Step 4: Plan OTP for the Remote Access server](Step-4-Plan-for-OTP-on-the-Remote-Access-Server.md)  
  


