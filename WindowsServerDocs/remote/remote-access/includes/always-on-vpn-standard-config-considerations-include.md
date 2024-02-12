## Standard configuration considerations

Always On VPN has many standard configuration options. However, it is essential that you include the following information when creating your VPN configuration:

- **Connection type.** Virtual private networks (VPNs) are point-to-point connections across a private or public network, such as the Internet. A VPN client uses special TCP/IP or UDP-based protocols, called tunneling protocols, to connect to a VPN server. The connection type also determines which kind of authentication you will use. For details about the tunneling protocols available, see [VPN connection types](/windows/security/identity-protection/vpn/vpn-connection-type/).

- **Routing.** In this context, routing rules determine whether users can use other network routes while connected to the VPN.

- **Triggering.** *Triggering* determines how and when a VPN connection is initiated (for example, when an app opens, when the device is turned on, manually by the user). For triggering options, see the [VPN auto-triggered profile options](/windows/security/identity-protection/vpn/vpn-auto-trigger-profile/).

- **Device or user authentication.** Always On VPN uses device certificates and device-initiated connection through a feature called [Device Tunnel](../vpn/vpn-device-tunnel-config.md). A device tunnel can be initiated automatically and is persistent, resembling a DirectAccess infrastructure tunnel connection.

>[!TIP]
>When migrating from DirectAccess to Always On VPN, consider starting with configuration options that are comparable to what you have, and then expand from there.

By using user certificates, the Always On VPN client connects automatically, but it does so at the user level (after user sign-in) instead of at the device level (before user sign-in). The experience is still seamless to the user, but it supports more advanced authentication mechanisms, like Windows Hello for Business.
