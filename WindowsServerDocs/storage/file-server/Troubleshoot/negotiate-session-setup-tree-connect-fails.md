---
title: Negotiate, Session Setup, and Tree Connect Failures
description: Introduces how to troubleshoot the Negotiate, Session Setup, and Tree Connect Failures.
author: Deland-Han
manager: dcscontentpm
audience: ITPro
ms.topic: article
ms.author: delhan
ms.date: 12/25/2019
---

# Negotiate, Session Setup, and Tree Connect Failures

This article describes how to troubleshoot the failures that occur during an SMB Negotiate, Session Setup, and Tree Connect request.

## Negotiate fails

The SMB server receives an SMB NEGOTIATE request from an SMB client. The connection times out and is reset after 60 seconds. There may be an ACK message after about 200 microseconds.

This problem is most often caused by antivirus program.

If you are using Windows Server 2008 R2, there are hotfixes for this problem. Make sure that the SMB client and the SMB server are up to date.

## Session Setup fails

The SMB server receives an SMB SESSION\_SETUP request from a SMB client but failed to response.

If the fully qualified domain name (FQDN) or Network Basic Input/Output System (NetBIOS) name of the server is used in the Universal Naming Convention (UNC) path, Windows will use Kerberos for authentication.

After the Negotiate response, there will be an attempt to get a Kerberos ticket for the Common Internet File System (CIFS) service principal name (SPN) of the server. Look at the Kerberos traffic on TCP port 88 to make sure that there are no Kerberos errors when the SMB client is gaining the token.

> [!NOTE]
> The errors that occur during the Kerberos Pre-Authentication are OK. The errors that occur after the Kerberos Pre-Authentication (instances in which authentication does not work), are the errors that caused the SMB problem.

Additionally, make the following checks:

- Look at the security blob in the SMB SESSION\_SETUP request to make sure the correct credentials are sent.

- Try to disable SMB server name hardening (**SmbServerNameHardeningLevel = 0**).

- Make sure that the SMB server has an SPN when it is accessed through a CNAME DNS record.

- Make sure that SMB signing is working. (This is especially important for older, third-party devices.)

## Tree Connect fails

Make sure that the user account credentials have both share and NT file system (NTFS) permissions to the folder.

The cause of common Tree Connect errors can be found in [3.3.5.7 Receiving an SMB2 TREE\_CONNECT Request](https://docs.microsoft.com/openspecs/windows_protocols/ms-smb2/652e0c14-5014-4470-999d-b174d7b2da87). The following are the solutions for two common status codes.

\[STATUS\_BAD\_NETWORK\_NAME\]

Make sure that the share exists on the server, and that it is spelled correctly in the SMB client request.

\[STATUS\_ACCESS\_DENIED\]

Verify that the disk and folder that are used by the share exists and is accessible.

If you are using SMBv3 or later, check whether the server and the share require encryption, but the client doesn't support encryption. To do this, take the following actions:

- Check the server by running the following command.

  ```PowerShell
  Get-SmbServerConfiguration | select Encrypt*
  ```

  If EncryptData and RejectUnencryptedAccess are true, the server
  requires encryption.

- Check the share by running the following command:

  ```PowerShell
  Get-SmbShare | select name, EncryptData  
  ```

  If EncryptData is true on the share, and RejectUnencryptedAccess is true on the server, encryption is required by the share

Follow these guidelines as you troubleshoot:

- Windows 8, Windows Server 2012, and later versions of Windows support client-side encryption (SMBv3 and later).

- Windows 7, Windows Server 2008 R2 and earlier versions of Windows do not support client-side encryption.

- Samba and third-party device may not support encryption. You may have to consult product documentation for more information.

## References

For more information, see the following articles.

[3.3.5.4 Receiving an SMB2 NEGOTIATE
Request](https://docs.microsoft.com/openspecs/windows_protocols/ms-smb2/b39f253e-4963-40df-8dff-2f9040ebbeb1)

[3.3.5.5 Receiving an SMB2 SESSION\_SETUP
Request](https://docs.microsoft.com/openspecs/windows_protocols/ms-smb2/e545352b-9f2b-4c5e-9350-db46e4f6755e)

[3.3.5.7 Receiving an SMB2 TREE\_CONNECT
Request](https://docs.microsoft.com/openspecs/windows_protocols/ms-smb2/652e0c14-5014-4470-999d-b174d7b2da87?redirectedfrom=MSDN)
