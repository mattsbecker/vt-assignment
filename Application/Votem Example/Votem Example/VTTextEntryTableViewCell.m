//
//  VTTextEntryTableViewCell.m
//  Votem Example
//
//  Created by Matt on 8/14/17.
//  Copyright © 2017 Matt S Becker. All rights reserved.
//

#import "VTTextEntryTableViewCell.h"

@implementation VTTextEntryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.textField.tintColor = [UIColor vt_primaryBrandColor];
    self.textField.floatingLabelActiveTextColor = [UIColor vt_lightTextColor];
    self.textField.floatingLabelTextColor = [UIColor vt_lightTextColor];
    self.textField.floatingLabelYPadding = 3.0;
    self.textField.textColor = [UIColor vt_primaryBrandColor];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
