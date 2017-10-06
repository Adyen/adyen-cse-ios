//
// Copyright (c) 2017 Adyen B.V.
//
// This file is open source and available under the MIT license. See the LICENSE file for more info.
//

#import "ADYViewController.h"

#import "AdyenCSE/AdyenCSE.h"

@interface ADYViewController ()

@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *cardTextField;
@property (strong, nonatomic) IBOutlet UITextField *monthTextField;
@property (strong, nonatomic) IBOutlet UITextField *yearTextField;
@property (strong, nonatomic) IBOutlet UITextField *securityCodeTextField;

@property (strong, nonatomic) NSArray *inputFields;

@end

@implementation ADYViewController

#error Set your public key.
static NSString * publicKey = @"";

#error Set the payment authorisation URL on your server.
static NSString * merchantPaymentAuthoriseUrl = @"";

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.inputFields = @[self.nameTextField,
                             self.cardTextField,
                             self.monthTextField,
                             self.yearTextField,
                             self.securityCodeTextField];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)payAction:(id)sender {
    [self hideKeyboard];

    if ([self isCreditCardFormComplete] == NO) {
        [self presentIncompleteCreditCardFormAlert];
        return;
    }
    
    // Encrypt card details.
    NSString *encryptedCardDetails = [self encryptedCardDetails];
    
    // Submit encrypted card details to the merchant server.
    [self submitEncryptedCardDetails:encryptedCardDetails];
}

- (void)hideKeyboard {
    [self.inputFields enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UITextField *textField = (UITextField *)obj;
        [textField resignFirstResponder];
    }];
}

#pragma mark - Encryption

- (NSString *)encryptedCardDetails {
    // Create a card details object.
    ADYCard *card = [ADYCard new];
    card.generationtime = [NSDate new];
    card.holderName = self.nameTextField.text;
    card.number = [self.cardTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    card.expiryMonth = self.monthTextField.text;
    card.expiryYear = self.yearTextField.text;
    card.cvc = self.securityCodeTextField.text;
    
    // Encrypt card details.
    NSData *cardData = [card encode];
    NSString *encryptedDetails = [ADYEncrypter encrypt:cardData publicKeyInHex:publicKey];
    
    return encryptedDetails;
}

#pragma mark - Merchant Server Submission

- (void)submitEncryptedCardDetails:(NSString *)encryptedCardDetails {
    NSURL *url = [NSURL URLWithString:merchantPaymentAuthoriseUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";

    // URL-encode encrypted card details parameter.
    NSString *body = [NSString stringWithFormat:@"encryptedCard=%@",
                      [encryptedCardDetails ady_URLEncodedString]];
    request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *task = nil;
    task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
            {
                NSString *message = nil;
                if (error) {
                    message = error.localizedDescription;
                } else {
                    message = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self presentMerchantServerResponseWithMessage:message];
                });
            }];
    [task resume];
}

- (void)presentMerchantServerResponseWithMessage:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Merchant Server Response", nil)
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"OK", nil)
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * _Nonnull action) {
                                                          [self dismissViewControllerAnimated:YES completion:nil];
                                                      }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Validation

- (BOOL)isCreditCardFormComplete {
    __block BOOL isComplete = YES;
    [self.inputFields enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UITextField *textField = (UITextField *)obj;
        if (textField.text.length == 0) {
            isComplete = NO;
            *stop = YES;
        }
    }];
    
    return isComplete;
}

- (void)presentIncompleteCreditCardFormAlert {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Incomplete Credit Card Form", nil)
                                                                             message:NSLocalizedString(@"Please fill in all the fields.", nil)
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"OK", nil)
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * _Nonnull action) {
                                                          [self dismissViewControllerAnimated:YES completion:nil];
                                                      }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
