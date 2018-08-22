//
//  MastersViewController.m
//  beautybox
//
//  Created by Evgeniy Merkulov on 24.07.2018.
//  Copyright © 2018 Evgeniy Merkulov. All rights reserved.
//

#import "MastersViewController.h"
#import "Api.h"
#import "MasterTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "MasterViewController.h"
#import "Fav.h"
#import "SelectCityViewController.h"
#import "UIColor+Main.h"

@interface MastersViewController ()

@end

@implementation MastersViewController
@synthesize tableView;
@synthesize filterButton;
@synthesize textfieldTxt;

-(void)viewWillDisappear:(BOOL)animated
{
    [textfieldTxt removeFromSuperview];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden=NO;
    //[self setTitle:self.name];
    if(CITY)
        self.cityLabel.text=CITY;
    if(CITY_ID)
        self.cityId=CITY_ID;
    
    textfieldTxt = [[UITextField alloc]initWithFrame:CGRectMake(60, 11, self.width-120, 25)];
    textfieldTxt.backgroundColor = [UIColor graTextField];
    textfieldTxt.borderStyle=UITextBorderStyleRoundedRect;
    [textfieldTxt setAutocorrectionType:UITextAutocorrectionTypeNo];
    [textfieldTxt setPlaceholder:self.name];
    [textfieldTxt setFont:[UIFont fontWithName:@"SFUIText-Regular" size:13]];
    textfieldTxt.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 10, textfieldTxt.frame.size.height)];
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    imageView.image = [UIImage imageNamed:@"loop"];
    [textfieldTxt addSubview:imageView];
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 0)];
    textfieldTxt.leftView = paddingView;

    textfieldTxt.delegate = self;
    [self.navigationController.navigationBar addSubview:textfieldTxt];
    [self reload];
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.currentPage=0;

    UIImage* image3 = [UIImage imageNamed:@"sort"];
    CGRect frameimg = CGRectMake(15,5, 25,25);
    
    UIButton *sortBtn = [[UIButton alloc] initWithFrame:frameimg];
    [sortBtn setBackgroundImage:image3 forState:UIControlStateNormal];
    [sortBtn addTarget:self action:@selector(sort:)
         forControlEvents:UIControlEventTouchUpInside];
    [sortBtn setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *sortBtnItem =[[UIBarButtonItem alloc] initWithCustomView:sortBtn];
    self.navigationItem.rightBarButtonItem =sortBtnItem;
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont fontWithName:@"SFUIText-Regular" size:16]}];
    
    self.navigationController.navigationBar.tintColor = [UIColor orange];
    self.navigationController.navigationBarHidden=NO;
    [self setNeedsStatusBarAppearanceUpdate];

    
    tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.width, self.height-120)];

    
    [self.view addSubview:tableView];
    
    tableView.delegate=self;
    tableView.dataSource=self;
    
    tableView.tableFooterView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 60)];
    tableView.tableHeaderView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 60)];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeCity:)];
    
    [tableView.tableHeaderView addGestureRecognizer:tap];

    tableView.separatorStyle=UITableViewCellSelectionStyleNone;
    [tableView setBackgroundColor:[UIColor clearColor]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self.view addSubview:tableView];
    [tableView registerNib:[UINib nibWithNibName:@"MasterTableViewCell" bundle:nil] forCellReuseIdentifier:@"MasterTableViewCell"];

    
    filterButton=[[UIButton alloc] initWithFrame:CGRectMake(self.width-70, self.height-120, 60, 60)];
    [filterButton setImage:[UIImage imageNamed:@"filter"] forState:UIControlStateNormal];
    [self.view addSubview:filterButton];
    [filterButton addTarget:nil action:@selector(filter:) forControlEvents:UIControlEventTouchDown];
    
    [self reload];
}

-(void)reload
{
    self.currentPage=1;
    [self reload:1];
}
-(void)reload:(NSInteger)page
{
    if(!_loading)
    {
    _loading=YES;
    [self startSpin];

    if(self.serviceId)
        [Api mastersWithServiceId:self.serviceId categoryID:self.catId cityId:self.cityId page:page block:^(NSObject *result) {
            if(page==1)
                self.masters=[NSMutableArray new];

            if(result==nil)
                [self openMessage:@"Ошибка интернет соединения"];
            [self loadMasters:result];
        }];
    else
        [Api mastersWithCatId:self.catId cityId:self.cityId page:page block:^(NSObject *result) {
            if(page==1)
                self.masters=[NSMutableArray new];
            if(result==nil)
                [self openMessage:@"Ошибка интернет соединения"];
            [self loadMasters:result];
            
            
        }];
    }
}
-(void)sort:(UIButton*)sender
{
    
}

