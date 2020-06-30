---
title: Wireless Access Deployment Planning
description: This topic is part of the Windows Server 2016 Networking guide "Deploy Password-Based 802.1X Authenticated Wireless Access"
manager: brianlic
ms.prod: windows-server
ms.technology: networking
ms.topic: article
ms.assetid: 8c632d02-2270-4a82-8fc4-74ea3747f079
ms.author: lizross
author: eross-msft
---
# Wireless Access Deployment Planning

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

Before you deploy wireless access, you must plan the following items:

- Installation of wireless access points \(APs\) on your network

- Wireless client configuration and access

The following sections provide details on these planning steps.

## Planning wireless AP installations
When you design your wireless network access solution, you must do the following:

1. Determine what standards your wireless APs must support
2. Determine the coverage areas where you want to provide wireless service
3. Determine where you want to locate wireless APs

Additionally, you must plan an IP address scheme for your wireless AP's and wireless clients. See the section **Plan the configuration of wireless AP's in NPS** below for related information.

### Verify wireless AP support for standards
For the purposes of consistency and ease of deployment and AP management, it is recommended that you deploy wireless APs of the same brand and model.

The wireless APs that you deploy must support the following:

- **IEEE 802.1X**

- **RADIUS authentication**

- **Wireless Authentication and Cipher.** Listed in order of most to least preferred:

    1.  WPA2\-Enterprise with AES

    2.  WPA2\-Enterprise with TKIP

    3.  WPA\-Enterprise with AES

    4.  WPA\-Enterprise with TKIP

>[!NOTE]
>To deploy WPA2, you must use wireless network adapters and wireless APs that also support WPA2. Otherwise, use WPA\-Enterprise.

In addition, to provide enhanced security for the network, the wireless APs must support the following security options:

- **DHCP filtering.** The wireless AP must filter on IP ports to prevent the transmission of DHCP broadcast messages in those cases in which the wireless client is configured as a DHCP server. The wireless AP must block the client from sending IP packets from UDP port 68 to the network.

- **DNS filtering.** The wireless AP must filter on IP ports to prevent a client from performing as a DNS server. The wireless AP must block the client from sending IP packets from TCP or UDP port 53 to the network.

- **Client isolation** If your wireless access point provides client isolation capabilities, you should enable the feature to prevent possible Address Resolution Protocol \(ARP\) spoofing exploits.

### Identify areas of coverage for wireless users
Use architectural drawings of each floor for each building to identify the areas where you want to provide wireless coverage. For example, identify the appropriate offices, conferences rooms, lobbies, cafeterias, or courtyards.

On the drawings, indicate any devices that interfere with the wireless signals, such as medical equipment, wireless video cameras, cordless telephones that operate in the 2.4 through 2.5 GHz Industrial, Scientific and Medical \(ISM\) range, and Bluetooth\-enabled devices.

On the drawing, mark aspects of the building that might interfere with wireless signals; metal objects used in the construction of a building can affect the wireless signal. For example, the following common objects can interfere with signal propagation: Elevators, heating and air\-conditioning ducts, and concrete support girders.

Refer to your AP manufacturer for information about sources that might cause wireless AP radio frequency attenuation. Most APs provide testing software that you can use to check for signal strength, error rate, and data throughput.

### Determine where to install wireless APs
On the architectural drawings, locate your wireless APs close enough together to provide ample wireless coverage but far enough apart that they do not interfere with each other.

The necessary distance between APs depends upon the type of AP and AP antenna, aspects of the building that block wireless signals, and other sources of interference. You can mark wireless AP placements so that each wireless AP is not more than 300 feet from any adjacent wireless AP. See the wireless AP manufacturer's documentation for AP specifications and guidelines for placement.

Temporarily install wireless APs in the locations specified on your architectural drawings. Then, using a laptop equipped with an 802.11 wireless adapter and the site survey software that is commonly supplied with wireless adapters, determine the signal strength within each coverage area.

In coverage areas where signal strength is low, position the AP to improve signal strength for the coverage area, install additional wireless APs to provide the necessary coverage, relocate or remove sources of signal interference.  

