//
//  AppDelegate.m
//  TfEL Maths Pedagogy
//
//  Created by Aidan Cornelius-Bell on 22/05/2015.
//  Copyright (c) 2015 Department for Education and Child Development. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    if ( [[[NSProcessInfo processInfo]environment]objectForKey:@"cleanSandbox"] ) {
        NSLog(@"TfEL Maths: is starting to cleanSandbox");
        [self EmptySandbox];
    } else if ([[[NSProcessInfo processInfo] environment] objectForKey:@"synciCloud"]) {
        NSLog(@"TfEL Maths: is starting to uploadToiCloud");
        [self uploadToiCloud];
    } else {
        NSLog(@"TfEL Maths: didFinishLaunchingWithOptions: ev: nil (or unhandled)");
    }
        
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL) uploadToiCloud {
    NSURL *ubiquityManager = [NSURL URLWithString:[NSString stringWithFormat:@"%@/tfeluserdata.sqlite", [[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:nil]]];
    
    if (ubiquityManager) { NSLog(@"TfEL Maths: Has iCloud access at %@.", ubiquityManager); } else { NSLog(@"TfEL Maths: is running on local data only."); }
    
    NSURL *userDataPath = [NSURL URLWithString:[NSString stringWithFormat:@"file://%@/tfeluserdata.sqlite", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]]];
    
    NSError *iCloudSyncError;
    
    [[[NSFileManager alloc]init]setUbiquitous:YES itemAtURL:userDataPath destinationURL:ubiquityManager error:&iCloudSyncError];
    
    if (!iCloudSyncError) {
        return YES;
    } else {
        NSLog(@"%@, Full DD: %@", [iCloudSyncError localizedDescription], iCloudSyncError);
        return NO;
    }
}

- (void)EmptySandbox {
    NSFileManager *fileMgr = [[NSFileManager alloc] init];
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSArray *files = [fileMgr contentsOfDirectoryAtPath:documentsDirectory error:nil];
    NSString *failed;
    
    while (files.count > 0) {
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSArray *directoryContents = [fileMgr contentsOfDirectoryAtPath:documentsDirectory error:&error];
        if (error == nil) {
            for (NSString *path in directoryContents) {
                NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:path];
                BOOL removeSuccess = [fileMgr removeItemAtPath:fullPath error:&error];
                files = [fileMgr contentsOfDirectoryAtPath:documentsDirectory error:nil];
                if (!removeSuccess) {
                    // Error
                    failed = @"could not remove a (1) file.";
                }
            }
        } else {
            // Error
            failed = @"could not remove, or find any file(s).";
        }
    }
    if ([failed length] >= 2) {
        NSLog(@"TfEL Maths Pedagogy Crashed Gracefully: Sandbox not cleared, %@.", failed);
    } else {
        NSLog(@"TfEL Maths Pedagogy Crashed Gracefully: Sandbox cleared.");
    }
    @throw NSInternalInconsistencyException;
}

@end
