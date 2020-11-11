//
//  AppDelegate.m
//  shortcutDemo
//
//  Created by cp on 9/30/15.
//  Copyright © 2015 cp. All rights reserved.
//

#import "AppDelegate.h"
#import "secondview.h"
#import "thirdview.h"

@interface AppDelegate ()
@property (nonatomic, retain) UIApplicationShortcutItem * launchedShortcutItem;

@end

@implementation AppDelegate

- (BOOL) handledShortCutItem: (UIApplicationShortcutItem *) shortcutItem
{
    BOOL handled = NO;
    if (!shortcutItem.type) return NO;
    if (![shortcutItem.type isKindOfClass:[NSString class]]) return NO;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    
    if ([shortcutItem.type isEqualToString:@"selfie"]) {
        handled = YES;
        NSLog(@"Play");
        
        secondview *vc = [storyboard instantiateViewControllerWithIdentifier:@"second"];

        self.window.rootViewController = vc;

        [self.window makeKeyAndVisible];
        
    }
    
    else if ([shortcutItem.type isEqualToString:@"vedio"]) {
        handled = YES;
        NSLog(@"Stop");
                thirdview *vc = [storyboard instantiateViewControllerWithIdentifier:@"third"];
        
                self.window.rootViewController = vc;
        
        [self.window makeKeyAndVisible];
    }

    return handled;
}

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(nullable NSDictionary *)launchOptions
{
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    Dynamic Shortcuts
//    UIApplicationShortcutIcon * addIcon = [UIApplicationShortcutIcon iconWithType: UIApplicationShortcutIconTypeAdd];//Icons should be square, single color,
//
//    UIApplicationShortcutItem * addItem = [[UIApplicationShortcutItem alloc]initWithType: @"add" localizedTitle: @"Add" localizedSubtitle: nil icon: addIcon userInfo: nil];
//
//    [UIApplication sharedApplication].shortcutItems = @[addItem];
    
    BOOL shouldPerformAdditionalDelegateHandling    = YES;
    if (launchOptions[UIApplicationLaunchOptionsShortcutItemKey]) {
        UIApplicationShortcutItem * shortcutItem = launchOptions[UIApplicationLaunchOptionsShortcutItemKey];
        self.launchedShortcutItem   = shortcutItem;
        // This will block "performActionForShortcutItem:completionHandler" from being called.
        shouldPerformAdditionalDelegateHandling     = NO;
    }
    return shouldPerformAdditionalDelegateHandling;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    if(!self.launchedShortcutItem) {
        return;
    }
    [self handledShortCutItem: self.launchedShortcutItem];

    self.launchedShortcutItem   = nil;
}

- (void) application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler
{
    BOOL result = [self handledShortCutItem: shortcutItem];
    completionHandler(result);
}

@end
