//
//  StateRepository.m
//  Take_Home_Task
//
//  Created by Gor Hakobyan on 1/25/20.
//  Copyright © 2020 Gor Hakobyan. All rights reserved.
//

#import "StoredSecondsService.h"

#define kprocessedSecondsArray @"kprocessedSecondsArray"

@interface StoredSecondsService()

@property(nonatomic, strong) NSUserDefaults *userDefaults;

@end

@implementation StoredSecondsService

- (instancetype)init {
    self = [super init];
    if (self) {
        self.userDefaults = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

- (BOOL)isSecondProcessed:(NSNumber *)second {
    NSMutableArray *data = [self getStoredArray];
    return [data containsObject:second];
}

- (void)markSecondProcessed:(NSNumber *)second {
    NSMutableArray *data = [self getStoredArray];
    if (!data) {
        data = [NSMutableArray array];
    }
    [data addObject:second];
    [self storeArray:data];
}

- (NSMutableArray *)getStoredArray {
    return [[self.userDefaults objectForKey:kprocessedSecondsArray] mutableCopy];
}

- (void)storeArray:(NSMutableArray *)array {
    [self.userDefaults setObject:array forKey:kprocessedSecondsArray];
}

@end
