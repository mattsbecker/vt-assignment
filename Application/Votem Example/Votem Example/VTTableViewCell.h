//
//  VTTableViewCell.h
//  Votem Example
//
//  Created by Matt on 8/14/17.
//  Copyright © 2017 Matt S Becker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableViewCell+VTTableViewCells.h"
#import "UIColor+VTColors.h"
#import "UIFont+VTFonts.h"

@interface VTTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *contentTextLabel;
@property (strong, nonatomic) IBOutlet UILabel *contentDetailTextLabel;
@property (strong, nonatomic) IBOutlet UILabel *positionTextLabel;
@end
