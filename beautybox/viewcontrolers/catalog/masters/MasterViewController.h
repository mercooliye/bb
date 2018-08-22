//
//  MasterViewController.h
//  beautybox
//
//  Created by Evgeniy Merkulov on 25.07.2018.
//  Copyright © 2018 Evgeniy Merkulov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBar.h"
#import "UIViewController+Utils.h"
#import "Api.h"
#import "AECollapsableTableView.h"
#import <GoogleMaps/GoogleMaps.h>
#import "AMRatingControl.h"
#import "CatMaster.h"
#import "ARLabel.h"
@interface MasterViewController : UIViewController

@property TabBar *tab;
@property UITableView *tableView;
@property UIPageControl *pageController;

@property NSDictionary *master;
@property NSArray *category;
@property NSArray *services;
@property NSArray *reviews;

@property CLLocationManager *gps;
@property GMSMapView *mapView;
@property JTMaterialSpinner *spinner;

@property AMRatingControl*ratingControl;
@property UILabel* countReviews;
@property ARLabel* adressLabel;
@property UIButton *favButton;

@property bool customerIsCollapsed  ;
@property bool siteIsCollapsed  ;
@property NSInteger collapseSection;
@property CatMaster *catMaster;
@property NSMutableDictionary *selecteds;
@property UIView *shadow;
@end
