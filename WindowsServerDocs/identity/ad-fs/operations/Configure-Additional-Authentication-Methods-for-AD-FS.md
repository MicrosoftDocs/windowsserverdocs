---
description: "Learn more about: Configure Additional Authentication Methods for AD FS"
ms.assetid: ddfbbda3-30ca-4537-af12-667efc6f63ff
title: Configure Additional Authentication Methods for AD FS
author: billmath
ms.author: billmath
manager: amycolannino
ms.date: 08/15/2023
ms.topic: article
---

# Configure Additional Authentication Methods for AD FS

In order to enable multifactor authentication (MFA), you must select at least one extra authentication method. By default, in Active Directory Federation Services (AD FS) in Windows Server, you can select Certificate Authentication (in other words, smart card-based authentication) as an extra authentication method.

> [!NOTE]
> If you select Certificate Authentication, ensure that the smart card certificates have been provisioned securely and have pin requirements.

Did you know that Microsoft Azure provides similar functionality in the cloud? Learn more about [Microsoft Azure identity solutions](https://aka.ms/m2w274).

Create a hybrid identity solution in Microsoft Azure:

- [Learn about Microsoft Entra multifactor authentication.](/azure/active-directory/authentication/concept-mfa-howitworks)
- [Manage identities for single-forest hybrid environments using cloud authentication.](/previous-versions/windows/it-pro/solutions-guidance/dn550986(v=ws.11))
- [Manage Risk with Additional multifactor authentication for Sensitive Applications.](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn280946(v=ws.11))

## Microsoft and third-party authentication methods

You can also configure and enable Microsoft and third-party authentication methods in AD FS in Windows Server. Once installed and registered with AD FS, you can enforce MFA as part of the global or per-relying-party authentication policy.

Below is an alphabetical list of Microsoft and third-party providers with MFA offerings currently available for AD FS in Windows Server.

|Provider|Offering|Link to learn more|
|-|-|-|
|Akamai Technologies|Akamai MFA|[Integrating Akamai MFA with Microsoft AD FS](https://techdocs.akamai.com/mfa/docs/adsf)|
|aPersona|aPersona Adaptive multifactor authentication for Microsoft AD FS SSO|[aPersona ASM AD FS Adapter](https://www.apersona.com/adfs)|
|Cyphercor Inc.|LoginTC multifactor authentication for AD FS|[LoginTC AD FS Connector](https://www.logintc.com/docs/connectors/adfs.html)|
|Duo Security|Duo MFA Adapter for AD FS|[Duo Authentication for AD FS](https://duo.com/docs/adfs)|
|Futurae|Futurae Authentication Suite for AD FS|[Futurae Strong Authentication](https://futurae.com)|
|Green Rocket Security|GreenRADIUS MFA Adapter for AD FS|[GreenRADIUS MFA for AD FS](https://www.greenrocketsecurity.com/2fa-for-adfs/)|
|inWebo Technologies|inWebo Enterprise Authentication service|[inWebo Enterprise Authentication](http://www.inwebo.com)|
|Microsoft Corp.|Microsoft Azure MFA|[Configure Azure MFA as authentication provider with AD FS](configure-ad-fs-and-azure-mfa.md)|
Mideye | Mideye Authentication Provider for AD FS | [Mideye two-factor authentication with Microsoft Active Directory Federation Service](https://www.mideye.com/support/administrators/documentation/integration/microsoft-adfs/)|
|Okta | Okta MFA for Active Directory Federation Services | [Okta MFA for Active Directory Federation Services (AD FS)](https://help.okta.com/en/prod/Content/Topics/integrations/adfs-okta-int.htm)|
|One Identity| Defender AD FS|[Defender AD FS Adapter](https://www.oneidentity.com/products/defender/)|
|Ping Identity|PingID MFA Adapter for AD FS|[PingID MFA Adapter for AD FS](https://documentation.pingidentity.com/pingid/pingidAdminGuide/index.shtml#pid_c_PingIDforADFSSSO.html)|
|RSA|RSA SecurID Authentication Agent for Microsoft Active Directory Federation Services|[RSA SecurID Authentication Agent for Microsoft Active Directory Federation Services](https://community.rsa.com/t5/securid-authentication-agent-for/tkb-p/auth-agent-ad-fs-documentation)|
|SecureMFA|SecureMFA OTP Provider| [AD FS multifactor authentication Providers](https://www.securemfa.com/)|
|Swisscom|Mobile ID Authentication Service and Signature Services|[Mobile ID Authentication Service](http://swisscom.ch/mid)|
|Symantec|Symantec Validation and ID Protection Service (VIP)|[Symantec Validation and ID Protection Service (VIP)](https://vip.symantec.com/)|
|Thales|SafeNet Trusted Access (STA)|[Authentication with AD Federation Services](https://www.thalesdocs.com/sta/Content/STA/SEdocs/AuthADFS.htm)|
|Trusona|Essential (passwordless MFA) and Executive (Essential + Identity Proofing)| [Trusona multifactor authentication](https://www.trusona.com/solution-overview/)|

## Custom Authentication Method for AD FS in Windows Server

We now provide instructions for building your own custom authentication method for AD FS in Windows Server. For more information, see [Build a Custom Authentication Method for AD FS in Windows Server 2012 R2](../development/ad-fs-build-custom-auth-method.md).

## See Also

[Manage Risk with Additional multifactor authentication for Sensitive Applications](Manage-Risk-with-Additional-Multi-Factor-Authentication-for-Sensitive-Applications.md)
