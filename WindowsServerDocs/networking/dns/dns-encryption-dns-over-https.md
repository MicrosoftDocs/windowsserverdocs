---
title: DNS Encryption using DNS over HTTPS in Windows
description: Discover how DNS over HTTPS (DoH) in Windows enhances privacy and security by encrypting DNS queries and responses using HTTPS and TLS.
#customer intent: As a network administrator, I want to understand how DNS over HTTPS (DoH) works so that I can secure DNS traffic in my organization.
author: robinharwood
ms.author: roharwoo
ms.reviewer: canasjorge
ms.topic: concept-article
ms.date: 01/19/2026
---

# DNS encryption using DNS over HTTPS in Windows

Traditional DNS uses unencrypted UDP or TCP messages on port 53, which exposes DNS traffic to passive monitoring, traffic analysis, and active manipulation by attackers. DNS encryption protects DNS query and response traffic from being observed, modified, or tampered with while in transit over a network.

DNS over HTTPS (DoH) is a standards‑based mechanism that encrypts DNS traffic by encapsulating DNS messages within HTTPS, providing confidentiality and integrity using Transport Layer Security (TLS). By encrypting DNS traffic, DoH helps prevent eavesdropping, man‑in‑the‑middle attacks, and unauthorized inspection of DNS queries and responses.

## How DNS over HTTPS works

DNS over HTTPS doesn't change the fundamental DNS query and response model. Instead, it changes how DNS messages are transported across the network.

When you enable DoH:

- The DNS server listens to HTTPS traffic.

- You configure a DoH-capable client (such as a Windows 11 client) to use the DoH server.

- The DoH client establishes a TLS connection to the DoH server.

- The client sends DNS queries inside an HTTPS request.

- The DNS server processes the query as usual.

- The DNS response is returned inside the HTTPS response.

## Security benefits of DNS over HTTPS

DNS over HTTPS provides the following security and privacy benefits:

- **Confidentiality**. DNS queries and responses are encrypted, preventing passive monitoring.

- **Integrity**. TLS protects DNS messages from modification during transit.

- **Authentication**. DNS clients can validate the identity of the DoH server using standard HTTPS certificate validation.

- **Resistance to traffic analysis**. DNS traffic blends with other HTTPS traffic, reducing exposure to DNS‑specific filtering or manipulation. This approach improves privacy and resistance to interception.

## DNS over HTTPS protocols and standards

IETF defines DNS over HTTPS in [RFC 8484 – DNS Queries over HTTPS (DoH)](https://www.rfc-editor.org/rfc/rfc8484.txt).

RFC 8484 specifies how to send and receive DNS messages using HTTP over TLS. The DoH standard supports both GET and POST methods and defines media types for DNS messages. This approach allows DNS traffic to benefit from modern HTTPS features such as encryption, authentication, and connection reuse.

Additionally, the DoH standard allows server implementations the freedom to configure the server’s listening URI and port, enabling flexible deployment across different network environments.

## DNS encryption and DNSSEC

DNS encryption, such as DoH, and DNSSEC address different threat models and are complementary technologies.

DNS encryption protects DNS traffic on the wire, while DNSSEC ensures that DNS data is cryptographically verified from an authoritative source.

Using DoH together with DNSSEC provides defense in depth by combining encrypted transport with authenticated DNS data.

## Related content

To learn more about securing DNS, see:

- [What is DNSSEC?](dnssec-overview.md)
- [Secure DNS Client over HTTPS (DoH)](doh-client-support.md)