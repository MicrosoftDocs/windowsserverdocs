---
title: Certificates and trust in Windows
description: Learn how the Microsoft Root Certificate Program works to distribute trusted root certificates automatically across Windows operating systems in disconnected environments.
author: gswashington
ms.author: wscontent
ms.topic: overview
ms.date: 08/22/2023

---

# Certificates and trust in Windows

> Applies To: Windows Server (All supported versions), Windows clients, Azure Stack HCI.

The Microsoft Root Certificate Program enables distribution of trusted and untrusted root
certificates within Windows operating systems. For more information about the list of members in
Windows Root Certificate Program, see
[List of Participants - Microsoft Trusted Root Program](/security/trusted-root/participants-list).

Trusted and untrusted root certificates are used by Windows operating systems and applications as a
reference when determining whether public key infrastructure (PKI) hierarchies and digital
certificates are trustworthy. Untrusted root certificates are certificates that are publicly known
to be fraudulent. Trusted and untrusted root certificates functionality works across all
environments, whether connected or disconnected.

Trusted and untrusted root certificates are contained in a certificate trust list (CTL). When you
want to distribute root certificates, you use a CTL. Windows Server features automatic daily update
functionality that includes downloads of latest CTLs. The list of trusted and untrusted root
certificates are called the Trusted CTL and Untrusted CTL, respectively. For more information, see
[Announcing the automated updater of untrustworthy certificates and keys](https://blogs.technet.com/b/pki/archive/2012/06/12/announcing-the-automated-updater-of-untrustworthy-certificates-and-keys.aspx).

Servers and clients access the Windows Update site to update the CTL using the automatic daily
update mechanism (CTL updater) discussed in this article. You can take advantage of CTL updater
functionality by installing the appropriate software updates. See the article
[Configure Trusted Roots and Disallowed Certificates](configure-trusted-roots-disallowed-certificates.md)
for guidance in installing the software updates on supported operating systems discussed in this
article.

## Automatic certificate trust list updates

By default, Windows downloads the CTLs from the Internet via an automatic mechanism called the CTL
Updater. The public URLs used by the CTL Updater can be made available to clients:

- `http://ctldl.windowsupdate.com/msdownload/update/v3/static/trustedr/en/disallowedcertstl.cab`
- `http://ctldl.windowsupdate.com/msdownload/update/v3/static/trustedr/en/authrootstl.cab`

Automatic update functionality also can be disabled if necessary, although isn't recommended.

Alternately, you also can create a Group Policy administrative templates (ADMX policy) to redirect
to an internal server for updates.

The registry location where trusted and untrusted CTLs are stored as follows:

- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SystemCertificates\AuthRoot\AutoUpdate\EncodedCtl`
- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SystemCertificates\AuthRoot\AutoUpdate\DisallowedCertEncodedCtl`

## Benefits of CTL Updater

Automatic update functionality using the CTL Updater delivers several benefits:

- **Registry settings for storing CTLs** New settings enable changing the location for uploading
  trusted or untrusted CTLs from the Windows Update site to a shared location in an organization.
  See
  [Registry Settings Modified](configure-trusted-roots-disallowed-certificates.md#registry-settings-modified).

- **Synchronization options** If the URL for the Windows Update site is moved to a local shared
  folder, the local shared folder must be synchronized with the Windows Update folder. This software
  update adds a set of options in the Certutil tool that you use to enable synchronization. For more
  information, see the
  [Certutil -syncWithWU](../../administration/windows-commands/certutil.md#-syncwithwu) Windows
  command reference.

- **Tool to select trusted root certificates** This software update introduces a tool for managing
  the set of trusted root certificates in your enterprise environment. You can view and select the
  set of trusted root certificates, export them to a serialized certificate store, and distribute
  them by using Group Policy. For more information, see the
  [Certutil -generateSSTFromWU SSTFile](../../administration/windows-commands/certutil.md#-generatesstfromwu)
  Windows command reference.

- **Independent configurability** The automatic update mechanism for trusted and untrusted
  certificates are independently configurable; you can use the automatic update mechanism to
  download only the untrusted CTLs and manage your own list of trusted CTLs. For more information,
  see
  [Registry settings modified](configure-trusted-roots-disallowed-certificates.md#registry-settings-modified).

 See
 [Configure Trusted Roots and Disallowed Certificates](configure-trusted-roots-disallowed-certificates.md)
 for guidance in installing the software updates on supported operating systems discussed in this
 article.

Automatic update functionality can be disabled if necessary, however it isn't recommended.

## Next steps

Now you understand more about trusted root and disallowed certificates in Windows, here are some
more articles that might help you as configure your systems.

- [Configure trusted roots and disallowed certificates](configure-trusted-roots-disallowed-certificates.md)

- [List of Participants - Microsoft Trusted Root Program](/security/trusted-root/participants-list)

- [Controlling the Update Root certificate Certificates Feature to Prevent the Flow of Information to and from the Internet](https://technet.microsoft.com/library/cc749331.aspx)

- [Event ID 8 — Automatic Root Certificates Update Configuration](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc734054(v=ws.10))

- [certutil](../../administration/windows-commands/certutil.md) Windows command reference
