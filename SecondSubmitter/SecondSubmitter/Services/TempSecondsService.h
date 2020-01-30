//
//  SecondsForSave.h
//  Take_Home_Task
//
//  Created by Gor Hakobyan on 1/26/20.
//  Copyright © 2020 Gor Hakobyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TempSecondsService : NSObject

- (void)addSecond:(NSNumber *)second;
- (void)removeSecond:(NSNumber *)second;
- (BOOL)isSecondProcessed:(NSNumber *)second;
- (NSMutableArray *)getSavedArray;

@end

NS_ASSUME_NONNULL_END
