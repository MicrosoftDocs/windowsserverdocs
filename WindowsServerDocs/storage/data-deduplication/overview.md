# Data Deduplication Overview
>Applies to Windows Server 2016
## <a name="what-is-dedup">What is Data Deduplication?</a>
Data Deduplication, often called "**Dedup**" for short, is a feature of Windows Server 2016 which can help reduce the impact of redundant data on storage costs. When enabled, Dedup optimizes free space on a volume by examining the data on the volume for duplication. Once identified, duplicated portions of the volume's dataset are stored once and are (optionally) compressed for additional savings. Data Deduplication optimizes redundancies without compromise data fidelity or integrity.

## <a name="why-is-dedup-useful">Why is Data Deduplication useful?</a>
Data Deduplication is an important tool in a storage administrator's toolkit for reducing costs associated with duplicated data. Large datasets often have **<u>a lot</u>** of duplication which increases the costs of storing the data. For example:

- User file shares may have many copies of the same, or very similar files
- Virtualization guests may be virtually identical from VM-to-VM
- Backup snapshots may have very minor differences from day-to-day.

The space savings that can be gained from Dedup are highly dependent on the dataset, or workload, on the volume. Datasets with high duplication could see optimization rates of up to 95%, or a 20x reduction in storage utilization. Information on average space savings by workload can be found [here](plan-to-deploy-data-deduplication.md#average-benefit-by-workload).

## <a name="how-does-dedup-differ">How does Data Deduplication differ from other optimization products?</a>
There are several important differences between Data Deduplication, and other common storage optimization products:

<ul>
<li><b>How does Data Deduplication differ from Single Instance Store?</b><br />
Single Instance Store, or SIS, was a predecessor technology to Dedup first introduced in Windows Storage Server 2008 R2. SIS optimized a volume by identifying files which were completely identical and replacing them with logical links to a single copy of a file stored in the SIS Common Store. Unlike SIS, Dedup can get space savings from files which are not identical but share many common patterns and from files which themselves contain many repeated patterns. SIS was deprecated in Windows Server 2012 R2 and removed in Windows Server 2016 in favor of Data Deduplication.</li>
<li><b>How does Data Deduplication differ from NTFS Compression?</b><br />
NTFS Compression is a feature of NTFS that can be optionally enabled at the volume level. With NTFS Compression, each individual file is optimized individually via compression at write-time. Unlike NTFS Compression, Dedup can get spacing savings across all the files on a volume. This is advantageous over NTFS Compression because files may have <u>both</u> internal duplication (which is addressed by NTFS Compression) and have similarities with other files on the volume (which is not addressed by NTFS Compression). Additionally, Dedup has a post-processing model, which means that new files (or modifications to existing files), will be written to disk unoptimized and will be optimized later on by Dedup.</li>
<li><b>How does Data Deduplication differ from archive file formats like zip, rar, 7z, cab, etc?</b><br />
Archive file formats like zip, rar, 7z, cab, etc perform compression over a specified set of files. Like Dedup, this means that both duplicated patterns within files and duplicated patterns across files are optimized, however this requires manual intervention, in the form of choosing which files should be included in the archive, and changes the access semantics, because now accessing a specific file within the archive means opening the archive, selecting the specific file desired, and decompressing that file for use. Dedup operates transparently to users and administrators, and requires no manual kick-off. Additionally, Dedup preserves access semantics - optimized files appear unchanged after optimization.</li>
</ul>

## <a name="how-does-dedup-work">How does Data Deduplication work?</a>
Data Deduplication in Windows Server was created with the following two principles:

<ol>
<li><b>Optimization should not get in the way of writes to the disk</b><br />
This means that Dedup optimizes data using a post-processing model; all data is written unoptimized to the disk, and then optimized later by Dedup.</li>
<li><b>Optimization should not change access semantics</b><br />
This means that users and applications which access data on an optimized volume are completely unaware that the files they are accessing have been Deduplicated. 
</li>
</ol>

Once enabled for a volume, Data Deduplication runs in the background to identify repeated patterns across files on that volume and to seamlessly move those portions, or chunks, with special pointers called Reparse Points that point to a unique copy of that chunk. This occurs in the following four steps:

<ol>
<li>Break files into variable-sized chunks</li>
<li>Identify unique chunks</li>
<li>Place chunks in the Dedup Chunk Store and optionally compress</li>
<li>Replace the file stream of optimized files with a Reparse Point to the Dedup Chunk Store</li>
</ol>

When optimized files are modified, the modifications get written unoptimized to the disk and are optimized by the Dedup Optimization Job later on. More information about the Optimization Job can be found [here](optimization-job.md).

