//
//  Card.m
//  AdyenClientsideEncryption
//
//  Created by Jeroen Koops on 8/7/13.
//  Copyright (c) 2013 Adyen. All rights reserved.
//

#import "Card.h"

@interface Card ()
@property (readonly) NSDateFormatter* dateFormatter;
@end

@implementation Card

+ (Card*)decode:(NSData*)json error:(NSError**)error {
    id result = [NSJSONSerialization JSONObjectWithData:json options:0 error:error];
    if(!result) {
        return nil;
    } else if(![result isKindOfClass:[NSDictionary class]]) {
        return nil;
    } else {
        NSDictionary* dict = (NSDictionary*)result;
        Card* card = [[Card alloc] init];
        card.number = dict[@"number"];
        card.holderName = dict[@"holderName"];
        card.cvc = dict[@"cvc"];
        card.expiryMonth = dict[@"expiryMonth"];
        card.expiryYear = dict[@"expiryYear"];
        return card;
    }
}

- (NSData*)encode {
    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
    
    for(NSString* key in @[ @"number", @"holderName", @"cvc", @"expiryMonth", @"expiryYear" ]) {
        if([self valueForKey:key]) {
            dict[key] = [self valueForKey:key];
        }
    }
    if(self.generationtime) {
        dict[@"generationtime"] = [self.dateFormatter stringFromDate:self.generationtime];
    }
    
    return [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
}

- (NSDateFormatter*)dateFormatter {
    static dispatch_once_t once;
    static NSDateFormatter* instance;
    dispatch_once(&once, ^{
        instance = [[NSDateFormatter alloc] init];
        instance.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        instance.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        instance.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
        instance.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZZZZZ";
    });
    return instance;
}

@end
