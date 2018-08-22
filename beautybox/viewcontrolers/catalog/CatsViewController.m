//
//  CatsViewController.m
//  beautybox
//
//  Created by Evgeniy Merkulov on 23.07.2018.
//  Copyright © 2018 Evgeniy Merkulov. All rights reserved.
//

#import "CatsViewController.h"
#import "Api.h"
#import "MastersViewController.h"
#import "Singleton.h"
#import "UIViewController+Utils.h"
#import "UIColor+Main.h"

@interface CatsViewController ()

@end

@implementation CatsViewController
@synthesize tableView;
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=NO;
    [self setTitle:_name];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont fontWithName:@"SFUIText-Regular" size:16]}];
    
    self.navigationController.navigationBar.tintColor = [UIColor orange];
    self.navigationController.navigationBarHidden=NO;
    [self setNeedsStatusBarAppearanceUpdate];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 65, self.width, self.height-120)];
    
    UIImageView *header=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, 200)];
    [header setContentMode:UIViewContentModeScaleAspectFill];
    [header setClipsToBounds:YES];
    [header setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%ld.png", (long)self.index]]];
    tableView.tableHeaderView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 200)];
    [tableView.tableHeaderView addSubview:header];
    [self.view addSubview:tableView];
    
    tableView.delegate=self;
    tableView.dataSource=self;
    
    tableView.tableFooterView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    tableView.separatorStyle=UITableViewCellSelectionStyleNone;
    [tableView setBackgroundColor:[UIColor clearColor]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self.view addSubview:tableView];
    
    [self startSpin];
    [Api categoryWithId:self.Id token:TOKEN block:^(NSObject *result) {
        if(result==nil)
            [self openMessage:@"Ошибка интернет соединения"];
        self.cats= [((NSDictionary*)result) objectForKey:@"data"];
        [self stopSpin];
        [tableView reloadData];
    }];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cats.count+1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(cityID)
    {
    [self setTitle:@""];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MastersViewController *vc = (MastersViewController *)[storyboard instantiateViewControllerWithIdentifier:@"MastersViewController"];
    vc.name=@"Все услуги";

    if(indexPath.row!=0){
            NSString *serviceID=[NSString stringWithFormat:@"%@",[[self.cats objectAtIndex:indexPath.row-1] objectForKey:@"serviceID"]];
            vc.serviceId=serviceID;
    vc.name=[[self.cats objectAtIndex:indexPath.row-1] objectForKey:@"title"];
    [vc setTitle:vc.name];
    }
    
    vc.catId=self.Id;
    vc.cityId=cityID;
    [self.navigationController pushViewController:vc animated:YES];
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc] init];
    for(UIView *v in cell.contentView.subviews)
        [v removeFromSuperview];
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(25, 0, self.width-60, 50)];
    [cell.contentView addSubview:label];
    [label setFont:[UIFont fontWithName:@"SFUIText-Regular" size:15 ]];

    if(indexPath.row==0)
        label.text=@"Все услуги";
    else
    {
    NSDictionary *cat=[self.cats objectAtIndex:indexPath.row-1];
    label.text=[cat objectForKey:@"title"];
    }
    
    UIView *line=[[UIView alloc] initWithFrame:CGRectMake(0, 49, self.width, 1)];
    [line setBackgroundColor:[UIColor blackColor]];
    line.alpha=0.13;
    [cell.contentView addSubview:line];
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
