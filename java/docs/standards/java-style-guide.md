# Standards 

## Code style 

#### IntelliJ Save Action Plugin
We use the IntelliJ Save Action plugin to format the code on save, organize imports
and methods.

Follow these instructions to install it:
1. Go to File > Settings > Plugins.
2. Search for plugin “Save Actions” and click install.
3. Search for “Save Actions” in the panel Settings and configure it as follows:

![save actions](https://image.ibb.co/jxeOCf/save-actions.png)


https://plugins.jetbrains.com/plugin/7642-save-actions

#### Google xml Code Style

We follow the Google Java code style and the best way to adhere it is
using the IntelliJ automatic formatter.
To accomplish this we need to configure the code style in IntelliJ using
the google xml code style configuration file.

You can find the xml file here
https://github.com/google/styleguide/blob/gh-pages/intellij-java-google-style.xml

And follow these instructions to import it:
1. Download the .xml.
2. Go to File > Settings > Editor > Code style.
3. Import the .xml:
4. Go to the Java section and change the indent size to 4.

![code style](https://image.ibb.co/jRB9k0/code-style.png)


#### SonarLint installation in IntelliJ
A linter is a tool that can be used to analyze source code and flag errors, bugs, style errors, etc.
SonarLint is a plugin for IntelliJ that exists with this purpose. In order to configure it, follow
these instructions:
1. Go to File > Settings > Plugins.
2. Search for plugin "Sonarlint" and select "Browse repositories". The following screen will appear:

![sonarlint plugin](https://image.ibb.co/gvDxsf/sonarlint1.png)


The tool will be automatically configured in IntelliJ. When writing code, some problematic sections
will be highlighted and the tool will provide suggestions to fix the potential bugs.

![sonarlint highlight](https://image.ibb.co/bFriXf/sonarlint2.png)


The tool can be customized by changing highlight colors if desired. To do this go to
File > Settings SonarLint:

![sonarlint colors](https://image.ibb.co/b5O8yL/sonarlint3.png)
