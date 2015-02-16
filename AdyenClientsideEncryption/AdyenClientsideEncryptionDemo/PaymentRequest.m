//
//  PaymentRequest.m
//  AdyenClientsideEncryptionDemo
//
//  Created by Jeroen Koops on 8/22/13.
//  Copyright (c) 2013 Adyen. All rights reserved.
//

#import "PaymentRequest.h"
#import "NSDictionary+Util.h"
#import "Card.h"
#import "ADYEncrypter.h"

@interface PaymentRequest () <NSURLConnectionDataDelegate>
@property (nonatomic, strong) NSMutableData* buffer;
@property (nonatomic, strong) NSHTTPURLResponse* response;
@end

@implementation PaymentRequest

- (void)submitWithMerchantAccount:(NSString *)merchantAccount
                         username:(NSString *)username
                         password:(NSString *)password
                        publicKey:(NSString *)publicKey {
    NSError* error;
    
    NSString* encryptedCreditCardData = [ADYEncrypter encrypt:[self.card encode] publicKeyInHex:publicKey];
    
    if(!encryptedCreditCardData) {
        [self.delegate request:self failedWithError:error];
        return;
    }
    
    NSMutableDictionary* form = [NSMutableDictionary dictionary];
    form[@"action"] = @"Payment.authorise";
    form[@"paymentRequest.amount.currency"] = self.currency;
    form[@"paymentRequest.amount.value"] = self.amount;
    form[@"paymentRequest.merchantAccount"] = merchantAccount;
    form[@"paymentRequest.reference"] = self.txReference;
    form[@"paymentRequest.additionalData.card.encrypted.json"] = encryptedCreditCardData;
    
    NSURL* targetURL = [NSURL URLWithString:@"https://pal-test.adyen.com/pal/adapter/httppost"];
    NSMutableURLRequest* req = [NSMutableURLRequest requestWithURL:targetURL];
    req.HTTPMethod = @"POST";
    [req setValue:[self authHeaderWithUsername:username password:password] forHTTPHeaderField:@"Authorization"];
    req.HTTPBody = [[form encodeFormData] dataUsingEncoding:NSUTF8StringEncoding];
    self.buffer = [NSMutableData data];
    [NSURLConnection connectionWithRequest:req delegate:self];
}

- (NSString*)authHeaderWithUsername:(NSString*)username password:(NSString*)password {
    NSString* base64 = [[[NSString stringWithFormat:@"%@:%@", username, password] dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:0];
    return [NSString stringWithFormat:@"Basic %@", base64];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [self.delegate request:self failedWithError:error];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSHTTPURLResponse *)response {
    self.response = response;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.buffer appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSString* responseString = [[NSString alloc] initWithData:self.buffer encoding:NSUTF8StringEncoding];
    if(self.response.statusCode == 200) {
        [self.delegate request:self finishedWithResponse:responseString];
    } else {
        [self.delegate request:self failedWithHTTPErrorCode:self.response.statusCode response:responseString];
    }
}

@end
