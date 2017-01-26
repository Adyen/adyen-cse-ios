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

+ (nonnull NSData *)encrypt:(nonnull NSData *)data withKey:(nonnull NSData *)key iv:(nonnull NSData *)iv;
+ (nonnull NSData *)encrypt:(nonnull NSData *)data withKey:(nonnull NSData *)key iv:(nonnull NSData *)iv
          tagLength:(size_t)tagLength adata:(nullable NSData *)adata;

@end
