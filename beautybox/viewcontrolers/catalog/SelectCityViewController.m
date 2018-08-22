//
//  SelectCityViewController.m
//  beautybox
//
//  Created by Evgeniy Merkulov on 24.07.2018.
//  Copyright © 2018 Evgeniy Merkulov. All rights reserved.
//

#import "SelectCityViewController.h"
#import "UIViewController+Utils.h"
#import "Api.h"
#import "UIColor+Main.h"

@interface SelectCityViewController ()

@end

@implementation SelectCityViewController
@synthesize tableView;
@synthesize locationManager;
@synthesize searchTextField;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 84, self.width, self.height-84)];
    
    /*
    UIButton *closeButton=[[UIButton alloc] initWithFrame:CGRectMake(5, 20, 100, 40)];
    [closeButton setTitle:@"Закрыть" forState:UIControlStateNormal];
    [self.view addSubview:closeButton];
    [closeButton setTitleColor:[UIColor orange] forState:UIControlStateNormal];
    [closeButton addTarget:nil action:@selector(close) forControlEvents:UIControlEventTouchDown];
    
    UIButton *regBnt=[[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height-50, self.view.frame.size.width/2,50)];
    [regBnt setTitle:NSLocalizedString(@"Закрыть", @"Закрыть") forState:UIControlStateNormal];
    [regBnt setBackgroundColor:[UIColor orange]];
    [self.view addSubview:regBnt];
    
    UIButton *loginBnt=[[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-50, self.view.frame.size.width/2,50)];
    [loginBnt setTitle:NSLocalizedString(@"Применить", @"Применить") forState:UIControlStateNormal];
    [loginBnt setTitleColor:[UIColor orange] forState:UIControlStateNormal];
    [loginBnt setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:loginBnt];
    
    [loginBnt addTarget:nil action:@selector(login) forControlEvents:UIControlEventTouchDown];
    [regBnt addTarget:nil action:@selector(reg) forControlEvents:UIControlEventTouchDown];
    */
    
    
    UIImageView *header=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 1)];
    [header setContentMode:UIViewContentModeScaleAspectFill];
    [header setClipsToBounds:YES];
    
    tableView.tableHeaderView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 40)];
    [tableView.tableHeaderView addSubview:header];
    [self.view addSubview:tableView];
    
    tableView.delegate=self;
    tableView.dataSource=self;
    
    tableView.tableFooterView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [tableView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:tableView];
    
    
    //searchTextField=[[UITextField alloc] initWithFrame:CGRectMake(10, 60, self.width-20, 50)];
    [searchTextField addTarget:self action:@selector(search:) forControlEvents:UIControlEventEditingChanged];
    
    [self.view addSubview:searchTextField];
    [searchTextField setTextAlignment:NSTextAlignmentCenter];
    //[searchTextField setBackgroundColor:[UIColor grayColor]];
    [searchTextField setPlaceholder:@"Поиск..."];
    [searchTextField setReturnKeyType:UIReturnKeyDone];
    
    
 
    
}
- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)search:(UITextField*)textField
{
    NSPredicate *sPredicate =
    [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"SELF.name contains[c] '%@'", textField.text]];
    self.citys=[self.allcitys filteredArrayUsingPredicate:sPredicate];
    if(textField.text.length==0)
        self.citys=self.allcitys;
    [tableView reloadData];
}
-(void)viewDidAppear:(BOOL)animated
{
    [self startSpin];
    [self initGPS];

}

-(void)close
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)loadCitisWith:(CLLocation*)location
{
    if(location)
    {
        [Api citysGeoWithLocation:location token:TOKEN block:^(NSObject *result) {
            NSDictionary *item=(NSDictionary*)result;
            if(item&&[[item objectForKey:@"status"] integerValue]==200)
            {
                if([item objectForKey:@"data"])
                {
                    [self stopSpin];

                    self.allcitys=[item objectForKey:@"data"];
                    self.citys=self.allcitys;
                    if(self.citys.count==0)
                        [self loadCitisWith:nil];
                    else
                        [tableView reloadData];

                }
            }
            else
            {
                [self loadCitisWith:nil];
            }
        }];
    }
    else
    {
        [Api citysWithToken:TOKEN block:^(NSObject *result) {
            [self stopSpin];
            NSDictionary *item=(NSDictionary*)result;
            if(item&&[[item objectForKey:@"status"] integerValue]==200)
            {
                
            NSDictionary *item=(NSDictionary*)result;
            if([[item objectForKey:@"status"] integerValue]==200)
            {
                if([item objectForKey:@"data"])
                {
                    self.allcitys=[item objectForKey:@"data"];
                    self.citys=self.allcitys;
                    [tableView reloadData];
                }
            }
            }
            
        }];
    }
}
-(void)initGPS
{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        [self.locationManager requestWhenInUseAuthorization];
    
    [locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    CLLocation *location = [locations lastObject];
    self.location=location;
    [self loadCitisWith:location];
    [locationManager stopUpdatingLocation];

    NSLog(@"lat%f - lon%f", location.coordinate.latitude, location.coordinate.longitude);
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager*)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined: {
            [self loadCitisWith:nil];
        } break;
        case kCLAuthorizationStatusDenied: {
            [self loadCitisWith:nil];
        } break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        case kCLAuthorizationStatusAuthorizedAlways: {
            [locationManager startUpdatingLocation]; //Will update location immediately
        } break;
        default:
            break;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.citys.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *Id=[[self.citys objectAtIndex:indexPath.row] objectForKey:@"cityID"];
    NSString *name=[[self.citys objectAtIndex:indexPath.row] objectForKey:@"name"];
    [[NSUserDefaults standardUserDefaults] setObject:Id forKey:@"cityID"];
    [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"cityName"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc] init];
    NSDictionary *city=[self.citys objectAtIndex:indexPath.row];
    cell.textLabel.text=[city objectForKey:@"name"];
    [cell.textLabel setFont:[UIFont fontWithName:@"SFUIText-Regular" size:14 ]];
    return cell;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
