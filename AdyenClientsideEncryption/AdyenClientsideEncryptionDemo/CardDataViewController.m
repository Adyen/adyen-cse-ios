//
//  CardDataViewController.m
//  AdyenClientsideEncryption
//
//  Created by Jeroen Koops on 8/19/13.
//  Copyright (c) 2013 Adyen. All rights reserved.
//

#import "CardDataViewController.h"
#import "Card.h"
#import "ADYEncrypter.h"
#import "NSDictionary+Util.h"
#import "PaymentRequest.h"

#include <mach/mach_time.h>

@interface CardDataViewController () <PaymentRequestDelegate>
@property (nonatomic, strong) UITextField* cardNumberField;
@property (nonatomic, strong) UITextField* cvcField;
@property (nonatomic, strong) UITextField* holderNameField;
@property (nonatomic, strong) UITextField* expiryMonthField;
@property (nonatomic, strong) UITextField* expiryYearField;
@property (nonatomic, strong) UITextField* currencyField;
@property (nonatomic, strong) UITextField* amountField;
@property (nonatomic, strong) UITextView* resultTextField;

@property (nonatomic, strong) NSUserDefaults* userDefaults;
@property (nonatomic, strong) PaymentRequest* req;
@end

@implementation CardDataViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self) {
        self.userDefaults = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGFloat frameWidth = self.view.frame.size.width;
    CGFloat frameHeight = self.view.frame.size.height;
    
    CGFloat y = 20;
    
    self.cardNumberField = [[UITextField alloc] initWithFrame:CGRectMake(20, y, 200, 35)];
    self.cardNumberField.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleRightMargin;
    self.cardNumberField.placeholder = @"Creditcard number";
    self.cardNumberField.borderStyle = UITextBorderStyleLine;
    self.cardNumberField.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.cardNumberField];
    
    self.cvcField = [[UITextField alloc] initWithFrame:CGRectMake(20 + 200 + 20, y, frameWidth - 260, 35)];
    self.cvcField.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleLeftMargin;
    self.cvcField.placeholder = @"CVC";
    self.cvcField.borderStyle = UITextBorderStyleLine;
    self.cvcField.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.cvcField];

    y += 35 + 20;
    
    self.holderNameField = [[UITextField alloc] initWithFrame:CGRectMake(20, y, frameWidth - 40, 35)];
    self.holderNameField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.holderNameField.placeholder = @"Cardholder name";
    self.holderNameField.borderStyle = UITextBorderStyleLine;
    self.holderNameField.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.holderNameField];
    
    y += 35 + 20;
    
    self.expiryMonthField = [[UITextField alloc] initWithFrame:CGRectMake(20, y, (frameWidth-60)/2, 35)];
    self.expiryMonthField.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleRightMargin;
    self.expiryMonthField.placeholder = @"Expiry month";
    self.expiryMonthField.borderStyle = UITextBorderStyleLine;
    self.expiryMonthField.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.expiryMonthField];
    
    self.expiryYearField = [[UITextField alloc] initWithFrame:CGRectMake((frameWidth-60)/2 + 40, y, (frameWidth-60)/2, 35)];
    self.expiryYearField.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleLeftMargin;
    self.expiryYearField.placeholder = @"Expiry year";
    self.expiryYearField.borderStyle = UITextBorderStyleLine;
    self.expiryYearField.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.expiryYearField];
    
    y += 35 + 20;
   
    self.currencyField = [[UITextField alloc] initWithFrame:CGRectMake(20, y, (frameWidth-60)/2, 35)];
    self.currencyField.placeholder = @"Currency (USD)";
    self.currencyField.borderStyle = UITextBorderStyleLine;
    self.currencyField.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.currencyField];
    
    self.amountField = [[UITextField alloc] initWithFrame:CGRectMake((frameWidth-60)/2 + 40, y, (frameWidth-60)/2, 35)];
    self.amountField.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleLeftMargin;
    self.amountField.placeholder = @"Amount (cents)";
    self.amountField.borderStyle = UITextBorderStyleLine;
    self.amountField.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.amountField];
    
    y += 35 + 20;

    
    // Abuse a UISegmentedControl with just one segment to get a nice-looking button on the cheap
    UISegmentedControl* buttons = [[UISegmentedControl alloc] initWithItems:@[ @"Submit" ]];
    buttons.momentary = YES;
    buttons.frame = CGRectMake((self.view.frame.size.width - 250) / 2, y, 250, 35);
    buttons.segmentedControlStyle = UISegmentedControlStyleBar;
    [buttons addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventValueChanged];
    buttons.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
    [self.view addSubview:buttons];
    
    y += 35 + 20;
    
    self.resultTextField = [[UITextView alloc] initWithFrame:CGRectMake(20, y, frameWidth - 40, frameHeight - 20 - y)];
    self.resultTextField.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.resultTextField.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.resultTextField];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UITapGestureRecognizer* tapGestureRecognizer =
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTapped:)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

- (void)buttonPressed:(id)sender {
    [self doSubmit];
}



- (void)doSubmit {
    [self.view endEditing:NO];
    if(![self settingsComplete]) {
        [self showError:@"Please fill in the Merchant account, Username, Password and Public key in the app settings"];
        return;
    }
    
    // First instantiate a Card object and set all its properties
    Card* card = [[Card alloc] init];
    card.generationtime = [[NSDate alloc] init];
    card.number = self.cardNumberField.text;
    card.cvc = self.cvcField.text;
    card.holderName = self.holderNameField.text;
    card.expiryMonth = self.expiryMonthField.text;
    card.expiryYear = self.expiryYearField.text;
    
    self.req = [[PaymentRequest alloc] init];
    self.req.card = card;
    self.req.amount = self.amountField.text;
    self.req.currency = self.currencyField.text;
    self.req.txReference = [NSString stringWithFormat:@"%lld", mach_absolute_time()];
    self.req.delegate = self;
    
    self.resultTextField.text = [NSString stringWithFormat:@"Transaction reference: %@\n\n", self.req.txReference];
    
    [self.req submitWithMerchantAccount:[self.userDefaults stringForKey:@"merchantAccount"]
                               username:[self.userDefaults stringForKey:@"username"]
                               password:[self.userDefaults stringForKey:@"password"]
                              publicKey:[self.userDefaults stringForKey:@"publicKey"]];
}

- (void)request:(PaymentRequest *)request failedWithError:(NSError *)error {
    [self showError:[NSString stringWithFormat:@"Failed to submit payment: %@", error]];
}

- (void)request:(PaymentRequest *)request finishedWithResponse:(NSString *)response {
    self.resultTextField.text = [self.resultTextField.text stringByAppendingString:response];
}

- (void)request:(PaymentRequest *)request failedWithHTTPErrorCode:(NSUInteger)HTTPErrorCode response:(NSString *)response {
    [self showError:[NSString stringWithFormat:@"HTTP error %lu", (unsigned long)HTTPErrorCode]];
    self.resultTextField.text = [self.resultTextField.text stringByAppendingString:response];
}

- (void)showError:(NSString*)message {
    UIAlertView* alertView =
        [[UIAlertView alloc] initWithTitle:@"Error"
                                   message:message
                                  delegate:nil
                         cancelButtonTitle:@"Ok"
                         otherButtonTitles:nil];
    [alertView show];

}

- (void)backgroundTapped:(id)sender {
    [self.view endEditing:YES];
}

- (BOOL)settingsComplete {
    for(NSString* key in @[ @"merchantAccount", @"username", @"password", @"publicKey" ]) {
        if([self.userDefaults stringForKey:key] == nil) {
            return NO;
        }
    }
    return YES;
}
@end
