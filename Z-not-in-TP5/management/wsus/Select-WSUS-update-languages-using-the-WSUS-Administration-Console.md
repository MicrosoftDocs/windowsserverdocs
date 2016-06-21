---
title: Select WSUS update languages using the WSUS Administration Console
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 66bc2f89-5b46-4407-8bd7-34449bb64e53
---
# Select WSUS update languages using the WSUS Administration Console
If you store updates on the local WSUS server, you must select the languages in which the updates are downloaded. You can modify the language settings at any time by using the WSUS Administration Console.

Language options are different for upstream WSUS servers than for downstream WSUS servers. You should understand how the language options work and plan their implementation to conserve resources and to guarantee that updates are always downloaded in all needed languages.

You should always select English regardless of the languages that you need. All updates are based on English language packs.

We recommend that after you change language options, you manually synchronize replica servers to the centrally managed WSUS server to avoid a mismatch of updates.

For more information and recommendations about language update options, see [Plan for WSUS language updates](assetId:///358e5660-ce8a-483a-aa60-e74fcee7b19c) in this deployment guide.

### To change the update language settings

1.  Open the WSUS Administration Console by following the instructions in [Open the WSUS Administration Console](Configure-WSUS-by-Using-the-WSUS-Administration-Console.md#opencon).

2.  In the left pane of the WSUS Administration Console, expand the server name, and then click **Options**.

3.  In the **Options** pane, click **Update Files and Languages**.

4.  Click the **Update Languages** tab.

5.  To download updates in all available languages:

    1.  Select **Download updates in all languages, including new languages**.

    2.  Click **Next**.

6.  To download updates in selected languages only:

    1.  Select **Download updates only in these languages**.

    2.  Select the check box for each language for which you want to download updates.

7.  Click **OK**.


