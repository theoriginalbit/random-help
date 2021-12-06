# Scroll Edge Appearance Bug

This was submitted via Feedback Assistant: FB9044088

This project is to demonstrate in isolation a bug in iOS 13 and higher.

The bug is that the `scrollEdgeAppearance` does not get applied to a UINavigationBar when large title mode is disabled and the scroll view content is scrolled to the top (scroll edge). When you scroll the first screen you will notice the navigation bar's title change colour and have it's shadow toggle visibility. The second screen demonstrates that when you scroll the `scrollEdgeAppearance` is ignored. The third screen manually updates the navigation bar's `standardAppearance` in response to scrolling, this screen exists to a) demo what the second screen *should* do, and b) show a workaround.

This project was submitted to Apple via a TSI to ensure it wasn't just a misunderstanding. The result of the discussion with the TSI support engineer confirmed it was a bug.



## This bug has now been fixed.
