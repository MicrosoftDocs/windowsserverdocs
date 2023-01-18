---
title: Configure trusted roots and disallowed certificates
description: Guidance on how to configure individual software updates for automatic daily Root Certificate Updates, including certificate trust lists (CTLs) and other functionality
ms.service: 
ms.topic: how-to 
author: gswashington
ms.author: roharwoo
ms.date: 01/18/2023
---

# Configure trusted roots and disallowed certificates

Applies To: Windows Server (All supported versions), Windows clients, Azure Stack HCI.

This article contains guidance intended to help administrators install automatic daily update functionality of Certificate Trust Lists (CTLs). Servers and clients access the Windows Update site to update CTLs using the automatic daily Root Certificate Updates mechanism discussed in this article.

See [Certificates and trust](certificates-and-trust.md) for more detailed knowledge on how the Microsoft Root Certificate Program works to distribute trusted root certificates automatically across Windows operating systems.

## Prerequisites

- Client machine with internet access to run certutil
- File server or web server for file storage
- AD Group policy or MDM solution to deploy configuration settings to your client

## Software update description

The following automatic update mechanisms are available in Windows Server 2012 R2 and Windows 8.1 and newer Windows versions or when the appropriate software update is installed (for older operating systems discussed in this article):

- **Registry settings for storing CTLs** New settings enable changing the location for uploading trusted or untrusted CTLs from the Windows Update site to a shared location in an organization. For more information, see the [Registry settings modified]() section.

- **Synchronization options** If the URL for the Windows Update site is moved to a local shared folder, the local shared folder must be synchronized with the Windows Update folder. This software update adds a set of options in the Certutil tool that administrators can use to enable synchronization. For more information, see the [New Certutil Options]() section.

- **Tool to select trusted root certificates** This software update introduces a tool for administrators who manage the set of trusted root certificates in their enterprise environment. Administrators can view and select the set of trusted root certificates, export them to a serialized certificate store, and distribute them by using Group Policy. For more information, see the [New Certutil Options]() section in this document.

- **Independent configurability** The automatic update mechanism for trusted and untrusted certificates are independently configurable. Administrators can use the automatic update mechanism to download only the untrusted CTLs and manage their own list of trusted CTLs. For more information, see the [Registry settings modified]() section in this document.

Automatic update functionality also can be disabled if necessary, although this isn't recommended. See [Event ID 8 — Automatic Root Certificates Update Configuration](https://learn.microsoft.com/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc734054(v=ws.10)?redirectedfrom=MSDN#turn-off-automatic-root-certificates-update) for more information.

## Configuration options

In Windows Server 2012 R2 and Windows 8.1 (or by installing the previously mentioned software updates on supported operating systems), an administrator can configure a file or web server to download the following files by using the automatic update mechanism:

- authrootstl.cab, which contains a non-Microsoft CTL

- disallowedcertstl.cab, which contains a CTL with untrusted certificates

- disallowedcert.sst, which contains a serialized certificate store, including untrusted certificates

- *thumbprint*.crt, which contains non-Microsoft root certificates

The steps to perform this configuration are described in the [Configure a file or web server to download the CTL files]() section of this document.

By using Windows Server 2012 R2 and Windows 8.1 (or by installing the previously mentioned software updates on supported operating systems), an administrator can:

- Configure Active Directory Domain Services (AD DS) domain member computers to use the automatic update mechanism for trusted and untrusted CTLs, without having access to the Windows Update site. This configuration is described in the [Redirect the Microsoft Automatic Update URL for a disconnected environment]() section of this document.

- Configure AD DS domain member computers to independently opt in for untrusted and trusted CTL automatic updates. This configuration is described in the [Redirect the Microsoft Automatic Update URL for untrusted CTLs only]() section of this document.

- Examine the set of root certificates in the Windows Root Certificate Program. This enables administrators to select a subset of certificates to distribute by using a Group Policy Object (GPO). This configuration is described in the [Use a subset of the trusted CTLs]() section of this document.

> [!IMPORTANT]
> All the steps shown in this document require that you use an account that is a member of the local <STRONG>Administrators</STRONG> group. For all Active Directory Domain Services (AD DS) configuration steps, you must use an account that is a member of the <STRONG>Domain Admins</STRONG> group or that has been delegated the necessary permissions.
> The procedures in this document depend upon having at least one computer that is able to connect to the Internet to download CTLs from Microsoft. The computer requires HTTP (TCP port 80) access and name resolution (TCP and UDP port 53) ability to contact ctldl.windowsupdate.com. This computer can be a domain member or a member of a workgroup. Currently all the downloaded files require approximately 1.5 MB of space.
> The settings described in this document are implemented by using GPOs. These settings are not automatically removed if the GPO is unlinked or removed from the AD DS domain. When implemented, these settings can be changed only by using a GPO or by modifying the registry of the affected computers.
> The concepts discussed in this document are independent of Windows Server Update Services (WSUS).

