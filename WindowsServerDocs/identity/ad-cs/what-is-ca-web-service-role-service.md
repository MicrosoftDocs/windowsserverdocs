---
title: Certificate Enrollment Web Service Guidance
description: Learn about the installation requirements, steps to install, and configuration options for Certificate Enrollment Web Service.
author: meaghanlewis
ms.topic: overview
ms.author: mosagie
ms.date: 02/10/2025
---

# Certificate Enrollment Web Service Guidance

The Certificate Enrollment Web Service is an Active Directory Certificate Services (AD CS) role service that enables users and computers to perform certificate enrollment by using the HTTPS protocol. Together with the Certificate Enrollment Policy Web Service, this enables policy-based certificate enrollment when the client computer is not a member of a domain or when a domain member is not connected to the domain. The Certificate Enrollment Web Service uses the HTTPS protocol to accept certificate requests from and return issued certificates to network client computers. The Certificate Enrollment Web Service uses the DCOM protocol to connect to the certification authority (CA) and complete certificate enrollment on behalf of the requester.

Certificate enrollment over HTTPS enables the following deployment scenarios:

- Certificate enrollment across forest boundaries to reduce the number of CAs in an enterprise

- Extranet deployment to issue certificates to mobile workers and business partners

This article provides the installation requirements for Certificate Enrollment Web Service and information about the configuration options that are presented when you use Server Manager to install the role service.

## Authentication types and considerations

Clients communicating with the Certificate Enrollment Web Service must use one of the following authentication types:

- Windows integrated authentication, also known as Kerberos authentication

- Client certificate authentication, also known as X.509 certificate authentication

- User name and password authentication

Each of these authentication types is discussed in more detail in the following sections.

> [!NOTE]
> If you want to enable key-based renewal, you must enable client certificate authentication for the Certificate Enrollment Web Service. Anonymous authentication to the web services is not supported.

### Windows integrated authentication (Kerberos authentication)

Windows Integrated Authentication uses Kerberos to provide a seamless authentication flow for devices connected to the internal network and joined to a domain. This method is preferred for internal deployments because it leverages the existing Kerberos infrastructure present within AD DS and requires minimal changes to certificate client computers. Use this authentication method if you only need clients to access the web service while connected directly to your internal network.

### Client certificate authentication (X.509 certificate authentication)

If certificates will be provisioned to computers, then clients computers can use client certificate authentication. Client certificate authentication doesn'tt require a direct connection to the corporate network. Client certificate authentication is preferred over username and password authentication because it provides a more secure method of authenticating. However, this method requires that x.509 certificates be initially provisioned to clients by separate means. Use this authentication method if you plan to provide users with digital X.509 certificates for client authentication. This authentication method enables you to make the web service available on the Internet. See [Client Certificate Authentication](https://social.technet.microsoft.com/wiki/contents/articles/7734.certificate-enrollment-web-services-in-active-directory-certificate-services.aspx#Authentication_Method_Considerations) for more information on how to configure client certificate authentication.

### User name and password authentication

The simplest form of authentication is username and password. This method typically is used for servicing clients that aren't directly connected to the internal network. It's a less secure authentication option than using client certificates, but it doesn't require provisioning a certificate to clients and therefore often easier to implement than client certificate authentication. Use this authentication method if you would like users to enter a username and password to authenticate to the web service. This authentication method can be used when the web service is accessed on the internal network or over the Internet.

## Planning load balancing and fault tolerance

When planning your Certificate Enrollment Web Service implementation, it's important to know that the single biggest factor affecting throughput according to extensive performance testing by Microsoft is network latency. Rather than relying on network load balancing (NLB) technologies, the Certificate Enrollment Policy Web Service and Certificate Enrollment Web Service client components have load balancing and fault tolerance logic built in. For example, the clients will automatically randomize the list of endpoints they’re provided and attempt to iterate through the list if the first endpoint is unresponsive. Thus, as long as multiple uniform resource identifiers (URIs) are published, basic load balancing and fault tolerance is built in.

Note that NLB should not be used to provide fault tolerance or high availability because NLB could route traffic to a host where the policy or web service is stopped or unavailable.  If all endpoints are published behind a single NLB balanced URI, the built in client logic would not be able to try the next URI, which would result in a less fault tolerant solution than if no special load balancing was used at all.

General best practices for load balancing the policy and enrollment web services include:

- Publish multiple enrollment and policy URIs, each with unique DNS names and preferably available through different network paths; allow the built in client logic to provide load balancing and fault tolerance.
- Don't publish multiple URIs behind a single URI (unless that URI is load balanced behind a device that is both network and application layer aware).
- Don't use DNS round robin or other DNS load balancing techniques that don't provide application layer intelligence and routing.

See [Planning_Load_Balancing_and_Fault_Tolerance](https://social.technet.microsoft.com/wiki/contents/articles/7734.certificate-enrollment-web-services-in-active-directory-certificate-services.aspx#Planning_Load_Balancing_and_Fault_Tolerance) for information on load balancing options for Windows client enrollment.

For detailed gudance on example configurations including:

- Intranet with a Single Forest
- Intranet with Multiple Forests
- Perimeter Network & Branch Office
- Renewal-Only Mode
- Key-based renewal
- Revoking certificates that could be used for key-based renewal

see [Example configurations](https://social.technet.microsoft.com/wiki/contents/articles/7734.certificate-enrollment-web-services-in-active-directory-certificate-services.aspx#Example_Configurations).

> [!NOTE]
> Key-based renewal mode is a feature introduced in Windows Server 2012 that allows an existing valid certificate to be used to authenticate a certificate renewal request. This enables computers that aren't connected directly to the internal network the ability to automatically renewal an existing certificate. To take advantage of this feature, the certificate client computers must be running at least Windows 8 or Windows Server 2012.

## Next steps

- [Certificate Enrollment Web Services in Active Directory Certificate Services](https://social.technet.microsoft.com/wiki/contents/articles/7734.certificate-enrollment-web-services-in-active-directory-certificate-services.aspx#Authentication_Method_Considerations)