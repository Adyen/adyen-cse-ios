//
//  TKRSACryptor.h
//
//  Created by Taras Kalapun on 10/25/14.
//

#import <Foundation/Foundation.h>

@interface TKRSACryptor : NSObject

+ (NSData *)encrypt:(NSData *)data withKeyInHex:(NSString *)keyInHex;

@end
