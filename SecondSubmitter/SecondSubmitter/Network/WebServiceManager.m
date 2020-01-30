//
//  WebServiceManager.m
//  Take_Home_Task
//
//  Created by Gor Hakobyan on 1/25/20.
//  Copyright © 2020 Gor Hakobyan. All rights reserved.
//

#import "WebServiceManager.h"
#import "JSON.h"
#import "NSURLSession+Addition.h"

static NSString *wsUrl = @"https://jsonplaceholder.typicode.com/";

@implementation WebServiceManager

+ (void)submitSeconds:(NSDictionary *)params withCompletion:( void (^) (id result, NSError *error))handler {
    NSMutableURLRequest *request = [self requestForPostMethod:@"posts" withJSONData:[params JSONData]];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSHTTPURLResponse* response = nil;
        NSError *error = nil;
        NSData *data = [NSURLSession sendSynchronousRequest:request returningResponse:&response error:&error];
        if (response.statusCode == 201) {
            NSDictionary *dict = [[NSDictionary alloc]initWithDictionary:[data objectFromJSONData]];
            handler(dict, nil);
        } else {
            handler(nil, error);
        }
    });
}


#pragma mark Request

+ (NSMutableURLRequest *)requestForPostMethod:(NSString *)method withJSONData:(NSData *)data {
    NSString* url = [NSString stringWithFormat:@"%@%@", wsUrl, method];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20.0f];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];
    return request;
}

@end
