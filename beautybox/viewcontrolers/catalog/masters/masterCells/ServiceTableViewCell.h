//
//  ServiceTableViewCell.h
//  beautybox
//
//  Created by Evgeniy Merkulov on 25.07.2018.
//  Copyright © 2018 Evgeniy Merkulov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServiceTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *infoButton;
@property (weak, nonatomic) IBOutlet UILabel *periodLabel;
@property (weak, nonatomic) IBOutlet UIButton *plusButton;

@end
