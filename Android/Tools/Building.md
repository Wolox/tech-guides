# Building

**The following file documents possible modifications for building Android
projects.**

## Table of contents
* [Run Gradle daemon](#topic1)
* [Enable incremental DEX building](#topic2)

## <a name="topic1"></a> Run Gradle daemon
Keeps Gradle running in the background as a daemon.
This may speed up compilation times.

### Procedure
1) Go to the project's Gradle properties file (**NOT** the module's Gradle file)

![gradle-properties](https://cloud.githubusercontent.com/assets/4109119/18404876/c58823bc-76c3-11e6-961d-7d3a744fc750.jpg)

2) Place the following code:

```groovy
org.gradle.daemon=true
org.gradle.jvmargs=-Xmx1024m -XX:MaxPermSize=256m -XX:+HeapDumpOnOutOfMemoryError -Dfile.encoding=UTF-8
```
**Note:** The second line specifies how much memory will be allocated for the daemon
process. Use a suitable value according to your computer's RAM memory size.
Don't use too much, remember that you will need memory for Android Studio as well.

## <a name="topic2"></a> Enable incremental DEX building
Enables incremental building of Android's DEX files.
This may speed up compilation times.

### Procedure
1) Go to the app's module Gradle file (the same file used for dependencies)
2) Place the following code:

```groovy
dexOptions {
  incremental true
}
```
