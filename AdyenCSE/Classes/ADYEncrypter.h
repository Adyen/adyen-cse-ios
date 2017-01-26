//
//  ADYEncrypter.h
//  AdyenClientsideEncryption
//
//  Created by Jeroen Koops on 8/7/13.
//  Copyright (c) 2013 Adyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ADYCryptor.h"

@interface ADYEncrypter : ADYCryptor

/**
 *  Encrypts the data with AES-CBC using
 *  generated AES256 session key and IV (12)
 *  Encrypts the session key with RSA using
 *  public key (using Keychain)
 *
 *  @param data     data to be encrypted
 *  @param keyInHex Public key in Hex with format "Exponent|Modulus"
 *
 *  @return Fully composed message in format:
 *    - a prefix
 *    - a separator
 *    - RSA encrypted AES key, base64 encoded
 *    - a separator
 *    - a Payload of iv and cipherText, base64 encoded
 *
 *  @see `setMsgPrefix:`
 *  @see `setMsgSeparator:`
 */
+ (nullable NSString *)encrypt:(nonnull NSData *)data publicKeyInHex:(nonnull NSString *)keyInHex;

@end
