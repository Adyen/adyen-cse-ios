//
//  NSString+URLEncoding.h
//  AdyenClientsideEncryptionDemo
//
//  Created by Oleg Lutsenko on 8/8/16.
//  Copyright © 2016 Adyen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AdyenURLEncoding)

- (nullable NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding;

@end
