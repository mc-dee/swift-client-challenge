#Swift Client Challenge

###Preface
The original idea for this challenge was do determine the best way to communicate data back from the DataProvider (UITableViewDelegate) to the view controller (UITableViewController).

I decided to experiment with URL routing, where passing back data to the UIViewController is, at least with the github client app, not necessary anymore.
This does not focus on fancy mappings from API calls to models, but more on the Router & Navigation approach.

###Routes and Navigation

Routes have to be registered first in App Delegate. I am doing this in the initialize() function:

```swift
override static func initialize() {
    Router.sharedRouter.registerRoute("users/:username", viewController: UserViewController.self)
    Router.sharedRouter.registerRoute("users/:username/repos", viewController: RepoViewController.self)
    Router.sharedRouter.registerRoute("repos/:owner/:repo/readme", viewController: ReadMeViewController.self)
}
```

The routes registered here are analogous to the Github Rest API, so we can use them for API calls as well. Dynamic parts of the URL are marked with a `:` prefix. To every route, we also define the corresponding view controller.

```swift
func registerRoute(path: String, viewController: UIViewController.Type)
```

Once registered, we can use this routes for navigating within the app via the `Navigator`, for the sake of this demo, only push is available. For example, if you wanted to navigate to the user profile, you would do the following:

```swift
Navigator.sharedNavigator.push("users/mwfire")
```

This will push the `UserViewController`, a view controller that conforms to the `Routable` protocol. This makes sure we have access to the `RouteRequest` struct, that contains the current path and the options dictionary, which let's you access the dynamic parts of the URL that routed to this view controller.

For example, the `ReadMeViewController`, called via

```swift
// Matches register route repos/:username/:repo/readme
Navigator.sharedNavigator.push("repos/mwfire/swift-client-challenge/readme)

```

has access to the follwing options

```swift
// Accessible via routeRequest.options
[":username" : "mwfire", ":repo" : "swift-client-challenge"]
```

So, if you wanted to set the title of the navigation bar in your view controller to the repo name, this would do the trick:

```swift
title = routeRequest.options[":repo"]
```

That's it.

###Launch/open app from URL

The neat thing about the URL navigation approach is that you can easily push view controllers from the AppDelegate, as simple as:

```swift
func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
    Navigator.sharedNavigator.push(url)
    return true
}
```

Therefore, you can launch the app with this URL, for example

```
swift-client-challenge://users/mwfire/repos
```

###Apologies in advance ;)
Given the few hours I had to write this, there are many places where I don't adhere to swift best practices, there's no error handling and forced unwrapping.
Some of the things might be overly complicated, but this is the first iteration and proof of concept. I'd be more than happy to discuss this with you guys. As I am still writing code mostly in Objective-C, I find myself having a hard time with some of the functional and protocol-oriented approaches. So please forgive me if this reminds you of the Objective-C times ;)

Copyright (c) 2016 Martin Wildfeuer under the MIT license

