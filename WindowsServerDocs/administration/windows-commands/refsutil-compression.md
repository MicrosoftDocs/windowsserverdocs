---
title: refsutil compression
description: Reference article for the refsutil compression tool, which queries or modifies compression settings on a Resilient File System (ReFS) volume in Windows.
author: dknappettmsft
ms.author: daknappe
ms.date: 04/02/2025
ms.topic: reference
---

# refsutil compression

The `refsutil compression` command is used to query or set the compression parameters on a specified Resilient File System (ReFS) volume. You can check the current compression status, apply compression using different formats, or decompress a compressed volume.

## Syntax

```
refsutil compression <drive> <[/q]> | <[/c] [/f <format>] [/e <engine>] [/cs <size>]>
```

## Parameters

| Parameters | Description |
|--|--|
| `<drive>` | Specifies the drive letter of the volume to be compressed in the format `E:`. |
| `/q` | Queries the volume's current compression parameters. |
| `/c` | Compresses the volume with the specified compression parameters. |
| `/f <format>` | Specifies the compression format to use. Valid options include:<br><br> <li>`LZ4`: A fast compression algorithm. <li> `ZSTD`: A compression algorithm that offers a good balance between compression ratio and speed. <li> `NONE`: Used to *decompress* a previously compressed volume. When using `NONE`, omit the engine and compression chunk size parameters.</li> |
| `/e <engine>` | Defines the compression level to use, which varies by format:<br><br> <li> `LZ4`: Levels `1`, `3-12`. The default is `1`. <br>Levels `3-12` use the LZ4HC algorithm, which provides higher compression ratios at the cost of slower compression speeds. <br><li> `ZSTD`: Levels `1-22`. The default is `3`. <br>Higher levels provide better compression ratios but reduce compression speed and might require more memory (especially levels `20` and greater). <br><br>Decompression speed remains consistent regardless of the chosen compression level.</li><br> Omitting the `/e` parameter or using the value `0` sets the default level for any given compression format. |
| `/cs <size>` | Specifies the compression chunk size in bytes. This value must be to the power of two (2^*n*), at least equal to the volume's cluster size, and no greater than `64MB`. Larger chunk sizes can enhance compression ratios but might negatively impact read performance for smaller data amounts. Beyond `1MB`, the benefits diminish significantly, so larger sizes aren't recommended.<br><br> If omitted or set to `0`, the volume's cluster size is used. |

> [!NOTE]
> For the `/e` parameter, the default compression values are subject to change.

## Examples

To query the F: volume compression parameters, run the command:

```
refsutil compression F: /q
```

To compress the F: volume using the `LZ4` format with level 12 compression and a chunk size of 524,288 bytes (512 KB), run the command:

```
refsutil compression F: /c /f LZ4 /e 12 /cs 524288
```

To compress the F: volume using the `ZSTD` format with level 15 compression and a chunk size of 131,072 bytes (128 KB), run the command:

```
refsutil compression F: /c /f ZSTD /e 15 /cs 131072
```

To compress the F: volume using the `ZSTD` format with default compression parameters, run the command:

```
refsutil compression F: /c /f ZSTD
```

To decompress the F: volume, run the command:

```
refsutil compression F: /c /f NONE
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
