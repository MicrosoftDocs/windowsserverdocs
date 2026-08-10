---
title: Export and import virtual machines
description: This article shows you how to export and import virtual machines using Hyper-V Manager or Windows PowerShell.
ms.author: roharwoo
author: robinharwood
ms.date: 05/14/2015
ms.topic: how-to
---

# Export and import virtual machines

This article shows you how to export and import a virtual machine, which is a quick way to move or copy them. This article also discusses some of the choices to make when doing an export or import.

## Export a virtual machine

An export gathers all required files into one unit--virtual hard disk files, virtual machine configuration files, and any checkpoint files. You can do this on a virtual machine that is in either a started or stopped state.

### [Hyper-V Manager](#tab/hyper-v-manager)

To create a virtual machine export:

1. In Hyper-V Manager, right-click the virtual machine and select **Export**.

1. Choose where to store the exported files, and click **Export**.

When the export is done, you can see all exported files under the export location.

### [PowerShell](#tab/powershell)

Open a session as Administrator and run a command like the following, after replacing \<vm name\> and \<path\>:

```powershell
Export-VM -Name <vm name> -Path <path>
```

For details, see [Export-VM](/powershell/module/hyper-v/export-vm).

---

## Import a virtual machine

Importing a virtual machine registers the virtual machine with the Hyper-V host. You can import back into the host, or new host. If you're importing to the same host, you don't need to export the virtual machine first, because Hyper-V tries to recreate the virtual machine from available files. Importing a virtual machine registers it so it can be used on the Hyper-V host.

> [!IMPORTANT]
> Hyper-V virtual machine configurations have a specific version number. You can only import a virtual machine if the Hyper-V host supports that configuration version. Typically, this means that you can import a virtual machine to a Hyper-V host running a newer version of Hyper-V, but you can't import a virtual machine created on a newer version of Hyper-V to an older version of Hyper-V. For more information, see [Supported virtual machine configuration versions](Upgrade-virtual-machine-version-in-Hyper-V-on-Windows-or-Windows-Server.md#supported-virtual-machine-configuration-versions).

The Import Virtual Machine wizard also helps you fix incompatibilities that can exist when moving from one host to another. This is commonly differences in physical hardware, such as memory, virtual switches, and virtual processors.

### [Hyper-V Manager](#tab/hyper-v-manager)

To import a virtual machine:

1. From the **Actions** menu in Hyper-V Manager, select **Import Virtual Machine**.

1. Click **Next**.

1. Select the folder that contains the exported files, and select **Next**.

1. Select the virtual machine to import.

1. Choose the import type, and select **Next**. For descriptions, see [Import types](#import-types).

1. Select **Finish**.

### [PowerShell](#tab/powershell)

Use the **Import-VM** cmdlet, following the example for the type of import you want. For descriptions of the types, see [Import types](#import-types).

#### Register in place

This type of import uses the files where they're stored at the time of import and retains the virtual machine's ID. The following command shows an example of an import file. Run a similar command with your own values.

```powershell
Import-VM -Path 'C:\<vm export path>\2B91FEB3-F1E0-4FFF-B8BE-29CED892A95A.vmcx'
```

#### Restore

To import the virtual machine specifying your own path for the virtual machine files, run a command like this, replacing the examples with your values:

```powershell
Import-VM -Path 'C:\<vm export path>\2B91FEB3-F1E0-4FFF-B8BE-29CED892A95A.vmcx' -Copy -VhdDestinationPath 'D:\Virtual Machines\WIN10DOC' -VirtualMachinePath 'D:\Virtual Machines\WIN10DOC'
```

#### Import as a copy

To complete a copy import and move the virtual machine files to the default Hyper-V location, run a command like this, replacing the examples with your values:

``` PowerShell
Import-VM -Path 'C:\<vm export path>\2B91FEB3-F1E0-4FFF-B8BE-29CED892A95A.vmcx' -Copy -GenerateNewId
```

For details, see [Import-VM](/powershell/module/hyper-v/import-vm).

---

### Import types

Hyper-V offers three import types:

- **Register in-place** – The register in-place type assumes export files are in the location where you store and run the virtual machine. The imported virtual machine has the same ID as it did at the time of export. Because of this, if the virtual machine is already registered with Hyper-V, it needs to be deleted before the import works. When the import has completed, the export files become the running state files and can't be removed.

- **Restore the virtual machine** – Restore the virtual machine to a location you choose, or use the default to Hyper-V. This import type creates a copy of the exported files and moves them to the selected location. When imported, the virtual machine has the same ID as it did at the time of export. Because of this, if the virtual machine is already running in Hyper-V, it needs to be deleted before the import can be completed. When the import has completed, the exported files remain intact and can be removed or imported again.

- **Copy the virtual machine** – The copy type is similar to the restore type in that you select a location for the files. The difference is that the imported virtual machine has a new unique ID, which means you can import the virtual machine to the same host multiple times.


