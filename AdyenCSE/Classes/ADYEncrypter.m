//
//  ADYEncrypter.m
//  AdyenClientsideEncryption
//
//  Created by Jeroen Koops on 8/7/13.
//  Copyright (c) 2013 Adyen. All rights reserved.
//

#import "ADYEncrypter.h"

@implementation ADYEncrypter

+ (void)initialize {
    [self setMsgPrefix:@"adyenan0_1_1"];
}

+ (nullable NSString *)encrypt:(nonnull NSData *)data publicKeyInHex:(nonnull NSString *)keyInHex {
    return [super encrypt:data publicKeyInHex:keyInHex];
}


@end
