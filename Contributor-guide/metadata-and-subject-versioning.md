# Metadata and version identifiers

This article discusses metadata and versioning for the articles in windowsserverdocs-pr repository. 

## Versioning
Several types of versioning apply to the articles in this repo: 

-  Versioning that indicates the product version that an article applies to is done two ways:
    - Manually on a single line in the article so it's visible as text on a published article.
    - By metadata, described below.
-  Source content versioning is handled through Github's history on the file. 

## Metadata structure and format

- Put Metadata at the top of the file, above the H1 heading.
- Separate the block from the rest of the file contents by using three dashes only in the first and last lines of the block.
- Put each metadata name/value pair on a separate line
- Use one of the following syntax patterns, depending on whether the metadata requires predefined values or accepts custom values. 

        ---
        name1: predefined-value
        name2: "my custom value"
        ---

## Metadata names and values

Certain metadata is required for all files published as articles in the TechNet technical library, while other metadata is recommended but not required. In some cases, only certain values are allowed for a specific piece of metadata. 

|Name|Value|
|---|---|
|title|Custom value that matches the H1 heading. Determines what shows in the browser tab.|
|description|Shows in search results and affects SEO. Include appropriate keywords but keep length to less than 160 characters.|
|author|Github alias of the primary author of the article|
|ms.author|MSFT alias of the article's author or content developer responsible for the technology area covered in the article.|
|ms.date|Date of last content update. Don't update for changes to metadata only. Use the format mm/dd/yyyy.|
|ms.prod|Identifies the Windows Server version for BI reporting, based on a predefined [value](https://microsoft.sharepoint.com/teams/STBCSI/Insights/_layouts/15/WopiFrame.aspx?sourcedoc=%7b7A321BF1-0611-4184-84DA-A0E964C435FA%7d&file=WEDCS_MasterList_CSIValues.xlsx&action=default&IsList=1&ListId=%7b46B17C8A-CD7E-47ED-A1B6-F2B654B55E2B%7d&ListItemId=969).|
|ms.technology|Identifies the technology area for BI reporting, based on a predefined [value](https://microsoft.sharepoint.com/teams/STBCSI/Insights/_layouts/15/WopiFrame.aspx?sourcedoc=%7b7A321BF1-0611-4184-84DA-A0E964C435FA%7d&file=WEDCS_MasterList_CSIValues.xlsx&action=default&IsList=1&ListId=%7b46B17C8A-CD7E-47ED-A1B6-F2B654B55E2B%7d&ListItemId=969)|
|ms.asset|GUID that identifies the article across all locales for BI reporting. Articles migrated from earlier authoring systems already have this. For articles created in Github, use a tool such as [https://guidgenerator.com/](https://guidgenerator.com/).| 

## Troubleshooting

Metadata that appears at the top of a published article happens when the source file has formatting errors. Some common errors are:

- Missing the triple hyphens at the first and last lines of the block, or the wrong number of hyphens.
- Metadata doesn't follow the required syntax: \<name\>:\<single space\>\<value>

Check your file for these and any other obvious errors, then submit a PR to publish the updated file. If you're stuck, email the PR reviewers alias: wssc-pra@microsoft.com

## See also
Metadata used in this repo is based on metadata used in Content Services & International \(CSI\). More info, including optional metadata, is available at [http://aka.ms/skyeye/meta](http://aka.ms/skyeye/meta).
For BI resources, see CSI BI teams [wiki](https://microsoft.sharepoint.com/teams/STBCSI/Insights/Selfserve%20BI%20wiki/Self-serve%20BI%20wiki.aspx).