## Configure a file or web server to download the CTL files

To facilitate the distribution of trusted or untrusted certificates for a disconnected environment, you must first configure a file or web server to download the CTL files from the automatic update mechanism.

> [!TIP]
> <BR>The configuration described in this section is not needed for environments where computers are able to connect to the Windows Update site directly. Computers that can connect to the Windows Update site are able to receive updated CTLs on a daily basis (if they are running Windows Server 2012, Windows 8, or the previously mentioned software updates are installed on supported operating systems). For more information, see <A href="https://support.microsoft.com/kb/2677070">document 2677070</A> in the Microsoft Knowledge Base.

#### To configure a server that has access to the Internet to retrieve the CTL files

1. Create a shared folder on a file or web server that is able to synchronize by using the automatic update mechanism and that you want to use to store the CTL files.

    > [!TIP]
    > <BR>Before you begin, you may have to adjust the shared folder permissions and NTFS folder permissions to allow the appropriate account access, especially if you're using a scheduled task with a service account. For more information on adjusting permissions, see <A href="https://technet.microsoft.com/library/cc753731.aspx">Managing Permissions for Shared Folders</A>.

1. From an elevated command prompt, run the following command:

    ```
    Certutil -syncWithWU \\<server>\<share>
    ```

    Substitute the actual server name for \<server\> and shared folder name for \<share\>. For example, for a server named Server1 with a shared folder named CTL, you'd run the command:

    ```
    Certutil -syncWithWU \\Server1\CTL
    ```

1. Download the CTL files on a server that computers on a disconnected environment can access over the network by using a FILE path (for example, `FILE://\\\\Server1\\CTL`) or an HTTP path (for example, `https://Server1/CTL`).

> [!NOTE]
> - If the server that synchronizes the CTLs is not accessible from the computers in the disconnected environment, you must provide another method to transfer the information. For example, you can allow one of the domain member computers to connect to the server, then schedule another task on the domain member computer to pull the information into a shared folder on an internal web server. If there is absolutely no network connection, you may have to use a manual process to transfer the files, such as a removable storage device.

> - If you plan to use a web server, you should create a new virtual directory for the CTL files. The steps to create a virtual directory by using Internet Information Services (IIS) are nearly the same for all the supported operating systems discussed in this document. For more information, see <A href="https://technet.microsoft.com/library/cc771804.aspx">Create a Virtual Directory (IIS7)</A>.

- Certain system and application folders in Windows have special protection applied to them. For example, the <STRONG>inetpub</STRONG> folder requires special access permissions, which make it difficult to create a shared folder for use with a scheduled task to transfer files. As an administrator, you're typically able to create a folder location at the root of a logical drive system to use for file transfers. </LI></UL>

## Redirect the Microsoft Automatic Update URL for a disconnected environment

If the computers in your network are configured in a domain environment and they're unable to use the automatic update mechanism or download CTLs, you can implement a GPO in AD DS to configure those computers to obtain the CTL updates from an alternate location.

> [!NOTE]
> The configuration in this section requires that you already completed the steps in [Configure a file or web server to download the CTL files]().

#### To configure a custom administrative template for a GPO

