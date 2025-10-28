---
title: "Data Exchange: Using key-value pairs to share information between the host and guest on Hyper-V"
description: Learn how the Hyper-V Data Exchange (KVP) integration service lets you share small bits of metadata between a virtual machine and the Hyper-V host using key-value pairs.
keywords: hyper-v, integration services, data exchange, kvp, key value pair
author: dknappettmsft
ms.author: daknappe
ms.date: 10/27/2025
ms.topic: how-to
---

# Data Exchange: Using key-value pairs to share information between the host and guest on Hyper-V

Data Exchange is an integration service (also known as key-value pair exchange or KVP) that can be used to share small pieces of information between a virtual machine (guest) and its Hyper-V host. General information about the virtual machine and host is automatically created and stored as key-value pairs. You can also create your own pairs to share custom data.

Key-value pairs consist of a "key" and a "value". Both are strings; no other data types are supported. When a key-value pair is created or changed, it becomes visible to both the guest and the host. KVP data travels over the Hyper-V VMbus and doesn't require any network connectivity between the guest and host.

Once created, key-value pairs remain until they're deleted. Any application that creates key-value pairs should delete them when they're no longer needed. Key-value pairs move with the virtual machine during Live Migration.

## Windows guests

On Windows guests, KVP data is stored in the registry under:

```text
HKLM\SOFTWARE\Microsoft\Virtual Machine
```

The data is organized in these subkeys:

- **Virtual Machine\\Auto** – Data describing the guest. Created by integration service drivers after they load. Visible to the host as intrinsic data.
- **Virtual Machine\\External** – Data pushed to the guest from the host by a user.
- **Virtual Machine\\Guest** – Data created on the guest. Visible to the host as non‑intrinsic data.
- **Virtual Machine\\Guest\\Parameter** – Data pushed to the guest from the host that describes the host.

Adding values from within the guest is as simple as creating a new string value under `HKLM\SOFTWARE\Microsoft\Virtual Machine\Guest`. You must be an administrator in the guest to modify this location. You can use WMI (PowerShell or other tooling) from the host or a remote machine (with permissions) to retrieve the value.

