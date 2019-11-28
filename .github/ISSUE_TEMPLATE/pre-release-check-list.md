---
name: Pre-Release check list
about: Things to test and check before releasing a new version of the app
title: ''
labels: ''
assignees: ''

---

### Things to be tested:

NOTE: The must to be tested on **Dutch** and UI features should be tested on different screen sizes.

##### General
- [ ] AppStore Screenshots are still valid
- [ ] AppStore Phased release is enabled
- [ ] Release notes for AppStore (Dutch and English)
- [ ] Release notes are displayed for the first run of this version 
- [ ] Force crash to check that Crashlytics still works correctly
- [ ] Firebase Remote Configurations do work correctly (version control, revoke messages, etc.)
- [ ] Basic authentication/revoke/passcode flow with other Nedap apps
- [ ] Notify support team (inform clients, update manuals, etc.) [create support issue](https://github.com/nedap/support-documentation/issues)

##### Database migration
If changes in the database, check the migration from older versions.

##### New features
List of new features (double check that they work as expected)
- [ ] https://github.com/nedap/<repo-name>/issues/XXX

##### Bugs fixed
List of fixed bugs (double check that the bug is fixed)
- [ ] https://github.com/nedap/<repo-name>/issues/XXX
