# Wolox Mobile Convention Naming

In Wolox we use conventions for naming projects and identifiers, as `Bundle ID` for `iOS` projects and `Application ID` for `Android`.

This convention, even though is very simple, has a critical impact in the project development, given we use scripts which read these properties and expect consistent values.

Moreover, we all love conventions and consistency for working.

### **Naming projects:**

For naming projects we use ["upper camel case"](http://wiki.c2.com/?UpperCamelCase). Don't ever add spaces, they don't get along well with our scripts.

Example:

- For single word projects like "Project", it should be named "Project".
- For multiple word projects like "My Project", it should be named "MyProject".

### **Naming identifiers:**

For naming identifiers we use the convention suggested for `iOS` in [this link](https://developer.apple.com/library/content/documentation/General/Reference/InfoPlistKeyReference/Articles/CoreFoundationKeys.html#//apple_ref/doc/uid/20001431-102070) and for `Android` in [this link](https://developer.android.com/studio/build/application-id.html).

Both of them are compatible. In particular in `Wolox` we use "com.Wolox.ProjectName".

Example:

- For single word projects like "Project", it should be named "com.Wolox.Project".
- For multiple word projects like "My Project", it should be named "com.Wolox.MyProject".

### NOTE:

When configuring an `iOS` project (both for native and react native) this `bundle ID` will be set depending on the `build configuration`.

For `iOS` projects, the base project contains 4 build configurations, and for `React Native` projects we use 2 build configurations (a subset of the native ones). For each of them we use a prefix to be appended after the `bundle ID`:

- `Debug`: ".debug", example: "com.Wolox.ProjectName.debug"
- `Alpha`: ".alpha", example: "com.Wolox.ProjectName.alpha"
- `Release`: "", example: "com.Wolox.ProjectName"

For `Production` we use no prefix, and we do not use `Wolox` as part of it, instead we use the name of the project.

- `Production`: "", example: "com.ProjectName.ProjectName"

Only take into account those present in your project.

### NOTE 2: 

For iOS native projects these `bundle ID`s will end up this way by following the [iOS Kickoff guide](../iOS/docs/kickoff/README.md)

### NOTE 3: 

There is a validation in `Fastlane` scripts that will ensure the `bundle ID`s are properly configured.
