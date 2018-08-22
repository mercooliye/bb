//
//  CatsViewController.h
//  beautybox
//
//  Created by Evgeniy Merkulov on 23.07.2018.
//  Copyright © 2018 Evgeniy Merkulov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+Utils.h"

@interface CatsViewController : UIViewController
@property UITableView *tableView;
@property NSInteger index;
@property NSArray *cats;
@property NSString *name;
@property NSString *Id;
@property JTMaterialSpinner *spinner;
@end
