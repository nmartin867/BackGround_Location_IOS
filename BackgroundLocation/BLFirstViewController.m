//
//  BLFirstViewController.m
//  BackgroundLocation
//
//  Created by Nick Martin on 9/30/14.
//  Copyright (c) 2014 BuggyList. All rights reserved.
//

#import "BLFirstViewController.h"
#import "BLMessageProvider.h"
#import "BLLocationProvider.h"


@interface BLFirstViewController ()<LocationProviderDelegate>
@property(nonatomic, strong) BLLocationProvider *locationProvider;
@end

@implementation BLFirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if(self.locationProvider == nil){
        self.locationProvider = [[BLLocationProvider alloc]initWithDelegate:self];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)getLocation:(id)sender {
    [self.locationProvider getLocation];
}


-(void)locationUpdatedWith:(NSString *)longitude andLatitude:(NSString *)latitude{
    [[BLMessageProvider sharedProvider]sendLocation:longitude latitude:latitude applicationState:@"Foreground"];
}

-(void)error:(NSError *)error{
    
}
@end
