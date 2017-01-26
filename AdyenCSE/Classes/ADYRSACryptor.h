//
//  ADYRSACryptor.h
//  AdyenClientsideEncryption
//
//  Created by Taras Kalapun on 10/25/14.
//  Copyright (c) 2013 Adyen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADYRSACryptor : NSObject

+ (nullable NSData *)encrypt:(nonnull NSData *)data withKeyInHex:(nonnull NSString *)keyInHex;

@end
