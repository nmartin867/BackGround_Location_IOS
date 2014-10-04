//
//  BLAppDelegate.m
//  BackgroundLocation
//
//  Created by Nick Martin on 9/30/14.
//  Copyright (c) 2014 BuggyList. All rights reserved.
//

#import "BLAppDelegate.h"
#import "BLMessageProvider.h"
#import <CoreLocation/CoreLocation.h>


@interface BLAppDelegate()<CLLocationManagerDelegate>{
    NSTimer *backgroundTimer;
   
}
 @property(nonatomic, strong)CLLocationManager *locationManager;
@end


@implementation BLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
    [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:nil];
    backgroundTimer = [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(timer) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:backgroundTimer forMode:NSRunLoopCommonModes];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [backgroundTimer invalidate];

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)getLocation{
    if (nil == self.locationManager)
        self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];
}

-(void)timer{
   [self getLocation];
}



#pragma mark - CLLocation Delegate Methods
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    // If it's a relatively recent event, turn off updates to save power.
    CLLocation* location = [locations lastObject];
    
    // If the event is recent, do something with it.
    NSString *longitude = [NSString stringWithFormat:@"%+.6f", location.coordinate.longitude];
    NSString *latitude = [NSString stringWithFormat:@"%+.6f", location.coordinate.latitude];
   [[BLMessageProvider sharedProvider]sendLocation:longitude latitude:latitude applicationState:@"Background"];
    [manager stopUpdatingLocation];
    
    
}


@end
