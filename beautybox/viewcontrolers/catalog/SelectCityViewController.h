//
//  SelectCityViewController.h
//  beautybox
//
//  Created by Evgeniy Merkulov on 24.07.2018.
//  Copyright © 2018 Evgeniy Merkulov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "UIViewController+Utils.h"

#define CITY [[NSUserDefaults standardUserDefaults] objectForKey:@"cityName"]
#define CITY_ID [[NSUserDefaults standardUserDefaults] objectForKey:@"cityID"]

@interface SelectCityViewController : UIViewController<UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

@property UITableView *tableView;
@property NSArray *citys;
@property NSArray *allcitys;
@property CLLocationManager *locationManager;
@property CLLocation *location;
@property JTMaterialSpinner *spinner;
@end
