---
title: AD FS hostname binding certificate authentication
description: Learn how AD FS supports alternate hostname binding for certificate authentication in Windows Server, including certificates without a SAN.
ms.date: 05/24/2024
ms.topic: how-to
---

# Alternate hostname binding for certificate authentication in AD FS on Windows Server



On many networks, the local firewall policies might not allow traffic through nonstandard ports like 49443. Nonstandard ports can create issues during certificate authentication with AD FS on Windows Server for earlier versions of Windows. Different bindings for device authentication and user certificate authentication on the same host aren't possible. 

For Windows versions earlier than Windows Server 2016, the default port 443 is bound to receive device certificates. This port can't be altered to support multiple binding in the same channel. Smart card authentication doesn't work and there's no notification to users that explains the cause.

## AD FS in Windows Server supports alternate host name binding

AD FS in Windows Server provides support for alternate host name binding by using two modes:

- The first mode uses the same host (`adfs.contoso.com`) with different ports (443, 49443).

- The second mode uses different hosts (`adfs.contoso.com` and `certauth.adfs.contoso.com`) with the same port (443). This mode requires a TLS/SSL certificate to support `certauth.\<adfs-service-name>` as an alternate subject name. Alternate host name binding can be configured at the time of the farm creation or later by using PowerShell.

## How to configure alternate host name binding for certificate authentication

There are two ways you can add the alternate host name binding for certificate authentication:

- The first approach is when you set up a new AD FS farm with AD FS for Windows Server 2016. If the certificate contains a subject alternative name (SAN), the certificate is automatically set up to use the second mode described earlier. Two different hosts (`sts.contoso.com` and `certauth.sts.contoso.com`) are automatically set up with the same port.

   If the certificate doesn't contain a SAN, a warning message indicates the certificate subject alternative names don't support `certauth.*`:

   ```output
   The SSL certificate subject alternative names do not support host name 'certauth.adfs.contoso.com'. Configuring certificate authentication binding on port '49443' and hostname 'adfs.contoso.com'.
   
   The SSL certificate does not contain all UPN suffix values that exist in the enterprise. Users with UPN suffix values not represented in the certificate will not be able to Workplace-Join their devices. For more information, see http://go.microsoft.com/fwlink/?LinkId=311954.
   ```

   For an installation where the certificate contains a SAN, you see only the second portion of the message:

   ```output
   The SSL certificate does not contain all UPN suffix values that exist in the enterprise. Users with UPN suffix values not represented in the certificate will not be able to Workplace-Join their devices. For more information, see http://go.microsoft.com/fwlink/?LinkId=311954.
   ```

- The second approach is available after you deploy AD FS on Windows Server. You can use the PowerShell cmdlet `Set-AdfsAlternateTlsClientBinding` to add the alternate host name binding for certificate authentication. For more information, see [Set-AdfsAlternateTlsClientBinding](/powershell/module/adfs/set-adfsalternatetlsclientbinding).

   ```powershell
   Set-AdfsAlternateTlsClientBinding -Member ADFS1.contoso.com -Thumbprint '<thumbprint of cert>'
   ```

At the prompt to confirm the certificate configuration, select **Yes** or **Yes to all**.

## Related links

- [Managing SSL Certificates in AD FS and WAP in Windows Server 2016](./manage-ssl-certificates-ad-fs-wap.md)
