This is a guide to setup rollbar for and account and projects.

## Account

You can create a new rollbar acount with your user by entering [here](https://rollbar.com/account/create/)

The account name should be in CamelCase and separated by `-`. For example `My-Account`.

In this account you will create all the different projects. For example, API, Android, iOS.

## Teams

Before creating the different projects you need to create two teams:

1 - Owner: Add the Project Arquitect, TM, clients and infraestructura@wolox.com.ar

2- Wolox: Add Developers

## Projects

Once you have the teams created you need to create the different projects. For this always use: AccountName-Tech. Where AccountName is the same name you put to the account, and Tech the technology of the server. For example:
- API: My-Account-API
- iOS: My-Account-iOS
- Android: My-Account-Android
- RN: My-Account-RN

and so on..

After you created the different projects, you need to share the server or clients access tokens to the team. Take into account that the same token should be used for all the environments, so its important to setup the servers correctly.
