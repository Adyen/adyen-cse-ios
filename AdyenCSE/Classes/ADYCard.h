//
//  Card.h
//  AdyenClientsideEncryption
//
//  Created by Jeroen Koops on 8/7/13.
//  Copyright (c) 2013 Adyen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_SWIFT_NAME(Card)
@interface ADYCard : NSObject
@property (nonatomic, strong, nullable) NSDate* generationtime;
@property (nonatomic, strong, nullable) NSString* number;
@property (nonatomic, strong, nullable) NSString* holderName;
@property (nonatomic, strong, nullable) NSString* cvc;
@property (nonatomic, strong, nullable) NSString* expiryMonth;
@property (nonatomic, strong, nullable) NSString* expiryYear;

+ (nullable ADYCard*)decode:(nonnull NSData*)json error:(NSError * _Nullable * _Nullable)error;
- (nullable NSData*)encode;
@end
