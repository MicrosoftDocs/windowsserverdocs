---
title: What is Network Device Enrollment Service for Active Directory Certificate Services?
description: Learn about the role of Network Device Enrollment Service and how it works with certificates based on Simple Certificate Enrollment Protocol
author: gswashington
ms.author: wscontent
ms.topic: overview
ms.date: 03/30/2023
---

# What is Network Device Enrollment Service for Active Directory Certificate Services?

Applies To: Windows Server (All supported versions)

The Network Device Enrollment Service (NDES) is one of the role services of Active Directory
Certificate Services (AD CS). NDES acts as a Registration Authority to enable the software on
routers and other network devices running without domain credentials to get certificates based on
the Simple Certificate Enrollment Protocol (SCEP).

SCEP defines the communication protocol between network devices and a Registration Authority for
certificate enrollment. It strives to support the secure issuance of certificates to network devices
in a scalable manner, using existing technology in closed networks with trusted endpoints. For more
information on SCEP, see
[RFC 8894 Simple Certificate Enrollment Protocol](https://datatracker.ietf.org/doc/html/rfc8894).

## Understanding the Network Device Enrollment Service

SCEP is a solution to the problem of enabling network devices that don't run with domain credentials
to enroll for x509 version 3 certificates from a Certification Authority (CA). NDES provides any
network device with a private key and associated certificate issued by a CA. Applications on the
device can use the key and its associated certificate to interact with other entities on the
network. The most common use of an NDES-issued certificate on a network device is to authenticate
the device in an IPSec session.

SCEP was developed to support the secure, scalable issuance of certificates to network devices by
using existing certification authorities (CAs). The protocol supports CA and registration authority
public key distribution, enrollment, and certificate revocation queries.

NDES performs the following functions:

- Generates and provides one-time enrollment passwords to administrators.

- Submits enrollment requests to the CA.

- Retrieves enrolled certificates from the CA and forwards them to the network device.

NDES is implemented as an Internet Server API (ISAPI) extension. It requires the Internet
Information Services (IIS) role to be installed on the same computer. It doesn't require the CA to
be installed on the same computer. The ISAPI extension runs in its own application pool, that is,
SCEP. This application pool is created during setup and is configured to run with the credentials
that were provided during setup.

The SCEP specification doesn't require devices to support TLS. However, the process of retrieving a
one-time password from the service should be protected using TLS. Setup creates two virtual
applications - one for the device and one for the administrator.

- Devices communication location`https://<hostname>/certsrv/mscep`
- Administrator enrollment password retrieval location `https://<hostname>/certsrv/mscep_admin`

Passwords are used by the service to authenticate the device before forwarding its enrollment
request to the CA. Passwords are obtained through a call to the
[administration virtual application](https://localhost/certsrv/mscep_admin).

Enrolling certificates through Network Device Enrollment Service is a straightforward process:

1. Device obtains an RSA public-private key pair from the _/certsrv/mscep_ web endpoint.

1. Administrator obtains a password from the Network Device Enrollment Service.

1. Administrator sets device with password and sets it to trust the enterprise PKI
   _/certserv/mscep\_admin_ web endpoint.

1. Device configured to send enrollment request to NDES.

1. NDES signs enrollment request with Enrollment Agent certificate and sends it to the CA.

1. CA issues the certificate.

1. Device retrieves issued certificate from NDES.

## NDES configuration settings

NDES can be configured to run as either of the following after installing the NDES role service:

- A user account that is specified as a service account

- The built-in application pool identity of the Internet Information Services (IIS) computer

## Next steps

Now that you've learned about what NDES is here are some articles to help you configure and run NDES
successfully.

- [Configure Network Device Enrollment Service for Active Directory Certificate Services](create-domain-user-account-ndes-service-account.md)

- If you require over-the-air enrollment for mobile devices, see
  [Using a Policy Module with the Network Device Enrollment Service](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn473016(v=ws.11)).

- For detailed information about NDES configuration and operation, see
  [Network Device Enrollment Service (NDES) in Active Directory Certificate Services (AD CS)](https://social.technet.microsoft.com/wiki/contents/articles/9063.network-device-enrollment-service-ndes-in-active-directory-certificate-services-ad-cs.aspx).
