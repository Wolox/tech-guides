# Android Studio

**The following file documents how to properly set up Android Studio to maximize
productivity.**

## Table of contents

* [Auto import](#topic1)
* [Automatic hungarian notation](#topic2)
* [Show line number](#topic3)
* [Auto fix code style errors in XML files](#topic4)

## <a name="topic1"></a> Auto import
Enables automatic imports and optimize dependencies.

### Procedure
*Paths may slightly differ between platforms (Linux, Mac OS, Windows)*

1) In the navigation menu, go to `Android Studio / Preferences`
2) In the side menu, select `Editor / General / Auto Import`
3) Check "Optimize imports on the fly"
4) Check "Add unambiguous imports on the fly"

## <a name="topic2"></a> Automatic hungarian notation
Enables automatic hungarian notation.

The hungarian notation works like this:
* Use `mVariable` for *member* (instance) variables
* Use `sVariable` for *static* (class) variables
* Use `CONSTANT` for constants

### Procedure
*Paths may slightly differ between platforms (Linux, Mac OS, Windows)*

1) In the navigation menu, go to `Android Studio / Preferences`
2) In the side menu, select `Editor / Code Style / Java`
3) In the tab menu, select `Code Generation`
4) In the `Field` row and `Name prefix` column, write "m"
5) In the `Static field` row and `Name prefix` column, write "s"

![hungarian-prefix](https://cloud.githubusercontent.com/assets/4109119/18405136/d86def0a-76c5-11e6-8bc9-c49fe245bf17.jpg)

## <a name="topic3"></a> Show line number
Displays a line counter next to the code editor.

### Procedure
*Paths may slightly differ between platforms (Linux, Mac OS, Windows)*

1) In the navigation menu, go to `Android Studio / Preferences`
2) In the side menu, select `Editor / General / Appearance`
3) Check "Show line numbers"

## <a name="topic4"></a> Auto fix code style errors in XML files
Automatically lint and fix code style errors in XML files.

### Procedure
1) Go to any XML file (layout, drawable, etc.)
1) In the navigation menu, go to `Code`
2) In the dropdown menu, select `Reformat Code`
