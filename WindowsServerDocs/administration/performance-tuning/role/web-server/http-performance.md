---
title: Performance Tuning for HTTP 1.1/2
description: Performance tuning recommendations for HTTP 1.1/2
ms.prod: windows-server
ms.technology: performance-tuning-guide
ms.topic: article
ms.author: IvanPash; GMonte
author: phstee
ms.date: 10/16/2017
---

# Performance Tuning HTTP 1.1/2

HTTP/2 is meant to improve performance on the client side (e.g., page load time on a browser). On the server, it may represent a slight increase in CPU cost. Whereas the server no longer requires a single TCP connection for every request, some of that state will now be kept in the HTTP layer. Furthermore, HTTP/2 has header compression, which represents additional CPU load.

Some situations require an HTTP/1.1 fallback (resetting the HTTP/2 connection and instead establishing a new connection to use HTTP/1.1). In particular, TLS renegotiation and HTTP authentication (other than Basic and Digest) require HTTP/1.1 fallback. Even though this adds overhead, these operations already imply some delay and so are not particularly performance-sensitive.

## See also
- [Web Server performance tuning](index.md) 
- [IIS 10.0 performance tuning](tuning-iis-10.md)