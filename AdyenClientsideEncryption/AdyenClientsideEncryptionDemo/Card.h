//
//  Card.h
//  AdyenClientsideEncryption
//
//  Created by Jeroen Koops on 8/7/13.
//  Copyright (c) 2013 Adyen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
@property (nonatomic, strong) NSDate* generationtime;
@property (nonatomic, strong) NSString* number;
@property (nonatomic, strong) NSString* holderName;
@property (nonatomic, strong) NSString* cvc;
@property (nonatomic, strong) NSString* expiryMonth;
@property (nonatomic, strong) NSString* expiryYear;

+ (Card*)decode:(NSData*)json error:(NSError**)error;
- (NSData*)encode;
@end
