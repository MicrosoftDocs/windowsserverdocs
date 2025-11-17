---
title: refsutil streamsnapshot
description: Reference article for the refsutil streamsnapshot tool, which manages Resilient File System (ReFS) data stream snapshots where you can create, delete, list, or compare snapshots in Windows.
author: robinharwood
ms.author: roharwoo
ms.date: 04/02/2025
ms.topic: reference
---

# refsutil streamsnapshot

The `refsutil streamsnapshot` command allows you to manage snapshots of data streams within files in the Resilient File System (ReFS). You can create, delete, list, or compare snapshots of data streams at specified points in time. The `file.dat` file contains the data streams for which you want to create, delete, list, or compare snapshots. Essentially, it's the target file upon which this utility performs its operations.

## Syntax

```
refsutil streamsnapshot [/c <name>] [/l] [/d <name>] [/q <name>] <file[:stream]>
```

## Parameters

| Parameter | Description |
|--|--|
| `/c <name>` | Creates a snapshot named `<name>` of the stream specified by `file[:stream]` at the current point in time. This option is mutually exclusive with `/d`, `/l`, and `/q`. |
| `/d <name>` | Deletes the snapshot named `<name>` from the specified file `<file>`. This parameter ignores the `[:stream]` portion of the file path and is mutually exclusive with `/c`, `/l`, and `/q`. |
| `/l <name>` | Lists all snapshots for the stream specified by `file[:stream]` that match the given `<name>`. Wildcards are allowed in `<name>`. This parameter is mutually exclusive with `/c`, `/d`, and `/q`. |
| `/q <name>` | Lists all modifications between the snapshot `<name>` and the current state of the stream specified by `[:stream]`. Both must reference streams in the same snapshot chain, with `<name>` being older than `[:stream]`. This parameter is mutually exclusive with `/c`, `/d`, and `/l`. |

> [!NOTE]
> If `[:stream]` isn't provided, this utility acts on the default unnamed data stream, `$DATA`.

## Examples

To create a snapshot named "snapshot_jan_2024" of the stream at the current point in time, run the following command:

```
refsutil streamsnapshot /c "snapshot_jan_2024" C:\file.dat
```

To delete a snapshot named "snapshot_jan_2024" from the file, run the following command:

```
refsutil streamsnapshot /d "snapshot_jan_2024" C:\file.dat
```

To list all snapshots for the stream in the file matching any pattern using the `*` wildcard, run the following command:

```
refsutil streamsnapshot /l "*" C:\file.dat
```

To list all modifications between the snapshot "snapshot_jan_2024" and the stream "snapshot_feb_2024", run the following command:

```
refsutil streamsnapshot /q "snapshot_jan_2024" C:\file.dat:snapshot_feb_2024
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
