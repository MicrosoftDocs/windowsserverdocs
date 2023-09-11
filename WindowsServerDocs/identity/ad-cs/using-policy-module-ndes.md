---
title: Using a Policy Module with the Network Device Enrollment Service
description: 
author: robinharwood
ms.topic: overview
ms.author: gswashington
ms.date: 09/21/2023
---

# Using a Policy Module with the Network Device Enrollment Service

Applies To: Windows Server 2012 R2

In Windows Server 2012 R2 the Active Directory Certificate Services (AD CS) Network Device Enrollment Service (NDES) supports a policy module that provides additional security for the Simple Certificate Enrollment Protocol (SCEP). This enhancement lets an organization or mobile device management solution address the issue described in [CERT Vulnerability Note VU\#971035](https://www.kb.cert.org/vuls/id/971035) titled, “Simple Certificate Enrollment Protocol (SCEP) doesn't strongly authenticate certificate requests.”

Without this policy module, when a user or a device requests a certificate, the SCEP implementation might require a unique or shared password. Without the policy module, only the password is required to get a certificate. In addition, the certificate subject name value is provided by the user at request time. Using a legitimately obtained password, a rogue user could request a certificate that has the following security problems:

- The subject name value is for another user and therefore the security risk is impersonation.

- The certificate purpose is changed and therefore the security risk is an elevation of privileges.

When you use a policy module with the Network Device Enrollment Service, this module addresses these security risks by implementing additional authentication. For example, the module can verify that the requested certificate is for a specific user and for a specific purpose, and it can enforce whether to deploy a user certificate or computer certificate.

Windows Server 2012 R2 AD CS Network Device Enrollment Service doesn't ship with a policy module. You must create it yourself or obtain it as part of a software solution from a vendor. For example, it might be included in a mobile device management solution. System Center 2012 R2 Configuration Manager provides a policy module that's required to deploy certificate profiles.

Use the following sections to help you understand how the policy module works, your deployment options, and how to install and uninstall the policy module.

- [How the policy module works]()

- [Deployment options for the Network Device Enrollment Service and a policy module]()

For more information about using the policy module with Configuration Manager, see [Certificate Profiles in Configuration Manager](https://technet.microsoft.com/library/dn261202.aspx) in the System Center 2012 Configuration Manager Documentation Library.

For developer information about how to create your own policy module, see [INDESPolicy interface](https://msdn.microsoft.com/en-us/library/windows/desktop/dn383665\(v=vs.85\).aspx) on MSDN.

## How the policy module works

The most typical scenario for using a policy module is to support the enrollment of user and computer certificates for mobile devices that use a cloud service. This is sometimes referred to as over-the-air enrollment. The following diagram shows the process flow after a mobile device administrator configures policy for certificate enrollment for a mobile device that's being used by an information worker.

:::image type="content" source="media/folder-with-same-name-as-article-file/service-technology-image-description.png" alt-text="Diagram showing process flow after mobile device admin makes policy got certificate enrollment.":::

<!-- ![](images/Dn473016.58b791ed-f7a5-41d7-b971-f966670f1714(WS.11).jpeg) -->

#### Process flow for a policy module and the Network Device Enrollment Service

1. The mobile device management (MDM) software requests a challenge password from the Network Device Enrollment Service.

    > [!NOTE]
    > The mobile device management software contacts the Network Device Enrollment Service by using the NDES mscep_admin interface.

1. The Network Device Enrollment Service delegates the challenge password request to the policy module.

1. The policy module creates a challenge password that requires that the certificate request includes the following items and then sends this instruction to the Network Device Enrollment Service:

      - Specific user

      - Specific purpose

      - Type of certificate (user or computer)

1. When the mobile device management software receives the challenge password, this software sends the uniform resource indicator (URI) for contacting the Network Device Enrollment Service and the challenge password to the mobile device.

1. The mobile device contacts the Network Device Enrollment Service to enroll a certificate.

    > [!NOTE]
    > The mobile device contacts the Network Device Enrollment Service by using the NDES mscep interface.

1. The Network Device Enrollment Service delegates the request to the policy module.

1. The policy module verifies the challenge password and certificate request. Then the policy module returns the result of the verification to the Network Device Enrollment Service.

    If the challenge password and certificate request isn't successfully verified by the policy module, the Network Device Enrollment Service returns an error to the mobile device. If the verification is successful, the Network Device Enrollment Service forwards the request to the certification authority.

1. When the request is approved by the certification authority, the certificate is issued to the Network Device Enrollment Service.

1. The Network Device Enrollment Service sends the certificate to the mobile device.

## Deployment options for the Network Device Enrollment Service and a policy module

You can choose between the following deployment options when you use the Network Device Enrollment Service and the policy module:

- [Deployment in a separate forest]()

- [Deployment in an isolated network]()

- [Deployment on an internal domain]()

### Deployment in a separate forest

This deployment design is the most secure but requires more infrastructure to support additional computers in another forest.

Create a new forest for the server running the Network Device Enrollment Service and the policy module, and the issuing CA. This design creates a security boundary from your internal domain controllers and domain accounts on the intranet, thereby reducing the risk of exposure. See the following diagram for an example of this deployment design that has the following characteristics:

- The root CA is offline and not a domain member.

- The issuing CAs in both forests are subordinate to the offline root CA.

- The server running the Network Device Enrollment Service has the policy module installed.

- The mobile device management software could be deployed in the perimeter network or in the internal network, depending on the technical requirements for the mobile device management solution. For example, for Configuration Manager, the site server and most site systems are deployed in the internal network, and the certificate registration point in the internal network communicates with the policy module on the server running the Network Device Enrollment Service in the perimeter network.

> [!NOTE]
> When you install the Network Device Enrollment Service on a domain member, you must install an issuing CA in the same domain.
> If you install the Network Device Enrollment Service on a workgroup computer, you must install the issuing CA on the same computer.

:::image type="content" source="media/folder-with-same-name-as-article-file/service-technology-image-description.png" alt-text="Diagram showing mobile device management software deployed in the perimeter network or in the internal network.":::
<!-- ![](images/Dn473016.3de3738c-1144-4a91-b29f-dac70fc16491(WS.11).jpeg) -->

This design provides protection for the internal network by isolating the domain and forest accounts used on the perimeter network and the internal network. Because the issuing CA on the perimeter network is subordinate to the root CA, the certificates that are issued in the perimeter network can be trusted on the internal network. If the perimeter network is compromised, you can use the root CA to revoke the certificate of the issuing CA in the perimeter network, which invalidates all certificates from the issuing CA in the perimeter network. The perimeter network can then be rebuilt and new certificates issued.

### Deployment in an isolated network

This deployment design offers a compromise between the most and least secure designs. It requires some infrastructure changes and configuration but without a separate forest.

This deployment design requires a single computer to run the Network Device Enrollment Service and the mobile device management solution. This computer is a member of the internal domain, so you don't have to install a separate issuing CA. The computer running the Network Device Enrollment Service and the mobile device management solution is attached by using a VPN or DirectAccess connection, which provides the isolated network environment. Mobile devices authenticate to the mobile device management software by using a user name and password before they obtain a certificate that then lets them access resources on the internally secured wireless network. See the following diagram for an example of this deployment design.

:::image type="content" source="media/folder-with-same-name-as-article-file/service-technology-image-description.png" alt-text="Diagram showing deployment design for how mobile devices authenticate user name and password.":::
<!-- ![](images/Dn473016.cd391501-1b51-4d7a-a2c5-b32f3fed706f(WS.11).jpeg) -->

In this design, the server running the Network Device Enrollment Service and the mobile device management solution can be at risk from attackers to compromise the internal network. To help mitigate this risk, install and configure the server running the Network Device Enrollment Service in the internal domain by using a temporary Domain Admin or Enterprise Admin account, then delete this account, and then move the server to the isolated network. Use additional security controls to protect this server and monitor it carefully for suspicious activity or signs that it might be compromised.

### Deployment on an internal domain

This deployment design is the least secure but lets you deploy this enrollment solution by using your existing internal domain structure.

In this design, there's no isolation for the server running the Network Device Enrollment Service and it's a member of the internal domain. The mobile device management software must authenticate all the requests for certificates from the wireless network. For example, this authentication might be to prompt for user name and password. See the following diagram for an example of this deployment design.

:::image type="content" source="media/folder-with-same-name-as-article-file/service-technology-image-description.png" alt-text="Diagram showing how mobile device management software must authenticate all the requests for certificates from the wireless network.":::
<!-- ![](images/Dn473016.db6ef0c4-5336-4900-893a-54cc3f6bf999(WS.11).jpeg) -->

This deployment design doesn't use a security boundary when the wireless network that is used to issue certificates is connected to the internal domain. In this scenario, the external wireless network could be used directly by an attacker in an attempt to compromise the internal domain. If you use this design, all computers on the internal network become potential targets for attack if the wireless network is compromised, so make sure that you use additional security controls to protect the entire internal network and all computers, and monitor them carefully for suspicious activity or signs that they might be compromised.

## Next steps

[Windows Server Security Forum](https://aka.ms/adcsforum)

[Active Directory Certificate Services (AD CS) Public Key Infrastructure (PKI) Frequently Asked Questions (FAQ)](https://aka.ms/adcsfaq)

[Windows PKI Documentation Reference and Library](https://social.technet.microsoft.com/wiki/contents/articles/987.windows-pki-documentation-reference-and-library.aspx)

[Windows PKI Blog](https://blogs.technet.com/b/pki/)