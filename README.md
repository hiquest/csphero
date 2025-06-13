# CSP Hero

CSP Hero is a **free**, **open-source** server and dashboard designed to help developers collect and analyze [Content Security Policy (CSP)](https://developer.mozilla.org/en-US/docs/Web/HTTP/Guides/CSP) reports.

> The easiest way to try CSP Hero is in [our cloud service](https://www.csphero.com/).

<img src="./.github/screenshots/main.png" width="100%" alt="CSP Hero dashboard"/>

---

## Features

- **Collect CSP reports**: collect CSP violation reports from your web applications.
- **Analyze reports**: View and analyze collected reports in a user-friendly dashboard.
- **Report aggregation**: Smartly aggregate reports to get a comprehensive view.

## What is a Content Security Police?

[Content Security Policy](https://developer.mozilla.org/en-US/docs/Web/HTTP/Guides/CSP) allows developers to define which resources are allowed to load on their web pages, helping to prevent cross-site scripting (XSS) attacks and other vulnerabilities.

When a violation occurs, the browser sends a report to the provided endpoint (via [report-uri](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Content-Security-Policy/report-uri) or [report-to](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Content-Security-Policy/report-to) directive), which can be collected and analyzed.

CSP Hero provides an endpoint to collect these reports and a dashboard to analyze and visualize them.

## Extra tools

Several free tools are available online (soon to be open-sourced):

- [CSP Builder](https://www.csphero.com/csp-builder) allows you to create a CSP policy with a user-friendly interface.
- [CSP Validator](https://www.csphero.com/csp-validator) validates your CSP policy and suggests improvements.
