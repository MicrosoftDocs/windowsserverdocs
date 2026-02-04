---
title: DNS Encryption using DNS over HTTPS in Windows and Windows Server
description: Discover how DNS over HTTPS (DoH) in Windows enhances privacy and security by encrypting DNS queries and responses using HTTPS and TLS.
#customer intent: As a network administrator, I want to understand how DNS over HTTPS (DoH) works so that I can secure DNS traffic in my organization.
author: robinharwood
ms.author: roharwoo
ms.reviewer: canasjorge
ms.topic: concept-article
ms.date: 02/03/2026
ai-usage: ai-assisted
---

# DNS encryption using DNS over HTTPS

Traditional DNS uses unencrypted UDP or TCP messages on port 53, which exposes DNS traffic to passive monitoring, traffic analysis, and active manipulation by attackers. DNS encryption protects DNS query and response traffic from being observed, modified, or tampered with while in transit over a network.

DNS over HTTPS (DoH) is a standards‑based mechanism that encrypts DNS traffic by encapsulating DNS messages within HTTPS, providing confidentiality and integrity using Transport Layer Security (TLS). By encrypting DNS traffic, DoH helps prevent eavesdropping, man‑in‑the‑middle attacks, and unauthorized inspection of DNS queries and responses.

## How DNS over HTTPS works

DNS over HTTPS doesn't change the fundamental DNS query and response model. Instead, it changes how DNS messages are transported across the network. When you enable DoH on a DNS Server, DoH becomes an additional encrypted communication option, and the DNS Server continues to answer traditional DNS queries unless you explicitly disable that capability.

When you enable DoH:

- The DNS server listens to HTTPS traffic.

- You configure a [DoH-capable client (such as a Windows 11 client)](doh-client-support.md) to use the DoH server.

- The DoH client establishes a TLS connection to the DoH server.

- The client sends DNS queries inside an HTTPS request.

- The DNS server processes the query as usual.

- The DNS response is returned inside the HTTPS response.

- Upstream DNS communication from the DoH server to authoritative DNS servers remains unchanged.

## DNS over HTTPS for DNS Server (preview)

> [!IMPORTANT]
> DNS over HTTPS (DoH) for DNS Server on Windows Server is currently in PREVIEW.
> This information relates to a prerelease product that may be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

Beginning with the 2026-02 Security Update [KB5075899](https://support.microsoft.com/help/5075899) for Windows Server 2025, you can enable DNS over HTTPS (DoH) on the DNS Server service to encrypt DNS traffic between DoH-capable clients and your DNS server.

An example of the DoH communication flow is as shown in the following diagram.

:::image type="content" source="../media/dns-encryption-dns-over-https/overview.png" alt-text="Diagram that shows the DNS over HTTPS communication flow between a client and server." lightbox="../media/dns-encryption-dns-over-https/overview.png":::

When configuring DNS over HTTPS for DNS Server, consider the following during the preview:

- Upstream DNS communication (forwarders, conditional forwarders, authoritative servers) remains unencrypted

- DNS zone transfers remain unencrypted

- You can't create a DNS query filter that only matches DoH queries

- Policies with a Transport Protocol query filter don't match DoH queries (for example, a policy with Transport Protocol filter set to `EQ, TCP` doesn't match DoH)

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

DNS encryption, such as DoH, and DNSSEC address different threat models and are complementary technologies. DNS encryption protects DNS traffic on the wire, while DNSSEC ensures that DNS data is cryptographically verified for integrity and from an authoritative source.

Using DoH together with DNSSEC provides defense in depth by combining encrypted transport with authenticated DNS data. To learn more about DNSSEC, see [What is DNSSEC?](dnssec-overview.md).

## Next steps

> [!div class="nextstepaction"]
> [Enable DNS over HTTPS on Windows DNS Server](enable-dns-over-https-server.md)
