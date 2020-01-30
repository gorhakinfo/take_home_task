//
//  Manager.m
//  Take_Home_Task
//
//  Created by Gor Hakobyan on 1/25/20.
//  Copyright © 2020 Gor Hakobyan. All rights reserved.
//

#import "Manager.h"
#import "StoredSecondsService.h"
#import "WebServiceManager.h"
#import "TempSecondsService.h"
#import "Reachability.h"

@interface Manager()

@property(nonatomic, strong) StoredSecondsService* storeService;
@property(nonatomic, strong) TempSecondsService* tempSecvice;
@property(nonatomic, assign) BOOL isProcessing;

@end

@implementation Manager

+ (instancetype)sharedInstance {
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.storeService = [[StoredSecondsService alloc] init];
        self.tempSecvice = [[TempSecondsService alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)submitCurrentSecond {
    NSNumber *currentSecond = @([self getCurrentSecond]);
    if ([self.storeService isSecondProcessed: currentSecond]) {
        [self logSecondAlreadyProcessed: currentSecond];
        return;
    }
    [self processSecond:currentSecond];
}


#pragma Mark - Private Methods -

- (void)appDidBecomeActive {
    [self execute];
}

- (void)logSecondAlreadyProcessed:(NSNumber *)second {
    NSLog(@"%@ Already Processed", second);
}

- (void)processSecond:(NSNumber *)second {
    if ([self.tempSecvice isSecondProcessed:second]) {
        [self logSecondAlreadyProcessed:second];
        return;
    }
    [self.tempSecvice addSecond:second];
    if (!self.isProcessing) {
        [self execute];
    }
}

- (int)getCurrentSecond {
    NSDate *currentTime = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"ss"];
    NSString *secondStr = [dateFormatter stringFromDate: currentTime];
    return [secondStr intValue];
}


#pragma Mark - Request -

- (void)execute {
    NSMutableArray *data = [self.tempSecvice getSavedArray];
    if ([data count]) {
        self.isProcessing = true;
        [WebServiceManager submitSeconds:@{@"seconds" : data.firstObject} withCompletion:^(id result, NSError *error) {
            if (result) {
                NSLog(@"%@", result);
                [self.storeService markSecondProcessed:data.firstObject];
                [self.tempSecvice removeSecond:data.firstObject];
            } else {
                if ([self isNetworkUnreachable]) {
                    self.isProcessing = false;
                    return;
                }
            }
            [self execute];
        }];
    } else {
        self.isProcessing = false;
    }
}


#pragma Mark - Reachability -

- (BOOL)isNetworkUnreachable {
    NetworkStatus networkStatus = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(handleNetworkChange:) name: kReachabilityChangedNotification object: nil];
        [[Reachability reachabilityForInternetConnection] startNotifier];
        return YES;
    }
    return NO;
}

- (void)handleNetworkChange:(NSNotification*) notification {
    NetworkStatus status = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    if (status != NotReachable) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
        [self execute];
    }
}

@end
