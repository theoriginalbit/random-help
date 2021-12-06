# RemoteNotification User Termination Launch Bug

So this was submitted via Feedback Assistant: FB9798071

I took part in the Meet with Developer Technical Support on Thursday, December 2, 2021 9:30 a.m. PST and my assigned Engineer confirmed the following is a bug and should not be happening. 

This project is to demonstrate in isolation the bug in iOS 14 and higher.

I have noticed a change in iOS 14 and 15 in regards to how remote notifications are handled; the new functionality deviates from previous findings back in iOS 12/13, which were confirmed with a separate Technical Support Incident 2 years ago.

It appears the app will be launched in the background to handle a remote notification, **even** if the user has terminated the app. The app is launched by the system, though doesn’t re-appear in the multitasking tray, and doesn’t get another launch event when the user opens the app again. The Apple Engineer I discussed this with had mentioned this may be due to Xcode tools being attached to the device, though we were able to replicate this issue with release builds on non-developer devices.

This app supports back to iOS 12 for testing convenience, but note this bug **does not** exist in iOS 12 or 13, this is an iOS 14 and 15 bug **only**. In iOS 12/13 the application will not be launched to process the remote notification if the user has terminated the app, as would be expected by developers and users alike.

## Replication steps

### On iOS 12/13 device (no bug)

- Open Console app to inspect logs of the device
- Launch app on device, copy APNs token
- Kill the app through the multitasking tray
- Send silent notification with a custom key “myValue” that is of an Int type
- Take a look at Console and notice the app WAS NOT launched
- Look in the multitasking tray and notice the app is NOT present in there
- Launch the app and notice NOTHING changes in the UI; it doesn’t show the second screen

### On iOS 14/15 device (bug)

- Open Console app to inspect logs of the device
- Launch app on device, copy APNs token
- Kill the app through the multitasking tray
- Send silent notification with a custom key “myValue” that is of an Int type
- Take a look at Console and notice the app WAS launched
- Look in the multitasking tray and notice the app is NOT present in there
- Launch the app and notice the UI HAS changed; showing the second screen with the same value from the silent notification
