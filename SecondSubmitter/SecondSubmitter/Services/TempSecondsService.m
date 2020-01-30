//
//  SecondsForSave.m
//  Take_Home_Task
//
//  Created by Gor Hakobyan on 1/26/20.
//  Copyright © 2020 Gor Hakobyan. All rights reserved.
//

#import "TempSecondsService.h"
#import "WebServiceManager.h"

#define ktempSecondsArray @"ktempSecondsArray"

@interface TempSecondsService()

@property(nonatomic, strong) NSUserDefaults *userDefaults;

@end

@implementation TempSecondsService

- (instancetype)init {
    self = [super init];
    if (self) {
        self.userDefaults = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

- (void)addSecond:(NSNumber *)second {
    NSMutableArray *data = [self getSavedArray];
    if (!data) {
        data = [NSMutableArray array];
    }
    [data addObject:second];
    [self saveArray:data];
}

- (void)removeSecond:(NSNumber *)second {
    NSMutableArray *data = [self getSavedArray];
    [data removeObject:second];
    [self saveArray:data];
}

- (BOOL)isSecondProcessed:(NSNumber *)second {
    NSMutableArray *data = [self getSavedArray];
    return [data containsObject:second];
}

- (NSMutableArray *)getSavedArray {
    return [[self.userDefaults objectForKey:ktempSecondsArray] mutableCopy];
}

- (void)saveArray:(NSMutableArray *)array {
    [self.userDefaults setObject:array forKey:ktempSecondsArray];
}

@end