Update your architectural drawings to indicate the final placement of all wireless APs. Having an accurate AP placement map will assist later during troubleshooting operations or when you want to upgrade or replace APs.

### Plan wireless AP and NPS RADIUS Client configuration
You can use NPS to configure wireless APs individually or in groups.

If you are deploying a large wireless network that includes many APs, it is much easier to configure APs in groups. To add the APs as RADIUS client groups in NPS, you must configure the APs with these properties.

- The wireless APs are configured with IP addresses from the same IP address range.

- The wireless APs are all configured with the same shared secret.

### Plan the use of PEAP Fast Reconnect
In an 802.1X infrastructure, wireless access points are configured as RADIUS clients to RADIUS servers. When PEAP fast reconnect is deployed, a wireless client that roams between two or more access points is not required to be authenticated with each new association.

PEAP fast reconnect reduces the response time for authentication between client and authenticator because the authentication request is forwarded from the new access point to the NPS that originally performed authentication and authorization for the client connection request.

Because both the PEAP client and NPS both use previously cached Transport Layer Security \(TLS\) connection properties \(the collection of which is named the TLS handle\), the NPS can quickly determine that the client is authorized for a reconnect.

>[!IMPORTANT]
>For fast reconnect to function correctly, the APs must be configured as RADIUS clients of the same NPS.

If the original NPS becomes unavailable, or if the client moves to an access point that is configured as a RADIUS client to a different RADIUS server, full authentication must occur between the client and the new authenticator.

### Wireless AP configuration
The following list summarizes items commonly configured on 802.1X\-capable wireless APs:

> [!NOTE]
> The item names can vary by brand and model and might be different from those in the following list. See your wireless AP documentation for configuration\-specific details.

- **Service set identifier \(SSID\)**. This is the name of the wireless network \(for example, ExampleWlan\), and the name that is advertised to wireless clients. To reduce confusion, the SSID that you choose to advertise should not match the SSID that is broadcast by any wireless networks that are within reception range of your wireless network.

    In cases in which multiple wireless APs are deployed as part of the same wireless network, configure each wireless AP with the same SSID. In cases in which multiple wireless APs are deployed as part of the same wireless network, configure each wireless AP with the same SSID.  

    In cases where you have a need to deploy different wireless networks to meet specific business needs, your wireless AP's on one network should broadcast a different SSID than the SSID your other network\(s\). For example, if you need a separate wireless network for your employees and guests, you could configure your wireless APs for the business network with the SSID set to broadcast **ExampleWLAN**. For your guest network, you could then set each wireless AP's SSID to broadcast **GuestWLAN**. In this way your employees and guests can connect to the intended network without unnecessary confusion.  

    > [!TIP]  
    > Some wireless AP's have the ability to broadcast multiple SSID's to accommodate multi\-network deployments. Wireless AP's that can broadcast multiple SSID's can reduce deployment and operational maintenance costs.  

- **Wireless authentication and encryption**.

    Wireless authentication is the security authentication that is used when the wireless client associates with a wireless access point.  

    Wireless encryption is the security encryption cipher that is used with wireless authentication to protect the communications that are sent between the wireless AP and the wireless client.  

