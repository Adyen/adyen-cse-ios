//
// Copyright (c) 2017 Adyen B.V.
//
// This file is open source and available under the MIT license. See the LICENSE file for more info.
//

#import <Foundation/Foundation.h>

#define ADYC_AESCCM_TraceLog 0

@interface ADYAESCCMCryptor : NSObject

+ (NSData *)encrypt:(NSData *)data withKey:(NSData *)key iv:(NSData *)iv;
+ (NSData *)encrypt:(NSData *)data withKey:(NSData *)key iv:(NSData *)iv
          tagLength:(size_t)tagLength adata:(NSData *)adata;

@end
