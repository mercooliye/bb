//
//  ReviewTableViewCell.m
//  beautybox
//
//  Created by Evgeniy Merkulov on 02.08.2018.
//  Copyright © 2018 Evgeniy Merkulov. All rights reserved.
//

#import "ReviewTableViewCell.h"
#import "UIColor+Main.h"
@implementation ReviewTableViewCell
@synthesize ratingControl;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    ratingControl = [[AMRatingControl alloc] initWithLocation:CGPointMake(20, 20) emptyColor:[UIColor grayColor] solidColor:[UIColor yelow] andMaxRating:5 ];
    [ratingControl setUserInteractionEnabled:NO];
    [ratingControl setTintColor:[UIColor whiteColor]];
    [self.contentView addSubview:ratingControl];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
