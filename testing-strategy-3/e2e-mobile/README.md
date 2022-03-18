# E2E

## Prerequisites

- [Install Platform-specific Dependencies, Tools and Dev-kits](https://github.com/wix/Detox/blob/master/docs/Introduction.GettingStarted.md)
- \[macOS] Install applesimutils for iOS

```shell
brew tap wix/brew
brew install applesimutils
```

### Running the tests

First install the related packages

```shell
npm install
```

Below are the running NPM scripts for each platform.

Note: **You need to have Metro bundler running** (`npm run start`)
to be able to run tests. Because this will run tests in Debug configuration,
it may run a little slower than ci:test:\* variants which run in Release configuration
without having to have Metro bundling running.

### Android

The following commands will start e2e test on Android emulator

```shell
# start Metro (if you haven't already)
npm run start-test

# You don't need to build every time.
npm run build:android
npm run test:android
```

### iOS

```shell
# start Metro (if you haven't already)
npm run start-test

# You don't need to build every time.
npm run build:ios
npm run test:ios
```

---

## Available scripts

- Clean

```
npm run clean
```

- Build debug: This will build package as a debug. So app can use hot reloading on running. You can only use it on development in your local.

```shell
npm run build:<android|ios>
```

- Run test debug: Use this script in your local only.

```shell
npm run test:<android|ios>
```

- You can also you '2' variants (but not the one with ci: prefix). They will exclude @story-not-finished tag from executing.

```shell
npm run test:<android2|ios2>
```

- **Rerunning** If there are failed tests, they will be logged as `@rerun.log` which then can be rerun with

```shell
npm run test:<android|ios>:rerun
```

- **Parallel Testing** with `test:android-multi` and `test:android2-multi` variants (`test:android` and `test:android2` counterparts, respectively) will run the test with _3_ emulators in parallel. Cucumber will split tests by Scenario automatically.

```shell
#Only on Android
npm run test:android-multi
```

- I am able to get a more reliable result with `HEADLESS` mode, which you can try with

```shell
DETOX_HEADLESS=true npm run test:android2-multi
```

- Build release: This will build package as release. (no Metro need when running)

```shell
npm run build:<android|ios>:release
```

- Run test release: This running is faster than debug because it doesn't use hot reloading while running. And run emulator in headless mode.

```shell
npm run test:<android|ios>:release
# for Android, you may want to kill the lingering emulator after run completed
# adb -e emu kill
```

- There's also a `release2` variants which was added with 'not @story-not-finished'
- **IMPORTANT** The `ci:test:<android|ios>2` variants are being used by CI and required additional setup. So you cannot run them in local environment yet.
- If you want to exclude the @story-not-finished tags, you can do so with

```shell
npm run ci:test:<android|ios> -- -t "not @story-not-finished"
```

### Utility script

inside `script` folder, there are two utility scripts `e2e.sh` and `search-story-not-finished.sh` both of them can be use in any path because the script use relative path.

##### `./e2e.sh`

is used for running the whole e2e process for single test case or all test cases. From checking backend status(if not minikube is not running it will start minikube and deploy for you), building frontend, running metro(It will kill and restart metro clean again), telling you the test is start and finish. Here is a list of Options

- `-d=[ios/android]` or `--device=[ios/android]` - to describe the device you want to test
- `-a` or `--all` - to run all active test cases. This option can not be used with `-u`
- `-u=[story number]` or `--user-story=[story number]` - to run a specific user story test case following team convention. This option can not be used with `-a`
- `-s` or `--skip` - to skip the test in case you only want to fix the test not the app code
- **Example 1**, you want to run only user story number 903 on android - use `./e2e.sh -d=android -u=903`
- **Example 2**, you want to run all the test on ios - use `./e2e.sh -d=ios -a` and after it finish as the team convention goes we run android as well - use `./e2e.sh -d=android -a`
- To see help instruction run the command without any options
- This script follow the manual way of running things, if the manual process change this script should be updated as well.

##### `./search-story-not-finished.sh`

is used for searching the file that has story not finish tag. It can be run without any additional option

### Structure

- **features** - list of test features
  - **step_definitions** - detox specific code to define test steps
  - **support**
    - **init.js** - cucumber hooks, integrated with detox
    - **adapter.js** - detox's adaptor for cucumber
    - **env.js** - default cucumber configuration
- **.detoxrc.json** - detox configuration

## Documents

### Detox

- [API](https://github.com/wix/Detox/blob/master/docs/APIRef.DeviceObjectAPI.md)

### Cucumber

- [Hooks](https://github.com/cucumber/cucumber-js/blob/main/docs/support_files/hooks.md)

### E2E Convention

- [Convention](https://aia-dp03.atlassian.net/wiki/spaces/THMI/pages/726728743/E2E+Convention)
