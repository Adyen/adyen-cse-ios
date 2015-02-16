//
//  NSString+Util.m
//  AdyenClientsideEncryption
//
//  Created by Jeroen Koops on 8/9/13.
//  Copyright (c) 2013 Adyen. All rights reserved.
//

#import "NSString+Util.h"

@implementation NSString (Util)

- (BOOL)isHexString {
    for(NSUInteger l=0; l<self.length; l++) {
        unichar c = [self characterAtIndex:l];
        if(![self isHexChar:c]) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)isHexChar:(unichar)c {
    return (c >= '0' && c <= '9') ||
           (c >= 'a' && c <= 'f') ||
           (c >= 'A' && c <= 'F');
}

- (NSString*)URLEncodedString {
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                 NULL,
                                                                                 (CFStringRef)self,
                                                                                 NULL,
                                                                                 (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                 kCFStringEncodingUTF8 ));
}

@end
