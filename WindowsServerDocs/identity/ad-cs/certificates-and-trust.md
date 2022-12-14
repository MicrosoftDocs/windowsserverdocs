---
title: Certificates and trust
description: Learn how the Microsoft Root Certificate Program works to distribute trusted root certificates automatically across Windows operating systems in disconnected environments.
ms.service: 
author: gswashington
ms.author: roharwoo
ms.topic: overview
ms.date: 12/14/2022

---

# Certificates and trust

Applies To: Windows Server (All supported versions), Windows clients, Azure Stack HCI.

Trusted root certificates are used by Windows operating systems and applications as a reference for which public key infrastructure (PKI) hierarchies and digital certificates are trustworthy. Trusted root certificates functionality works across all environments, whether connected or disconnected.

The Microsoft Root Certificate Program distributes trusted root certificates within Windows operating systems. In Windows, trusted root certificates are stored in the Trusted Root Certification Authorities certificate. Applications in Windows reference this certificate when determining what public key infrastructure (PKI) hierarchies and digital certificates are trustworthy.

Trusted root certificates are contained in a certificate trust list (CTL). When you want to distribute root certificates you use a CTL. Windows Server features automatic daily update functionality that includes downloads of latest CTLs. The list of trusted root certificates is called a Trusted CTL. Servers and clients access the Windows Update site to update the CTL using the automatic daily update mechanism (CTL updater) discussed in this article. You can take advantage of CTL updater functionality by installing the appropriate software updates. See [Configure Trusted Roots and Disallowed Certificates](configure-trusted-roots-disallowed-certificates.md) for guidance in installing the software updates on supported operating systems discussed in this article.

## Automatic certificate trust list updates

Automatic update functionality benefits include:

- **Registry settings for storing CTLs** New settings enable changing the location for uploading trusted or untrusted CTLs from the Windows Update site to a shared location in an organization. See [Registry Settings Modified](configure-trusted-roots-disallowed-certificates.md#registry-settings-modified).

- **Synchronization options** If the URL for the Windows Update site is moved to a local shared folder, the local shared folder must be synchronized with the Windows Update folder. This software update adds a set of options in the Certutil tool that you use to enable synchronization. For more information, see [New Certutil Options](configure-trusted-roots-disallowed-certificates.md#new-certutil-options).

- **Tool to select trusted root certificates** This software update introduces a tool for managing the set of trusted root certificates in your enterprise environment. You can view and select the set of trusted root certificates, export them to a serialized certificate store, and distribute them by using Group Policy. For more information, see [New Certutil Options](configure-trusted-roots-disallowed-certificates.md#new-certutil-options).

- **Independent configurability** The automatic update mechanism for trusted and untrusted certificates are independently configurable; you can use the automatic update mechanism to download only the untrusted CTLs and manage your own list of trusted CTLs. For more information, see [Registry settings modified](configure-trusted-roots-disallowed-certificates.md#registry-settings-modified).

Automatic update functionality also can be disabled if necessary. See [Workflow: PKI Client: Certificate Root Update Program - Overview (visualstudio.com)](https://supportability.visualstudio.com/WindowsDirectoryServices/_wiki/wikis/WindowsDirectoryServices/414078/Workflow-PKI-Client-Certificate-Root-Update-Program) for more information.

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