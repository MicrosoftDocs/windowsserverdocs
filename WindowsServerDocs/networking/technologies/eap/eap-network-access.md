---
title: Extensible Authentication Protocol (EAP) for network access
description: This topic presents information about the Extensible Authentication Protocol (EAP) default settings that you can use to configure Windows-based computers.
author: khdownie
ms.author: v-kedow
ms.topic: conceptual
ms.date: 12/22/2020
---

# Extensible Authentication Protocol (EAP) for network access

> Applies to: Windows Server 2019, Windows Server 2016, Windows Server 2012

The Extensible Authentication Protocol (EAP) is an architectural framework that provides extensibility for authentication methods for commonly used protected network access technologies, such as IEEE 802.1X-based wireless access, IEEE 802.1X-based wired access, and Point-to-Point Protocol (PPP) connections such as Virtual Private Networking (VPN). EAP is not an authentication method like MS-CHAP v2, but rather a framework on the access client and authentication server that allows networking vendors to develop and easily install new authentication methods known as EAP methods.

## Authentication methods

This topic contains configuration information specific to the following authentication methods in EAP. Note that EAP authentication methods that are used within tunneled EAP methods are commonly known as **inner methods** or **EAP types**.

- **Protected EAP (PEAP)**

  This section contains configuration information for the two default inner EAP methods that are provided with PEAP.

  1. EAP-Transport Layer Security (TLS)

     Appearing as **Smart Card or other Certificate Properties** in the operating system, EAP-TLS can be deployed as an inner method for PEAP or as a standalone EAP method. When it is configured as an inner authentication method, the configuration settings for EAP-TLS are identical to the settings that are used to deploy EAP-TLS as an outer method, except that it is configured to operate within PEAP. For configuration details, see Smart Card or other Certificate Properties configuration items.

  2. EAP-Microsoft Challenge Handshake Authentication Protocol version 2 (MS-CHAP v2)

- **EAP-TLS**

  This section about Smart Card or other Certificate Properties includes information about the following configurations:

  - Configure New Certificate Selection configuration items
  - Select EKUs
  - Add or Edit EKU

- **EAP-Tunneled Transport Layer Security (TTLS)**

- **EAP-Subscriber Identity Module (SIM), EAP-Authentication and Key Agreement (AKA), and EAP-AKA Prime (AKA')**

  Enables authentication by using SIM cards, and is implemented when a customer purchases a wireless broadband service plan from a mobile network operator. As part of the plan, the customer commonly receives a wireless profile that is preconfigured for SIM authentication.

  This section provides information about the following configuration settings:

  - EAP-SIM
  - EAP-AKA
  - EAP-AKA’

## EAP-TLS, PEAP, and EAP-TTLS

You can access the EAP properties for 802.1X authenticated wired and wireless access in the following ways:

- By configuring the Wired Network (IEEE 802.3) Policies and Wireless Network (IEEE 802.11) Policies extensions in Group Policy.

- By manually configuring wired or wireless connections on client computers.

You can access the EAP properties for virtual private network (VPN) connections in the following ways:

- By using Connection Manager Administration Kit (CMAK) to configure VPN connections.

- By manually configuring VPN connections on client computers.

By default, you can configure EAP settings for the following network authentication methods for 802.1X authenticated wired access, 802.1X authenticated wireless access, and VPN:

- Microsoft: Smart Card or other Certificate (EAP-TLS)
- Microsoft: Protected EAP (PEAP)
- Microsoft: EAP-TTLS

Additionally, the MS-CHAP-V2 network authentication method is available for VPN by default.

## Protected EAP Properties configuration items

The following table lists the items that can be configured for Protected EAP.

   > [!IMPORTANT]
   > Deploying the same type of authentication method for PEAP and EAP creates a security vulnerability. When you deploy both PEAP and EAP (which is not protected), do not use the same authentication type. For example, if you deploy PEAP-TLS, do not also deploy EAP-TLS.

| **Item** | **Details** |
| --------------- | --------------- |
| Verify the server's identity by validating the certificate | Specifies that the client verifies that server certificates presented to the client computer have the correct signatures, have not expired, and were issued by a trusted root certification authority (CA). The default setting is "enabled." 
   > [!IMPORTANT]
   > If you disable this check box, client computers cannot verify the identity of your servers during the authentication process. If server authentication does not occur, users are exposed to severe security risks, including the possibility that users might unknowingly connect to a rogue network.|
| Connect to the servers | Allows you to specify the name for Remote Authentication Dial-In User Service (RADIUS) servers that provide network authentication and authorization. |


