---
title: Certificates and trust
description: Learn how the Microsoft Root Certificate Program works to distribute trusted root certificates automatically across Windows operating systems.
ms.service: 
author: gswashington
ms.author: roharwoo
ms.topic: overview
ms.date: 12/05/2022

---

# Certificates and trust

Applies To: Windows Server (All supported versions)

The Microsoft Root Certificate Program distributes trusted root certificates within Windows operating systems. In Windows, trusted root certificates are stored in the Trusted Root Certification Authorities certificate. Applications in Windows reference this certificate when determining what public key infrastructure (PKI) hierarchies and digital certificates are trustworthy.

When you want to distribute root certificates you use a certificate trust list (CTL). There are CTLs for both trusted and untrusted root certificates. The list of trusted root certificates is called a Trusted CTL. Untrusted root certificates are certificates that are publicly known to be fraudulent. The list of untrusted root certificates is called an _____ CTL.
<!-- (Q: WHAT ARE THEY (Untrusted CTLs) CALLED?) -->

Client computers access the Windows Update site by using the automatic update mechanism to update both trusted and untrusted CTLs.

Windows Server 2012 R2, Windows Server 2012 and Windows 8.1, and Windows 8 operating systems feature automatic daily update functionality that includes downloads of certificate trust lists. Windows Server 2012 R2 and Windows 8.1 offer additional functionality to control how your CTLs are updated.

Individual manual software updates are available for Windows Server 2012, Windows Server 2008 R2, Windows Server 2008, Windows 8, Windows 7, and Windows Vista. You can take advantage of the automatic update functionality discussed in this document by manually installing the appropriate software updates. See [Configure Trusted Roots and Disallowed Certificates](configure-trusted-roots-disallowed-certificates.md) for guidance in installing the software updates on supported operating systems discussed in this article.

Prior to Windows Server 2012 R2 and Windows 8.1, the same registry setting controlled updates for trusted and untrusted root certificates; you could not selectively enable or disable one or the other. This presented several challenges.

- **Conflicting recommendations regarding automatic updates for trusted and untrusted CTLs** Although disabling automatic updates for trusted CTLs was recommended if you managed your lists of trusted root certificates manually (in disconnected or connected environments), disabling automatic updates of untrusted CTLs was *not* recommended.

    See [Controlling the Update Root certificate Certificates Feature to Prevent the Flow of Information to and from the Internet](https://technet.microsoft.com/library/cc749331.aspx) to learn more.

- **No method to view and extract only the trusted root certificates in a trusted CTL** This missing functionality made managing a customized list of trusted certificates  difficult task.

## Software update descriptions

Automatic update functionality to address the challenges for disconnected environments 
<!-- (???? ROBIN TO YOU AGREE THAT THE PRECEDING SECTIONS DO NOT CLEARLY ENOUGH DIFFERENTIATE BETWEEN CONNECTED AND DISCONNECTED ENVIRONMENTS? MUST THEY DO SO?)-->
now are available in Windows Server 2012 R2 and Windows 8.1, or by installing the appropriate manual software update. Improvements in automatics update functionality include:

- **Registry settings for storing CTLs** New settings enable changing the location for uploading trusted or untrusted CTLs from the Windows Update site to a shared location in an organization. See [Registry Settings Modified](configure-trusted-roots-disallowed-certificates.md#registry-settings-modified).

- **Synchronization options** If the URL for the Windows Update site is moved to a local shared folder, the local shared folder must be synchronized with the Windows Update folder. This software update adds a set of options in the Certutil tool that you can use to enable synchronization. For more information, see [New Certutil Options](configure-trusted-roots-disallowed-certificates.md#new-certutil-options).

- **Tool to select trusted root certificates** This software update introduces a tool for managing the set of trusted root certificates in your enterprise environment. You can view and select the set of trusted root certificates, export them to a serialized certificate store, and distribute them by using Group Policy. For more information, see [New Certutil Options](configure-trusted-roots-disallowed-certificates.md#new-certutil-options).

- **Independent configurability** The automatic update mechanism for trusted and untrusted certificates are independently configurable. This means you can use the automatic update mechanism to download only the untrusted CTLs and manage your own list of trusted CTLs. For more information, see [Registry settings modified](configure-trusted-roots-disallowed-certificates.md#registry-settings-modified).

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

- [certutil](/administration/windows-commands/certutil.md)