1. On a domain controller, create a new administrative template. Open a text file in Notepad and then change the file name extension to .adm. The contents of the file should be as follows:

    ```
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

1. Use a descriptive name to save the file, such as **RootDirURL.adm**.

    > [!TIP]
    - Ensure that the file name extension is .adm and not .txt.
    - If you've not already enabled file name extension viewing, see [How To: View File Name Extensions](https://social.technet.microsoft.com/wiki/contents/articles/1784.how-to-view-file-name-extensions.aspx).
    - If you save the file to the %windir%\inf folder, it will be easier to locate in the following steps.

1. Open the Group Policy Management Editor.

      - If you're using Windows Server 2008 R2 or Windows Server 2008, select **Start**, and then select **Run**.

      - If you're using Windows Server 2012 R2 or Windows Server 2012, press the **Windows** key plus the **R** key simultaneously.

    Type **GPMC.msc**, and then press ENTER.

    > [!WARNING]
    > <BR>You can link a new GPO to the domain or to any organizational unit (OU). The GPO modifications implemented in this document alter the registry settings of the affected computers. You can't undo these settings by deleting or unlinking the GPO. The settings can only be undone by reversing them in the GPO settings or by modifying the registry using another technique.

1. In the Group Policy Management console, expand the **Forest** object, expand the **Domains** object, and then expand the specific domain that contains the computer accounts that you want to change. If you have a specific OU that you want to modify, then navigate to that location. select an existing GPO or right-select and then select **Create a GPO in this domain, and Link it here** to create a new GPO. Right-select the GPO you want to modify and then select **Edit**.

1. In the navigation pane, under **Computer Configuration**, expand **Policies**.

1. Right-select **Administrative Templates**, and then select **Add/Remove Templates**.

1. In **Add/Remove Templates**, select **Add**. In the **Policy Templates** dialog box, select the .adm template that you previously saved. select **Open**, and then select **Close**.

1. In the navigation pane, expand **Administrative Templates**, and then expand **Classic Administrative Templates (ADM)**.

1. elect **Windows AutoUpdate Settings**, and in the details pane, double-select **URL address to be used instead of default ctldl.windowsupdate.com**.

1. Select **Enabled**. In the **Options** section, enter the URL to the file server or web server that contains the CTL files. For example, `https://server1/CTL` or `file://\\\\server1\\CTL`. select **OK**. Close the Group Policy Management Editor.

The policy is effective immediately, but the client computers must be restarted to receive the new settings, or you can type **gpupdate /force** from an elevated command prompt or from Windows PowerShell.

