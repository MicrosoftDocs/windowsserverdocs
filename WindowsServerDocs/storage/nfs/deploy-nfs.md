---
title: Deploy Network File System
description: Learn how to deploy Network File System (NFS), which lets your organization transfer files between Windows and UNIX systems.
ms.topic: article
author: JasonGerend
ms.author: jgerend
ms.date: 03/27/2023
---

# Deploy Network File System

>Applies to: Windows Server 2022, Windows Server 2019, and Windows Server 2016.

Network File System (NFS) provides a file sharing solution that lets you transfer files between computers running Windows Server and UNIX operating systems by using the NFS protocol. This article describes the steps you should follow to deploy NFS.

## What's new in Network File System

Here's what's changed for NFS in Windows Server:

- **Support for NFS version 4.1**: This protocol version includes the following enhancements.

  - Makes navigating firewalls easier, which improves accessibility.
  - Supports the RPCSEC\_GSS protocol, providing stronger security and allowing clients and servers to negotiate security.
  - Supports UNIX and Windows file semantics.
  - Takes advantage of clustered file server deployments.
  - Supports WAN-friendly compound procedures.

- **NFS module for Windows PowerShell**: The availability of built-in NFS cmdlets makes it easier to automate various operations. The cmdlet names are consistent with other Windows PowerShell cmdlets (with verbs such as "Get" and "Set"), making it easier for users familiar with Windows PowerShell to learn to use new cmdlets.
- **NFS management improvements**: A new centralized UI-based management console simplifies configuration and management of SMB and NFS shares, quotas, file screens, and classification, in addition to managing clustered file servers.
- **Identity Mapping improvements**: This improvement includes new UI support and task-based Windows PowerShell cmdlets for configuring identity mapping. Administrators can quickly configure an identity mapping source, and then create individual mapped identities for users. Improvements make it easy for administrators to set up a share for multi-protocol access over both NFS and SMB.
- **Cluster resource model restructure**: This improvement brings consistency between the cluster resource model for the Windows NFS and SMB protocol servers and simplifies administration. For NFS servers that have many shares, the resource network and the number of WMI calls required fail over a volume containing a large number of NFS shares are reduced.
- **Integration with Resume Key Manager**: The Resume Key Manager tracks file server and file system state. The tool enables the Windows SMB and NFS protocol servers to fail over without disrupting clients or server applications that store their data on the file server. This improvement is a key component of the continuous availability capability of the file server running Windows Server.

## Scenarios for using Network File System

NFS supports a mixed environment of Windows-based and UNIX-based operating systems. The following deployment scenarios are examples of how you can deploy a continuously available Windows Server file server by using NFS.

### Provision file shares in heterogeneous environments

This scenario applies to organizations with heterogeneous environments that consist of both Windows and other operating systems, such as UNIX or Linux-based client computers. With this scenario, you can provide multi-protocol access to the same file share over both the SMB and NFS protocols. Typically, when you deploy a Windows file server in this scenario, you want to facilitate collaboration between users on Windows and UNIX-based computers. When a file share is configured, it's shared with both the SMB and NFS protocols. Windows users access their files over the SMB protocol, and users on UNIX-based computers typically access their files over the NFS protocol.

For this scenario, you must have a valid identity mapping source configuration. Windows Server supports the following identity mapping stores:

- Mapping File
- Active Directory Domain Services (AD DS)
- RFC 2307-compliant LDAP stores such as Active Directory Lightweight Directory Services (AD LDS)
- User Name Mapping (UNM) server

### Provision file shares in UNIX-based environments

In this scenario, Windows file servers are deployed in a predominantly UNIX-based environment to provide access to NFS file shares for UNIX-based client computers. An Unmapped UNIX User Access (UUUA) option was initially implemented for NFS shares in Windows Server 2008 R2. This option enables Windows servers to store NFS data without creating UNIX-to-Windows account mapping. UUUA allows administrators to quickly provision and deploy NFS without having to configure account mapping. When it is enabled for NFS, UUUA creates custom security identifiers (SIDs) to represent unmapped users. Mapped user accounts use standard Windows SIDs, and unmapped user accounts use custom NFS SIDs.

## System requirements

Server for NFS can be installed on any version of Windows Server. You can use NFS with UNIX-based computers that are running an NFS server or NFS client, if these NFS server and client implementations comply with one of the following protocol specifications:

