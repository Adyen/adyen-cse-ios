//
//  NSString+URLEncoding.m
//  AdyenClientsideEncryptionDemo
//
//  Created by Oleg Lutsenko on 8/8/16.
//  Copyright © 2016 Adyen. All rights reserved.
//

#import "NSString+AdyenURLEncoding.h"
#import "NSString+AdyenUtil.h"

@implementation NSString (AdyenURLEncoding)

-(NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding {
    return [self URLEncodedString];
}

@end
