//
//  ReviewsViewController.m
//  beautybox
//
//  Created by Evgeniy Merkulov on 06.08.2018.
//  Copyright © 2018 Evgeniy Merkulov. All rights reserved.
//

#import "ReviewsViewController.h"
#import "UIColor+Main.h"
#import "ReviewTableViewCell.h"
#import "AMRatingControlBig.h"
#import "NSString+Ending.h"
#import "NSDate+TimeAgo.h"

@interface ReviewsViewController ()

@end

@implementation ReviewsViewController
@synthesize tableView;
@synthesize reviews;

-(void)viewWillAppear:(BOOL)animated
{
    tableView.dataSource=self;
    tableView.delegate=self;
    [self setTitle:@"Отзывы"];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont fontWithName:@"SFUIText-Regular" size:14]}];
    
    self.navigationController.navigationBar.tintColor = [UIColor orange];
  

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [tableView registerNib:[UINib nibWithNibName:@"ReviewTableViewCell" bundle:nil] forCellReuseIdentifier:@"ReviewTableViewCell"];
    [tableView.tableHeaderView setBackgroundColor:[UIColor clearColor]];
    
    tableView.tableFooterView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self header];
}

-(void)header
{
    float h=350;
    tableView.tableHeaderView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, h)];
    UIView *header=[[UIView alloc] initWithFrame:CGRectMake(7, 10, self.width-14, h-18)];
    [header setBackgroundColor:[UIColor whiteColor]];
    [tableView.tableHeaderView addSubview:header];
    
    UILabel *ratingLabel=[[UILabel alloc] initWithFrame:CGRectMake(15, 10, 60, 60)];
    [ratingLabel setFont:[UIFont fontWithName:@"SFUIText-Regular" size:36]];
    [header addSubview:ratingLabel];
    ratingLabel.text=[NSString stringWithFormat:@"%.1f", [self.rating floatValue]];
    
    AMRatingControlBig *mainRatingControl= [[AMRatingControlBig alloc] initWithLocation:CGPointMake(60, 20) emptyColor:[UIColor clearColor] solidColor:[UIColor yelow] andMaxRating:5 ];
    mainRatingControl.frame=CGRectMake(90, 20, 150, 70);
    mainRatingControl.starSpacing=1;
    mainRatingControl.starFontSize=32;
    mainRatingControl.starWidthAndHeight=30;
    [header addSubview:mainRatingControl];
    mainRatingControl.rating=[self.rating integerValue];
    
    UILabel *countLabel=[[UILabel alloc] initWithFrame:CGRectMake(90, 65, 150, 25)];
    [countLabel setFont:[UIFont fontWithName:@"SFUIText-Regular" size:16]];
    [header addSubview:countLabel];
    countLabel.text=[NSString stringWithFormat:@"%@ %@", [self.master objectForKey:@"countReviews"]?:@"0", [NSString ending:[[self.master objectForKey:@"countReviews"] integerValue]    words:@[@"отзыв",@"отзыва",@"отзывов"]]];
    
    if(! [self.master objectForKey:@"countReviews"])
    {
        countLabel.text=[NSString stringWithFormat:@"Нет отзывов"];
    }
    NSArray *stars=@[@"countReviewsFive",@"countReviewsFour",@"countReviewsThere",@"countReviewsTwo",@"countReviewsOne"];
    NSInteger countReviws=[[self.master objectForKey:@"countReviews"] integerValue];
    
    for(int i=0; i<5;i++)
    {
       AMRatingControl *ratingControl = [[AMRatingControl alloc] initWithLocation:CGPointMake(15, 95+i*30) emptyColor:[UIColor clearColor] solidColor:[UIColor yelow] andMaxRating:5 ];
        ratingControl.rating=5-i;
        ratingControl.starWidthAndHeight=ratingControl.starWidthAndHeight+2;
        [ratingControl setUserInteractionEnabled:NO];
        [ratingControl setTintColor:[UIColor whiteColor]];
        [header addSubview:ratingControl];
        
        float widthLine=header.frame.size.width-140;
        
        float countStars=[[_master objectForKey:[stars objectAtIndex:i]] floatValue];
        
        UIView *lineLight=[[UIView alloc] initWithFrame:CGRectMake(130, 105+i*30, widthLine, 4)];
        [lineLight setBackgroundColor:[UIColor lightGray]];
        [header addSubview:lineLight];
        
        UIView *lineDark=[[UIView alloc] initWithFrame:CGRectMake(130, 105+i*30, countReviws!=0?(widthLine*(countStars/countReviws)):0, 4)];
        [lineDark setBackgroundColor:[UIColor lightGrayColor]];
        [header addSubview:lineDark];
    }
    
    UIButton *sendButton=[[UIButton alloc] initWithFrame:CGRectMake(10, h-85, header.frame.size.width-20, 50)];
    [sendButton.titleLabel setFont:[UIFont fontWithName:@"SFUIText-Regular" size:16]];
    [sendButton setBackgroundColor:[UIColor orange]];
    [sendButton setTitle:@"Оцените этот салон" forState:UIControlStateNormal];
    [header addSubview:sendButton];
    
}

#pragma mark - UITableViewDataSource
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *review=[reviews objectAtIndex:indexPath.row];
    ReviewTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ReviewTableViewCell"];
    cell.textView.text=[review objectForKey:@"message"];
    cell.nameLabel.text=[review objectForKey:@"name"];
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:[[review objectForKey:@"time"] floatValue]];
    cell.timeLabel.text=[NSString stringWithFormat:@"%@", [date dateTimeAgo]];

    cell.ratingControl.rating=[[review objectForKey:@"ratingUser"] integerValue];
    if(cell.ratingControl.rating==0)
        cell.ratingControl.hidden=YES;
    else
        cell.ratingControl.hidden=NO;

    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 
    return reviews.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewAutomaticDimension;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
