//
//  VTTextEntryTableViewCell.h
//  Votem Example
//
//  Created by Matt on 8/14/17.
//  Copyright © 2017 Matt S Becker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableViewCell+VTTableViewCells.h"
#import "UIColor+VTColors.h"
#import "UIFont+VTFonts.h"
#import <JVFloatLabeledTextField/JVFloatLabeledTextField.h>

@interface VTTextEntryTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *textField;

@end
