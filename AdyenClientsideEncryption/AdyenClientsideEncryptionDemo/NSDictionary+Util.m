//
//  NSDictionary+Util.m
//  AdyenClientsideEncryptionDemo
//
//  Created by Jeroen Koops on 8/22/13.
//  Copyright (c) 2013 Adyen. All rights reserved.
//

#import "NSDictionary+Util.h"
#import "NSString+Util.h"

@implementation NSDictionary (Util)

- (NSString*)encodeFormData {
    NSMutableString* s = [NSMutableString string];
    [self enumerateKeysAndObjectsUsingBlock:^(NSString* key, NSString* value, BOOL *stop) {
        if(s.length) {
            [s appendString:@"&"];
        }
        [s appendFormat:@"%@=%@", [key URLEncodedString], [value URLEncodedString]];
    }];
    return s;
}

@end
