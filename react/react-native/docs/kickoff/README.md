React Native: Kickoff guide
===========================

## Prerequisites
- React native dev environment: https://facebook.github.io/react-native/docs/getting-started.html
- node & npm: https://github.com/creationix/nvm#install-script
- yarn: https://yarnpkg.com/lang/en/docs/install/#alternatives-tab
- ruby (for Fastlane): https://github.com/rbenv/rbenv#installation
- git repository

## Project kickoff instructions

Before starting read this [Convention guide](../../../mobile/docs/naming/README.md) to figure out what the `Project Name` should be.

1. Project boilerplate
```bash
bash <(curl -s https://raw.githubusercontent.com/Wolox/wolmo-bootstrap-react-native/master/run.sh)
```

1a. If the app have `double-conversion` or `fishhook` related errors, try running:  
```
cd node_modules/react-native/scripts && ./ios-install-third-party.sh && cd ../../../
cd node_modules/react-native/third-party/glog-0.3.*/ && ../../scripts/ios-configure-glog.sh && cd ../../../../
cp ios/build/Build/Products/Debug-iphonesimulator/libfishhook.a node_modules/react-native/Libraries/WebSocket/
```

2. Create app in Apple Developer Portal and iTunes Connect
```bash
fastlane produce
```

3. Create signing certificates and provisioning profiles
```
fastlane match --git_url <project repository url> --git_branch certificates
```
You still need to manually set this certificates using xCode.
Commit this changes!

4. Everything is ready! Notify your team manager.
