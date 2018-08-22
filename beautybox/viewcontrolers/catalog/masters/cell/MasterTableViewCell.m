//
//  MasterTableViewCell.m
//  beautybox
//
//  Created by Evgeniy Merkulov on 24.07.2018.
//  Copyright © 2018 Evgeniy Merkulov. All rights reserved.
//

#import "MasterTableViewCell.h"
#import "UIColor+Main.h"

@implementation MasterTableViewCell
@synthesize back;
@synthesize ratingControl;
@synthesize countReviews;
@synthesize nameTextView;
@synthesize addressTextView;

- (void)awakeFromNib {
    
    
    [super awakeFromNib];

    // Initialization code
    self.back.layer.masksToBounds=NO;
    self.back.layer.shadowRadius = 2.4;
    self.back.layer.shadowColor = [UIColor grayColor].CGColor;
    self.back.layer.shadowOffset = CGSizeMake(0, 0);
    self.back.layer.shadowOpacity = 0.3;
    
    
    self.back3.layer.masksToBounds=NO;
    self.back3.layer.shadowRadius = 2.4;
    self.back3.layer.shadowColor = [UIColor grayColor].CGColor;
    self.back3.layer.shadowOffset = CGSizeMake(0, 0);
    self.back3.layer.shadowOpacity = 0.3;
    
    
    ratingControl = [[AMRatingControl alloc] initWithLocation:CGPointMake(17, 300) emptyColor:[UIColor grayColor] solidColor:[UIColor yelow] andMaxRating:5 ];
    
    [ratingControl setUserInteractionEnabled:NO];
    [ratingControl setTintColor:[UIColor whiteColor]];
    [self.contentView addSubview:ratingControl];

    nameTextView=[[ARLabel alloc] initWithFrame:CGRectMake(22, 250, self.frame.size.width-70, 0)];
    [nameTextView setNumberOfLines:2];
    addressTextView=[[ARLabel alloc] initWithFrame:CGRectMake(22, 240, 0, 0)];
    [addressTextView setNumberOfLines:2];

    [self addSubview:addressTextView];
    [self addSubview:nameTextView];
    
    
    countReviews=[[UILabel alloc] initWithFrame:CGRectMake(ratingControl.frame.size.width+30, ratingControl.frame.origin.y+3, 100, ratingControl.frame.size.height)];
    [countReviews setFont:[UIFont fontWithName:@"SFUIText-Regular" size:13]];
    [self.contentView addSubview:countReviews];
    //[countReviews setBackgroundColor:[UIColor grayColor]];

}

-(void)setName:(NSString*)name Address:(NSString*)address
{
    float h_image=250;
    
    [nameTextView setText:name];
    [nameTextView fitHeight];
    float h=nameTextView.height;
    [addressTextView setFrame:CGRectMake(22, h_image+h+5, self.frame.size.width-40, 0)];
    [addressTextView setText:address];
    [addressTextView fitHeight];
    [nameTextView setBackgroundColor:[UIColor clearColor]];
    [addressTextView setBackgroundColor:[UIColor clearColor]];
    
    [nameTextView setFont:[UIFont fontWithName:@"SFUIText-Bold" size:17]];
    [addressTextView setFont:[UIFont fontWithName:@"SFUIText-Regular" size:15]];

    ratingControl.frame=CGRectMake(22, addressTextView.height+h+h_image+10, ratingControl.frame.size.width, ratingControl.frame.size.height);
    countReviews.frame=CGRectMake(ratingControl.frame.size.width+30, ratingControl.frame.origin.y+3, 100, ratingControl.frame.size.height);

 
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
