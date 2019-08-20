---
ms.assetid: ddfbbda3-30ca-4537-af12-667efc6f63ff
title: Configure Additional Authentication Methods for AD FS
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 07/26/2019
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
---

# Configure Additional Authentication Methods for AD FS

In order to enable multi-factor authentication (MFA), you must select at least one additional authentication method. By default, in Active Directory Federation Services (AD FS) in Windows Server 2012 R2, you can select Certificate Authentication (in other words, smart card-based authentication) as an additional authentication method.

> [!NOTE]
> If you select Certificate Authentication, ensure that the smart card certificates have been provisioned securely and have pin requirements.

Did you know that Microsoft Azure provides similar functionality in the cloud? Learn more about [Microsoft Azure identity solutions](http://aka.ms/m2w274).<br /><br />Create a hybrid identity solution in Microsoft Azure:<br /> - [Learn about Azure Multi-Factor Authentication.](http://aka.ms/ey6o9r)<br /> - [Manage identities for single-forest hybrid environments using cloud authentication.](http://aka.ms/g1jat8)<br /> - [Manage Risk with Additional Multi-Factor Authentication for Sensitive Applications.](http://aka.ms/kt1bbm)

## Microsoft and third-party additional authentication methods
You can also configure and enable Microsoft and third-party authentication methods in AD FS in Windows Server 2012 R2. Once installed and registered with AD FS, you can enforce MFA as part of the global or per-relying-party authentication policy.

Below is an alphabetical list of Microsoft and third-party providers with MFA offerings currently available for AD FS in Windows Server 2012 R2.

|Provider|Offering|Link to learn more|
|-|-|-| 
|aPersona|aPersona Adaptive Multi-Factor Authentication for Microsoft ADFS SSO|[aPersona ASM ADFS Adapter](https://www.apersona.com/adfs)|
|Duo Security|Duo MFA Adapter for AD FS|[Duo Authentication for AD FS](https://duo.com/docs/adfs)|
|Futurae|Futurae Authentication Suite for AD FS|[Futurae Strong Authentication](https://futurae.com)|
|Gemalto|Gemalto Identity & Security Services|[http://www.gemalto.com/identity](http://www.gemalto.com/identity)|
|inWebo Technologies|inWebo Enterprise Authentication service|[inWebo Enterprise Authentication](http://www.inwebo.com)|
|Login People|Login People MFA API connector for AD FS 2012 R2 (public beta)|[https://www.loginpeople.com](https://www.loginpeople.com)|
|Microsoft Corp.|Microsoft Azure MFA|[Walkthrough Guide: Manage Risk with Additional Multi-Factor Authentication for Sensitive Applications](https://technet.microsoft.com/library/dn280946.aspx) (see step 3)|
Mideye | Mideye Authentication Provider for ADFS | [Mideye two-factor authentication with Microsoft Active Directory Federation Service](https://www.mideye.com/support/administrators/documentation/integration/microsoft-adfs/)|
|Okta | Okta MFA for Active Directory Federation Services | [Okta MFA for Active Directory Federation Services (ADFS)](https://help.okta.com/en/prod/Content/Topics/integrations/adfs-okta-int.htm)|
|One Identity| Starling 2FA AD FS|[Starling 2FA AD FS Adapter](https://www.oneidentity.com/products/starling-two-factor-authentication/)|
|One Identity| Defender AD FS|[Defender AD FS Adapter](https://www.oneidentity.com/products/defender/)|
|Ping Identity|PingID MFA Adapter for AD FS|[PingID MFA Adapter for AD FS](https://documentation.pingidentity.com/pingid/pingidAdminGuide/index.shtml#pid_c_PingIDforADFSSSO.html)|
|RSA, The Security Division of EMC|RSA SecurID Authentication Agent for Microsoft Active Directory Federation Services|[RSA SecurID Authentication Agent for Microsoft Active Directory Federation Services](http://www.emc.com/security/rsa-securid/rsa-authentication-agents/microsoft-ad-fs.htm)|
|SafeNet, Inc.|SafeNet Authentication Service (SAS) Agent for AD FS|[SafeNet Authentication Service: AD FS Agent Configuration Guide](http://www.safenet-inc.com/resources/integration-guide/data-protection/Safenet_Authentication_Service/SafeNet_Authentication_Service__AD_FS_Agent_Configuration_Guide/?langtype=1033)|
|SecureMFA|SecureMFA OTP Provider| [ADFS Multi Factor Authentication Providers](https://www.securemfa.com/)|
|Swisscom|Mobile ID Authentication Service and Signature Services|[Mobile ID Authentication Service](http://swisscom.ch/mid)|
|Symantec|Symantec Validation and ID Protection Service (VIP)|[Symantec Validation and ID Protection Service (VIP)](http://www.symantec.com/vip-authentication-service)|
|Trusona|Essential (passwordless MFA) and Executive (Essential + Identity Proofing)| [Trusona Multi-factor Authentication](https://www.trusona.com/solution-overview/)|


## Custom Authentication Method for AD FS in Windows Server 2012 R2
We now provide instructions for building your own custom authentication method for AD FS in Windows Server 2012 R2. For more information, see [Build a Custom Authentication Method for AD FS in Windows Server 2012 R2](https://go.microsoft.com/fwlink/?LinkID=511980).

## See Also
[Manage Risk with Additional Multi-Factor Authentication for Sensitive Applications](Manage-Risk-with-Additional-Multi-Factor-Authentication-for-Sensitive-Applications.md)


