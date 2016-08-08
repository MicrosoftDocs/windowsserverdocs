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




