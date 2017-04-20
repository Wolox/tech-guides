## Navigation Drawer
**WOLOX - ANDROID**

# Shared Element Transition / Android

## Purpose
The purpose of this document is to explain the implementation of shared elements transitions
between activities

## Table of contents

1. [How it looks](#topic-how-it-looks)
2. [Creating a "NavigationUtils.Builder"](#topic-creating-a-navigationutils-builder)
3. [Setting up the views](#topic-setting-up-the-views)
4. [Setting up the "App Theme"](#topic-setting-up-the-app-theme)
5. [Extra considerations](#topic-extra-considerations)
5. [Sources](#topic-sources)

## <a name="topic-how-it-looks"></a>  How it looks
Let's start by how it looks!

![example animation](https://cloud.githubusercontent.com/assets/6062888/12004245/fb25adea-ab27-11e5-954f-e0320c91d804.gif)

As can be seen in the GIF, we can make any element/s shared by two activities move from the starting position in the first one to the ending position in the second one, making the transition between both of them more fluid.  

Fortunately, Android has a [framework](https://developer.android.com/training/transitions/overview.html) that allows us to achieve this type on animations with little work, and to make this even easier, there's a `Builder` class on `NavigationUtils` that facilitates this for us.  

## <a name="topic-creating-a-navigationutils-builder"></a>  Creating a `NavigationUtils.Builder`

To make an animation we can use the `NavigationUtils.Builder` class, that uses the `Builder` pattern and gives us a readable easy to use API to use these animations. There are a few methods:

- `setClass(Class clazz)` Sets the activity to be opened. This is the only mandatory field, if it's not called a `RuntimeException` will be thrown.
- `addSharedElement(View sharedView, String sharedString)` Adds a shared element. The `sharedView` is the view from the first activity to be animated and the `sharedString` is the string which was given to the view on the second activity as `transitionName` (more on this later).
- `addExtra(String reference, Serializable object)` or `addIntentObject(IntentObject intentObject)` Adds an extra to be sent in the intent that opens the activity.
- `jump()` Fires the created intent and opens the new activity with an animation (or normally if `addSharedElement` was never called)

#### Example (from the GIF on top)
```java
new NavigationUtils.Builder(getActivity())
    .setClass(FinishedMatchActivity.class)
    .addSharedElement(viewHolder.mAvatar,
        getString(R.string.transition_player_avatar))
    .addSharedElement(viewHolder.mName,
        getString(R.string.transition_player_name))
    .addSharedElement(viewHolder.mMatchDetails,
        getString(R.string.transition_match_log_details))
    .addExtra(Extras.MatchLog.MATCH_LOG, matchLog)
    .jump();
```

### Return animation

With the code above the animation from the first activity to the second will show. If we also want the reverse animation when returning, instead of calling `Activity.finish()` we must call `Activity.supportFinishAfterTransition()` to destroy the activity and go back.

## <a name="topic-setting-up-the-views"></a>  Setting up the views  

In order for the framework to know which two views are the shared ones, an attribute must be given to them in the XML code, `android:transitionName="@string/transition_name"` This transition name is the same we must then pass as parameter to the `NavigationUtils.Builder` when calling `addSharedElement(View sharedView, String sharedString)`. The `sharedString` must be the same as the `android:transitionName`. A setter method also exists to set the transition name programmatically if necessary.  

If the `sharedString` passed is null, `sharedView.getTransitionName()` will be used, which means both views would need to have the same transition name.

## <a name="topic-setting-up-the-app-theme"></a>  Setting up the `App Theme`

The last thing missing is to set up our default theme on `styles.xml`. All of this works only on API level 21 or above, which means we have to create a separate styles xml file under the folder `values-v21`. The `styles.xml` there must look something like this:
``` xml
    <style name="AppTheme" parent="Theme.AppCompat.Light.NoActionBar">

        ...

        <item name="android:windowContentTransitions">true</item>

        <item name="android:windowAllowEnterTransitionOverlap">false</item>
        <item name="android:windowAllowReturnTransitionOverlap">false</item>
        <item name="android:windowSharedElementEnterTransition">@android:transition/move</item>
        <item name="android:windowSharedElementExitTransition">@android:transition/move</item>

    </style>
```
The only mandatory item is the first one, `android:windowContentTransitions` as true, but the others can let us customize animations of all the app. There are more as well that can be looked up and added if wanted.

## <a name="topic-extra-considerations"></a>  Extra considerations

That's pretty much it! Following everything above you should be able to make shared element transitions between activities.  

Some custom views in some libraries *can* cause trouble though. A perfect example of this is the `SimpleDraweeView` of `Fresco` that we use so much. Since it overrides some methods from `ImageView` it doesn't work out of the box. However, there's an easy fix that involves extending the class and overriding a method. I called it `TranslateDraweeView` and the code for it can be found in this [gist](https://gist.github.com/gnardini/f1fe23dabd560a1837f6)  

There can also be trouble if trying to animate `TextView`s of different text size. A possible solution for it has been posted on [Stack Overflow](http://stackoverflow.com/questions/26599824/how-can-i-scale-textviews-using-shared-element-transitions) that can be checked out if something like this is needed.

## <a name="topic-sources"></a>  Sources

[Android Transition Framework](https://developer.android.com/training/transitions/overview.html)  
[Material Animations Gist](https://gist.github.com/lopspower/1a0b4e0c50d90fbf2379) by [lopspower](https://gist.github.com/lopspower)  
