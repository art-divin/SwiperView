### SwiperView ###
Swiper View is a class that provides simple and easy-to-use swipable view:

![alt tag](swiper.gif)

### Description ###

Swiper View is a UIDynamics-based UIView subclass that provides multiple layers of UIViews with different visual effects.

Swiper View consists of:

1. The view itself
2. Content view to which UIVisualEffects are applied
3. Topmost view (which is a content view) to which readable UI elements should be added
4. UIDynamicsAnimator that handles:
  * UICollisionBehavior that restricts movement of the content view
  * UIDynamicItemBehavior that restricts rotation of the content view
  * UISnapBehavior that attaches center of the content view with base view
5. UIPanGestureRecognizer that reacts on user interaction
6. UILabels for: 
  * Left item
  * Right item
  * Text on topmost item

### Requirements ###

SwiperView uses [UIVibrancyEffect](https://developer.apple.com/library/prerelease/ios/documentation/UIKit/Reference/UIVibrancyEffect/index.html), which is available only starting **iOS 8.0**.
I personally think that this control doesn't make much of a sense without transparency (blur) and vibrancy (for blur) because user expects "Delete" button to appear, and not a custom control. User won't figure out that there's something underneath cell's view without seeing some kind of indication, for which blur is used.
SwiperView is written in Swift, so you'll need at least **XCode 6.0** to run it

### References ###

While developing, I've checked out these references:

1. https://github.com/yahoojapan/DynamicsSample
2. https://github.com/ide/UIVisualEffects
3. https://github.com/TeehanLax/UICollectionView-Spring-Demo/blob/master/UICollectionView-Spring-Demo/TLViewController.m
4. https://developer.apple.com/library/ios/documentation/UIKit/Reference/UISnapBehavior_Class/index.html
5. https://developer.apple.com/library/ios/samplecode/DynamicsCatalog/Introduction/Intro.html

### License ###

* [MIT License](http://opensource.org/licenses/MIT) is used

> Copyright (c) 2015 Ruslan Alikhamov

> Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

> The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

> THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


### Contributions ###

If you feel like making a contribution, feel free to create a pull request!
