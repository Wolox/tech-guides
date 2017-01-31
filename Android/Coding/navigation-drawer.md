## Navigation Drawer
**WOLOX - ANDROID**

# Navigation Drawer / Android

## Purpose
Here I'll describe the basics to have a working Navigation Drawer, the way it was implemented in previous projects. All examples will be taken from [MatchMaker](https://github.com/Wolox/matchmaker-android) and are based on the official docs.

[Official Docs](http://developer.android.com/training/implementing-navigation/nav-drawer.html)

## Table of contents

1. [XML creation](#topic-xml-creation)
2. [Populate with elements](#topic-populate-with-elements)
3. [Opening and closing the drawer](#topic-opening-and-closing-the-drawer)
4. [What else?](#topic-what-else)
5. [Projects where it was used](#topic-projects)

##<a name="topic-xml-creation"></a> XML creation
You must create a `DrawerLayout` with exactly 2 childs. The first one is the actual view. Usually we have a toolbar and a container to be populated when items of the navigation drawer are selected. The second one is the navigation drawer. It's recommended to use `NavigationView`. This view allows the items to be loaded from a `menu` but since we usually have to follow some sort of custom design guideline, we can set an empty menu and populate the items ourselves.

``` xml
<android.support.v4.widget.DrawerLayout
    android:id="@+id/nav_drawer"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:elevation="@dimen/spacing_medium">

    <LinearLayout
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:orientation="vertical">

        <include layout="@layout/toolbar" />

        <FrameLayout
            android:id="@+id/main_activity_container"
            android:layout_width="match_parent"
            android:layout_height="match_parent"/>

    </LinearLayout>

    <android.support.design.widget.NavigationView
        android:id="@+id/nav_view"
        android:layout_width="@dimen/nav_width"
        android:layout_height="match_parent"
        android:layout_gravity="start"
        app:menu="@menu/empty_menu">

        <ScrollView
            android:layout_width="match_parent"
            android:layout_height="match_parent"
            android:background="@color/white">

            <LinearLayout
                android:layout_width="match_parent"
                android:layout_height="match_parent"
                android:orientation="vertical">

                <include android:id="@+id/drawer_header"
                    layout="@layout/nav_header" />

                <include android:id="@+id/drawer_notifications"
                    layout="@layout/nav_item" />

                <include android:id="@+id/drawer_make_match"
                    layout="@layout/nav_item" />

               ...

            </LinearLayout>

        </ScrollView>

    </android.support.design.widget.NavigationView>

</android.support.v4.widget.DrawerLayout>
```

##<a name="topic-populate-with-elements"></a> Populate with elements

First, inject the drawer and items of the drawer, along with anything else you might need (toolbar, header, etc).

``` java
    @Bind(R.id.nav_drawer)
    DrawerLayout mDrawer;

    @Bind({R.id.drawer_notifications,
            R.id.drawer_make_match,
            R.id.drawer_contacts, ...})
    List<View> mMenuItemViews;
```

A great way to handle individual items and identify them is to create a simple inner class, `MenuItem`.
In the following snippet you'll notice that there is a `TextView` being injected there. This is because we are showing only a string, representing the item on each position. More views like images or text could be added if needed. See also that a `Presenter` is being called whenever an item is clicked. This is because we are using the MVP pattern here, but the same effect can be achieved by moving the methods shown below to the `Activity`.

``` java
    @Override
    protected void populate() {
        for (int i = 0 ; i < mMenuItemViews.size() ; i++)
            new MenuItem(mMenuItemViews.get(i), mItemsNames.get(i), i);
        ...
    }

    class MenuItem {

        @Bind(R.id.nav_option_name)
        TextView mName;

        MenuItem(View view, String title, final int position) {
            ButterKnife.bind(this, view);
            mName.setText(title);
            view.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    mPresenter.onNavItemSelected(position);
                }
            });
        }
    }
```

When the `onNavItemSelected` method of the `Presenter` is called, the appropriate fragment is instantiated and the view (activity) is told to set the fragment and title. Note that fragments are stored in a variable, `mCurrentFragment`. This is not necessary but is useful in some cases.
``` java
    public void onNavItemSelected(int position) {
        switch (position) {
            case DRAWER_NOTIFICATIONS:
                mCurrentFragment = NotificationsFragment.newInstance();
                break;
            case DRAWER_MAKE_MATCH:
                mCurrentFragment = MakeMatchFragment.newInstance();
                break;
            case DRAWER_CONTACTS:
                mCurrentFragment = ContactsFragment.newInstance();
                break;
            ...
        }
        if (mCurrentFragment != null) {
            getView().setFragment(mCurrentFragment);
            getView().setTitle(position);
        }
    }
```

And finally, the simple `setFragment` method back on the `Activity`
``` java
    @Override
    public void setFragment(WoloxFragment f) {
        replaceFragment(R.id.main_activity_container, f);
    }
```

##<a name="topic-opening-and-closing-the-drawer"></a> Opening and closing the drawer

It hasn't been shown how to set the `Toolbar` here but I'll assume you are using one. When populating it, you should add a listener to the navigation icon (the one on the left, for navigation drawers it's usually a [burger icon](https://www.newfangled.com/wp-content/uploads/2014/08/stuffcontentmgrfiles2ac67e44c30a21635f8a9d498f832bc1cmisc_resized80_313_257_hamenu.png)) to open and close the navigation drawer. Notice that the `openDrawer` and `closeDrawer` methods are separate because they are called from elsewhere as well. The `GravityCompat.START` being passed as parameter means that the drawer opens and closes in relation to the 'start' of the screen which is usually to the left.

``` java
    @Override
    protected void setListeners() {
        mToolbar.setNavigationOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (mDrawer.isDrawerOpen(GravityCompat.START)) closeDrawer();
                else openDrawer();
            }
        });
    }

    @Override
    public void openDrawer() {
        mDrawer.openDrawer(GravityCompat.START);
    }

    @Override
    public void closeDrawer() {
        mDrawer.closeDrawer(GravityCompat.START);
    }
```

##<a name="topic-what-else"></a> What else?
You should now have a working navigation drawer. I've left some blanks to be filled, but all the basic concepts of how to use a Navigation Drawer have been covered.

Something cool that could bee added is to make the drawer visible below the Status Bar. If you need to do something like this look into adding the `android:fitsSystemWindows=”true”` line to the Drawer and making the status bar color transparent. If it is added in some project, consider adding how to do it here and adding your project to the list at the bottom of this page.

## Projects where it was used
- [MatchMaker](https://github.com/Wolox/matchmaker-android)
- [Buenos Libros](https://github.com/Wolox/buenos-libros-android)
