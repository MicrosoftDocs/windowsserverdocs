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
ms.assetid: 1f1215cd-404f-42f2-b55f-3888294d8a1f
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

## Performance
Block clone dramatically accelerates copy operations. This helps address the increasing demands of virtualization workloads, as .vdhx merge operations complete significantly faster. 

## See also
-   [DUPLICATE_EXTENTS_DATA](https://msdn.microsoft.com/en-us/library/windows/desktop/mt590821(v=vs.85).aspx)
-   [FSCTL_DUPLICATE_EXTENTS_TO_FILE](https://msdn.microsoft.com/en-us/library/windows/desktop/mt590823(v=vs.85).aspx)




