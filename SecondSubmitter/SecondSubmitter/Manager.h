//
//  Manager.h
//  Take_Home_Task
//
//  Created by Gor Hakobyan on 1/25/20.
//  Copyright © 2020 Gor Hakobyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Manager : NSObject

+ (instancetype)sharedInstance;
- (void)submitCurrentSecond;

@end

NS_ASSUME_NONNULL_END
