//
//  JSON.h
//  Take_Home_Task
//
//  Created by Gor Hakobyan on 1/25/20.
//  Copyright © 2020 Gor Hakobyan. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark Deserializing methods


@interface NSData (JSONDeserializing)

- (id)objectFromJSONData;

@end


#pragma mark Serializing methods


@interface NSDictionary (JSONSerializing)

- (NSData *)JSONData;

@end
