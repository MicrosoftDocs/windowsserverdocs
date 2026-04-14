---
title: refsutil
description: Reference article for the refsutil tool, which manages and repairs Resilient File System (ReFS) volumes in Windows ensuring their integrity, performance, and optimization.
author: robinharwood
ms.author: roharwoo
ms.date: 04/02/2025
ms.topic: reference
---

# refsutil

The `refsutil` tool is a command-line utility designed to manage and repair volumes formatted with the Resilient File System (ReFS) in Windows. This utility provides a wide range of functionalities to ensure the integrity, performance, and optimization of ReFS volumes. It's an essential tool for maintaining robust file system operations and addressing various issues that might arise.

## Commands

| Command | Description |
|--|--|
| [compression](refsutil-compression.md) | Enables and manages volume compression to save storage space. |
| [dedup](refsutil-dedup.md) | Identifies and consolidates duplicate clusters to optimize storage usage. |
| [fixboot](refsutil-fixboot.md) | Repairs boot sectors to ensure proper system startup. |
| [iometrics](refsutil-iometrics.md) | Tracks and reports input/output metrics for volume performance analysis. |
| [leak](refsutil-leak.md) | Detects and resolves memory or resource leaks in the file system. |
| [salvage](refsutil-salvage.md) | Performs recovery operations on a corrupt volume to retrieve data. |
| [streamsnapshot](refsutil-streamsnapshot.md) | Manages snapshots of data streams for backup or recovery purposes. |
| [triage](refsutil-triage.md) | Analyzes and addresses file system corruptions. |

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
