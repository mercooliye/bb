//
//  ReviewsViewController.h
//  beautybox
//
//  Created by Evgeniy Merkulov on 06.08.2018.
//  Copyright © 2018 Evgeniy Merkulov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+Utils.h"

@interface ReviewsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSArray *reviews;
@property NSString *rating;
@property NSDictionary *master;
@end
