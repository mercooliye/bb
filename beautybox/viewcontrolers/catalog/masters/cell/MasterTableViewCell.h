//
//  MasterTableViewCell.h
//  beautybox
//
//  Created by Evgeniy Merkulov on 24.07.2018.
//  Copyright © 2018 Evgeniy Merkulov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMRatingControl.h"
#import "HBVLinkedTextView.h"
#import "ARLabel.h"

@interface MasterTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UITextView *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *back;
@property (weak, nonatomic) IBOutlet UILabel *service1PriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *service2PriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *service3PriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *service1NameLabel;
@property (weak, nonatomic) IBOutlet UILabel *service2NameLabel;
@property (weak, nonatomic) IBOutlet UILabel *service3NameLabel;

@property (weak, nonatomic) IBOutlet UIButton *favButton;
@property (weak, nonatomic) IBOutlet UIImageView *favIconImageView;
@property (weak, nonatomic) IBOutlet HBVLinkedTextView *price1TextView;
@property (weak, nonatomic) IBOutlet HBVLinkedTextView *price2TextView;
@property (weak, nonatomic) IBOutlet UIView *back3;
@property (weak, nonatomic) IBOutlet HBVLinkedTextView *price3TextView;
@property AMRatingControl *ratingControl;

@property ARLabel *nameTextView;
@property ARLabel *addressTextView;

@property UILabel *countReviews;
-(void)setName:(NSString*)name Address:(NSString*)address;

@end
