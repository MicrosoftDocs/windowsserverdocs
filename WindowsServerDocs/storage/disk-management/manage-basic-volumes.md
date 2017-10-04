Applies To: Windows 7, Windows Server 2008 R2

A basic disk is a physical disk that contains primary partitions, extended partitions, or logical drives. Partitions and logical drives on basic disks are known as basic volumes. You can only create basic volumes on basic disks.

You can add more space to existing primary partitions and logical drives by extending them into adjacent, contiguous unallocated space on the same disk. To extend a basic volume, it must be formatted with the NTFS file system. You can extend a logical drive within contiguous free space in the extended partition that contains it. If you extend a logical drive beyond the free space available in the extended partition, the extended partition grows to contain the logical drive as long as the extended partition is followed by contiguous unallocated space.

-   [Assign a mount point folder path to a drive](https://technet.microsoft.com/en-us/library/cc753321(v=ws.11).aspx)
-   [Extend a Basic Volume](https://technet.microsoft.com/en-us/library/cc771473(v=ws.11).aspx)
-   [Shrink a Basic Volume](https://technet.microsoft.com/en-us/library/cc731894(v=ws.11).aspx)