> [!IMPORTANT]
> The trusted and untrusted CTLs can be updated on a daily basis, so ensure that you keep the files synchronized by using a scheduled task or another method (such as a script that handles error conditions) to update the shared folder or web virtual directory. For additional details about creating a scheduled task, see [Schedule a Task](https://technet.microsoft.com/library/cc748993.aspx). If you plan to write a script to make daily updates, see the [New Certutil Options]() and [Potential errors with Certutil -SyncWithWU]() sections of this document. These sections provide more information about command options and the error conditions.

## Redirect the Microsoft Automatic Update URL for untrusted CTLs only

Some organizations may want only the untrusted CTLs (not the trusted CTLs) to be automatically updated. To accomplish this, you can create two .adm templates to add to Group Policy.

> [!IMPORTANT]
>
- In a disconnected environment, you can use the following procedure with the previous procedure (redirect the Microsoft Automatic Update URL for trusted CTLs and untrusted CTLs). This procedure explains how to selectively disable the automatic update of trusted CTLs.
- You also can use this procedure in a connected environment in isolation to selectively disable the automatic update of trusted CTLs. </LI></OL>

#### To selectively redirect only untrusted CTLs

1. On a domain controller, create the first new administrative template by starting with a text file and then changing the file name extension to .adm. The contents of the file should be as follows:

    ```
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

1. Use a descriptive name to save the file, such as **DisableAllowedCTLUpdate.adm**.

1. Create a second new administrative template. The contents of the file should be as follows:

    ```
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

    > [!TIP]
- Ensure that the file name extensions of these files are .adm and not .txt.
- If you haven't already enabled file name extension viewing, see [How To: View File Name Extensions](https://social.technet.microsoft.com/wiki/contents/articles/1784.how-to-view-file-name-extensions.aspx).
- If you save the file to the %windir%\inf folder, it will be easier to locate in the following steps.

1. Open the Group Policy Management Editor.

1. In the Group Policy Management console, expand the **Forest**, **Domains**, and specific domain object that you want to modify. Right-select the **Default Domain Policy GPO**, and then select **Edit**.

1. In the navigation pane, under **Computer Configuration**, expand **Policies**.

1. Right-select **Administrative Templates**, and then select **Add/Remove Templates**.

1. In **Add/Remove Templates**, select **Add**. Use the **Policy Templates** dialog box to select the .adm templates that you previously saved (hold the CTRL key, and select each file to select both.) select **Open**, and then select **Close**.

1. In the navigation pane, expand **Administrative Templates** and then expand **Classic Administrative Templates (ADM)**.

1. Select **Windows AutoUpdate Settings** and then in the details pane, double-select **Auto Root Update**.

1. Select **Disabled**. This setting prevents the automatic update of the trusted CTLs. Select **OK**.

1. In the details pane, double-select **Untrusted CTL Automatic Update**. Select **Enabled**. Select **OK**.

The policy is effective immediately, but the client computers must be restarted to receive the new settings, or you can type **gpupdate /force** from an elevated command prompt or from Windows PowerShell.

> [!IMPORTANT]
> <BR>The trusted and untrusted CTLs can be updated on a daily basis, so ensure that you keep the files synchronized by using a scheduled task or another method to update the shared folder or virtual directory.

## Use a subset of the trusted CTLs

This section describes how you can produce, review, and filter the trusted CTLs that you want computers in your organization to use. You must implement the GPOs described in the previous procedures to make use of this resolution. This resolution is available for disconnected and connected environments.

There are two procedures to complete to customize the list of trusted CTLs.

1. Create a subset of trusted certificates

1. Distribute the trusted certificates by using Group Policy

#### To create a subset of trusted certificates

Here's how to ... generated from Windows `.sst` files<link to certutil#bookmarked heading>.

1. From a computer that is connected to the Internet, open Windows PowerShell as an Administrator or open an elevated command prompt, and type the following command:

    ```
    Certutil -generateSSTFromWU WURoots.sst
    ```

1. You can run the following command in Windows Explorer to open the WURoots.sst:

    ```
    start explorer.exe wuroots.sst
    ```

    > [!TIP]
    > <BR>You also can use Internet Explorer to navigate to the file and double-select it to open it. Depending on where you stored the file, you may also be able to open it by typing `wuroots.sst`.

1. In the navigation pane of Certificate Manager, expand the file path under **Certificates -Current User** until you see **Certificates**, and then select **Certificates**.

1. In the details pane, you can see the trusted certificates. Hold down the CTRL key and select each of the certificates that you want to allow. When you've finished selecting the certificates you want to allow, right-select one of the selected certificates, select **All Tasks**, and then select **Export**.

    > [!IMPORTANT]
    > <BR>You must select a minimum of two certificates to export the .sst file type. If you select only one certificate, the .sst file type is not available and the .cer file type is selected instead.

1. In the Certificate Export Wizard, select **Next**.

1. On the **Export File Format** page, select **Microsoft Serialized Certificate Store (.SST)**, and then select **Next**.

1. On the **File to Export** page, enter a file path and an appropriate name for the file, such as **C:\\AllowedCerts.sst**, and then select **Next**. Select **Finish**. When you're notified that the export was successful, select **OK**.

1. Copy the `.sst` file that you created to a domain controller.

#### To distribute the list of trusted certificates by using Group Policy

1. On the domain controller that has the customized `.sst` file, open the Group Policy Management Editor.

1. In the Group Policy Management console, expand the **Forest**, **Domains**, and specific domain object that you want to modify. Right-select **Default Domain Policy GPO**, and then select **Edit**.

1. In the navigation pane, under **Computer Configuration**, expand **Policies**, expand **Windows Settings**, expand **Security Settings**, and then expand **Public Key Policies**.

1. Right-select **Trusted Root Certification Authorities**, and then select **Import**.

1. In the Certificate Import Wizard, select **Next**.

1. Enter the path and file name of the file that you copied to the domain controller, or use the **Browse** button to locate the file. Select **Next**.

1. Confirm that you want to place these certificates in the **Trusted Root Certification Authorities** certificate store by selecting **Next**. select **Finish**. When you're notified that the certificates imported successfully, select **OK**.

1. Close the Group Policy Management Editor.

The policy is effective immediately, but the client computers must be restarted to receive the new settings, or you can type **gpupdate /force** from an elevated command prompt or from Windows PowerShell.

## Registry settings modified

The settings described in this document configure the following registry keys on the client computers. These settings aren't automatically removed if the GPO is unlinked or removed from the domain. These settings must be reconfigured, if you want to change them.

| Registry keys | Value and Description |
|--------|---------|
| HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SystemCertificates\AuthRoot\DisableRootAutoUpdate | A value of 1 disables the Windows AutoUpdate of the trusted CTL. |  
| HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SystemCertificates\AuthRoot\EnableDisallowedCertAutoUpdate | A value of 1 enables the Windows AutoUpdate of the untrusted CTL. |
| HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SystemCertificates\AuthRoot\AutoUpdate\RootDirUrl | Configures the shared location (the HTTP or the FILE path). |

## Deleting Trusted and Untrusted CTLs

It may be necessary for various reasons to delete all Trusted and Untrusted CTLs from a client machine. The following Certutil options can be used to accomplish this.

`certutil -verifyCTL AuthRoot`
`certutil -verifyCTL Disallowed`

## Checking Last Sync Time

To check the most recent sync time on the local machine for either Trusted or Untrusted CTLs, run the following Certutil command:

`certutil -verifyctl AuthRoot | findstr /i "lastsynctime"`
`certutil -verifyctl Disallowed | findstr /i "lastsynctime"`

## New Certutil Options

The following options were added to Certutil:

| Syntax | Description | Example |
|--------|---------|---------|
| CertUtil [Options] -syncWithWU DestinationDir| Sync with Windows Update.</br></br>- DestinationDir is the folder that receives the files by using the automatic update mechanism.</br>- The following files are downloaded by using the automatic update mechanism:</br></br> - The `authrootstl.cab` contains the CTLs of non-Microsoft root certificates.</br> - The `disallowedcertstl.cab` contains the CTLs of untrusted certificates.</br>- The `disallowedcert.sst` contains the serialized certificate store, including the untrusted certificates.</br>- The `thumbprint.crt` contains the non-Microsoft root certificates. | CertUtil -syncWithWU \\server1\PKI\CTLs |
| CertUtil [Options] -generateSSTFromWU SSTFile | Generate SST by using the automatic update mechanism.</br></br>SSTFile: `.sst` file to be created. The generated .sst file contains the non_Microsoft root certificates that were downloaded by using the automatic update mechanism. | CertUtil –generateSSTFromWU TRoots.sst |

> [!TIP]
> `Certutil -SyncWithWU -f <folder>` updates existing files in the target folder.
> `Certutil -syncWithWU -f -f <folder>` removes and replaces files in the target folder.

## Potential errors with Certutil -SyncWithWU

You may encounter the following errors and warnings when running the `Certutil -syncWithWU` command:

- If you use a non-existent local path or folder as the destination folder, you'll see the error:
  
    The system can't find the file specified. 0x80070002 (WIN32: 2 ERROR\_FILE\_NOT\_FOUND)

- If you use a non-existent or unavailable network location as the destination folder, you'll see the error:

    The network name can't be found. 0x80070043 (WIN32: 67 ERROR\_BAD\_NET\_NAME)

- If your server can't connect over TCP port 80 to Microsoft Automatic Update servers, you'll receive the following error:

    A connection with the server couldn't be established 0x80072efd (INet: 12029 ERROR\_INTERNET\_CANNOT\_CONNECT)

- If your server is unable to reach the Microsoft Automatic Update servers with the DNS name ctldl.windowsupdate.com, you'll receive the following error:

    The server name or address couldn't be resolved 0x80072ee7 (INet: 12007 ERROR\_INTERNET\_NAME\_NOT\_RESOLVED).

- If you don't use the **-f** switch, and any of the CTL files already exist in the directory, you'll receive a *file* exists error:

    CertUtil: -syncWithWU command FAILED: 0x800700b7 (WIN32/HTTP: 183 ERROR\_ALREADY\_EXISTS) Certutil: Can't create a file when that file already exists.

- If there's a change in the trusted root certificates, you'll see: "Warning\! Encountered the following no longer trusted roots: \<folder path\>\\\<thumbprint\>.crt. Use "-f -f" options to force the delete of the above ".crt" files. Was "authrootstl.cab" updated? If yes, consider deferring the delete until all clients have been updated."

## Related content

- [Certificates and trust](certificates-and-trust.md)

- [Controlling the Update Root certificate Certificates Feature to Prevent the Flow of Information to and from the Internet](https://technet.microsoft.com/library/cc749331.aspx

- [certutil](/administration/windows-commands/certutil.md)
  
- [How to Write a Simple .Adm File for Registry-based Group Policy](https://technet.microsoft.com/library/cc738443.aspx)

- [Writing Custom ADM Files for System Policy Editor](https://support.microsoft.com/kb/225087)

- [Managing Group Policy ADMX Files Step-by-Step Guide](https://technet.microsoft.com/library/cc709647.aspx)

- [Windows Root certificate Certificate Program - Members List (All CAs)](https://go.microsoft.com/fwlink/?linkid=269988)

- [Controlling the Update Root certificate Certificates Feature to Prevent the Flow of Information to and from the Internet](https://technet.microsoft.com/library/cc749331.aspx)

- [Windows Server Security Forum](https://aka.ms/adcsforum)

- [Active Directory Certificate Services (AD CS) Public Key Infrastructure (PKI) Frequently Asked Questions (FAQ)](https://aka.ms/adcsfaq)

- [Windows PKI Documentation Reference and Library](https://social.technet.microsoft.com/wiki/contents/articles/987.windows-pki-documentation-reference-and-library.aspx)

- [Windows PKI Blog](https://blogs.technet.com/b/pki/)