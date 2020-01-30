//
//  WebServiceManager.h
//  Take_Home_Task
//
//  Created by Gor Hakobyan on 1/25/20.
//  Copyright © 2020 Gor Hakobyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WebServiceManager : NSObject

+ (void)submitSeconds:(NSDictionary *)params withCompletion:( void (^) (id result, NSError *error))handler;

@end
