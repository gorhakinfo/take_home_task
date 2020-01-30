//
//  JSON.m
//  Take_Home_Task
//
//  Created by Gor Hakobyan on 1/25/20.
//  Copyright © 2020 Gor Hakobyan. All rights reserved.
//

#import "JSON.h"

#pragma mark Deserializing methods

@implementation NSData (JSONDeserializing)

- (id)objectFromJSONData {
    return [NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingAllowFragments error:nil];
}

@end


#pragma mark Serializing methods

@implementation NSDictionary (JSONKitSerializing)

- (NSData *)JSONData {
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    return data;
}

@end
