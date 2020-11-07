---
title: Add the required metadata tags to your Windows Server-related article
description: A list of the information you must add as metadata tags to the top of your Windows Server-related articles. The required tags are subject to change, based on both your reporting and team requirements.
author: eross-msft
ms.author: lizross
ms.date: 05/06/2019
---

# Add the required metadata tags to your Windows Server-related article

At the top of every article, there is specific metadata that must be included for tracking and SEO purposes. The required tags are subject to change, based on reporting requirements. However, you should be notified if you need to add/remove any fields.

It should look like this, including the three hyphens (---) at the top and bottom:

```markdown
---
title: Required. The title of the article should go here. This is used in SEO and search results.
description: Required. A description for the article should go here. This is used in search results, to provide users with information about whether the article has the information they're looking for.
author: Required. Your GitHub alias
ms.author: Required. Your Microsoft alias
manager: Optional. Your manager's Microsoft alias
ms.reviewer: Optional. The Microsoft alias for the primary PM for the feature/functionality
ms.topic: Type of article, including conceptual, how-to, hub-page, overview, quickstart, reference, sample, troubleshooting, or tutorial
ms.date: Date of change (MM/DD/YYYY)

---
```

## Example

```markdown
---
title: What is Windows Admin Center?
description: Learn about the Windows Admin Center, a locally-deployed, browser-based management tool set that lets you manage your Windows Servers with no Azure or cloud dependency.
author: danielle-github
ms.author: danielle
manager: alainch
ms.reviewer: alainch
ms.topic: overview
ms.date: 07/06/2019

---
```