//
//  Section.h
//  beautybox
//
//  Created by Evgeniy Merkulov on 25.07.2018.
//  Copyright © 2018 Evgeniy Merkulov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Section : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *serviceCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconRight;

@end
