//
//  NSString+URLEncoding.m
//  AdyenClientsideEncryptionDemo
//
//  Created by Oleg Lutsenko on 8/8/16.
//  Copyright © 2016 Adyen. All rights reserved.
//

#import "NSString+AdyenURLEncoding.h"

@implementation NSString (AdyenURLEncoding)

-(nullable NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding {
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                 (CFStringRef)self,
                                                                                 NULL,
                                                                                 (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                                 CFStringConvertNSStringEncodingToEncoding(encoding)));
}

@end
