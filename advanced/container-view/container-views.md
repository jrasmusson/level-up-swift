# Container Views 

<img src="https://github.com/jrasmusson/level-up-ios/blob/master/advanced/container-view/images/container-view.png" alt="drawing" />

Container views are view controllers that contain sub views, and manage and state and transition between them.

They are great for when you have a logical grouping of ViewControllers within your app, and you want to present and dismiss the entire workflow as one.

`UINavigationController` as well as `UITabViewController` are examples of Container views. Let’s see how they work now.

## Tracking State

Let’s say I have a modem I would like to activate, and I want to take the user through a series of screens depending upon whether the modem successfully activates or fails.

<img src="https://github.com/jrasmusson/level-up-ios/blob/master/advanced/container-view/images/tracking-state.png" alt="drawing" />

This is a great example of where a Container View would come in handy because it would be nice to have some way of tracking what state the user flow is in, and where to go next.

You can think of the above diagram as a state machine. Which we can represent as an enum like this.

```swift
    enum NavigationState {
        case readyToActivate
        case activating
        case success
        case failure
    }

private var navigationState: NavigationState = .readyToActivate
```

By tracking the state of this enum in our `ContainerViewController`, and then reacting to it when the state changes.

```swift
    func didPressPrimaryCTAButton(_ sender: Any?) {
        switch navigationState {
        case .readyToActivate:
            showNextNavigationState(.activating)
        case .activating:
            showNextNavigationState(.success)
        case .success:
            dismiss(animated: true, completion: nil)
        case .failure:
            showNextNavigationState(.readyToActivate)
            break
        }
    }
```

We can elegantly transition from one state in our container view to another, without a lot of code and transition logic.

## Presenting Views

The one thing that is a little bit different with Container Views is how you show the next view controller you would like to transition too.

Instead of simply creating your next state ViewController and pushing it onto the view stack with `present(viewController: UIViewController`, you need to make three child parent calls when presenting your child viewController onto a parent.

```swift
    func presentNextState(viewController: UIViewController) {
        // The view controller we want to present (embedded in nav controller)
        navigationViewController.setViewControllers([nextViewController], animated: true)

        // The x3 things we need to do when presented a child view controller within a parent
        view.addSubview(navigationViewController.view)
        addChild(navigationViewController)
        navigationController?.didMove(toParent: self)
    }
```

`addSubView`, `addChild` and `didMove` are the three calls we need to make in our `ContainerViewController` when adding a child to the parent.

At first these look like strange APIs. We typically don’t use them very much. But these are the calls you must make in `UIKit` to have the child take over the view from the parent. It’s just how it works.

When we are done with our Container View, and we want to return to whatever our app was doing before, we need only call `dismiss` and the `ContainerViewController` will be popped off the stack.

```swift
    func didPressSecondaryCTAButton(_ sender: Any?) {
        dismiss(animated: true, completion: nil)
    }
```

![TableView](https://github.com/jrasmusson/level-up-ios/blob/master/advanced/container-view/images/demo.gif)

## An aside - Responder Chains ⚡

This app uses the Responder Chain to communicate which buttons were pressed in sub views back up to the parent ContainerView.

<img src="https://github.com/jrasmusson/level-up-ios/blob/master/advanced/container-view/images/responder-chain.png" alt="drawing" />

Responder chain is an alternative to the protocol delegate pattern where `UIControl` events are fired app the view hierarchies view, and the first view that is found that can handle the request takes it.

That’s what this protocol is doing. It defines (in a type safe way) which calls the Container View responds to.

```swift
@objc // Responder Chain
protocol ContainerViewControllerResponder {
    func didPressPrimaryCTAButton(_ sender: Any?)
    func didPressSecondaryCTAButton(_ sender: Any?)
}
```

And listens for these events when the underlying sub view buttons get clicked.

```swift
// responder chain
        activateButton.addTarget(nil, action: #selector(responder.didPressPrimaryCTAButton(_:)), for: .primaryActionTriggered)
        cancelButton.addTarget(nil, action: #selector(responder.didPressSecondaryCTAButton(_:)), for: .primaryActionTriggered)
```

By sticking a `nil` in the beginning of `addTarget` we signal that this request can be handled by anybody in the responder chain. It’s a bit more opaque than protocol delegate. But if you are careful it can lead to cleaner code and is a common pattern in Mac and iOS applications.

## Summary

Container views are great when you have clusterings of ViewControllers that form a logical unit of operation within your app.They work by tracking state, handling viewController transitions, and can be dismissed like any other view controller when done.

Always remember to call
`view.addSubView`
`addChild`
`didMove` when adding a child to a parent view controller. And enjoy logically grouping your viewControllers together :)

Happy coding! 🤖

### Links that help

- [Apple Container Views](https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/ImplementingaContainerViewController.html)
- [Custom Container Example](https://www.swiftbysundell.com/articles/custom-container-view-controllers-in-swift/)
- [Using Child View Controllers](https://www.swiftbysundell.com/articles/using-child-view-controllers-as-plugins-in-swift/)
- [Responder Chain](https://useyourloaf.com/blog/using-the-responder-chain/)
- [Source Code](https://github.com/jrasmusson/level-up-ios/tree/master/advanced/container-view/source/ContainerView)


