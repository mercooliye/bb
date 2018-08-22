//
//  MainViewController.m
//  beautybox
//
//  Created by Evgeniy Merkulov on 15.07.18.
//  Copyright © 2018 Evgeniy Merkulov. All rights reserved.
//

#import "MainViewController.h"
#import "MainTableViewCell.h"
#import "CatsViewController.h"
#import "Singleton.h"
#import "SelectCityViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController
@synthesize tableView;
@synthesize cats;
@synthesize Ids;
@synthesize cityTextField;

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=YES;
    if(cityName)
        [cityTextField setPlaceholder:cityName];
    [self setTitle:@""];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    cityTextField.leftViewMode = UITextFieldViewModeAlways;

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, 15, cityTextField.frame.size.height)];
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    
    imageView.image = [UIImage imageNamed:@"loop"];
    [cityTextField addSubview:imageView];
    
    /*
    if(!CITY_ID)
    {
    NSString *Id=@"3";
    NSString *name=@"Балаково";
    [[NSUserDefaults standardUserDefaults] setObject:Id forKey:@"cityID"];
    [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"cityName"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    }
    */
    self.cats=@[@"Маникюр",@"Стрижка",@"Наращивание ресниц",
                @"Эстетика",@"Макияж"];
    Ids=@[@"1",@"10",@"7",@"6",@"5"];
    tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 65, self.width, self.height-120)];
    
    [tableView registerNib:[UINib nibWithNibName:@"MainTableViewCell" bundle:nil] forCellReuseIdentifier:@"MainTableViewCell"];
    
    tableView.tableHeaderView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 10)];
    
    [self.view addSubview:tableView];

    tableView.delegate=self;
    tableView.dataSource=self;
    
    tableView.tableFooterView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    tableView.separatorStyle=UITableViewCellSelectionStyleNone;
    [tableView setBackgroundColor:[UIColor clearColor]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;

}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleBlackOpaque;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cats.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

- (IBAction)selectCity:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SelectCityViewController *vc = (SelectCityViewController *)[storyboard instantiateViewControllerWithIdentifier:@"SelectCityViewController"];
    
    [self presentViewController:vc animated:YES completion:nil];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(cityID)
    {
    CatsViewController *vc=[[CatsViewController alloc] init];
    vc.index=indexPath.row;
    vc.name=[cats objectAtIndex:indexPath.row];
    vc.Id=[Ids objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        [self openMessage:@"Требуется выбрать город"];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MainTableViewCell*cell=(MainTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"MainTableViewCell" forIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    NSString *cat=[self.cats objectAtIndex:indexPath.row];

    [cell.backImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%ld.png", (long)indexPath.row]]];
    
    if(indexPath.row>4)
        [cell.backImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%ld.png", (long)indexPath.row-4]]];

    cell.leftLabel.hidden=NO;
    cell.rightLabel.hidden=NO;

    if(indexPath.row==0||
        indexPath.row==2||
       indexPath.row==4)
    {
        cell.rightLabel.text=cat;
        cell.leftLabel.hidden=YES;
    }
    else
    {
        cell.leftLabel.text=cat;
        cell.rightLabel.hidden=YES;

    }
        
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
