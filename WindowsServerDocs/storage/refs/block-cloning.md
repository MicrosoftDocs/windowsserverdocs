---
title: Block cloning on ReFS
description:
author: gawatu
ms.author: gawatu
manager: gawatu
ms.date: 12/6/2016
ms.topic: article
ms.prod: refs
ms.technology: storage
ms.assetid: 
---

# Block cloning on ReFS
>Applies To: Windows Server 2016

Block cloning instructs the file system to copy a range of file bytes on behalf of an application, where the destination file may be the same as, or different from, the source file. Copy operations, unfortunately, are expensive historically, since they trigger expensive read and writes to the underlying, physical data. 

Block cloning in ReFS, however, is performed as a low-cost metadata operation rather than reading from and writing to file data. Because ReFS enables multiple files to share the same logical clusters (physical locations on a volume), copy operations only need to remap a region of a file to a separate physical location, converting an expensive, physical operation to a quick, logical one. This allows copies to complete faster and generate less I/O to the underlying storage. This improvement also benefits virtualization workloads, as .vhdx checkpoint merge operations are dramatically accelerated when using block clone operations. Additionally, because multiple files can share the same logical clusters, identical data isn't physically stored multiple times, improving storage capacity. 
  
## How it works 

Block cloning on ReFS converts a file data operation into a metadata operation. In order to make this optimization, ReFS introduces a reference count into its metadata, which records the number of virtual clusters that reference the same logical cluster (physical location). This allows multiple files to share the same physical data. 

By keeping a reference count for each logical cluster, ReFS does not break the isolation between files: writes to shared clusters trigger an allocate-on-write mechanism, where ReFS allocates a new cluster for the incoming write. This mechanism preserves the integrity of the logical cluster that was shared by multiple files. 

### Example
Suppose there are two files, where each file is composed of three clusters, and each cluster is stored on a distinct location of the volume. The initial reference count reflects that each physical region of the volume is only referenced by one virtual cluster.


When an application issues a block clone for regions A and B, ReFS remaps the virtual clusters and updates the reference count, without reading or writing any file data. 


Both files now share logical clusters on disk, revealed by the reference counts shown in the table. By sharing these logical clusters, ReFS reduces capacity consumption in the volume. 
If an application attempts to write to a shared region, ReFS will duplicate the shared region, update reference counts, and perform the incoming write to the newly duplicated region. This ensures that isolation between the files is preserved.   

## Functionality restrictions and remarks
- The source and destination region must begin and end at a cluster boundary. 
- The cloned region must be less than 4GB in length. 
- The destination region must not extend past the end of the file. If the application wishes to extend the destination with cloned data, it must first call [SetEndOfFile](https://msdn.microsoft.com/en-us/library/windows/desktop/aa365531(v=vs.85).aspx). 
- If the source and destination regions are in the same file, they must not overlap. (The application may be able to proceed by splitting up the block clone operation into multiple block clones that no longer overlap).
- The source and destination files must be on the same ReFS volume. 
- The source and destination files must have the same [Integrity Streams](https://msdn.microsoft.com/en-us/library/windows/desktop/gg258117(v=vs.85).aspx) setting. 
- If the source file is sparse, the destination file must also be sparse. 
- The block clone operation will break Shared Opportunistic Locks (also know as [Level 2 Opportunistic Locks](https://msdn.microsoft.com/en-us/library/windows/desktop/aa365713(v=vs.85).aspx)).
- The ReFS volume must have been formatted with Windows Server 2016, and if Windows Failover Clustering is in use, the Clustering Functional Level must have been Windows Server 2016 or later at format time. 

## See also
-   [DUPLICATE_EXTENTS_DATA](https://msdn.microsoft.com/en-us/library/windows/desktop/mt590821(v=vs.85).aspx)
-   [FSCTL_DUPLICATE_EXTENTS_TO_FILE](https://msdn.microsoft.com/en-us/library/windows/desktop/mt590823(v=vs.85).aspx)




