//
//  BLSecondViewController.m
//  BackgroundLocation
//
//  Created by Nick Martin on 9/30/14.
//  Copyright (c) 2014 BuggyList. All rights reserved.
//

#import "BLSecondViewController.h"

@implementation BLSecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    NSURL *url = [NSURL URLWithString:@"http://jlcmobile.com/nick.nsf/results"];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlRequest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
