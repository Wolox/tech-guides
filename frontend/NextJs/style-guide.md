# Next.js Style Guide

## Table of Contents

1. [Basic Rules](#basic-rules)
1. [Folder Structure](#folder-structure)
1. [Fetching Data](#fetching-data)
1. [Api Routes](#naming)
1. [SEO](#mixins)

## Basic Rules

- If you are not using our Next.js Boostrap, make sure your the next.config.js
  file include pageExtensions as follows
  ```js
  module.exports = {
    pageExtensions: ['page.tsx', 'api.ts'],
  }
  ```
- Only include one index.page.tsx component per page.
- Always use JSX syntax.

## Folder Structure

```
└───locales //folder to i18n per page
│ └─── es
│     └─── home.json
│     └─── myscreenpage.json
│     └───etc
│ └─── en
│     └─── home.json
│     └─── myscreenpage.json
│     └───etc
│
└───components
│ └───baseComponents
│     └───Input
│     └───Text
│     └───Button
│     └───etc
│
└───pages
│   | index.page.tsx // root or hoem page.
│   └───api
│   │   └───MyServerlessApi
│   │       | index.api.tsx
│   └───MyScreenPage
│       | components/
│       | constants.ts
│       | index.page.tsx
│       | styles.module.scss //only if you are using css modules.
│       | utils.ts
│       | assets // Screen specific app assets
│
└─── public
│ └─── assets
|
└───config
    | api.ts
└───constants
└─── store (Redux/Contex/Recoil)
│   | store.ts
│   └───myReducer
│       | actions.ts
│       | reducer.ts
│       | selectors.ts
└─── hooks
└─── types
└─── services
    | MyService.ts
└───utils
│   index.ts
```

## Fetching Data

Next.js allows you to fetch data in different ways, depending on your needs and
preferences.

- **getStaticProps**: The getStaticProps function is executed on the server side
  is compiled, and allows you to retrieve data from an external API or any other
  source and pass it as properties to the component. This function is util when
  we need to have some pages prebuilt like **blogs**, or **lading
  pages**.<br /><br />

  ```js
  function MyComponent(props) {
    return (
      // Use the retrieved data as component props
      <div>{props.data}</div>
    )
  }

  export async function getStaticProps() {
    // Retrieve data from the external API using the Fetch API
    const res = await fetch('https://my-api.com/datos')
    const data = await res.json()

    // Pass the data as props to the component
    return {props: {data}}
  }
  ```

- **getServerSideProps**: The getServerSideProps function, which is executed on
  the server side every time a page is accessed, to fetch data and pass it to
  the component as properties. yop can also get the query parameters in the URL
  as request parameters.<br /><br />

  ```js
  function MyComponent(props) {
    return (
      // Use the retrieved data as component props
      <div>{props.data}</div>
    )
  }

  export async function getServerSideProps(context) {
    // Retrieve data from theexternal API
    const res = await fetch.get('https://mi-api.com/datos', {
      params: context.query,
    })
    const data = res.data

    // Pass the data as props to the component
    return {props: {data}}
  }
  ```

In addition to **getStaticProps** and **getServerSideProps**, in Next.js you can
also use other external tools and libraries to fetch data, such as react-query
or the Fetch API. You can also use the React useEffect function to fetch data
when a component is mounted, and then store the data in the component's state so
that it can be used in your user interface.

## API Routes

In Next.js API routes are a way to build server-side logic for handling
asynchronous requests in a Next.js application. They allow you to create
endpoints that can be used to retrieve or update data, perform tasks, or
communicate with external APIs. These routes are typically used to handle
server-side logic and are not intended to be used for rendering traditional web
pages. API routes in Next.js are implemented as special files in the /pages/api
directory of your application. Each file in this directory represents a separate
API endpoint and can export a default function that will be invoked when a
request is made to that endpoint. For example, you might create an /api/users
endpoint to handle requests related to retrieving, updating, and deleting user
data. This endpoint could then be used to perform database queries or call
external APIs to retrieve the necessary data and return it to the client in a
JSON. Here is an example of an API route in Next.js that returns a list of users
in JSON format: // pages/api/users.js

import users from './data/users.json';

export default (req, res) => { res.status(200).json(users); } This API route
exports a default function that is invoked when a request is made to the
/api/users endpoint. The function uses the res object to send a JSON response to
the client with a list of users. You can then make a request to this endpoint
from your front-end code using a tool like fetch. For example:

```js
fetch('/api/users')
  .then(res => res.json())
  .then(data => console.log(data))
```

This will send a GET request to the /api/users endpoint and log the response
data to the console.

## SEO

In Next.js you can improve the SEO of the websites using some
[pre-rendering modes](#fetching-data) this modes will we could to get a document
HTML optimized for the web crawler and indexers.

- **Prerendering modes**:

  - Static Generation: HTML is only generating during build time.

  - Server-side Rendering: HTML is generating on each reques.<br /><br />

- **Head Component**: Next.js provides a built-in component called ‘Head’, which
  helps to append different elements such as title tag, meta tag etc. to the
  <head> part of the document. You can import it from next/head.<br /><br />

  ```js
  import Head from 'next/head'

  function IndexPage() {
    return (
      <div>
        <Head>
          <title>My page title</title>
          <meta name="description" content="This is my page description" />{' '}
        </Head>
        <p>Hello world!</p>{' '}
      </div>
    )
  }

  export default IndexPage
  ```

  Head Component makes sure all of your pages include important details like
  title, description etc. that need to get rendered into your page. Next.js
  recognises this metadata and lift it to the right location in your HTML
  document when the page is being rendered. It helps in improving SEO.

<!-- https://medium.com/scalereal/how-next-js-helps-to-improve-seo-ffeff36e9fdd -->
