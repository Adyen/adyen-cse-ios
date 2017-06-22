//
//  ADYRSACryptor.h
//  AdyenClientsideEncryption
//
//  Created by Taras Kalapun on 10/25/14.
//  Copyright (c) 2013 Adyen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADYRSACryptor : NSObject

+ (NSData *)encrypt:(NSData *)data withKeyInHex:(NSString *)keyInHex;

@end
