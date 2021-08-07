# SwiftUI Modifier Bug

This is quite a simple issue to demonstrate, take a look inside `ContentView.swift` and attempt to preview the view, it will fail.

Now remove the modifier `.doSomethingIf(true)` on the `Text` element, the preview will succeed this time.

It appears that having the generic constraint `where Self == Text` on the extension which adds the function chain causes the issue. If you reapply `.doSomethingIf(true)` to the `Text` element and removing the generic constraint from the extension, the preview will also succeed.

