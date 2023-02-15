---
title: Trusted roots and disallowed certificates
description: Learn how the Microsoft Root Certificate Program works to distribute trusted root certificates automatically across Windows operating systems in disconnected environments.
ms.service: 
author: gswashington
ms.author: roharwoo
ms.topic: overview
ms.date: 01/18/2023

---

# Certificates and trust

Applies To: Windows Server (All supported versions), Windows clients, Azure Stack HCI.

The Microsoft Root Certificate Program enables distribution of trusted and untrusted root certificates within Windows operating systems. For more information about the list of members in Windows Root Certificate Program, see [Windows Root Certificate Program - Members List (All CAs)](GET VERIFIED LINK FROM FLORIN).

Trusted and untrusted root certificates are used by Windows operating systems and applications as a reference when determining whether public key infrastructure (PKI) hierarchies and digital certificates are trustworthy. Untrusted root certificates are certificates that are publicly known to be fraudulent. Trusted and untrusted root certificates functionality works across all environments, whether connected or disconnected.

Trusted and untrusted root certificates are contained in a certificate trust list (CTL). When you want to distribute root certificates, you use a CTL. Windows Server features automatic daily update functionality that includes downloads of latest CTLs. The list of trusted and untrusted root certificates are called the Trusted CTL and Untrusted CTL, respectively. See [Announcing the automated updater of untrustworthy certificates and keys](https://blogs.technet.com/b/pki/archive/2012/06/12/announcing-the-automated-updater-of-untrustworthy-certificates-and-keys.aspx) for more information.

Servers and clients access the Windows Update site to update the CTL using the automatic daily update mechanism (CTL updater) discussed in this article. You can take advantage of CTL updater functionality by installing the appropriate software updates. See [Configure Trusted Roots and Disallowed Certificates](configure-trusted-roots-disallowed-certificates.md) for guidance in installing the software updates on supported operating systems discussed in this article.

## Automatic certificate trust list updates

By default, Windows downloads the CTLs from the Internet via an automatic mechanism called the CTL Updater. The public URLs used by the CTL Updater can be made available to clients. These are:

- http://ctldl.windowsupdate.com/msdownload/update/v3/static/trustedr/en/disallowedcertstl.cab 
- http://ctldl.windowsupdate.com/msdownload/update/v3/static/trustedr/en/authrootstl.cab

Automatic update functionality also can be disabled if necessary, although isn't recommended.

Alternately, you also can create a Group Policy administrative templates (ADMX policy) to redirect to an internal server for updates.

The registry location where trusted and untrusted CTLs are stored as follows:

- HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SystemCertificates\AuthRoot\AutoUpdate\EncodedCtl
- HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SystemCertificates\AuthRoot\AutoUpdate\DisallowedCertEncodedCtl

## Benefits of CTL Updater

Automatic update functionality using the CTL Updater delivers several benefits:

- **Registry settings for storing CTLs** New settings enable changing the location for uploading trusted or untrusted CTLs from the Windows Update site to a shared location in an organization. See [Registry Settings Modified](configure-trusted-roots-disallowed-certificates.md#registry-settings-modified).

- **Synchronization options** If the URL for the Windows Update site is moved to a local shared folder, the local shared folder must be synchronized with the Windows Update folder. This software update adds a set of options in the Certutil tool that you use to enable synchronization. For more information, see [New Certutil Options](configure-trusted-roots-disallowed-certificates.md#new-certutil-options).

- **Tool to select trusted root certificates** This software update introduces a tool for managing the set of trusted root certificates in your enterprise environment. You can view and select the set of trusted root certificates, export them to a serialized certificate store, and distribute them by using Group Policy. For more information, see [New Certutil Options](configure-trusted-roots-disallowed-certificates.md#new-certutil-options).

- **Independent configurability** The automatic update mechanism for trusted and untrusted certificates are independently configurable; you can use the automatic update mechanism to download only the untrusted CTLs and manage your own list of trusted CTLs. For more information, see [Registry settings modified](configure-trusted-roots-disallowed-certificates.md#registry-settings-modified).

 See [Configure Trusted Roots and Disallowed Certificates](configure-trusted-roots-disallowed-certificates.md) for guidance in installing the software updates on supported operating systems discussed in this article.

## Related content

- [Announcing the automated updater of untrustworthy certificates and keys](https://blogs.technet.com/b/pki/archive/2012/06/12/announcing-the-automated-updater-of-untrustworthy-certificates-and-keys.aspx)

- [Windows Root Certificate Program - Members List (All CAs)](https://social.technet.microsoft.com/wiki/contents/documents/2592.windows-root-certificate-program-members-list-all-cas.aspx)

- [How to Write a Simple .Adm File for Registry-based Group Policy](https://technet.microsoft.com/library/cc738443.aspx)

- [Writing Custom ADM Files for System Policy Editor](https://support.microsoft.com/kb/225087)

- [Managing Group Policy ADMX Files Step-by-Step Guide](https://technet.microsoft.com/library/cc709647.aspx)

- [Windows Root certificate Certificate Program - Members List (All CAs)](https://go.microsoft.com/fwlink/?linkid=269988)

- [Controlling the Update Root certificate Certificates Feature to Prevent the Flow of Information to and from the Internet](https://technet.microsoft.com/library/cc749331.aspx)

- [Windows Server Security Forum](https://aka.ms/adcsforum)

- [Active Directory Certificate Services (AD CS) Public Key Infrastructure (PKI) Frequently Asked Questions (FAQ)](https://aka.ms/adcsfaq)

- [Windows PKI Documentation Reference and Library](https://social.technet.microsoft.com/wiki/contents/articles/987.windows-pki-documentation-reference-and-library.aspx)

- [Windows PKI Blog](https://blogs.technet.com/b/pki/)

- [Event ID 8 — Automatic Root Certificates Update Configuration](https://learn.microsoft.com/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc734054(v=ws.10)?redirectedfrom=MSDN)

- [An update is available that enables administrators to update trusted and disallowed CTLs in disconnected environments in Windows](https://support.microsoft.com/topic/an-update-is-available-that-enables-administrators-to-update-trusted-and-disallowed-ctls-in-disconnected-environments-in-windows-0c51c702-fdcc-f6be-7089-4585fad729d6) 

- [certutil](/administration/windows-commands/certutil.md)