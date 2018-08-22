//
//  ReviewTableViewCell.h
//  beautybox
//
//  Created by Evgeniy Merkulov on 02.08.2018.
//  Copyright © 2018 Evgeniy Merkulov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMRatingControl.h"

@interface ReviewTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property AMRatingControl *ratingControl;
@end
