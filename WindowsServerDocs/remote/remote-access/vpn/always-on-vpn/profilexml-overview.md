---
title: ProfileXML Overview
description: This section provides a brief overview of the technologies of Always On VPN and links to additional documentation.
ms.prod: windows-server-threshold
ms.technology: networking, remote access, vpn
ms.topic: article
ms.assetid: 5ae1a40b-4f10-4ace-8aaf-13f7ab581f4f
manager: brianlic
ms.author: pashort
author: shortpatti
ms.date: 2/24/2018
---

# ProfileXML Overview

ProfileXML is a URI node within the VPNv2 CSP. Rather than configuring each VPNv2 CSP node individually—such as triggers, route lists, and authentication protocols—use this node to configure a Windows 10 VPN client by delivering all the settings as a single XML block to a single CSP node. The ProfileXML schema matches the schema of the VPNv2 CSP nodes almost identically, but some terms are slightly different.

You use ProfileXML in all the delivery methods this guide describes, including Windows PowerShell, System Center Configuration Manager, and Intune. There are two ways to configure the ProfileXML VPNv2 CSP node in this guide:

- **OMA-DM**. One way is to use an MDM provider capable of using OMA-DM, as discussed earlier in the section “VPNv2 CSP nodes.” Using this method, you can easily insert the VPN profile configuration XML markup into the ProfileXML CSP node. This is the method you’ll use to configure the Remote Access Always On VPN client by using Intune.

- **Windows Management Instrumentation (WMI)-to-CSP bridge**. The second method of configuring the ProfileXML CSP node is to use the WMI-to-CSP bridge—a WMI class called **MDM_VPNv2_01**—that can access the VPNv2 CSP and therefore the ProfileXML node. When you create a new instance of that WMI  class, WMI uses the CSP to create the VPN profile. This is the method you use to configure the Remote Access Always On VPN client by using Windows PowerShell and System Center Configuration Manager.

Even though these configuration methods differ, both require a properly formatted XML VPN profile. To use the ProfileXML VPNv2 CSP setting, you construct XML by using the ProfileXML schema to configure the tags necessary for the simple deployment scenario. For more details, see [ProfileXML XSD](https://msdn.microsoft.com/windows/hardware/commercialize/customize/mdm/vpnv2-profile-xsd).

In the section “Infrastructure requirements,” Table 1 provided an overview of the individual settings for the VPN client. Below is each of those required settings and its corresponding ProfileXML tag. You configure each setting in a specific tag within the ProfileXML schema, and not all of them are found under the native profile. For additional tag placement, see the ProfileXML schema.

**Connection type:** Native IKEv2

ProfileXML element:

    <NativeProtocolType>IKEv2</NativeProtocolType>

**Routing:** Split tunneling

ProfileXML element:

    <RoutingPolicyType>SplitTunnel</RoutingPolicyType>

**Name resolution:** Domain Name Information List and DNS suffix

ProfileXML elements:

    <DomainNameInformation>
    <DomainName>.corp.contoso.com</DomainName>
    <DnsServers>10.10.1.10,10.10.1.50</DnsServers>
    </DomainNameInformation>
    
    <DnsSuffix>corp.contoso.com</DnsSuffix>


**Triggering:** Always On and Trusted Network Detection

ProfileXML elements:

    <AlwaysOn>true</AlwaysOn>
    <TrustedNetworkDetection>corp.contoso.com</TrustedNetworkDetection>


**Authentication:** PEAP-TLS with TPM-protected user certificates

ProfileXML elements:

    <Authentication>
    <UserMethod>Eap</UserMethod>
    <Eap>
    <Configuration>...</Configuration>
    </Eap>
    </Authentication>

You can use simple tags to configure some VPN authentication mechanisms. However, EAP and PEAP are more involved. The easiest way to create the XML markup is to configure a VPN client with its EAP settings, and then export that configuration to XML. 

For more information about EAP settings, see [EAP configuration](https://msdn.microsoft.com/windows/hardware/commercialize/customize/mdm/eap-configuration). 