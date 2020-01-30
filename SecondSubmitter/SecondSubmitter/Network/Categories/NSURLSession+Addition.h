//
//  NSURLSession+Addition.h
//  Take_Home_Task
//
//  Created by Gor Hakobyan on 1/25/20.
//  Copyright © 2020 Gor Hakobyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLSession (Addition)

+ (NSData *)sendSynchronousRequest:(NSURLRequest *)request returningResponse:(NSURLResponse **)response error:(NSError **)error;

@end
