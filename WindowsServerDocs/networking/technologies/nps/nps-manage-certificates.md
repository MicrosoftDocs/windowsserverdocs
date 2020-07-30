---
title: Manage Certificates Used with NPS
description: This topic provides information about using server certificates with Network Policy Server in Windows Server 2016.
manager: brianlic
ms.prod: windows-server
ms.technology: networking
ms.topic: article
ms.assetid: 204a4ef4-9d78-4a62-9940-43cc0e1c39d0
ms.author: lizross 
author: eross-msft
---

# Manage Certificates Used with NPS

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

If you deploy a certificate-based authentication method, such as Extensible Authentication Protocol\-Transport Layer Security \(EAP\-TLS\), Protected Extensible Authentication Protocol\-Transport Layer Security \(PEAP\-TLS\), and PEAP\-Microsoft Challenge Handshake Authentication Protocol version 2 \(MS\-CHAP v2\), you must enroll a server certificate to all of your NPSs. The server certificate must:

- Meet the minimum server certificate requirements as described in [Configure Certificate Templates for PEAP and EAP Requirements](nps-manage-cert-requirements.md)

- Be issued by a certification authority \(CA\) that is trusted by client computers. A CA is trusted when its certificate exists in the Trusted Root Certification Authorities certificate store for the current user and local computer.

The following instructions assist in managing NPS certificates in deployments where the trusted root CA is a third-party CA, such as Verisign, or is a CA that you have deployed for your public key infrastructure \(PKI\) by using Active Directory Certificate Services \(AD CS\).

## Change the Cached TLS Handle Expiry

During the initial authentication processes for EAP\-TLS, PEAP\-TLS, and PEAP\-MS\-CHAP v2, the NPS caches a portion of the connecting client's TLS connection properties. The client also caches a portion of the NPS's TLS connection properties.

Each individual collection of these TLS connection properties is called a TLS handle.

Client computers can cache the TLS handles for multiple authenticators, while NPSs can cache the TLS handles of many client computers.

The cached TLS handles on the client and server allow the reauthentication process to occur more rapidly. For example, when a wireless computer reauthenticates with an NPS, the NPS can examine the TLS handle for the wireless client and can quickly determine that the client connection is a reconnect. The NPS authorizes the connection without performing full authentication.

Correspondingly, the client examines the TLS handle for the NPS, determines that it is a reconnect, and does not need to perform server authentication.

On computers running Windows 10 and Windows Server 2016, the default TLS handle expiry is 10 hours.

In some circumstances, you might want to increase or decrease the TLS handle expiry time.

For example, you might want to decrease the TLS handle expiry time in circumstances where a user's certificate is revoked by an administrator and the certificate has expired. In this scenario, the user can still connect to the network if an NPS has a cached TLS handle that has not expired. Reducing the TLS handle expiry might help prevent such users with revoked certificates from reconnecting.

>[!NOTE]
>The best solution to this scenario is to disable the user account in Active Directory, or to remove the user account from the Active Directory group that is granted permission to connect to the network in network policy. The propagation of these changes to all domain controllers might also be delayed, however, due to replication latency. 

## Configure the TLS Handle Expiry Time on Client Computers

You can use this procedure to change the amount of time that client computers cache the TLS handle of an NPS. After successfully authenticating an NPS, client computers cache TLS connection properties of the NPS as a TLS handle. The TLS handle has a default duration of 10 hours \(36,000,000 milliseconds\). You can increase or decrease the TLS handle expiry time by using the following procedure.

Membership in **Administrators**, or equivalent, is the minimum required to complete this procedure.

>[!IMPORTANT]
>This procedure must be performed on an NPS, not on a client computer.

### To configure the TLS handle expiry time on client computers

1. On an NPS, open Registry Editor.

2. Browse to the registry key **HKEY\_LOCAL\_MACHINE\System\CurrentControlSet\Control\SecurityProviders\SCHANNEL**

3. On the **Edit** menu, click **New**, and then click **Key**.

4. Type **ClientCacheTime**, and then press ENTER.

