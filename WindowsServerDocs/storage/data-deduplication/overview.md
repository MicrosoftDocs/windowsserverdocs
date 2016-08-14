# Data Deduplication Overview
>Applies to Windows Server 2016

## <a name="what-is-dedup"></a>What is Data Deduplication?
Data Deduplication, often called "**Dedup**" for short, is a feature of Windows Server 2016 which can help reduce the impact of redundant data on storage costs. When enabled, Dedup optimizes free space on a volume by examining the data on the volume for duplication. Once identified, duplicated portions of the volume's dataset are stored once and are (optionally) compressed for additional savings. Data Deduplication optimizes redundancies without compromise data fidelity or integrity.

## <a name="why-is-dedup-useful"></a>Why is Data Deduplication useful?
Data Deduplication is an important tool in a storage administrator's toolkit for reducing costs associated with duplicated data. Large datasets often have **<u>a lot</u>** of duplication which increases the costs of storing the data. For example:

- User file shares may have many copies of the same, or very similar files
- Virtualization guests may be virtually identical from VM-to-VM
- Backup snapshots may have very minor differences from day-to-day.

The space savings that can be gained from Dedup are highly dependent on the dataset, or workload, on the volume. Datasets with high duplication could see optimization rates of up to 95%, or a 20x reduction in storage utilization. The following table highlights typical deduplication savings for various content types:

<table>
    <thead>
        <tr>
            <th>Scneario</th>
            <th>Content</th>
            <th>Typical Space Savings</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>User documents</td>
            <td>Office documents, photos, music, videos, etc</td>
            <td>30-50%</td>
        </tr>
        <tr>
            <td>Deployment shares</td>
            <td>Software binaries, cab files, symbols files, etc</td>
            <td>70-80%</td>
        </tr>
        <tr>
            <td>Virtualization libraries</td>
            <td>ISOs, Virtual hard disk files, etc</td>
            <td>50-60%</td>
        </tr>
    </tbody>
</table>

## <a id="when-can-dedup-be-used"></a>When can Dedup be used?

<table>
    <tbody>
        <tr>
            <td align="center"><img src="media/overview-clustered-gpfs.png"></td>
            <td>General Purpose File Server</td>
        </tr>
        <tr>
            <td align="center"><img src="media/overview-vdi.png"></td>
            <td>Virtualized Desktop Infrastructure (VDI) deployments</td>
        </tr>
        <tr>
            <td align="center"><img src="media/overview-backup.png"></td>
            <td>Backup targets</td>
        </tr>
    </tbody>
</table>
