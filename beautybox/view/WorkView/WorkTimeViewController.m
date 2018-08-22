//
//  WorkTimeViewController.m
//  beautybox
//
//  Created by Evgeniy Merkulov on 02.08.2018.
//  Copyright © 2018 Evgeniy Merkulov. All rights reserved.
//

#import "WorkTimeViewController.h"
#import "UIViewController+Utils.h"

@interface WorkTimeViewController ()

@end

@implementation WorkTimeViewController
@synthesize workView;
@synthesize work;
@synthesize scrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    scrollView=[[UIScrollView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:scrollView];

    workView = [[[NSBundle mainBundle] loadNibNamed:@"WorkView" owner:self options:nil] objectAtIndex:0];
    workView.frame=CGRectMake(0, 0, self.width-40, workView.bounds.size.height);
    [workView.exitButton addTarget:nil action:@selector(close) forControlEvents:UIControlEventTouchDown];
    [scrollView addSubview:workView];
    [scrollView setContentSize:CGSizeMake(0, self.height)];
    [workView setCenter:self.view.center];
   
    /*
    workView.mondayTime.text=[NSString stringWithFormat:@"%@-%@", [[work objectAtIndex:0] objectForKey:@"timeOff"],[[work objectAtIndex:0] objectForKey:@"timeTo"]];
    workView.thusdayTime.text=[NSString stringWithFormat:@"%@-%@", [[work objectAtIndex:1] objectForKey:@"timeOff"],[[work objectAtIndex:1] objectForKey:@"timeTo"]];
    */
    
    int i=0;
    for(UILabel *label in workView.labels)
    {
        if(work.count>i)
        {
            if([[[work objectAtIndex:i] objectForKey:@"day"] isEqualToString:[workView.days objectAtIndex:i]])
                label.text=[NSString stringWithFormat:@"%@-%@", [[work objectAtIndex:i] objectForKey:@"timeOff"],[[work objectAtIndex:i] objectForKey:@"timeTo"]];
            else
            {
                label.hidden=YES;
                ((UILabel*)[workView.holidays objectAtIndex:i]).hidden=NO;
            }
        
        }
        i++;
    }
    for(UILabel *label in workView.holidays)
        label.hidden=YES;
    
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:[NSDate date]];
    int weekday = [components weekday];
    if([components weekday]==0)
        weekday=8;
    if([components weekday]==1)
        weekday=2;
    [workView.todayLabel setCenter:CGPointMake(workView.todayLabel.center.x, ((UILabel*)[workView.holidays objectAtIndex:weekday-2]).center.y)];
    
}

static inline NSString *stringFromWeekday(int weekday)
{
    static NSString *strings[] = {
        @"Sunday",
        @"Monday",
        @"Tuesday",
        @"Wednesday",
        @"Thursday",
        @"Friday",
        @"Saturday",
    };
    
    return strings[weekday - 1];
}





-(void)viewWillAppear:(BOOL)animated
{
    [UIView animateWithDuration:.2 animations:^(void) {
        [scrollView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.0]];
        [scrollView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]];
    }];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [UIView animateWithDuration:.2 animations:^(void) {
        [scrollView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]];
        [scrollView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.0]];
    }];
}

-(void)close
{
    [self dismissViewControllerAnimated:NO completion:nil];
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
