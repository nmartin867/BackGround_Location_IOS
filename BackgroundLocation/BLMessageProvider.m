//
//  BLMessageProvider.m
//  BackgroundLocation
//
//  Created by Nick Martin on 10/1/14.
//  Copyright (c) 2014 BuggyList. All rights reserved.
//

#import "BLMessageProvider.h"
#import "AFHTTPRequestOperationManager.h"

static BLMessageProvider *instance = nil;
static NSString *urlFormat = @"http://jlcmobile.com/nick.nsf/test?openagent&%@&%@&%@";

@implementation BLMessageProvider

+(instancetype)sharedProvider{
    if(instance == nil){
       instance = [[super allocWithZone:NULL] init];
    }
    return instance;
}

-(void)sendLocation:(NSString *)logitude
           latitude:(NSString *)latitude
   applicationState:(NSString *)state{
    NSString *requestUrl = [NSString stringWithFormat:urlFormat, logitude, latitude, state];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:requestUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end
