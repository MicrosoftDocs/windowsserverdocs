---
title: Configure trusted roots and disallowed certificates in Windows
description: Guidance on how to configure individual software updates for automatic daily Root Certificate Updates, including certificate trust lists (CTLs)
ms.topic: how-to 
author: gswashington
ms.author: wscontent
ms.date: 08/22/2023
---

# Configure trusted roots and disallowed certificates in Windows

> Applies To: Windows Server (All supported versions), Windows clients, Azure Stack HCI.

Redirect the Microsoft Automatic Update URL to a file or web server hosting Certificate Trust Lists
(CTLs), untrusted CTLs, or a subset of the trusted CTL files in a disconnected environment.

To learn more about how the Microsoft Root Certificate Program works to distribute trusted root
certificates automatically across Windows operating systems, see
[Certificates and trust](certificate-trust.md).

> [!TIP]
> You don't need to redirect the Microsoft Automatic Update URL for environments where computers are
> able to connect to the Windows Update site directly. Computers that can connect to the Windows
> Update site are able to receive updated CTLs on a daily basis.

## Prerequisites

Before you can configure your disconnected environment to use CTL files hosted on a file or web
server, you need to complete the following prerequisites.

### Client prerequisites

- At least one computer that is able to connect to the Internet to download CTLs from Microsoft. The
  computer requires HTTP (TCP port 80) access and name resolution (TCP and UDP port 53) ability to
  contact `ctldl.windowsupdate.com`. This computer can be a domain member or a member of a
  workgroup. Currently all the downloaded files require approximately 1.5 MB of space.
- Client machines must be connected to an Active Directory Domain Service domain.
- You must be a member of the local _Administrators_ group.

### Server prerequisites

- A file server or web server for hosting the CTL files.
- AD Group policy or MDM solution to deploy configuration settings to your client.
- An account that is a member of the _Domain Admins_ group or that has been delegated the necessary
  permissions

## Configuration methods

An administrator can configure a file or web server to download the following files by using the
automatic update mechanism:

- `authrootstl.cab` contains a non-Microsoft CTL.

- `disallowedcertstl.cab` contains a CTL with untrusted certificates.

- `disallowedcert.sst` contains a serialized certificate store, including untrusted certificates.

- `<thumbprint>`.crt contains non-Microsoft root certificates.

