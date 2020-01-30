//
//  ViewController.m
//  Take_Home_Task
//
//  Created by Gor Hakobyan on 1/31/20.
//  Copyright © 2020 Gor Hakobyan. All rights reserved.
//

#import "ViewController.h"
#import <SecondSubmitter/SecondSubmitter.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)submit:(id)sender {
    [[Manager sharedInstance] submitCurrentSecond];
}

@end
