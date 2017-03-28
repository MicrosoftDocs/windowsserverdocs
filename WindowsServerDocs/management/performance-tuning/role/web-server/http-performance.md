---
title: Performance Tuning for HTTP 1.1/2
description: Performance Tuning HTTP 1.1/2
ms.prod: windows-server-threshold
ms.service: na
manager: dongill
ms.technology: performance-tuning-guide
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e4658f31-043d-4497-9373-ab99549a83c7
author: phstee
ms.author: IvanPash; GMonte
ms.date: 10/31/2016
---

# Performance Tuning for HTTP 1.1/2

HTTP/2 is meant to improve performance on the client side (e.g., page load time on a browser). On the server, it may represent a slight increase in CPU cost. Whereas the server no longer requires a single TCP connection for every request, some of that state will now be kept in the HTTP layer. Furthermore, HTTP/2 has header compression, which represents additional CPU load.

Some situations require an HTTP/1.1 fallback (resetting the HTTP/2 connection and instead establishing a new connection to use HTTP/1.1). In particular, TLS renegotiation and HTTP authentication (other than Basic and Digest) require HTTP/1.1 fallback. Even though this adds overhead, these operations already imply some delay and so are not particularly performance-sensitive.
