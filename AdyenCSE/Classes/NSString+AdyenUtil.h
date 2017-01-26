//
//  NSString+Util.h
//  AdyenClientsideEncryption
//
//  Created by Jeroen Koops on 8/9/13.
//  Copyright (c) 2013 Adyen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AdyenUtil)

- (BOOL)isHexString NS_SWIFT_UNAVAILABLE("");
- (nullable NSString*)URLEncodedString NS_SWIFT_UNAVAILABLE("");
@end
