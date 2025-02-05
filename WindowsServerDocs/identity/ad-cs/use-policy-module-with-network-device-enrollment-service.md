---
title: Use a policy module with the Network Device Enrollment Service
description: Learn about the policy module and how it works. Understand how to install and uninstall the policy module for the Network Device Enrollment Service.
author: robinharwood
ms.topic: article
ms.author: mosagie
ms.date: 09/21/2023
---

# Use a policy module with the Network Device Enrollment Service

The Active Directory Certificate Services (AD CS) Network Device Enrollment Service (NDES) support a policy module that provides extra security for the Simple Certificate Enrollment Protocol (SCEP). Without this policy module, when a user or a device requests a certificate, the SCEP might require a unique or shared password. In this scenario, users only need the password to get a certificate. In addition, the certificate subject name value is provided by the user at request time. Using a legitimately obtained password, a rogue user could request a certificate that creates the following security risks:

- The subject name value matches a different user, allowing the rogue user to impersonate that other user.

- The user changes the certificate purpose, giving themselves elevated privileges.

When you use a policy module with the Network Device Enrollment Service, this module addresses these security risks by requiring additional authentication. For example, the module can verify that the requested certificate is for a specific user and for a specific purpose, and it can enforce whether to deploy a user certificate or computer certificate.

This article explains how the policy module works, your deployment options, and how to install and uninstall the policy module.

## Process flow for a policy module and the Network Device Enrollment Service

Use a policy module to support enrolling user and computer certificates for mobile devices using cloud services. This scenario is also known as *over-the-air enrollment*. The following diagram shows an example process for a scenario where a mobile device administrator configures a certificate enrollment policy for mobile devices used by information workers.

:::image type="content" source="../media/mobile-device-admin-config.png" alt-text="Diagram showing process flow after mobile device admin makes policy got certificate enrollment.":::

1. The mobile device management (MDM) software requests a challenge password from the Network Device Enrollment Service.

    > [!NOTE]
    > The MDM software contacts the NDES mscep_admin interface.

1. The Network Device Enrollment Service delegates the challenge password request to the policy module.

1. The policy module creates a challenge password that requires that the certificate request includes the user, purpose, and type of certificate (user or computer), and then sends this instruction to the Network Device Enrollment Service.

1. When the mobile device management software receives the challenge password, this software sends the uniform resource indicator (URI) for contacting the Network Device Enrollment Service and the challenge password to the mobile device.

1. The mobile device contacts the Network Device Enrollment Service to enroll a certificate.

1. The Network Device Enrollment Service delegates the request to the policy module.

1. The policy module verifies the challenge password and certificate request. Then the policy module returns the result of the verification to the Network Device Enrollment Service. If the challenge password and certificate request isn't successfully verified by the policy module, the Network Device Enrollment Service returns an error to the mobile device. If the verification is successful, the Network Device Enrollment Service forwards the request to the certification authority.

1. When the request is approved by the certification authority, the certificate is issued to the Network Device Enrollment Service.

1. The Network Device Enrollment Service sends the certificate to the mobile device.

## Deployment options for the Network Device Enrollment Service and a policy module

You can choose between the three deployment options when you use the Network Device Enrollment Service and the policy module. Deployment in:

- A separate forest

- An isolated network

- An internal domain

### Deployment in a separate forest

You can create a new forest that covers the server running the Network Device Enrollment Service, the policy module, and the issuing certificate authority (CA). This design creates a security boundary from your internal domain controllers and domain accounts on the intranet, thereby reducing the risk of exposure. This deployment design is the most secure but requires more infrastructure to support additional computers in another forest.

This deployment design is the most secure, but it requires more infrastructure to support additional computers in another forest.

> [!NOTE]
> When you install the Network Device Enrollment Service on a domain member, you must also install an issuing CA in the same domain.
> If you install the Network Device Enrollment Service on a workgroup computer, you must install the issuing CA on the same computer.

This design helps protect the internal network by isolating the domain and forest accounts you use on the perimeter network and the internal network. Because the issuing CA on the perimeter network is subordinate to the root CA, the system trusts the certificates it issues in both the perimeter and internal networks. If the perimeter network is compromised, you can use the root CA to revoke the certificate of the issuing CA in the perimeter network, which invalidates all certificates from the issuing CA in the perimeter network. Once you resolve the safety issue, you can rebuild the perimeter network and issue new certificates.

### Deployment in an isolated network

This deployment design offers a compromise between the most and least secure designs. You still need to change some infrastructure and configurations, but you don't need to create a separate forest.

This deployment design requires a single computer to run the Network Device Enrollment Service and the mobile device management solution. This computer is a member of the internal domain, so you don't have to install a separate issuing CA. You attach the computer running the Network Device Enrollment Service and the mobile device management solution by using a VPN or DirectAccess connection, which provides the isolated network environment. Mobile devices authenticate to the mobile device management software by require a username and password before they can get the certificate that lets them access resources on the internally secured wireless network.

In this design, there's a possibility that the server running the Network Device Enrollment Service and the mobile device management solution are at risk from attackers to compromise the internal network. To help mitigate this risk, use a temporary Domain Admin or Enterprise Admin account to install and configure the server running the Network Device Enrollment Service in the internal domain. Once you're finished, delete the temporary account, then move the server to the isolated network. Use additional security controls to protect this server and monitor it carefully for suspicious activity or signs that it might be compromised.

### Deployment on an internal domain

This deployment design is the least secure, but it lets you use your existing internal domain structure to deploy your enrollment solution.

In this design, the Network Device Enrollment Service isn't isolated and is a member of the internal domain. The mobile device management software must authenticate all requests for certificates from the wireless network. For example, the software might prompt users for username and password to authenticate them.

This deployment design doesn't use a security boundary when you connect the wireless network that issues certificates to the internal domain. In this scenario, an attacker could potentially use the external wireless network directly to try to compromise the internal domain. If you use this design, all computers on the internal network become potential targets for attack if the wireless network is compromised, so make sure that you use additional security controls to protect the entire internal network and all computers. Monitor your devices carefully for suspicious activity or signs that they might be compromised.

## Related content

- For more information about using the policy module with Configuration Manager, see [Certificate Profiles in Configuration Manager](/mem/configmgr/protect/deploy-use/introduction-to-certificate-profiles).

- [Active Directory Certificate Services (AD CS) Public Key Infrastructure (PKI) Frequently Asked Questions (FAQ)](https://aka.ms/adcsfaq)

- [Windows PKI Documentation Reference and Library](https://social.technet.microsoft.com/wiki/contents/articles/987.windows-pki-documentation-reference-and-library.aspx)
