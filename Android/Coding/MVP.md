**WOLOX - ANDROID**

#MVP / Android

## Purpose
This guide covers the basics to work using the Model-View-Presenter pattern in Android.

## Table of contents

1. [What's the main idea?](#topic-main-idea)
2. [Sample code](#topic-sample-code)

##<a name="topic-main-idea"></a> What's the main idea?

**Model:** This is the well known model, present in many of the most common patterns and use cases. It represents the world we are working with, every real world element that our app should know how to represent. Both the _View_ and the _Presenter_ are aware of this model and they know how to use its properties and methods.

**View:** In Android our views are our `Fragment` and `Activity` classes that we are using, they are able to alter the UI as we need and in most cases they need to receive structured data from a source in order to populate themselves. Previously in our code, this data was obtained directly from services which allow us to make Async calls directly from our _View_ classes having both our UI and data fetching code in our View classes, **this had to change**.

In order to have a better and cleaner code we introduce a third layer in this called _Presenter_ which will be in charge of everything related with our business logic leaving only UI logic to the _View_ classes. _Just as it should be_.

**Presenter:** This layer, introduced here, is **implemented with native java code** meaning it doesn't need to know whether it's used in an Android application or a web service. _How does this work with our structure previously described?_ Easy, what we are going to add to each view is a simple interface which defines the actions it needs to do in communication with another service (usually a data providing one).

Now the presenter only needs to know which are this methods and what kind of information are they expecting regardless of how this affects our UI, **this will be decided by the _View_ classes**.

##<a name="topic-sample-code"></a> Sample code

Here is a very simple code snippet showing how this works and how it should be used to keep your code as simple as possible

```java
/**
 * Interface view for {#UsersFragment}
 */
public interface UserView {

    void onUserLoadSuccess(User user);

    void onUserLoadError(Exception e);

}
```

```java
/**
 * Fragment that obtains a user and loads it's data in the fragment
 */
public class LoginFragment extends WoloxFragment<UsersPresenter> implements UsersView {

    // layout(), setListeners() and init() code...

    @Override
    protected void populate() {
        // This presenter is obtained from the superclass
        presenter.loadUser(/* User id */);
    }

    @Override
    protected LoginPresenter createPresenter() {
        return new UserPresenter(this, getActivity());
    }

    @Override
    public void onUserLoadSuccess(User user) {
        // Populate view with user data
    }

    @Override
    public void onUserLoadError(Exception e) {
        // Let the user know that something went wrong
    }
}
```

```java
/**
 * Presenter for user view
 */
public class UserPresenter extends BasePresenter<UserView> {

    LoginPresenter(UserView view, Context context) {
        super(view, context);
    }

    public void loadUser(long userId) {

        // Make API call to get user data.
        Call<User> call = Application.userService.getUser(userId);
        call.enqueue(new WoloxCallback<User>() {

            @Override
            public void onSuccess(User response) {
                getView().onUserLoadSuccess(response);
            }

            @Override
            public void onCallFailed(ResponseBody responseBody, int code) {
                getView().onUserLoadError(new IllegalArgumentException("Invalid user"));
            }
        });
    }

}
```
