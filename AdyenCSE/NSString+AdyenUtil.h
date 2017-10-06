//
//  NSString+Util.h
//  AdyenClientsideEncryption
//
//  Created by Jeroen Koops on 8/9/13.
//  Copyright (c) 2013 Adyen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AdyenUtil)

- (BOOL)isHexString DEPRECATED_MSG_ATTRIBUTE("Use -ady_isHexString instead.");
- (BOOL)ady_isHexString;

- (NSString *)URLEncodedString DEPRECATED_MSG_ATTRIBUTE("Use -ady_URLEncodedString instead.");
- (NSString *)ady_URLEncodedString;

@end