- NFS Version 4.1 Protocol Specification (as defined in RFC [5661](https://tools.ietf.org/html/rfc5661))
- NFS Version 3 Protocol Specification (as defined in RFC [1813](https://tools.ietf.org/html/rfc1813))
- NFS Version 2 Protocol Specification (as defined in RFC [1094](https://tools.ietf.org/html/rfc1094))

## Deploy NFS infrastructure

You need to deploy the following computers and connect them on a local area network (LAN):

- One or more computers running Windows Server on which you'll install the two main Services for NFS components: Server for NFS and Client for NFS. You can install these components on the same computer or on different computers.
- One or more UNIX-based computers that are running NFS server and NFS client software. The UNIX-based computer that is running NFS server hosts an NFS file share or export, which is accessed by a computer that is running Windows Server as a client by using Client for NFS. You can install NFS server and client software either in the same UNIX-based computer or on different UNIX-based computers, as desired.
- A domain controller running at the Windows Server 2008 R2 functional level. The domain controller provides user authentication information and mapping for the Windows environment.
- When a domain controller isn't deployed, you can use a Network Information Service (NIS) server to provide user authentication information for the UNIX environment. Or, if you prefer, you can use password and group files that are stored on the computer that's running the User Name Mapping service.

### Install Network File System on the server with Server Manager

1. From the **Add Roles and Features** Wizard, under **Server Roles**, expand **File and Storage Services** > expand **File and iSCSI Services**.

1. Select **File Server** and **Server for NFS**, select **Next**.

1. A dialog box lets you know what other tools are required for the selected feature.

   - Check the box for the required features, select **Add Features**.

1. Select **Next**, and then choose any other preferred features. When you're ready, select **Next**.

1. To install the NFS components on the server, select **Install**.

### Install Network File System on the server with Windows PowerShell

1. Start Windows PowerShell. Select and hold (or right-click) the PowerShell icon on the taskbar, and select **Run as Administrator**.

1. Run the following Windows PowerShell commands:

```powershell
Import-Module ServerManager
Add-WindowsFeature FS-NFS-Service
Import-Module NFS
```

## Configure NFS authentication

For the NFS version 4.1 and NFS version 3.0 protocols, we recommend that you use Kerberos (RPCSEC_GSS). There are three options with increasing levels of security protection:

- **Krb5**: Uses the Kerberos version 5 protocol to authenticate users before granting them access to the file share.
- **Krb5i**: Uses the Kerberos version 5 protocol to authenticate with integrity checking (checksums), which verifies that the data hasn't been altered.
- **Krb5p**: Uses the Kerberos version 5 protocol, which authenticates NFS traffic with encryption for privacy. This option is the most secure Kerberos option.

  > [!NOTE]
  > You can also choose not to use the preceding Kerberos authentication methods and instead enable unmapped user access through AUTH_SYS. We *strongly discourage* using this option as it removes all authentication protections and allows any user with access to the NFS server to access data.
  > When you use unmapped user access, you can specify to allow unmapped user access by UID or GID, which is the default. You can also allow anonymous access.

Instructions for configuring NFS authentication are discussed in the following section.

## Create an NFS file share

You can create an NFS file share by using either Server Manager or Windows PowerShell NFS cmdlets.

### Create an NFS file share with Server Manager

1. Sign in to the server as a member of the local Administrators group.

1. Server Manager starts automatically.

   - If the tool doesn't automatically start, select **Start**. Enter **servermanager.exe**, and then select **Server Manager**.

1. On the left, select **File and Storage Services**, then select **Shares**. 

1. Under the **Shares** column, select **To create a file share, start the New Share Wizard**.

1. On the **Select Profile** page, select either **NFS Share - Quick** or **NFS Share - Advanced**, then select **Next**.

1. On the **Share Location** page, select a server and a volume, then select **Next**.

1. On the **Share Name** page, enter a name for the new share, then select **Next**.

1. On the **Authentication** page, specify the authentication method you want to use, then select **Next**.

1. On the **Share Permissions** page, select **Add**. The **Add Permissions** dialog opens.

   1. Choose the level of user permissions to grant: **Host**, **Netgroup**, **Client group**, or **All Machines**.
   
   1. For the selected user level, enter the name for the user(s) to grant permission to the share.

   1. Use the drop-down menu to select the preferred **Language encoding**.

   1. Use the drop-down menu to select the preferred **Share permissions**.

   1. (Optional) Select the **Allow root access** checkbox. _This option isn't recommended_.

   1. Select **Add**. The dialog closes. Select **Next**.

1. On the **Permissions** page, configure access control for your selected users. When you're ready, select **Next**.

1. On the **Confirmation** page, review your configuration, and select **Create** to create the NFS file share.

### Windows PowerShell equivalent commands

The following Windows PowerShell cmdlet can also create an NFS file share (where `nfs1` is the name of the share and `C:\\shares\\nfsfolder` is the file path):

```powershell
New-NfsShare -Name nfs1 -Path C:\shares\nfsfolder
```

### Known issue

NFS version 4.1 allows the file names to be created or copied with illegal characters. If you attempt to open the files with vi editor, it shows the files as being corrupt. You can't save the file from vi, rename, move it, or change permissions. So avoid using illegal characters.
