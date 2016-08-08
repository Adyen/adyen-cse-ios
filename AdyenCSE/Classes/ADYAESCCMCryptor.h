//
//  ADYAESCCMCryptor.h
//  AdyenClientsideEncryption
//
//  Created by Taras Kalapun on 10/25/14.
//  Copyright (c) 2013 Adyen. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ADYC_AESCCM_TraceLog 0

@interface ADYAESCCMCryptor : NSObject

+ (NSData *)encrypt:(NSData *)data withKey:(NSData *)key iv:(NSData *)iv;
+ (NSData *)encrypt:(NSData *)data withKey:(NSData *)key iv:(NSData *)iv
          tagLength:(size_t)tagLength adata:(NSData *)adata;

@end