-(void)filter:(UIButton*)sender
{
    
}



-(void)loadMasters:(NSObject*)result
{
    [self stopSpin];

    NSDictionary *res=(NSDictionary*)result;
    
    if([res objectForKey:@"data"] )
    {
        if(self.masters==nil)
            self.masters=[NSMutableArray new];
        if([(NSArray*)[res objectForKey:@"data"] count]!=0)
        {
            [self.masters addObjectsFromArray:[res objectForKey:@"data"]];
            self.currentPage++;
            [tableView reloadData];
            _loading=NO;
        }

    }
    

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.masters.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_masters.count>0)
    {
        NSDictionary *master=[self.masters objectAtIndex:indexPath.row];
       ARLabel* nameTextView=[[ARLabel alloc] initWithFrame:CGRectMake(22, 250, self.view.frame.size.width-100, 0)];
        [nameTextView setNumberOfLines:2];
       ARLabel* addressTextView=[[ARLabel alloc] initWithFrame:CGRectMake(22, self.view.frame.size.width-100, 0, 0)];
        [addressTextView setNumberOfLines:2];
        [nameTextView setText:[master objectForKey:@"name"]];
        [nameTextView fitHeight];
        float h=nameTextView.height;
        [addressTextView setFrame:CGRectMake(22, h+5, self.view.frame.size.width-40, 0)];
        [addressTextView setText:[master objectForKey:@"address"]];
        [addressTextView fitHeight];
        [nameTextView setBackgroundColor:[UIColor clearColor]];
        [addressTextView setBackgroundColor:[UIColor clearColor]];
        
    if([[[_masters objectAtIndex:indexPath.row] objectForKey:@"ratingReviews"] integerValue]==0)
        return 420+addressTextView.y+addressTextView.height;
    else
        return 440+addressTextView.y+addressTextView.height;

    
    }
    return 500;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self setTitle:@""];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MasterViewController *vc = (MasterViewController *)[storyboard instantiateViewControllerWithIdentifier:@"MasterViewController"];
    vc.master=[_masters objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MasterTableViewCell*cell=(MasterTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"MasterTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    NSDictionary *master=[self.masters objectAtIndex:indexPath.row];
    NSArray *files=[master objectForKey:@"files"];
    [cell.logoImageView sd_setImageWithURL:[NSURL URLWithString:[files objectAtIndex:0]]];

    NSArray *services=[master objectForKey:@"services"];
    
    //cell.nameLabel.text=[master objectForKey:@"name"];
    [cell setName:[master objectForKey:@"name"] Address:[NSString stringWithFormat:@"%@",[master objectForKey:@"address"]?:@""]];
    [cell setName:[master objectForKey:@"name"] Address:[NSString stringWithFormat:@"%@",[master objectForKey:@"address"]?:@""]];
    //cell.addressTextView.text=[NSString stringWithFormat:@"%@",[master objectForKey:@"address"]?:@""];
 
    NSMutableDictionary *grayAttr = [@{NSFontAttributeName:[UIFont fontWithName:@"SFUIText-Regular" size:13],
                                                NSForegroundColorAttributeName:[UIColor lightGrayColor] }mutableCopy];
    if(services.count>0)
    {
        cell.service1PriceLabel.text=[NSString stringWithFormat:@"%@", [[services objectAtIndex:0] objectForKey:@"price"]];
        cell.service1NameLabel.text=[NSString stringWithFormat:@"%@", [[services objectAtIndex:0] objectForKey:@"name"]];
        
        cell.price1TextView.text=[NSString stringWithFormat:@"от %@ ₽", [[services objectAtIndex:0] objectForKey:@"price"]];
    
        
        [cell.price1TextView linkString:@"от"
                      defaultAttributes:grayAttr
                  highlightedAttributes:grayAttr
                             tapHandler:^(NSString *linkedString) {
                                 
                             }];
        [cell.price1TextView linkString:@"₽"
                      defaultAttributes:grayAttr
                  highlightedAttributes:grayAttr
                             tapHandler:^(NSString *linkedString) {
                                 
                             }];
    }
    if(services.count>1)
    {
        cell.service2PriceLabel.text=[NSString stringWithFormat:@"%@", [[services objectAtIndex:1] objectForKey:@"price"]];
        cell.service2NameLabel.text=[NSString stringWithFormat:@"%@", [[services objectAtIndex:1] objectForKey:@"name"]];
        
        cell.price2TextView.text=[NSString stringWithFormat:@"от %@ ₽", [[services objectAtIndex:1] objectForKey:@"price"]];
        
        
        [cell.price2TextView linkString:@"от"
                      defaultAttributes:grayAttr
                  highlightedAttributes:grayAttr
                             tapHandler:^(NSString *linkedString) {
                                 
                             }];
        [cell.price2TextView linkString:@"₽"
                      defaultAttributes:grayAttr
                  highlightedAttributes:grayAttr
                             tapHandler:^(NSString *linkedString) {
                                 
                             }];

    }
    if(services.count>2)
    {
        cell.service3PriceLabel.text=[NSString stringWithFormat:@"%@", [[services objectAtIndex:2] objectForKey:@"price"]];
        cell.service3NameLabel.text=[NSString stringWithFormat:@"%@", [[services objectAtIndex:2] objectForKey:@"name"]];

        cell.price3TextView.text=[NSString stringWithFormat:@"от %@ ₽", [[services objectAtIndex:2] objectForKey:@"price"]];
        
        
        [cell.price3TextView linkString:@"от"
                      defaultAttributes:grayAttr
                  highlightedAttributes:grayAttr
                             tapHandler:^(NSString *linkedString) {
                                 
                             }];
        [cell.price3TextView linkString:@"₽"
                      defaultAttributes:grayAttr
                  highlightedAttributes:grayAttr
                             tapHandler:^(NSString *linkedString) {
                                 
                             }];
    }
    

    
    [cell.service1PriceLabel sizeToFit];
    [cell.service2PriceLabel sizeToFit];
    [cell.service3PriceLabel sizeToFit];

    
    //cell.addressLabel.text=[NSString stringWithFormat:@"%@",[master objectForKey:@"address"]?:@""];
    cell.countReviews.text=@"";
    [cell.textLabel setFont:[UIFont fontWithName:@"SFUIText-Regular" size:14 ]];
    cell.ratingControl.rating=[[master objectForKey:@"ratingReviews"] integerValue]?:0;
        if([master objectForKey:@"countReviews"])
    cell.countReviews.text=[NSString stringWithFormat:@"(%@)",[master objectForKey:@"countReviews"]];
    if(cell.ratingControl.rating==0)
    {
        cell.countReviews.hidden=YES;
        cell.ratingControl.hidden=YES;
    }
    else
    {
        cell.countReviews.hidden=NO;
        cell.ratingControl.hidden=NO;
    }
    
    if(!TOKEN)
    {
        cell.favButton.hidden=YES;
        cell.favIconImageView.hidden=YES;
    }
    else
    {
    cell.favButton.tag=indexPath.row;
    if([[master objectForKey:@"favorite"] integerValue]==1)
    {
        [cell.favButton setImage:[UIImage imageNamed:@"love_sel"] forState:UIControlStateNormal];
        cell.favButton.selected=YES;
    }
    else
    {
        [cell.favButton setImage:[UIImage imageNamed:@"fav"] forState:UIControlStateNormal];
        cell.favButton.selected=NO;

    }
    }
    [cell.favButton addTarget:nil action:@selector(fav:) forControlEvents:UIControlEventTouchDown];

    return cell;
}
- (IBAction)changeCity:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SelectCityViewController *vc = (SelectCityViewController *)[storyboard instantiateViewControllerWithIdentifier:@"SelectCityViewController"];

    [self presentViewController:vc animated:YES completion:nil];

}

-(void)fav:(UIButton*)sender
{
    int index=sender.tag;
    NSDictionary *master=[self.masters objectAtIndex:index];
    NSString *Id= [master objectForKey:@"userID"];
    
    if(!sender.selected)
    {
        sender.selected=YES;
        [sender setImage:[UIImage imageNamed:@"love_sel"] forState:UIControlStateNormal];
        [Api masterAddFav:Id block:^(NSObject *result) {
        }];
    }
    else
    {
       
        sender.selected=NO;
        [sender setImage:[UIImage imageNamed:@"fav"] forState:UIControlStateNormal];
        [Api masterDeleteFav:Id block:^(NSObject *result) {
        }];
    }
    
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.textfieldTxt resignFirstResponder];
    CGFloat height = scrollView.frame.size.height;
    CGFloat contentYoffset = scrollView.contentOffset.y;
    CGFloat distanceFromBottom = scrollView.contentSize.height - contentYoffset;
    if(distanceFromBottom-height < 10&&!_loading)
    {
        NSLog(@"end of the table");
        [self reload:self.currentPage];
    }
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
