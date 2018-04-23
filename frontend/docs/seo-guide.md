# Search Engine Optimization Guideline

## Purpose

**Search engine optimization** (SEO) is the practice of increasing the quantity and quality of traffic to your website through organic search engine results.
The aim of this document is to show good practices and conventions to improve your webpage's SEO.

## Table of Contents

1. [Glossary](#1-glossary)
   1. [SEM](#1.1-SEM)
      - [SEO](#SEO)
      - [PPC](#PPC)
   2. [Index](#1.2-index)
   3. [Crawl](#1.3-crawl)
   4. [Crawler](#1.4-crawler)
2. [On-Page](#2-on-page)
   1. [General](#2.1-general)
      - [Google Analytics](#google-analytics)
      - [HTTPS](#https)
      - [Flash](#flash)
      - [iFrames](#iframes)
      - [Page Speed](#page-speed)
   2. [Content](#2.2-content)
      - [General](#general)
      - [Title](#title)
      - [Images](#images)
   3. [Meta-tags](#2.3-meta-tags)
      - [Meta content type](#meta-content-type)
      - [Meta descriptions](#meta-descriptions)
      - [Viewport](#viewport)
      - [Language](#language)
      - [Keywords](#keywords)
      - [Structured data](#structured-data)
   4. [Structure](#2.4-structure)
      - [Headings](#headings)
      - [Write valid code](#write-valid-code)
      - [Pagination](#pagination)
   5. [Accessibility](#2.5-Accessibility)
      - [Status code errors](#status-code-errors)
      - [Sitemap](#sitemap)
      - [Canonical Tag](#canonical-tag)
      - [URLs](#urls)
      - [Redirections](#redirections)
      - [Robots Exclusion Protocol](#robots-exclusion-protocol-(rep))
   6. [Social networks](#2.6-social-networks)
      - [Social sharing buttons](#social-sharing-buttons)
      - [The Open Graph](#the-open-graph)
      - [Twitter Cards](#twitter-cards)
      
## 1. Glossary

### 1.1 SEM

**Search Engine Marketing (SEM)** is a form of Internet marketing that involves the promotion of websites by increasing their visibility in search engine results pages (SERPS) through optimization and advertising.

#### SEO

**Search Engine Optimization (SEO)** is a technical process through which differents changes in your websitie structure and content are implemented in order to improve its visibility in organic results from search engines.

To learn more please read [Google 101: How Google crawls, indexes and serves the web](https://support.google.com/webmasters/answer/70897)

#### PPC

When it comes to boosting traffic in your website, you have two basic options: **Pay Per Click (PPC)** advertising or SEO.

You can pay for traffic using the PPC advertising programs provided by Google Adwords, Yahoo Search Marketing and others. **This guidelines do not contemplate this techniques**.


### 1.2 Index

Google stores all web pages that it knows about in its index. The index entry for each page describes the content and location (URL) of that page. 

A page is indexed by Google if it has been visited by the Google crawler, analyzed for content and meaning, and stored in the Google index. It is important to know that Google does not index all pages but only the ones that seem relevent to it. To learn more visit [this site](https://www.google.com/search/howsearchworks/).

To see indexed pages in your site, use the `site:` operator, like this: `site:google.com`. [Read more...](https://support.google.com/webmasters/answer/35256?hl=en)

### 1.3 Crawl

The process of looking for new or updated web pages. Google discovers URLs by following links, by reading sitemaps, and by many other means. Google crawls the web, looking for new pages, then indexes them (when appropriate).
[Read more...](https://support.google.com/webmasters/answer/7643418)

### 1.4 Crawler

Automated software that crawls (fetches) pages from the web and indexes them.

Googlebot is the generic name of Google's crawler. Googlebot crawls the web constantly.

## 2. On-Page

On-site SEO (also known as on-page SEO) is the **practice of optimizing elements on a website**. This can involve optimizing both the content and HTML source code of pages on a site.

### 2.1 General


#### Google Analytics

Google Analytics can help us undetstand how our seach strategy is working and give us some insights into what we should do. Make sure you have Google Analytics correctly implemented in your web.

_Why:_
>During a search engine optimization (SEO) campaign, you will need to use Google Analytics to track the performance of your work in order to have a success. [Read more...](https://developers.google.com/analytics/solutions/)

#### HTTPS

Google has taken a strict stance to ensure that they protect the privacy of their consumers, to achieve this [the search engine announced HTTPS as a ranking signal](https://security.googleblog.com/2014/08/https-as-ranking-signal_6.html).

Other recommendations that Google gives to developers and webmasters are:

- Use 2048-bit key certificates.
- Use relative URLs for resources that reside on the same secure domain.
- Use protocol relative URLs for all other domains.

_Why:_
> If you want to know more about SSL I recommend you read the [following answer](https://security.stackexchange.com/questions/6290/how-is-it-possible-that-people-observing-an-https-connection-being-established-w/6296#6296).

#### Flash

Avoid **Flash** content or pages. They are not accessible on mobile phones and will be ranked lower.

#### iFrames

Ensure there are **no content in iFrames**. Frames can cause problems for search engines because they don't correspond to the conceptual model of the web. 

> Learn more [here](https://support.google.com/webmasters/answer/34445?hl=en) and [here](https://developers.google.com/speed/docs/insights/rules).

#### Page Speed

Page speed is a measurement of how fast the content on your page loads. You can evaluate your page's speed with [Google's PageSpeed Insights.](https://developers.google.com/speed/pagespeed/insights/) Google has indicated page speed **is one of the signals used by its algorithm to rank pages**.

Some of the many ways to increase your page speed are:

- Use **Gzip**, a software application for file compression, to reduce the size of your CSS, HTML, and JavaScript files. [Read more...](https://developers.google.com/speed/docs/insights/EnableCompression)
- **Minify CSS, JavaScript, and HTML**. [Read more...](https://developers.google.com/speed/docs/insights/MinifyResources)
- Remove **render-blocking JavaScript**. [Read more...](https://developers.google.com/speed/docs/insights/BlockingJS)
- Leverage **browser caching**. [Read more...](https://developers.google.com/speed/docs/insights/LeverageBrowserCaching)

_Why:_
> Page speed is a measurement of how fast the content on your page loads. [Read more...](https://moz.com/learn/seo/page-speed)

### 2.2 Content

#### General

Content is the most important thing in SEO. Keep in mind:

- New content is important! **Keep your page active** and Google will reward it.
- Content should **not have orthographic or serious grammatical errors**.
- All your pages should have **at least 300 words**. If your web has less content, is it really necessary?
- **Text/HTML ratio** is not a direct ranking factor for search engines but there are many factors related to the ratio that indicate best SEO practices and thus may indirectly result in higher search rankings. A good text to HTML ratio is about from 25 to 70 percent.

#### Title

This element especifies **the title of a webpage**. Title tags are displayed on search engine result pages (SERPs) as the clickable headline for a given result, and are important for usability, SEO, and social sharing.

- Is about **50-60 characters long**, including spaces.

- Is concise and **contains your best keywords**.

- Each page should have its own **exclusive title**.

- Here you can find an (snippet optimizer)[http://www.seomofo.com/snippet-optimizer.html] that allows you to see how your titles look on Google and other search results.

Example:

```html
<title>Title of the document</title>
```

_Why:_
> Title tags are a major factor in helping search engines understand what your page is about, and they are the first impression many people have of your page. [Read more...](https://moz.com/learn/seo/title-tag)

#### Images

Almost every content has to have an image in it. But, how this affect SEO? Well, without the proper optimization, however, you’re wasting a valuable SEO asset. Plus, the larger the file size, the longer it takes your page to load, and the higher your bounce rate will be.

- Be sure that your images are no larger than they need to be and that they are in the right file format.
  _Why:_
  > Your page's load time will vary based on the number and size of your assets.

- All images must have an `alt` attribute implemented that describes its content.
  The alt text describes what’s on the image and the function of the image on the page.
  Alt tags will be displayed in place of an image if an image file cannot be loaded.
  For example:
  ```html
  <img src="painting-coolidge-dogs.gif" alt="Dogs' group playing poker around a table">
  ```
  _Why:_
  > ALT text attaches a description to your pictures so that they show up in Google and other search engine's image results. [Read more...](https://moz.com/learn/seo/alt-text)

- You have a **Favicon**. This is the icon that you can see next to the title in your browser's tab.
- SVG is the best choice if the image is not a picture, an icon for example.

Here you can find some image optimizers that will help you:

- [TinyPNG](https://tinypng.com/).
- [SVGOMG](https://jakearchibald.github.io/svgomg/).

### 2.3 Meta-tags

Meta-tags describe a page's content; they don't appear on the page itself, but only in the page's code. 

#### Meta content type

This tag is necessary to declare your character set for the page and <u>should be present on every page</u>. For example:

  ```html
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
  ```

_Why:_
> Leaving this out could impact how your page renders in the browser.

#### Meta descriptions

It explains to search engines and searchers themselves what your page is about. Describes the page to searchers as they read through the SERPs.

- Should be 160 - 300 characters long. Keep in mind that the "optimal" length will vary depending on the situation, and your primary goal should be to provide value and drive clicks.
- Is concise and contain your best keywords.
- Each page should have its own meta description.
- Don't include double quotation marks

_Why:_
> [Learn more...](https://moz.com/learn/seo/meta-description)

#### Viewport

Be sure your page has a viewport meta tag value compatible with most of mobile browsers. For example:

```html
  <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
```

_Why:_

> A viewport controls how a webpage is displayed on a mobile device. Without a viewport, mobile devices will render the page at a typical desktop screen width, scaled to fit the screen. Setting a viewport gives control over the page's width and scaling on different devices. [Read more...](https://developers.google.com/web/fundamentals/design-and-ux/responsive/#set-the-viewport)

#### Keywords
**These days Google doesn’t use meta keywords in its ranking algorithm at all**, because they're too easy to abuse. Years ago, marketers eager for page views would insert keywords totally unrelated to their pages into their code in an attempt to pirate traffic from the more popular pages. This was known as "keyword stuffing." Google eventually got wise to this and decided in the end to devalue the tool.

So, how to implement keyword tags in your page? Simple, don't do it.

#### Structured data

In an SEO context, "structured data" usually refers to implementing some type of markup on a webpage, in order to provide additional detail around the page’s content.

This markup improves the search engines’ understanding of that content, which can help with relevancy signals and also enables a site to benefit from enhanced results in SERPs (rich snippets, rich cards, carousels, knowledge boxes, etc). 

[Schema.org](http://schema.org/) is the result of collaboration between Google, Bing, Yandex, and Yahoo! to help you provide the information their search engines need to understand your content and provide the best search results possible at this time. Adding Schema markup to your HTML improves the way your page displays in SERPs by enhancing the rich snippets that are displayed beneath the page title.

If you want to learn more about how to implement Structured Data in your webpage, please visit [Google Developers Site](https://developers.google.com/search/docs/guides/prototype).

You can validate your markup with Google's [Structured Data Testing Tool](https://search.google.com/structured-data/testing-tool/u/0/).

### 2.4 Structure

#### Headings

>  *“We do use H tags to understand the structure of the text on a page better”* John Mueller, Google 2015

The six heading elements, H1 through H6, denote section headings, with **H1 as the most important and H6 as the least**. The H1 tag is the most important heading because it’s the highest level tag that shows **what your specific page is about**.

Although the order and occurrence of headings is not constrained by the HTML DTD, documents should not skip levels (for example, from H1 to H3), as converting such documents to other representations is often problematic.

You have to keep in mind that headings implementation is one of the more highlighted elements in SEO.

Try to follow these rules:

- Your website should have only one H1 tag per page or one H1 per `<section>`. Your H1 tag should help your reader understand what the page is about.
- Your H1 tag should contain your most important keywords for that page. These should also match the page title keywords and META keywords.
- There are no pages without an H1.

#### Write valid code

Ensure your code has valid markup. You can use the following tools for that:

- [HTML Validator](https://validator.w3.org/).
- [CSS Validator](https://jigsaw.w3.org/css-validator/).

Keep in mind, W3C validation is not the "SEO magic bullet" to achieve high positions. A good HTML syntax does not ensure you a good place in Google SERPs, but a bad syntax move us away them.

#### Pagination

Pagination is used to improve user experience. Instead of serving a lengthy page of results, it presents several smaller pieces (and arguably the most relevant first) that are easier to consume. Another advantage is that shorter pages load faster. But it can sometimes cause problems for search engines, if it is not correctly implemented.

Implement the `rel="next"` and `rel="prev"` attributes. We can use these elements to specify a relationship between multiple URLs. 

[Read more...](https://webdesign.tutsplus.com/articles/helping-search-engines-handle-pagination--webdesign-10035)

### 2.5 Accessibility

#### Status code errors

- **1XX:** These are informational codes and they indicate a provisional response, you should very rarely explicitly send a 1xx response.
- **2XX:** These are success messages, this is what will be returned by default when a web page is successfully served up.
- **3XX:** These are all redirection messages. This means that the client needs to perform an additional action in order to correctly complete the request. For more information go to [Reditections section](#redirections).
- **4XX:** These are all client error messages. The most well known of these is the 404 message, but there are others, which I will get into in more detail later.
  - **Provide a 403 error page** (access denied).
  - **Provide a 404 error page** (Page not found).
- **5XX:** These are all server error messages. Ensure your page does not return 500 errors.

#### Sitemap

I should start with this, Google does not index your pages because you asked for it. Google indexes pages because it founds them and considers them them good enough to be indexed.

Sitemaps are machine readable URL submission lists in various formats, e.g., XML or plain text. It’s like an archive of every webpage in your website. **Use your sitemaps as sleuthing tools to discover and eliminate indexation problems**, and only let/ask Google to index the pages you know Google is going to want to index.

Sitemaps are part of Robots Exclusion Protocol (REP), which we will cover in some lines.

- If you’ve got a big site, use dynamic sitemaps. You can use plugins for this, for example: [DynamicSitemaps (RoR)](https://github.com/lassebunk/dynamic_sitemaps).
- Don't include pages in your sitemap that are blocked by robots.txt or have set meta robots `'noindex,follow'`.

 [Read more...](https://moz.com/blog/xml-sitemaps)

#### Canonical Tag
Canonical URL **allows you to tell search engines that certain similar URLs are actually one and the same**. Sometimes you have products or content that is accessible under multiple URLs, or even on multiple websites. Using a canonical URL (an HTML link tag with attribute rel=canonical) these can exist without harming your rankings.

You should use www or not in your web site’s canonical hostname? For SEO **it really doesn’t matter at all as long as you choose one**. For example:

- https://www.my-page.com

- https://my-page.com

What do you have to do to set the canonical URL?

1. First, you pick one of your two pages as the canonical version. It should be the version you think is the most important one.
2.  Add a `rel=canonical` link from the non-canonical page to the canonical one in the `<head>` section.

```html
<link rel="canonical" href="https://www.my-page.com/">
```

_Why:_

> This method help us to prevent problems caused by identical or "duplicate" content appearing on multiple URLs. [Read more...](https://moz.com/learn/seo/canonicalization)

#### URLs

Search engines and visitors can interact with your website more effectively when you implement URLs that describe your pages content.

- URLs should not be grater than 100 charaters.
- Avoid using more than 3 levels in your URLs. What I mean with level? https://yourdomain.com/level1/level2/level3.
- URLs must be human-readable. They have to describe page content and include keyword in it. For example:
  - BAD: https://yourdomain.com/12345.
  - GOOD: https://yourdomain.com/how-to-implement-good-seo-strategy.
- There are no params in the URL, this can be setup in Google Search Console.

_Why:_
> URLs are extremely vital to your SEO campaign. Be sure to use URLs that make it easy for Google to index your site. [Read more...](https://support.google.com/webmasters/answer/6080548?visit_id=0-636594791880851880-2150656090&hl=en&rd=2)

#### Redirections

A redirect is a way to send both users and search engines to a different URL from the one they originally requested. The three most commonly used redirects are 301, 302, and Meta Refresh.

It is important to highlight some facts about them: 

- **All redirects carry a degree of SEO risk**.
- While 3xx redirects preserve PageRank, 301s remain the preferred method of choice for permanent redirects.
- Beyond PageRank, all other rules about redirection remain. If you redirect to a non-relevant page, or buy a website in order to redirect 1,000 pages to your homepage, you likely won’t see much of a boost.
- Successful migrations to HTTPS are now less prone to lose PageRank.
- **The best redirect is where every other element stays the same, as much as possible, except for the URL.**

> What means each redirection? [Read more...](https://moz.com/learn/seo/redirection)

#### Robots Exclusion Protocol (REP)

The Robots Exclusion Protocol (REP) is a conglomerate of standards that regulate Web robot behavior and search engine indexing. Despite the "Exclusion" in its name, the REP covers mechanisms for inclusion too.

Some of this mechanisms are: robots.txt, rebots meta elements, microformat relationship-nofollow and sitmaps. We can divide them in two groups:

- **Crawler directives:** *(robots.txt, sitemaps)* Suggest to crawlers what they should crawl and must not crawl. 


- **Indexer directives:** *(REP tags, microformats)* Require crawling.

There’s an important but subtle difference between using **meta robots** and using **robots.txt** to prevent indexation of a page. Using meta robots "noindex,follow" allows the link equity going to that page to flow out to the pages it links to. If you block the page with robots.txt, you’re just flushing that down the toilet.

_Why:_

> This is a very complex topic, so I recommend you to [read more...](https://developers.google.com/analytics/solutions/)

### 2.6 Social networks

#### Social sharing buttons

Social networks may not play direct role in ranking your site. But social shares generate more eyes focusing on your content, and the more people you attract, the more likely someone is to link. 

_Why:_
> A study by [BrigthEdge](https://www.brightedge.com/) found that prominent social sharing buttons can increase social sharing by 700%. [Read more...](https://blog.hubspot.com/blog/tabid/6307/bid/24994/using-social-sharing-buttons-leads-to-7x-more-mentions-data.aspx)

#### The Open Graph

The Open Graph protocol enables any web page to become a rich object in a social graph. For instance, this is used by Facebook to allow any web page to have the same functionality as any other object from Facebook.

You can validate your markup with the [Facebook Object Debugger tool](https://developers.facebook.com/tools/debug/og/object/?q=https%3A%2F%2Fwww.wolox.com.ar%2Fmobile.html).

_Why:_
> For more information, see [The Open Graph protocol](http://ogp.me/).

#### Twitter Cards

With Twitter Cards, you can attach rich photos, videos and media experience to Tweets that drive traffic to your website.

You can validate your cards with the [Twitter Card validator tool](https://cards-dev.twitter.com/validator).

_Why:_
> For more information see [Twitter documentation](https://dev.twitter.com/cards/overview).
