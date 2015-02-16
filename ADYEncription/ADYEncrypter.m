//
//  ADYEncrypter.m
//  AdyenClientsideEncryption
//
//  Created by Jeroen Koops on 8/7/13.
//  Copyright (c) 2013 Adyen. All rights reserved.
//

#import "ADYEncrypter.h"


//static NSString* const ep_versionString = @"0_1_1";
//static NSString* const ep_messagePrefix = @"adyenan";
//static NSUInteger ep_AESKeyLength = 32;
//static NSUInteger ep_AESNonceLength = 12;
//static int ep_AESTagLength = 8;

@implementation ADYEncrypter

+ (void)initialize {
    [self setMsgPrefix:@"adyenan0_1_1"];
}

@end
