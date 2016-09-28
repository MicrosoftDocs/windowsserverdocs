# Quality criteria for pull request review

Pull requests must meet minimum criteria to be accepted for integration into the repo. Pull request reviewers generally review only what is new or changed, using the blocking and non-blocking quality review items listed in this article to evaluate the changes. Reviewers may ask for more information or for a requestor to fix issues before accepting a pull request. The requestor is responsible for making the changes.

>[!IMPORTANT] 
>Opening a pull request triggers quality checks and publication to our internal staging site. It's your responsibility to review both, from links in comments \(on the Conversation tab of the PR, click **Show all checks** > **Details**\). After you've done this, indicate it by adding the **"ready-to-merge"** label to the PR. \(Click **Labels** or the gear to the right of the comment stream in the PR.) If you can't add the label \(come contributors have reported this), add 'ready-to-merge' a comment to the PR and send email to reviewer's alias, wssc-pra@microsoft.com.

## Blocking content quality items

The updates must comply with the following criteria to be merged.

| Category | Quality review item |
|----------|---------------------|
|Prerequisites|	The pull request has no:<br>- validation errors or warnings<br>- merge conflicts<br>- obvious content regressions<br>- embedded repo or any unusual, extraneous files|
|Repo integrity	|Pull request contains fewer than 100 changed files unless it's updating a release branch from master or doing a similar bulk update like a metadata fix. (Really, a PR should contain far fewer than that, but after 100 changed files, GitHub doesn’t display the diffs).|
|Repo integrity| Pull request does not get merged by the person who created the pull request.|
|Naming	|File names for new files follow the [file naming guidelines](file-names-and-locations.md).|
|Naming	|New folders introduced into the repo follow the [folder naming guidelines](file-names-and-locations.md#folder-names-in-the-repo).|
|Naming/SEO|The H1 title has enough information to describe the content of the article, to differentiate it from other articles, and to map to likely customer keywords. For example, an H1 title of "Overview" doesn't meet this criteria.|
|Content|It's a technical document. See the [what goes where guidance](content-channel-guidance.md).|
|Content|It has an introductory paragraph, and a procedural or conceptual body of content. It has enough content to stand on its own as an article and isn't a small fragment of information.|
|Content| It follows standard formatting and content design: elements that should be numbered lists are numbered, elements that should be unordered lists are bulleted. This is basic usability.|
|Content| It has no unusual graphics, information architecture or structures, or obviously non-standard designs.|
|Site/design functionality|	The article doesn't have a manually authored TOC within the contents. The article must rely on H2s for its on-page TOC.|
|Site/design functionality|	If H2 headings are used, there are at least two. Any H3 heads are preceded by an H2 heading. Using one H2 heading creates a single-item article TOC. Use an H2 headings before an H3 heading to ensure a TOC is created.|
|Markdown| Article contains no blocks of HTML; minor inline HTML is permitted – such as superscript, subscript, special characters, and other minor formatting that Markdown doesn't support. HTML tables are allowed ONLY if the table contains bulleted or numbered lists, but that usually indicates the content could be simplified so it can be coded in Markdown.|
|Markdown	|Custom markdown elements are used where appropriate. Ex: Notes are coded using the !NOTE extension, not as plain text.|
|Images|Images include alt text. **This is an accessibility requirement that must be fulfilled as part of release criteria.** [Guidelines here](https://worldready.cloudapp.net/Styleguide/Read?id=2665&topicid=28349). |
|Images	|Animated GIFs are not accepted into the repo.|
|Images | Images have clear resolution, are free of misspelled words, and contain no private information [See the image guidance](https://github.com/Azure/azure-content/blob/master/contributor-guide/create-images-markdown.md). |
|Staging| The article has been previewed on staging and doesn't contain any obvious formatting issues:<br>- A numbered or bulleted list that appears as a paragraph <br> - Code in a code block appearing partly in the code block and partly outside it <br>- Numbered steps numbered incorrectly due to faulty indentation|

## Non-blocking content quality items

For these items, pull request reviewers provide feedback and instructions for the author to follow up with fixes in a later pull request. However, this feedback doesn't block the decision to merge. Authors should follow up within 3 business days with fixes.

| Category | Quality review item |
|----------|---------------------|
|Content|Articles should have a “Next steps” at the end with 1-3 relevant and compelling next steps. Brief text should be included that helps the customer understand why the next steps are relevant. (New articles only).
|Images|Images use the correct callout style and color, and screenshots use the correct border and placeholder style. [See the image guidance](https://github.com/Azure/azure-content/blob/master/contributor-guide/create-images-markdown.md).|
|Site/design functionality|The H2 headings, when rendered in the on-page TOC, should ideally wrap to no more than 2 lines. Longer headings make the article TOC harder to scan.|
|Style conventions|All titles and headings are sentence case.|
|Process|When you delete or rename an article, make sure you follow the process. Pull request reviewers should add the following comment and link in a comment:<br><br>*Please verify you followed the process in the contributor's guide: [Change the name of an article or delete it](rename-or-retire.md).*|
