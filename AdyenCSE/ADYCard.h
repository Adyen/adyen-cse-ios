//
// Copyright (c) 2017 Adyen B.V.
//
// This file is open source and available under the MIT license. See the LICENSE file for more info.
//

#import <Foundation/Foundation.h>

@interface ADYCard : NSObject
@property (nonatomic, strong) NSDate* generationtime;
@property (nonatomic, strong) NSString* number;
@property (nonatomic, strong) NSString* holderName;
@property (nonatomic, strong) NSString* cvc;
@property (nonatomic, strong) NSString* expiryMonth;
@property (nonatomic, strong) NSString* expiryYear;

+ (ADYCard*)decode:(NSData*)json error:(NSError**)error;
- (NSData*)encode;
@end
