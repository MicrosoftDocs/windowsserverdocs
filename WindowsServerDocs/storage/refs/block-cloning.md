---
title: Block cloning on ReFS
description:
author: gawatu
ms.author: gawatu
manager: gawatu
ms.date: 12/6/2016
ms.topic: article
ms.prod: windows-server-threshold
ms.technology: storage-file-systems
ms.assetid: 
---

# Block cloning on ReFS
>Applies To: Windows Server 2016

Block cloning instructs the file system to copy a range of file bytes on behalf of an application, where the destination file may be the same as, or different from, the source file. Copy operations, unfortunately, are expensive, since they trigger expensive read and writes to the underlying, physical data. 

Block cloning in ReFS, however, performs copies as a low-cost metadata operation rather than reading from and writing to file data. Because ReFS enables multiple files to share the same logical clusters (physical locations on a volume), copy operations only need to remap a region of a file to a separate physical location, converting an expensive, physical operation to a quick, logical one. This allows copies to complete faster and generate less I/O to the underlying storage. This improvement also benefits virtualization workloads, as .vhdx checkpoint merge operations are dramatically accelerated when using block clone operations. Additionally, because multiple files can share the same logical clusters, identical data isn't physically stored multiple times, improving storage capacity. 
  
## How it works 

Block cloning on ReFS converts a file data operation into a metadata operation. In order to make this optimization, ReFS introduces a reference count into its metadata, which records the number of virtual clusters that reference the same LCN (logical cluster number). This allows multiple files to share the same physical data:

<img src=media/ref-count-example.gif alt="Show reference count updates when multiple files reference same LCN"/>


By keeping a reference count for each logical cluster, ReFS does not break the isolation between files: writes to shared clusters trigger an allocate-on-write mechanism, where ReFS allocates a new cluster for the incoming write. This mechanism preserves the integrity of the logical cluster that was shared by multiple files. 

### Example
Suppose there are two files, X and Y, where each file is only composed of three virtual clusters, and each virtual cluster maps to a separate LCN (logical cluster number). The initial reference count reflects that each logical cluster is only referenced by one virtual cluster.

<img src=media/block-clone-1.png alt="Two files each with three distinct virtual clusters which all map to logical clusters that have ref count 1"/>

Now suppose an application issues a block clone operation from File X, over a region that includes LCNs 1 and 2, to File Y at the offset where LCN 5 current is. The following file system state would result:

<img src=media/block-clone-2.png alt="Reference count shows 2 for blocked clone region"/>

This file system state reveals a successful duplication of the block cloned region. Because ReFS performs this copy operation by only updating VCN to LCN mappings, no physical data was read, nor was the physical data in File Y overwritten. File X and Y now share logical clusters, reflected by the reference counts in the table. Because no data was physically copied, ReFS reduces capacity consumption on the volume. 

Now suppose the application attempts to overwrite LCN 1 in File X. ReFS will duplicate the shared region into another logical cluster (LCN 7, in this example), update the reference counts appropriately, and perform the incoming write to the newly duplicated region. This ensures that isolation between the files is preserved.   

<img src=media/block-clone-3.png alt="Isolation preserved by writing to LCN 7 and updating ref counts"/>

Note that after the modifying write, LCN 2 is still shared by both files.  


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




