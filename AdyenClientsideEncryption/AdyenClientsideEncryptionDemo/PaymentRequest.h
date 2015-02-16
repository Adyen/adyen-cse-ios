//
//  PaymentRequest.h
//  AdyenClientsideEncryptionDemo
//
//  Created by Jeroen Koops on 8/22/13.
//  Copyright (c) 2013 Adyen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PaymentRequest;
@class Card;

@protocol PaymentRequestDelegate 

- (void)request:(PaymentRequest*)request
failedWithError:(NSError*)error;

- (void)request:(PaymentRequest*)request
finishedWithResponse:(NSString*)response;

- (void)request:(PaymentRequest*)request
failedWithHTTPErrorCode:(NSUInteger)HTTPErrorCode
       response:(NSString*)response;
@end

@interface PaymentRequest : NSObject

@property (nonatomic, strong) Card* card;
@property (nonatomic, strong) NSString* currency;
@property (nonatomic, strong) NSString* amount;
@property (nonatomic, strong) NSString* txReference;

@property (nonatomic, weak) id<PaymentRequestDelegate> delegate;

- (void)submitWithMerchantAccount:(NSString*)merchantAccount
                         username:(NSString*)username
                         password:(NSString*)password
                        publicKey:(NSString*)publicKey;
@end
