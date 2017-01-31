**WOLOX - ANDROID**

#Code review guide / Android

## Purpose
The following guide indicates the main elements that are taken into account during the Code Review process for the Android platform.

## Table of contents

1. [Java Linter](#topic-java-linter)
2. [Layout linter](#topic-layout-linter)
3. [Variables naming](#topic-variables-naming)
4. [Building in the CI server](#topic-building-in-the-ci-server)
5. [Test coverage](#topic-test-coverage)
6. [Identifiers naming](#topic-identifiers-naming)
7. [Classes naming](#topic-classes-naming)
8. [Interfaces naming](#topic-interfaces-naming)
9. [Project structure](#topic-project-structure)
10. [Usage of Android's annotations](#topic-android-annotations)

### <a name="topic-java-linter"></a> 1) Java Linter
Before creating a new Pull Request the Java linter must be executed locally. In case the result of the linter is not satisfactory, the developer must make the necessary modifications to adjust the style of the code to the standard that we use in Wolox.
Bare in mind that the Java linter may be configured on the CI server, and the PR can not be approved until it does not pass the linter requirements.

### <a name="topic-layout-linter"></a> 2) Layouts Linter
The attributes of Views and ViewGroups present in layouts should be sorted as follows:

1. `android:id = “...”`
2. `android:layout_xxx = “...”`
3. `Any other attribute`

*Automation in Android Studio: Code / Reformat Code (can be configured if necessary from File / Settings)*

### <a name="topic-variables-naming"></a> 3) Variables naming
Hungarian notation is used to name the variables in camelCase format for variables and capital letters with underscores for constants.

* Instance variables (member): `private Class mOneVariable;`
* Class variables (static): `private static Class sAnotherVariable`
* Constants: `public static final String A_CONSTANT = "My  Constant";`

Note that variables that are collections (typically arrays or implementations of List) must have identifiers in plural form. Examples: mUsers, mNews.

*Automation in Android Studio: File / Settings / Editor / Code Style / Java, "Code Generation" tab and write "m" in Field / Name Prefix and "s" in Static Field / Name Prefix*

### <a name="topic-building-in-the-ci-server"></a> 4) Building in the CI server
If a CI server is configured, the app must be able to be successfully compiled on each new PR.

### <a name="topic-test-coverage"></a> 5) Test coverage
If a CI server is configured, the changes introduced in the PR must comply with the minimum coverage percentage established for the project.

### <a name="topic-identifiers-naming-"></a> 6) Identifiers naming
The names of all the resources IDs must indicate their location and / or functionality within the project uniquely. Spaces are defined with underscores.

Examples:

|            Element           |                        ID                       |
|:----------------------------:|:-----------------------------------------------:|
| Activities/Fragments Layouts | fragment_login<br> activity_login                   |
| Strings                      | login_email<br> login_password                      |
| Views                        | fragment_login_myButton<br> activity_login_myButton |
| Layouts (ViewGroups)         | fragment_login_myLayout<br> activity_login_myLayout |
| Dimens                       | dimen_small<br> dimen_medium<br> dimen_big<br>              |
| Font Sizes                   | font_small<br> font_medium<br> font_big  <br>               |
| Radious                      | radious_small<br> radious_medium<br> radious_big<br>        |

### <a name="topic-classes-naming"></a> 7) Classes naming
Class names must be descriptive and written in UpperCamelCase, with the format FunctionalityType.

Examples:

|       Class      |      Name      |
|:----------------:|:--------------:|
| Activities       | LoginActivity  |
| Fragments        | LoginFragment  |
| Presenters (MVP) | LoginPresenter |
| Views (MVP)      | iLoginView<br> Note: MVP Views are interfaces     |
| Model (MVP)      | User           |

<br>
Note: The models are not accompanied by their function, it is implicit (that is, they are not named User Model).

### <a name="topic-interfaces-naming"></a> 8) Interfaces naming
Interfaces must have the prefix `I`, which allows them to be identified quickly. This also increases productivity with the search function or the IDE's autocomplete feature.

Note: This requirement covers both the interfaces used in MVP (for views) and any other interface used in the project.

### <a name="topic-project-structure"></a> 9) Project structure
The project's structure must be configured in __packages by functionalities and not packages by type__. This allows the structure to be more scalable and a new developer to the project can locate the functionalities quickly to make changes.

#### Example of a correct structure (ordered by functionality)
```
  app/
      models/
      utils/
      customViews/
      features/
          home/
          auth/
              login/
              signup/
                  SignupPresenter
                  ISignupView
                  SignupFragment
                  SignupRecyclerAdapter
                  SignupActivity
```

#### Example of an incorrect structure (ordered by type)
```
  app/
      models/
      utils/
      activites/
          SignupActivity
      adapters/
          SignupRecyclerAdapter
      fragments/
          SignupFragment
      interfaces/
          ISignupView
      presenters/
          SignupPresenter
```

### <a name="topic-android-annotations"></a> 9) Usage of Android's annotations
Android's SDK provides a number of useful annotations that can be used to provide
more clarity when implementing methods. Additionally, this annotations will be
check by Android Studio, enforcing type safety.
The following annotations will be required in every `public` method of the project,
specially in Presenters.

* `@Nullable`: The value may be null
* `@NonNull`: The value cannot be null
* `@StringRes`: The value must be a string resource (`R.string.xxx`)
* `@ColorRes`: The value must be a color resource (`R.color.xxx`)
* `@ColorInt`: The value must be a color integer (`RRGGBB` or `AARRGGBB`)
* `@DimenRes`: The value must be a dimen resource (`R.dimen.xxx`)

#### Example

```java
@NonNull      // Indicates that the following method cannot return Null
@Override
public MyClass myAnnotatedMethod(
              String aSimpleString,                 // eg: "Hello World"
              @StringRes anIdOfAResourceString,     // eg: R.string.myString
              @NonNull Context context,             // eg: A non null Android's context
              @Nullable Integer myNullableValkue) { // eg: null or 123

  return ... // return something that is not null

  }
```

Additional annotations that can be useful:
* `@CheckResult`: Warns the caller if the result value is not being used
* `@CallSuper`: Enforces the caller to call `super` before implementing anything else

More info about Android's annotations can be found [here](https://developer.android.com/studio/write/annotations.html)
