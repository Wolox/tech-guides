# Wolox Mobile Convention Naming

At Wolox we use conventions for naming projects and identifiers, as `Bundle ID` for `iOS` projects and `Application ID` for `Android`.

This convention, even though is very simple, has a critical impact in the project development, given we use scripts which read these properties and expect consistent values.

Moreover, we all love conventions and consistency for working.

### **Naming projects:**

For naming projects we use ["upper camel case"](http://wiki.c2.com/?UpperCamelCase). Don't ever add spaces, they don't get along well with our scripts.

Example:

- For single word projects like "Project", it should be named "Project".
- For multiple word projects like "My Project", it should be named "MyProject".

### **Naming identifiers:**

For naming identifiers we use the convention suggested for `iOS` in [this link](https://developer.apple.com/library/content/documentation/General/Reference/InfoPlistKeyReference/Articles/CoreFoundationKeys.html#//apple_ref/doc/uid/20001431-102070) and for `Android` in [this link](https://developer.android.com/studio/build/application-id.html).

Both of them are compatible. In particular at `Wolox` we use "com.Wolox.ProjectName".

Example:

- For single word projects like "Project", it should be named "com.Wolox.Project".
- For multiple word projects like "My Project", it should be named "com.Wolox.MyProject".

### NOTE:

When configuring an `iOS` project (both for native and react native) this `bundle ID` will be set depending on the `build configuration`.

For `iOS` projects, the base project contains 4 build configurations, and for `React Native` projects we use 2 build configurations (a subset of the native ones). For each of them we use a prefix to be appended after the `bundle ID`:

- `Debug`: ".debug", example: "com.Wolox.ProjectName.debug"

We use this `build configuration` for developing the applications in the local developer environment, and for running the tests in continuous integration environment.

- `Alpha`: ".alpha", example: "com.Wolox.ProjectName.alpha"

We use this `build configuration` for deploying the applications in `Wolox`s Itunes Connect account. These deploys are used for sending builds to `Wolox` QA (Quality Assurance).

- `Release`: "", example: "com.Wolox.ProjectName"

We use this `build configuration` for deploying the applications in `Wolox`s Itunes Connect account. These deploys are used both for sending the applications to beta testing for external testers (in case the application has an external client), or for sending the application public in the App Store (in case the application is `Wolox` internal).

- `Production`: "", example: "com.ProjectName.ProjectName"

For `Production` we use no prefix, and we do not use `Wolox` as part of it, instead we use the name of the project. In case the applications is `Wolox` internal this configuration will not be used.

We use this `build configuration` for deploying the applications in client's Itunes Connect account. These deploys are used for sending the application public in the App Store (in case the application is not `Wolox` internal, and has an external client instead).

Only take into account those present in your project. Depending on the technology you are developing your project includes the necessary `build configuration`s. 

You can check which of them are present by going to your project name, in the root of the left project navigator. Once there, enter your project once again under the title "PROJECTS" in the left bar deployed. The `build configuration`s are listed in the tab "Info", under "Configurations".

### NOTE 2: 

For iOS native projects these `bundle ID`s will end up this way by following the [iOS Kickoff guide](../iOS/docs/kickoff/README.md)

### NOTE 3: 

There is a validation in `Fastlane` scripts that will ensure the `bundle ID`s are properly configured.
