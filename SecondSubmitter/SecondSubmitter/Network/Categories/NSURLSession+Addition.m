//
//  NSURLSession+Addition.m
//  Take_Home_Task
//
//  Created by Gor Hakobyan on 1/25/20.
//  Copyright © 2020 Gor Hakobyan. All rights reserved.
//

#import "NSURLSession+Addition.h"

@implementation NSURLSession (Addition)

+ (NSData *)sendSynchronousRequest:(NSURLRequest *)request returningResponse:(NSURLResponse *__autoreleasing *)responsePointer error:(NSError *__autoreleasing *)errorPointer {
    dispatch_semaphore_t semaphore;
    __block NSData *result = nil;
    semaphore = dispatch_semaphore_create(0);
    void (^completionHandler)(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error);
    completionHandler = ^(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error) {
        if ( errorPointer != NULL ) {
            *errorPointer = error;
        }
        if ( responsePointer != NULL ) {
            *responsePointer = response;
        }
        if ( error == nil ) {
            result = data;
        }
        dispatch_semaphore_signal(semaphore);
    };
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:completionHandler] resume];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    return result;
}

@end