5. Right-click **ClientCacheTime**, click **New**, and then click **DWORD (32-bit) Value**.

6. Type the amount of time, in milliseconds, that you want client computers to cache the TLS handle of an NPS after the first successful authentication attempt by the NPS.

## Configure the TLS Handle Expiry Time on NPSs

Use this procedure to change the amount of time that NPSs cache the TLS handle of client computers. After successfully authenticating an access client, NPSs cache TLS connection properties of the client computer as a TLS handle. The TLS handle has a default duration of 10 hours \(36,000,000 milliseconds\). You can increase or decrease the TLS handle expiry time by using the following procedure.

Membership in **Administrators**, or equivalent, is the minimum required to complete this procedure.

>[!IMPORTANT]
>This procedure must be performed on an NPS, not on a client computer.

### To configure the TLS handle expiry time on NPSs

1. On an NPS, open Registry Editor.

2. Browse to the registry key **HKEY\_LOCAL\_MACHINE\System\CurrentControlSet\Control\SecurityProviders\SCHANNEL**

3. On the **Edit** menu, click **New**, and then click **Key**.

4. Type **ServerCacheTime**, and then press ENTER.

5. Right-click **ServerCacheTime**, click **New**, and then click **DWORD (32-bit) Value**.

6. Type the amount of time, in milliseconds, that you want NPSs to cache the TLS handle of a client computer after the first successful authentication attempt by the client.

## Obtain the SHA-1 Hash of a Trusted Root CA Certificate

Use this procedure to obtain the Secure Hash Algorithm (SHA-1) hash of a trusted root certification authority (CA) from a certificate that is installed on the local computer. In some circumstances, such as when deploying Group Policy, it is necessary to designate a certificate by using the SHA-1 hash of the certificate.

When using Group Policy, you can designate one or more trusted root CA certificates that clients must use in order to authenticate the NPS during the process of mutual authentication with EAP or PEAP. To designate a trusted root CA certificate that clients must use to validate the server certificate, you can enter the SHA-1 hash of the certificate.

This procedure demonstrates how to obtain the SHA-1 hash of a trusted root CA certificate by using the Certificates Microsoft Management Console (MMC) snap-in. 

To complete this procedure, you must be a member of the **Users** group on the local computer.

### To obtain the SHA-1 hash of a trusted root CA certificate

1. In the Run dialog box or Windows PowerShell, type **mmc**, and then press ENTER. The Microsoft Management Console \(MMC\) opens. In the MMC, click **File**, then click **Add/Remove Snap\in**. The **Add or Remove Snap-ins** dialog box opens.

2. In **Add or Remove Snap-ins**, in **Available snap-ins**, double-click **Certificates**. The Certificates snap-in wizard opens. Click **Computer account**, and then click **Next**.

3. In **Select Computer**, ensure that **Local computer (the computer this console is running on)** is selected, click **Finish**, and then click **OK**.

4. In the left pane, double-click **Certificates (Local Computer)**, and then double-click the **Trusted Root Certification Authorities** folder.

5. The **Certificates** folder is a subfolder of the **Trusted Root Certification Authorities** folder. Click the **Certificates** folder.

6. In the details pane, browse to the certificate for your trusted root CA. Double-click the certificate. The **Certificate** dialog box opens.

7. In the **Certificate** dialog box, click the **Details** tab.

8. In the list of fields, scroll to and select **Thumbprint**.

9. In the lower pane, the hexadecimal string that is the SHA-1 hash of your certificate is displayed. Select the SHA-1 hash, and then press the Windows keyboard shortcut for the Copy command \(CTRL\+C\) to copy the hash to the Windows clipboard.

10. Open the location to which you want to paste the SHA-1 hash, correctly locate the cursor, and then press the Windows keyboard shortcut for the Paste command \(CTRL\+V\). 

For more information about certificates and NPS, see [Configure Certificate Templates for PEAP and EAP Requirements](nps-manage-cert-requirements.md).

For more information about NPS, see [Network Policy Server (NPS)](nps-top.md).
