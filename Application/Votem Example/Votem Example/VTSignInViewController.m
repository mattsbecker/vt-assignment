//
//  ViewController.m
//  Votem Example
//
//  Created by Matt on 8/12/17.
//  Copyright © 2017 Matt S Becker. All rights reserved.
//

#import "VTSignInViewController.h"
#import <JVFloatLabeledTextField/JVFloatLabeledTextField.h>

@interface VTSignInViewController ()
@property (strong, nonatomic) IBOutlet UILabel *signInDescriptionLabel;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *userIDTextField;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UILabel *userIDFootnoteLabel;
@property (strong, nonatomic) IBOutlet UILabel *loginContentLabel;

@end

@implementation VTSignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureFonts];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --- Private Methods ---

- (void)configureFonts {
    self.signInDescriptionLabel.textColor = [UIColor vt_primaryBrandColor];
    self.signInDescriptionLabel.font = [UIFont vt_standardContentFont];
    self.userIDFootnoteLabel.textColor = [UIColor vt_lightTextColor];
    self.userIDFootnoteLabel.font = [UIFont vt_footnoteFont];
    self.userIDTextField.floatingLabelActiveTextColor = [UIColor vt_primaryBrandColor];
    self.passwordTextField.floatingLabelActiveTextColor = [UIColor vt_primaryBrandColor];
    self.userIDTextField.placeholderColor = [UIColor vt_lightTextColor];
    self.passwordTextField.placeholderColor = [UIColor vt_lightTextColor];
    self.loginContentLabel.textColor = [UIColor vt_primaryBrandColor];
    self.loginContentLabel.font = [UIFont vt_standardContentFont];
    self.userIDTextField.floatingLabelYPadding = 3.0;
    self.passwordTextField.floatingLabelYPadding = 3.0;
    self.userIDTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.passwordTextField.secureTextEntry = YES;
    self.userIDTextField.placeholder = NSLocalizedString(@"ONBOARDING.LOGIN_ACCOUNT_ID_FIELD_PLACEHOLDER", @"Login User ID Field Placeholder");
    self.passwordTextField.placeholder = NSLocalizedString(@"ONBOARDING.LOGIN_PASSWORD_FIELD_PLACEHOLDER", @"Login Password Field Placeholder");
    self.userIDFootnoteLabel.text = NSLocalizedString(@"ONBOARDING.ACCOUNT_ID_FOOTNOTE", @"Login user id footnote");
    self.loginContentLabel.text = NSLocalizedString(@"ONBOARDING.LOGIN_TITLE", @"Login title string");
}

#pragma mark --- Instance Methods ---

#pragma mark --- Class Method Overrides ---
+ (NSString *)titleForViewController {
    return @"Sign In";
}


@end
