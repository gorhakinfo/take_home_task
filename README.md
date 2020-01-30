# take_home_task

# SecondSubmitter framework. 

As an interface it has  2 methods - 'sharedInstace' and 'submitCurrentSecond'.  By using this interface the current second is extracted and sent as a POST request to https://jsonplaceholder.typicode.com/posts endpoint with the body {"seconds": "55"}, if "55" was the extracted number of seconds (synchronous and in order of happening). It logs the JSON response. I used the Reachability class (provided by apple) for handling network changes. As a container, I used NSMutableArray  and NSUserDefaults for saving it. If the request failed with backgrounded/killed reason, nothing is lost, as progress will be resumed when App goes to foreground again.

# Framework usage

-  add  [Manager sharedInstance] method in 


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions { 
    [Manager sharedInstance];
    return YES;
}
- used [[Manager sharedInstance] submitCurrentSecond] method when you want to submit current second.

# Environment

- Objective C
- Xcode version 11.2.1
- ios 8.0

# Author - Gor Hakobyan
