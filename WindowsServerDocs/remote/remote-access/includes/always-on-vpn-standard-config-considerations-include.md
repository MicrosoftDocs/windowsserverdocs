## Standard configuration considerations

Always On VPN has many configuration options. However you choose your VPN configuration, though, include the following information:

-   **Connection type.** Connection protocol selection is important and ultimately goes hand in hand with the type of authentication you will use. For details about the tunneling protocols available, see [VPN connection types](https://docs.microsoft.com/windows/security/identity-protection/vpn/vpn-connection-type/).

-   **Routing.** In this context, routing rules determine whether users can use other network routes while connected to the VPN.

    -   _Split tunneling_ allows simultaneous access to other networks, such as the Internet.

    -   _Force tunneling_ requires all traffic to go exclusively through the VPN and does not allow simultaneous access to other networks.

-   **Triggering.** _Triggering_ determines how and when a VPN connection is initiated (for example, when an app opens, when the device is turned on, manually by the user). For triggering options, see the [VPN auto-triggered profile options](https://docs.microsoft.com/windows/security/identity-protection/vpn/vpn-auto-trigger-profile/).

-   **Device or user authentication.** Always On VPN uses device certificates and device-initiated connection through a feature called [Device Tunnel](https://docs.microsoft.com/windows-server/remote/remote-access/vpn/vpn-device-tunnel-config). That connection can be initiated automatically and is persistent, resembling a DirectAccess infrastructure tunnel connection.

>[!TIP]
>When migrating from DirectAccess to Always On VPN, consider starting with configuration options that are comparable to what you have, and then expand from there.

By using user certificates, the Always On VPN client connects automatically, but it does so at the user level (after user sign-in) instead of at the device level (before user sign-in). The experience is still seamless to the user, but it supports more advanced authentication mechanisms, like Windows Hello for Business.