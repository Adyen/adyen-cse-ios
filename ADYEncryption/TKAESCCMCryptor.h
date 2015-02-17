//
//  TKAESCCMCryptor.h
//
//  Created by Taras Kalapun on 10/25/14.
//

#import <Foundation/Foundation.h>

#define TKC_AESCCM_TraceLog 0

@interface TKAESCCMCryptor : NSObject

+ (NSData *)encrypt:(NSData *)data withKey:(NSData *)key iv:(NSData *)iv;
+ (NSData *)encrypt:(NSData *)data withKey:(NSData *)key iv:(NSData *)iv
          tagLength:(size_t)tagLength adata:(NSData *)adata;

@end
