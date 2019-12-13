---
title: Export and import virtual machines
description: Shows you how to export and import virtual machines using Hyper-V Manager or Windows PowerShell.
ms.prod: windows-server
author: KBDAzure
ms.author: kathydav
manager: dongill
ms.technology: compute-hyper-v
ms.date: 12/13/2016
ms.topic: article
ms.assetid: 7fd996f5-1ea9-4b16-9776-85fb39a3aa34
---

>Applies To: Windows 10, Windows Server 2016, Microsoft Hyper-V Server 2016, Windows Server 2019, Microsoft Hyper-V Server 2019

# Export and Import virtual machines

This article shows you how to export and import a virtual machine, which is a quick way to move or copy them. This article also discusses some of the choices to make when doing an export or import.

## Export a Virtual Machine

An export gathers all required files into one unit--virtual hard disk files, virtual machine configuration files, and any checkpoint files. You can do this on a virtual machine that is in either a started or stopped state.

### Using Hyper-V Manager

To create a virtual machine export:

1. In Hyper-V Manager, right-click the virtual machine and select **Export**.

2. Choose where to store the exported files, and click **Export**.

When the export is done, you can see all exported files under the export location.

### Using PowerShell

Open a session as Administrator and run a command like the following, after replacing \<vm name\> and \<path\>:

```powershell
Export-VM -Name \<vm name\> -Path \<path\>
```

For details, see [Export-VM](https://docs.microsoft.com/powershell/module/hyper-v/export-vm).

## Import a Virtual Machine 

Importing a virtual machine registers the virtual machine with the Hyper-V host. You can import back into the host, or new host. If you're importing to the same host, you don't need to export the virtual machine first, because Hyper-V tries to recreate the virtual machine from available files. Importing a virtual machine registers it so it can be used on the Hyper-V host.

The Import Virtual Machine wizard also helps you fix incompatibilities that can exist when moving from one host to another. This is commonly differences in physical hardware, such as memory, virtual switches, and virtual processors.

### Import using Hyper-V Manager

To import a virtual machine:

1. From the **Actions** menu in Hyper-V Manager, click **Import Virtual Machine**.

2. Click **Next**.

3. Select the folder that contains the exported files, and click **Next**.

4. Select the virtual machine to import.

5. Choose the import type, and click **Next**. (For descriptions, see [Import types](#import-types), below.)

6. Click **Finish**.

### Import using PowerShell

Use the **Import-VM** cmdlet, following the example for the type of import you want. For descriptions of the types, see [Import types](#import-types), below. 

#### Register in place

This type of import uses the files where they are stored at the time of import and retains the virtual machine's ID. The following command shows an example of an import file. Run a similar command with your own values.

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

For details, see [Import-VM](https://docs.microsoft.com/powershell/module/hyper-v/import-vm).

### Import types

Hyper-V offers three import types:

- **Register in-place** – This type assumes export files are in the location where you'll store and run the virtual machine. The imported virtual machine has the same ID as it did at the time of export. Because of this, if the virtual machine is already registered with Hyper-V, it needs to be deleted before the import works. When the import has completed, the export files become the running state files and can't be removed.

- **Restore the virtual machine** – Restore the virtual machine to a location you choose, or use the default to Hyper-V. This import type creates a copy of the exported files and moves them to the selected location. When imported, the virtual machine has the same ID as it did at the time of export. Because of this, if the virtual machine is already running in Hyper-V, it needs to be deleted before the import can be completed. When the import has completed, the exported files remain intact and can be removed or imported again.

- **Copy the virtual machine** – This is similar to the Restore type in that you select a location for the files. The difference is that the imported virtual machine has a new unique ID, which means you can import the virtual machine to the same host multiple times.

