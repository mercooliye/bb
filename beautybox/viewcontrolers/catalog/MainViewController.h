//
//  MainViewController.h
//  beautybox
//
//  Created by Evgeniy Merkulov on 15.07.18.
//  Copyright © 2018 Evgeniy Merkulov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+Utils.h"

@interface MainViewController : UIViewController
@property UITableView *tableView;
@property NSArray *cats;
@property (weak, nonatomic) IBOutlet UITextField *cityTextField;
@property NSArray *Ids;
@end