For information about registry size limits, see the (legacy) article [Registry Element Size Limits](https://msdn.microsoft.com/library/windows/desktop/ms724872.aspx).

### Add a new key-value pair in the guest

In this example, the value of **Status** is set to `Ready`:

```powershell
$regPath = "HKLM:\SOFTWARE\Microsoft\Virtual Machine\Guest"
Set-ItemProperty -Path $regPath -Name "Status" -Value "Ready" -Type String
```

You can use the same syntax to change the value.

### Query key-value pairs in the guest

To query the value of the **External** subkey (data pushed to the guest from the host):

```powershell
$regPath = "HKLM:\SOFTWARE\Microsoft\Virtual Machine\External"
Get-ItemProperty -Path $regPath -Name "Name"
```

## Linux guests

Linux doesn't have a registry, so KVP items are stored in the file system. A daemon process, `hv_kvp_daemon`, must be running to handle processing. For most distributions with Linux Integration Services (LIS) or in-kernel drivers installed, this daemon starts automatically. In some cases, extra steps may be required to install and start the daemon.

The Linux integration services implement data exchange with KVP pools. A KVP pool is a file stored in a specific path. There are four pool files:

```text
/var/lib/hyperv/.kvp_pool_0
/var/lib/hyperv/.kvp_pool_1
/var/lib/hyperv/.kvp_pool_2
/var/lib/hyperv/.kvp_pool_3
```

These pool files map to the following Windows registry key sets:

- Pool 0: `Virtual Machine\External`
- Pool 1: `Virtual Machine\Guest`
- Pool 2: `Virtual Machine\Auto`
- Pool 3: `Virtual Machine\Guest\Parameter`

> [!NOTE]
> For more information about Linux KVP support, see [Linux and FreeBSD Virtual Machines on Hyper-V](Supported-Linux-and-FreeBSD-virtual-machines-for-Hyper-V-on-Windows.md).
>
> The key-value pair infrastructure might not function correctly without a Linux software update. Contact your distribution vendor for an update if you encounter issues.

### Pool structure

Each pool file contains records with this structure:

```c
struct kvp_record
{
    unsigned char key[ HV_KVP_EXCHANGE_MAK_KEY_SIZE ];
    unsigned char value[ HV_KVP_EXCHANGE_MAX_VALUE_SIZE ];
};
```

Those size constants are defined in `hyperv.h` (a kernel header distributed with the Linux kernel sources).

### Read and display values from pool 0

This sample reads KVP values from pool 0 and displays them.

```c
```c
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>
#include <fcntl.h>
#include "../include/linux/hyperv.h"

typedef struct kvp_record
{
    unsigned char key [HV_KVP_EXCHANGE_MAX_KEY_SIZE];
    unsigned char value [HV_KVP_EXCHANGE_MAX_VALUE_SIZE];
} KVP_RECORD;

KVP_RECORD myRecords[200];

void KVPAcquireLock(int fd)
{
    struct flock fl = {F_RDLCK, SEEK_SET, 0, 0, 0};
    fl.l_pid = getpid();

    if (-1 == fcntl(fd, F_SETLKW, &fl))
    {
        perror("fcntl lock");
        exit (-10);
    }
}

void KVPReleaseLock(int fd)
{
    struct flock fl = {F_UNLCK, SEEK_SET, 0, 0, 0};
    fl.l_pid = getpid();

    if (-1 == fcntl(fd, F_SETLK, &fl))
    {
        perror("fcntl unlock");
        exit (-20);
    }
}

int main (int argc, char **argv)
{
    char poolName[] = "/var/lib/hyperv/.kvp_pool_0";
    int   i;
    int   fd;
    int   bytesRead;
    int   numRecords;

    fd = open(poolName, O_RDONLY);
    if (-1 == fd)
    {
        printf("Error: Unable to open pool file %s\n", poolName);
        exit (-30);
    }

    KVPAcquireLock(fd);
    bytesRead = read(fd, myRecords, sizeof(myRecords));
    KVPReleaseLock(fd);

    numRecords = bytesRead / sizeof(struct kvp_record);
    printf("Number of records : %d\n", numRecords);

    for (i = 0; i < numRecords; i++)
    {
        printf("  Key  : %s\n  Value: %s\n\n", myRecords[i].key, myRecords[i].value);
    }

    close(fd);

    return 0;
}
```

### Create a KVP item in pool 1

```c
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>
#include <fcntl.h>
#include "../include/linux/hyperv.h"

typedef struct kvp_record
{
    unsigned char key [HV_KVP_EXCHANGE_MAX_KEY_SIZE];
    unsigned char value [HV_KVP_EXCHANGE_MAX_VALUE_SIZE];
} KVP_RECORD;

void KVPAcquireWriteLock(int fd)
{
    struct flock fl = {F_WRLCK, SEEK_SET, 0, 0, 0};
    fl.l_pid = getpid();

    if (-1 == fcntl(fd, F_SETLKW, &fl))
    {
        perror("fcntl lock");
        exit (-10);
    }
}

void KVPReleaseLock(int fd)
{
    struct flock fl = {F_UNLCK, SEEK_SET, 0, 0, 0};
    fl.l_pid = getpid();

    if (-1 == fcntl(fd, F_SETLK, &fl))
    {
        perror("fcntl unlock");
        exit (-20);
    }
}

int main (int argc, char **argv)
{
    char poolName[] = "/var/lib/hyperv/.kvp_pool_1";
    int   fd;
    KVP_RECORD newKvp;

    if (3 != argc)
    {
        printf("Usage: WritePool keyName valueString\n\n");
        exit (-5);
    }

    fd = open(poolName, O_WRONLY);
    if (-1 == fd)
    {
        printf("Error: Unable to open pool file %s\n", poolName);
        exit (-30);
    }

    memset((void *)&newKvp, 0, sizeof(KVP_RECORD));
    memcpy(newKvp.key, argv[1], strlen(argv[1]));
    memcpy(newKvp.value, argv[2], strlen(argv[2]));

    KVPAcquireWriteLock(fd);
    write(fd, (void *)&newKvp, sizeof(KVP_RECORD));
    KVPReleaseLock(fd);

    close(fd);

    return 0;
}
```

### Delete a KVP item from pool 1

This sample deletes an item.

```c
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>
#include <fcntl.h>
#include <uapi/linux/hyperv.h>

typedef struct kvp_record
{
    unsigned char key [HV_KVP_EXCHANGE_MAX_KEY_SIZE];
    unsigned char value [HV_KVP_EXCHANGE_MAX_VALUE_SIZE];
} KVP_RECORD;

void KVPAcquireWriteLock(int fd)
{
    struct flock fl = {F_WRLCK, SEEK_SET, 0, 0, 0};
    fl.l_pid = getpid();

    if (-1 == fcntl(fd, F_SETLKW, &fl))
    {
        perror("fcntl lock");
        exit (-10);
    }
}

void KVPReleaseLock(int fd)
{
    struct flock fl = {F_UNLCK, SEEK_SET, 0, 0, 0};
    fl.l_pid = getpid();

    if (-1 == fcntl(fd, F_SETLK, &fl))
    {
        perror("fcntl unlock");
        exit (-20);
    }
}

int find_record_offset(int fd, char *key)
{
    int bytesRead;
    int offset = 0;
    int retval = -1;

    KVP_RECORD kvpRec;

    while (1)
    {
        lseek(fd, offset, SEEK_SET);
        bytesRead = read(fd, &kvpRec, sizeof(KVP_RECORD));
        if (0 == bytesRead)
        {
            break;
        }

        if (0 == strcmp(key, (const char *) kvpRec.key))
        {
            retval = offset;
            break;
        }

        offset += sizeof(KVP_RECORD);
    }

    return retval;
}

int main (int argc, char **argv)
{
    char  poolName[] = "/var/lib/hyperv/.kvp_pool_1";
    int   fd;
    int   exitVal = -1;
    int   bytesRead;
    int   bytesWritten;
    int   offset_to_delete;
    int   offset_last_record;
    KVP_RECORD kvpRec;

    if (2 != argc)
    {
        printf("Usage: WritePool keyName valueString\n\n");
        exit (-5);
    }

    fd = open(poolName, O_RDWR, 0644);
    if (-1 == fd)
    {
        printf("Error: Unable to open pool file %s\n", poolName);
        exit (-10);
    }

    KVPAcquireWriteLock(fd);
    offset_to_delete = find_record_offset(fd, argv[1]);
    if (offset_to_delete < 0)
    {
        exitVal = -15;
        goto cleanup2;
    }

    offset_last_record = lseek(fd, -sizeof(KVP_RECORD), SEEK_END);
    if (offset_last_record < 0)
    {
        exitVal = -20;
        goto cleanup2;
    }

    if (offset_last_record != offset_to_delete)
    {
        lseek(fd, offset_last_record, SEEK_SET);
        bytesRead = read(fd, &kvpRec, sizeof(KVP_RECORD));
        lseek(fd, offset_to_delete, SEEK_SET);
        bytesWritten = write(fd, &kvpRec, sizeof(KVP_RECORD));
    }

    ftruncate(fd, offset_last_record);

    exitVal = 0;

cleanup2:
    KVPReleaseLock(fd);

cleanup1:
    close(fd);

    return exitVal;
}
```

## Working with key-value pairs from the host using WMI

The following examples use the WMI v2 namespace. For WMI v1 (older versions), remove the `\v2` segment from the namespace path.

> [!NOTE]
> If you're using Windows 8 or Windows 8.1, install Client Hyper-V to get the namespaces.

### Read the value from the host

This example gets the value of the key `Status` from a VM named `Vm1`:

```powershell
$vm = Get-WmiObject -Namespace root\virtualization\v2 -Class \
    Msvm_ComputerSystem -Filter {ElementName = 'Vm1'}
$vm.GetRelated("Msvm_KvpExchangeComponent").GuestExchangeItems | % { \
    $GuestExchangeItemXml = ([XML]$_).SelectSingleNode(\
        "/INSTANCE/PROPERTY[@NAME='Name']/VALUE[child::text() = 'Status']")
    if ($GuestExchangeItemXml -ne $null)
    {
        $GuestExchangeItemXml.SelectSingleNode(\
            "/INSTANCE/PROPERTY[@NAME='Data']/VALUE/child::text()" ).Value
    }
}
```

### Add or modify key-value pairs from the host

To add a key-value pair from the host, get instances of both the management service and the VM and create a new instance of `Msvm_KvpExchangeDataItem`. When creating the new instance, specify the `Name`, `Data`, and `Source` (must be `0`). Then call `AddKvpItems`.

Querying for host-created key-value pairs is similar to guest queries but requires an additional association hop to `Msvm_KvpExchangeComponentSettingData`. Modifying and deleting values works the same way—specify the same key name and call the appropriate `Modify` or `Remove` method.

> [!IMPORTANT]
> The examples below use the v2 namespace. If you're using Windows Server 2008 or Windows Server 2008 R2, remove the `\v2` segment.

### Add a new key-value pair

```powershell
$VmMgmt = Get-WmiObject -Namespace root\virtualization\v2 -Class \
    Msvm_VirtualSystemManagementService
$vm = Get-WmiObject -Namespace root\virtualization\v2 -Class \
    Msvm_ComputerSystem -Filter {ElementName='VM1'}
$kvpDataItem = ([WMIClass][String]::Format("\\{0}\\{1}:{2}", \
    $VmMgmt.ClassPath.Server, \
    $VmMgmt.ClassPath.NamespacePath, \
    "Msvm_KvpExchangeDataItem")).CreateInstance()

$kvpDataItem.Name = "Name"
$kvpDataItem.Data = "Data"
$kvpDataItem.Source = 0

$VmMgmt.AddKvpItems($Vm, $kvpDataItem.PSBase.GetText(1))
```

### Query key-value pairs on the host

```powershell
$VmMgmt = Get-WmiObject -Namespace root\virtualization\v2 -Class \
    Msvm_VirtualSystemManagementService
$vm = Get-WmiObject -Namespace root\virtualization\v2 -Class \
    Msvm_ComputerSystem -Filter {ElementName='VM1'}
($vm.GetRelated("Msvm_KvpExchangeComponent")[0] ).GetRelated("Msvm_KvpExchangeComponentSettingData").HostExchangeItems | % { \
    $GuestExchangeItemXml = ([XML]$_).SelectSingleNode(\
        "/INSTANCE/PROPERTY[@NAME='Name']/VALUE[child::text() = 'Name2']")
    if ($GuestExchangeItemXml -ne $null)
    {
        $GuestExchangeItemXml.SelectSingleNode(\
            "/INSTANCE/PROPERTY[@NAME='Data']/VALUE/child::text()" ).Value
    }
}
```

### Modify a key-value pair

```powershell
$VmMgmt = Get-WmiObject -Namespace root\virtualization\v2 -Class \
    Msvm_VirtualSystemManagementService
$vm = Get-WmiObject -Namespace root\virtualization\v2 -Class \
    Msvm_ComputerSystem -Filter {ElementName='VM1'}
$kvpDataItem = ([WMIClass][String]::Format("\\{0}\\{1}:{2}", \
    $VmMgmt.ClassPath.Server, \
    $VmMgmt.ClassPath.NamespacePath, \
    "Msvm_KvpExchangeDataItem")).CreateInstance()

$kvpDataItem.Name = "Name"
$kvpDataItem.Data = "Data2"
$kvpDataItem.Source = 0

$VmMgmt.ModifyKvpItems($Vm, $kvpDataItem.PSBase.GetText(1))
```

### Remove a key-value pair

```powershell
$VmMgmt = Get-WmiObject -Namespace root\virtualization\v2 -Class \
    Msvm_VirtualSystemManagementService
$vm = Get-WmiObject -Namespace root\virtualization\v2 -Class \
    Msvm_ComputerSystem -Filter {ElementName='VM1'}
$kvpDataItem = ([WMIClass][String]::Format("\\{0}\\{1}:{2}", \
    $VmMgmt.ClassPath.Server, \
    $VmMgmt.ClassPath.NamespacePath, \
    "Msvm_KvpExchangeDataItem")).CreateInstance()

$kvpDataItem.Name = "Name"
$kvpDataItem.Data = [String]::Empty
$kvpDataItem.Source = 0

$VmMgmt.RemoveKvpItems($Vm, $kvpDataItem.PSBase.GetText(1))
```

## See also

- [Hyper-V integration services](integration-services.md)
- [Supported Linux and FreeBSD virtual machines for Hyper-V on Windows](Supported-Linux-and-FreeBSD-virtual-machines-for-Hyper-V-on-Windows.md)
- [PowerShell Direct](powershell-direct.md)

