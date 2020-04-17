# Google Assistant with Dialogflow

## Description

[Google Assistant](https://developers.google.com/assistant) is an artificial intelligence-powered virtual assistant developed by Google that is primarily available on mobile and smart home devices. We use [Dialogflow](https://dialogflow.com/), a Google-owned developer of human–computer interaction technologies based on natural language conversations that allows us to integrate with Assistant to create Agents quickly and easily.

## Implementation

Google Assistant with Dialogflow was used in Natura project.

### Backend

- At the [Google Actions Console](https://console.actions.google.com/) you have to create a new Action.

- Once the Action is created, go to [Dialogflow](https://dialogflow.cloud.google.com/) and create a new Agent. At Google Project select the Action you created in Google Actions Console.

- Now you have the Dialogflow Agent integrated with Assistant Action.

- At Intents delete the Default Welcome Intent. Now create a new intent, called "welcome". Add the "Google Assistant Welcome" Event, and enable webhook call for this intent at the bottom section Fulfillment. Save intent.

- Go to Integration section, enter in "Integration settings". Select "welcome" at Explicit invocation and click "Test". It updates your Action project for next step.

- Now you have to create a Function, the backend that will be deployed to Google Cloud Functions. Run `firebase init` at you folder project. Select "Functions: Configure and deploy Cloud Functions", then "Use an existent project". Select the project id from the list. Select JavaScript or TypeScript language, Eslint and if you want to install dependencies. It creates a "functions" folder with the Funciton.

- At "functions/index.js" insert this code below:

```
const functions = require('firebase-functions'),
	{ dialogflow } = require('actions-on-google'),
	app = dialogflow();

app.intent('welcome', conv => conv.ask(`¡Bienvenido a tu Action de Assistant!`));  

exports.dialogflowFirebaseFulfillment = functions.https.onRequest(app);
```

- Move to functions folder and install "actions-on-google" package with `npm install actions-on-google`.

- Execute `firebase deploy --only functions:dialogflowFirebaseFulfillment` to deploy the code at Google Cloud Functions.

- For some reason the deploy does not impact at first, you must go to Fulfillment at Dialogflow section, enable "Inline Editor", copy the same code at index.js and package.json from your function created before, and deploy in Dialogflow. When the deploy ends, you are able to change your first code at the folder you created first, and use the command `firebase deploy --only functions:dialogflowFirebaseFulfillment` to deploy it.

- Go to Overview tab at [Google Actions Console](https://console.actions.google.com/) and complete the Quick setup, you have to complete the Assistant Action name by which it will be invoked.

- Go to Test tab at [Google Actions Console](https://console.actions.google.com/) and start testing.

## Pain Points

- When you have to deploy the development to Production at Assistant, you need to pass the Google Review. They test all the flows and intents of the action. If you need to enter a code or some id in the conversation and you get a dynamic answer, they demand to use [Account linking](https://developers.google.com/assistant/identity), cause they think you are using some external API or service. To use Account Linking, you have to implement some login with Google Accounts or an external API with some web view.

- If your Action enables users to complete a transaction (physical goods or services and / or digital goods or subscription purchases) you have to implement the [Transactions API or Digital Purchase API](https://developers.google.com/assistant/transactions).

## Alternatives

- Amazon Alexa, is a virtual assistant AI technology developed by Amazon.

## References and Documentation

+ Questions? Go to [StackOverflow](https://stackoverflow.com/questions/tagged/actions-on-google), [Assistant Developer Community on Reddit](https://www.reddit.com/r/GoogleAssistantDev/) or [Support](https://developers.google.com/assistant/support).

+ For bugs, please report an issue on Bitbucket.

+ Getting started with [Actions SDK Guide](https://developers.google.com/assistant/actions/actions-sdk/).

+ Actions on Google [Documentation](https://developers.google.com/assistant)

+ Actions on Google [Codelabs](https://codelabs.developers.google.com/?cat=Assistant).