- **Wireless AP IP address \(static\)**. On each wireless AP, configure a unique static IP address. If the subnet is serviced by a DHCP server, ensure that all AP IP addresses fall within a DHCP exclusion range so that the DHCP server does not try to issue the same IP address to another computer or device. Exclusion ranges are documented in the procedure "To create and activate a new DHCP Scope" in the [Core Network Guide](https://technet.microsoft.com/windows-server-docs/networking/core-network-guide/core-network-guide). If you are planning to configure APs as RADIUS clients by group in NPS, each AP in the group must have an IP address from the same IP address range.

- **DNS name**. Some wireless APs can be configured with a DNS name. Configure each wireless AP with a unique name. For example, if you have a deployed wireless APs in a multi\-story building, you might name the first three wireless APs that are deployed on the third floor AP3\-01, AP3\-02, and AP3\-03.

- **Wireless AP subnet mask**. Configure the mask to designate which portion of the IP address  is the network ID and which portion of the IP address is the host.

- **AP DHCP service**. If your wireless AP has a built\-in DHCP service, disable it.

- **RADIUS shared secret**. Use a unique RADIUS shared secret for each wireless AP unless you are planning to configure NPS RADIUS clients in groups - in which circumstance you must configure all of the APs in the group with the same shared secret. Shared secrets should be a random sequence of at least 22 characters long, with both uppercase and lowercase letters, numbers, and punctuation. To ensure randomness, you can use a random character generation program to create your shared secrets. It is recommended that you record the shared secret for each wireless AP and store it in a secure location, such as an office safe. When you configure RADIUS clients in the NPS console you will create a virtual version of each AP. The shared secret that you configure on each virtual AP in NPS must match the shared secret on the actual, physical AP.

- **RADIUS server IP address**. Type the IP address of the NPS that you want to use to authenticate and authorize connection requests to this access point.

- **UDP port\(s\)**. By default, NPS uses UDP ports 1812 and 1645 for RADIUS authentication messages and UDP ports 1813 and 1646 for RADIUS accounting messages. It is recommended that you do not change the default RADIUS UDP ports settings.

- **VSAs**. Some wireless APs require vendor\-specific attributes \(VSAs\) to provide full wireless AP functionality.

- **DHCP filtering**. Configure wireless APs to block wireless clients from sending IP packets from UDP port 68 to the network. See the documentation for your wireless AP to configure DHCP filtering.

- **DNS filtering**. Configure wireless APs to block wireless clients from sending IP packets from TCP or UDP port 53 to the network. See the documentation for your wireless AP to configure DNS filtering.

## Planning wireless client configuration and access

When planning the deployment of 802.1X\-authenticated wireless access, you must consider several client\-specific factors:

- **Planning support for multiple standards**.

    Determine whether your wireless computers are all using the same version of Windows or whether they are a mixture of computers running different operating systems. If they are different, ensure that you understand any differences in standards supported by the operating systems.

    Determine whether all of the wireless network adapters on all of the wireless client computers support the same wireless standards, or whether you need to support varying standards. For example, determine whether some network adapter hardware drivers support WPA2\-Enterprise and AES, while others support only WPA\-Enterprise and TKIP.

- **Planning client authentication mode**. Authentication modes define how Windows clients process domain credentials. You can select from the following three network authentication modes in the wireless network policies.  

    1. **User re\-authentication**. This mode specifies that authentication is always performed by using security credentials based on the computer's current state. When no users are logged on to the computer, authentication is performed by using the computer credentials. When a user is logged on to the computer, authentication is always performed by using the user credentials.  

    2. **Computer only**. Computer only mode specifies that authentication is always performed by using only the computer credentials.  

    3.  **User authentication**. User authentication mode specifies that authentication is only performed when the user is logged on to the computer. When there are no users logged on to the computer, authentication attempts are not performed.  

- **Planning wireless restrictions**. Determine whether you want to provide all of your wireless users with the same level of access to your wireless network, or whether you want to restrict access for some of your wireless users. You can apply restrictions in NPS against specific groups of wireless users.  For example, you can define specific days and hours that certain groups are permitted access to the wireless network.  

- **Planning methods for adding new wireless computers**. For wireless\-capable computers that are joined to your domain before you deploy your wireless network, if the computer is connected to a segment of the wired network that is not protected by 802.1X, the wireless configuration settings are automatically applied after you configure Wireless Network \(IEEE 802.11\) Policies on the domain controller and after Group Policy is refreshed on the wireless client.  

    For computers that are not already joined to your domain, however, you must plan a method to apply the settings that are required for 802.1X\-authenticated access. For example, determine whether you want to join the computer to the domain by using one of the following methods.

    1.  Connect the computer to a segment of the wired network that is not protected by 802.1X, then join the computer to the domain.

    2.  Provide your wireless users with the steps and settings that they require to add their own wireless bootstrap profile, which allows them to join the computer to the domain.

    3.  Assign IT staff to join wireless clients to the domain.

### Planning support for multiple standards

The Wireless Network \(IEEE 802.11\) Policies extension in Group Policy provides a wide range of configuration options to support a variety of deployment options.

You can deploy wireless APs that are configured with the standards that you want to support, and then configure multiple wireless profiles in Wireless Network \(IEEE 802.11\) Policies, with each profile specifying one set of standards that you require.

For example, if your network has wireless computers that support WPA2\-Enterprise and AES, other computers that support WPA\-Enterprise and AES, and other computers that support only WPA\-Enterprise and TKIP, you must determine whether you want to:

- Configure a single profile to support all of the wireless computers by using the weakest encryption method that all of your computers support - in this case, WPA\-Enterprise and TKIP.  
- Configure two profiles to provide the best possible security that is supported by each wireless computer. In this instance you would configure one profile that specifies the strongest encryption \(WPA2\-Enterprise and AES\), and one profile that uses the weaker WPA\-Enterprise and TKIP encryption. In this example, it is essential that you place the profile that uses WPA2\-Enterprise and AES highest in the preference order. Computers that are not capable of using WPA2\-Enterprise and AES will automatically skip to the next profile in the preference order and process the profile that specifies WPA\-Enterprise and TKIP.

> [!IMPORTANT]
> You must place the profile with the most secure standards higher in the ordered list of profiles, because connecting computers use the first profile that they are capable of using.

### Planning restricted access to the wireless network

In many cases, you might want to provide wireless users with varying levels of access to the wireless network. For example, you might want to allow some users unrestricted access, any hour of the day, every day of the week. For other users, you might only want to allow access during core hours, Monday through Friday, and deny access on Saturday and Sunday.

This guide provides instructions to create an access environment that places all of your wireless users in a group with common access to wireless resources. You create one wireless users security group in the Active Directory Users and Computers snap\-in, and then make every user for whom you want to grant wireless access a member of that group.

When you configure NPS network policies, you specify the wireless users security group as the object that NPS processes when determining authorization.

However, if your deployment requires support for varying levels of access you need only do the following:  

1. Create more than one Wireless Users Security Group to create additional wireless security groups in Active Directory Users and Computers. For example, you can create a group that contains users who have full access, a group for those who only have access during regular working hours, and other groups that fit other criteria that match your requirements.

2. Add users to the appropriate security groups that you created.

3. Configure additional NPS network policies for each additional wireless security group, and configure the policies to apply the conditions and constraints that you require for each group.

### Planning methods for adding new wireless computers

The preferred method to join new wireless computers to the domain and then log on to the domain is by using a wired connection to a segment of the LAN that has access to domain controllers, and is not protected by an 802.1X authenticating Ethernet switch.

In some cases, however, it might not be practical to use a wired connection to join computers to the domain, or, for a user to use a wired connection for their first log on attempt by using computers that are already joined to the domain.

To join a computer to the domain by using a wireless connection or for users to log on to the domain the first time by using a domain\-joined computer and a wireless connection, wireless clients must first establish a connection to the wireless network on a segment that has access to the network domain controllers by using one of the following methods.

1. **A member of the IT staff joins a wireless computer to the domain, and then configures a Single Sign On bootstrap wireless profile.** With this method, an IT administrator connects the wireless computer to the wired Ethernet network, and then joins the computer to the domain. Then the administrator distributes the computer to the user. When the user starts the computer, the domain credentials that they manually specify for the user logon process are used to both establish a connection to the wireless network and log on to the domain.  

2. **The user manually configures wireless computer with bootstrap wireless profile, and then joins the domain.** With this method, users manually configure their wireless computers with a bootstrap wireless profile based on instructions from an IT administrator. The bootstrap wireless profile allows users to establish a wireless connection, and then join the computer to the domain. After joining the computer to the domain and restarting the computer, the user can log on to the domain by using a wireless connection and their domain account credentials.

To deploy wireless access, see [Wireless Access Deployment](e-wireless-access-deployment.md).