The steps to perform this configuration are described in the
[Configure a file or web server to download the CTL files](#configure-a-file-or-web-server-to-download-the-ctl-files)
section of this document.

There are several methods to configure your environment to use local CTL files or a subset of
trusted CTLs. The following methods are available.

- Configure Active Directory Domain Services (AD DS) domain member computers to use the automatic
  update mechanism for trusted and untrusted CTLs, without having access to the Windows Update site.
  This configuration is described in the [Redirect the Microsoft Automatic Update URL](#redirect-the-microsoft-automatic-update-url) section of this document.

- Configure AD DS domain member computers to independently opt-in for untrusted and trusted CTL
  automatic updates. The independent opt-in configuration is described in the
  [Redirect the Microsoft Automatic Update URL for untrusted CTLs only](#redirect-the-microsoft-automatic-update-url-for-untrusted-ctls-only)
  section of this document.

- Examine the set of root certificates in the Windows Root Certificate Program. Examining the root
  certificate set enables administrators to select a subset of certificates to distribute by using a
  Group Policy Object (GPO). This configuration is described in the
  [Use a subset of the trusted CTLs](#use-a-subset-of-the-trusted-ctls) section of this document.

> [!IMPORTANT]
>
> - The settings described in this document are implemented by using GPOs. These settings are not
> automatically removed if the GPO is unlinked or removed from the AD DS domain. When implemented,
> these settings can be changed only by using a GPO or by modifying the registry of the affected
> computers.
>
> - The concepts discussed in this document are independent of Windows Server Update Services (WSUS).

## Configure a file or web server to download the CTL files

To facilitate the distribution of trusted or untrusted certificates for a disconnected environment,
you must first configure a file or web server to download the CTL files from the automatic update
mechanism.

### Retrieve the CTL files from Windows Update

1. Create a shared folder on a file or web server that is able to synchronize by using the automatic
   update mechanism and that you want to use to store the CTL files.

    > [!TIP]
    > Before you begin, you may have to adjust the shared folder permissions and NTFS folder
    > permissions to allow the appropriate account access, especially if you're using a scheduled
    > task with a service account. For more information on adjusting permissions, see
    > [Managing Permissions for Shared Folders](https://technet.microsoft.com/library/cc753731.aspx).

1. From an elevated PowerShell prompt, run the following command:

    ```powershell
    Certutil -syncWithWU \\<server>\<share>
    ```

    Substitute the actual server name for `<server>` and shared folder name for `<share>` For
    example, for a server named `Server1` with a shared folder named CTL, you'd run the command:

    ```powershell
    Certutil -syncWithWU \\Server1\CTL
    ```

1. Download the CTL files on a server that computers on a disconnected environment can access over
   the network by using a FILE path (for example, `FILE://\\Server1\CTL`) or an HTTP path (for
   example, `https://Server1/CTL`).

> [!NOTE]
>
> - If the server that synchronizes the CTLs is not accessible from the computers in the
> disconnected environment, you must provide another method to transfer the information. For
> example, you can allow one of the domain members to connect to the server, then schedule
> another task on the domain member computer to pull the information into a shared folder on an
> internal web server. If there is absolutely no network connection, you may have to use a manual
> process to transfer the files, such as a removable storage device.
>
> - If you plan to use a web server, you should create a new virtual directory for the CTL files.
> The steps to create a virtual directory by using Internet Information Services (IIS) are nearly
> the same for all the supported operating systems discussed in this document. For more information,
> see [Create a Virtual Directory (IIS7)](https://technet.microsoft.com/library/cc771804.aspx).
>
> - Certain system and application folders in Windows have special protection applied to them. For
> example, the _inetpub_ folder requires special access permissions, which make it difficult to
> create a shared folder for use with a scheduled task to transfer files. An administrator can
> create a folder location at the root of a logical drive system to use for file transfers.

## Redirect the Microsoft Automatic Update URL

The computers in your network might be configured in a disconnected environment and therefore unable
to use the automatic update mechanism or download CTLs. You can implement a GPO in AD DS to
configure these computers to obtain the CTL updates from an alternate location.

The configuration in this section requires that you already completed the steps in
[Configure a file or web server to download the CTL files](#configure-a-file-or-web-server-to-download-the-ctl-files).

### To configure a custom administrative template for a GPO

1. On a domain controller, create a new administrative template. Open a text file in Notepad and
   then change the file name extension to `.adm`. The contents of the file should be as follows:

    ```ADM
    CLASS MACHINE
    CATEGORY !!SystemCertificates
        KEYNAME "Software\Microsoft\SystemCertificates\AuthRoot\AutoUpdate"
        POLICY !!RootDirURL
           EXPLAIN !!RootDirURL_help
           PART !!RootDirURL EDITTEXT
                 VALUENAME "RootDirURL"
           END PART
        END POLICY
    END CATEGORY
    [strings]
    RootDirURL="URL address to be used instead of default ctldl.windowsupdate.com"
    RootDirURL_help="Enter a FILE or HTTP URL to use as the download location of the CTL files."
    SystemCertificates="Windows AutoUpdate Settings"
    ```

1. Use a descriptive name to save the file, such as `RootDirURL.adm`.

    - Ensure that the file name extension is `.adm` and not `.txt`.

    - If you haven't already enabled file name extension viewing, see
      [How To: View File Name Extensions](https://social.technet.microsoft.com/wiki/contents/articles/1784.how-to-view-file-name-extensions.aspx).

    - If you save the file to the `%windir%\inf` folder, it's easier to locate in the following
      steps.

1. Open the Group Policy Management Editor. Select **Start > Run**, type **GPMC.msc**, then press ENTER.

    > [!WARNING]
    > You can link a new GPO to the domain or to any organizational unit (OU). The GPO modifications
    > implemented in this document alter the registry settings of the affected computers. You can't
    > undo these settings by deleting or unlinking the GPO. The settings can only be undone by
    > reversing them in the GPO settings or by modifying the registry using another technique.

1. Expand the **Forest** object, expand the **Domains** object, and then expand the specific domain
   that contains the computer accounts that you want to change. If you have a specific OU that you
   want to modify, then navigate to that location.

1. Right-select and then select **Create a GPO in this domain, and Link it here** to create a new
   GPO.

1. In the navigation pane, under **Computer Configuration**, expand **Policies**.

1. Right-select **Administrative Templates**, then select **Add/Remove Templates**.

1. In **Add/Remove Templates**, select **Add**.

1. In the **Policy Templates** dialog box, select the `.adm` template that you previously saved.
   Select **Open**, then select **Close**.

1. In the navigation pane, expand **Administrative Templates**, and then expand **Classic
   Administrative Templates (ADM)**.

1. Select **Windows AutoUpdate Settings**, and in the details pane, double-select **URL address to
   be used instead of default ctldl.windowsupdate.com**.

1. Select **Enabled**. In the Options section, enter the URL to the file server or web server that
   contains the CTL files. For example, `https://server1/CTL` or `file://\\server1\CTL`.

1. Select **OK**.

1. Close the Group Policy Management Editor.

The policy is effective immediately, but the client computers must be restarted to receive the new
settings, or you can type `gpupdate /force` from an elevated command prompt or from Windows
PowerShell.

> [!IMPORTANT]
> The trusted and untrusted CTLs can be updated on a daily basis, so ensure that you keep the files
> synchronized by using a scheduled task or another method (such as a script that handles error
> conditions) to update the shared folder or web virtual directory. For more information about
> creating a scheduled task using PowerShell, see
> [New-ScheduledTask](/powershell/module/scheduledtasks/new-scheduledtask). If you plan to write a
> script to make daily updates, see the
> [certutil](../../administration/windows-commands/certutil.md) Windows command reference.

## Redirect the Microsoft Automatic Update URL for untrusted CTLs only

Some organizations might want only the untrusted CTLs (not the trusted CTLs) to be automatically
updated. To automatically update only the untrusted CTLs, create two `.adm` templates to add to
Group Policy.

In a disconnected environment, you can use the following procedure with the previous procedure
(redirect the Microsoft Automatic Update URL for trusted CTLs and untrusted CTLs). This procedure
explains how to selectively disable the automatic update of trusted CTLs.

You also can use this procedure in a connected environment in isolation to selectively disable the
automatic update of trusted CTLs.

### To selectively redirect only untrusted CTLs

1. On a domain controller, create the first new administrative template by starting with a text file
   and then changing the file name extension to `.adm`. The contents of the file should be as
   follows:

    ```ADM
    CLASS MACHINE
    CATEGORY !!SystemCertificates
        KEYNAME "Software\Policies\Microsoft\SystemCertificates\AuthRoot"
        POLICY !!DisableRootAutoUpdate
           EXPLAIN !!Certificates_config
           VALUENAME "DisableRootAutoUpdate"
           VALUEON NUMERIC 0
              VALUEOFF NUMERIC 1

        END POLICY
    END CATEGORY
    [strings]
    DisableRootAutoUpdate="Auto Root Update"
    Certificates_config="By default automatic updating of the trusted CTL is enabled. To disable the automatic updating trusted CTLe, select Disabled."
    SystemCertificates="Windows AutoUpdate Settings"
    ```

1. Use a descriptive name to save the file, such as `DisableAllowedCTLUpdate.adm`.

1. Create a second new administrative template. The contents of the file should be as follows:

    ```ADM
    CLASS MACHINE
    CATEGORY !!SystemCertificates
        KEYNAME "Software\Policies\Microsoft\SystemCertificates\AuthRoot"
        POLICY !!EnableDisallowedCertAutoUpdate
           EXPLAIN !!Certificates_config
           VALUENAME "EnableDisallowedCertAutoUpdate"
           VALUEON NUMERIC 1
              VALUEOFF NUMERIC 0

        END POLICY
    END CATEGORY
    [strings]
    EnableDisallowedCertAutoUpdate="Untrusted CTL Automatic Update"
    Certificates_config="By default untrusted CTL automatic update is enabled. To disable trusted CTL update, select Disabled."
    SystemCertificates="Windows AutoUpdate Settings"
    ```

1. Use a descriptive file name to save the file, such as **EnableUntrustedCTLUpdate.adm**.

    - Ensure that the file name extensions of these files are `.adm` and not `.txt`.

    - If you save the file to the `%windir%\inf` folder, it's easier to locate in the following
      steps.

1. Open the Group Policy Management Editor.

1. Expand the **Forest** object, expand the **Domains** object, and then expand the specific domain
   that contains the computer accounts that you want to change. If you have a specific OU that you
   want to modify, then navigate to that location.

1. In the navigation pane, under **Computer Configuration**, expand **Policies**.

1. Right-select **Administrative Templates**, then select **Add/Remove Templates**.

1. In **Add/Remove Templates**, select **Add**.

1. In the **Policy Templates** dialog box, select the `.adm` template that you previously saved.
   Select **Open**, then select **Close**.

1. In the navigation pane, expand **Administrative Templates**, then expand **Classic Administrative
   Templates (ADM)**.

1. Select **Windows AutoUpdate Settings**, then in the details pane, double-click **Auto Root
   Update**.

1. Select **Disabled**, then select **OK**.

1. In the details pane, double-click **Untrusted CTL Automatic Update**, then select **Enabled** and
   **OK**.

The policy is effective immediately, but the client computers must be restarted to receive the new
settings, or you can type `gpupdate /force` from an elevated command prompt or from Windows
PowerShell.

> [!IMPORTANT]
> The trusted and untrusted CTLs can be updated on a daily basis, so ensure that you keep the files
> synchronized by using a scheduled task or another method to update the shared folder or virtual
> directory.

## Use a subset of the trusted CTLs

This section describes how you can produce, review, and filter the trusted CTLs that you want
computers in your organization to use. You must implement the GPOs described in the previous
procedures to make use of this resolution. This resolution is available for disconnected and
connected environments.

There are two procedures to customize the list of trusted CTLs.

1. Create a subset of trusted certificates

1. Distribute the trusted certificates by using Group Policy

### To create a subset of trusted certificates

Here's how to generate SST files by using the automatic Windows update mechanism from Windows. For
more information about generating SST files, see the
[Certutil](../../administration/windows-commands/certutil.md#-generatesstfromwu) Windows
commands reference.

1. From a computer that is connected to the Internet, open Windows PowerShell as an Administrator or
   open an elevated command prompt, and type the following command:

    ```powershell
    Certutil -generateSSTFromWU WURoots.sst
    ```

1. Run the following command in Windows Explorer to open `WURoots.sst`:

    ```powershell
    start explorer.exe wuroots.sst
    ```

    > [!TIP]
    > You also can use Internet Explorer to navigate to the file and double-click it to open it.
    > Depending on where you stored the file, you may also be able to open it by typing
    > `wuroots.sst`.

1. Open Certificate Manager.

1. Expand the file path under **Certificates - Current User** until you see **Certificates**, then
   select **Certificates**.

1. In the details pane, you can see the trusted certificates. Hold down the <kbd>CTRL</kbd> key and
   select each of the certificates that you want to allow. When you've finished selecting the
   certificates you want to allow, right-click one of the selected certificates, select **All
   Tasks**, then select **Export**.

    - You must select a minimum of two certificates to export the `.sst` file type. If you select
      only one certificate, the `.sst` file type isn't available, and the `.cer` file type is
      selected instead.

1. In the Certificate Export Wizard, select **Next**.

1. On the **Export File Format** page, select **Microsoft Serialized Certificate Store (.SST)**, and
   then select **Next**.

1. On the **File to Export** page, enter a file path and an appropriate name for the file, such as
   `C:\AllowedCerts.sst`, then select **Next**.

1. Select **Finish**. When you're notified that the export was successful, select **OK**.

1. Copy the `.sst` file that you created to a domain controller.

#### To distribute the list of trusted certificates by using Group Policy

1. On the domain controller that has the customized `.sst` file, open the Group Policy Management
   Editor.

1. Expand the **Forest**, **Domains**, and specific domain object that you want to modify.
   Right-click **Default Domain Policy GPO**, then select **Edit**.

1. In the navigation pane, under **Computer Configuration**, expand **Policies**, expand **Windows
   Settings**, expand **Security Settings**, then expand **Public Key Policies**.

1. Right-click **Trusted Root Certification Authorities**, then select **Import**.

1. In the Certificate Import Wizard, select **Next**.

1. Enter the path and file name of the file that you copied to the domain controller, or use the
   **Browse** button to locate the file. Select **Next**.

1. Confirm that you want to place these certificates in the **Trusted Root Certification
   Authorities** certificate store by selecting **Next**. select **Finish**. When you're notified
   that the certificates imported successfully, select **OK**.

1. Close the Group Policy Management Editor.

The policy is effective immediately, but the client computers must be restarted to receive the new
settings, or you can type `gpupdate /force` from an elevated command prompt or from Windows
PowerShell.

## Registry settings modified

The settings described in this document configure the following registry keys on the client
computers. These settings aren't automatically removed if the GPO is unlinked or removed from the
domain. These settings must be reconfigured, if you want to change them.

- Enable or disable the Windows AutoUpdate of the trusted CTL:

  - **Key**: `HKLM\SOFTWARE\Policies\Microsoft\SystemCertificates\AuthRoot\DisableRootAutoUpdate`
  - **Type**: `REG_DWORD`
  - **Name**: `DisableRootAutoUpdate`
  - **Data**: `0` to enabled or `1` to disable.
  - **Default**: There is no key present by default. Without a key present, the default is enabled.

- Enable or disable the Windows AutoUpdate of the untrusted CTL:

  - **Key**: `SOFTWARE\Policies\Microsoft\SystemCertificates\AuthRoot`
  - **Type**: `REG_DWORD`
  - **Name**: `EnableDisallowedCertAutoUpdate`
  - **Data**: `0` to enabled or `1` to disable.
  - **Default**: There is no key present by default. Without a key present, the default is enabled.

- Set the shared CTL file location (HTTP or the FILE path):

  - **Key**: `HKLM\SOFTWARE\Microsoft\SystemCertificates\AuthRoot\AutoUpdate\RootDirUrl`
  - **Type**: `REG_SZ`
  - **Name**: `RootDirUrl`
  - **Data**: Enter a valid HTTP or file URI.
  - **Default**: There is no key present by default. Without a key present, the default behavior
     used Windows Update.

## Verify Trusted and Untrusted CTLs

It may be necessary for various reasons to verify all Trusted and Untrusted CTLs from a client
machine. The following Certutil options can be used to verify all Trusted and Untrusted CTLs from a
client machine.

```powershell
certutil -verifyCTL AuthRoot
certutil -verifyCTL Disallowed
```

## Checking Last Sync Time

To check the most recent sync time on the local machine for either Trusted or Untrusted CTLs, run
the following Certutil command:

```powershell
certutil -verifyctl AuthRoot | findstr /i "lastsynctime"
certutil -verifyctl Disallowed | findstr /i "lastsynctime"
```

## Related links

- [Certificates and trust](certificate-trust.md)

- [List of Participants - Microsoft Trusted Root Program](/security/trusted-root/participants-list)

- [certutil](../../administration/windows-commands/certutil.md) Windows command reference
  
- [Windows Root certificate Certificate Program - Members List (All CAs)](https://go.microsoft.com/fwlink/?linkid=269988)

- [Controlling the Update Root certificate Certificates Feature to Prevent the Flow of Information to and from the Internet](https://technet.microsoft.com/library/cc749331.aspx)
