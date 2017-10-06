//
//  NSDictionary+Util.h
//  AdyenClientsideEncryptionDemo
//
//  Created by Jeroen Koops on 8/22/13.
//  Copyright (c) 2013 Adyen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (AdyenUtil)

- (NSString *)encodeFormData DEPRECATED_MSG_ATTRIBUTE("Use -ady_encodeFormData instead.");
- (NSString *)ady_encodeFormData;

@end
