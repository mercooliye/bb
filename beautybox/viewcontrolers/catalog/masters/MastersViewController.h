//
//  MastersViewController.h
//  beautybox
//
//  Created by Evgeniy Merkulov on 24.07.2018.
//  Copyright © 2018 Evgeniy Merkulov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+Utils.h"

@interface MastersViewController : UIViewController<UIScrollViewDelegate>
@property NSString *name;
@property NSString *catId;
@property NSString *serviceId;
@property NSString *cityId;
@property UITableView *tableView;
@property NSMutableArray *masters;
@property JTMaterialSpinner *spinner;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property NSInteger currentPage;
@property UIButton *filterButton;
@property BOOL loading;
@property BOOL bottom;
@property UITextField *textfieldTxt;
@end
