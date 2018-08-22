//
//  FstViewController.m
//  beautybox
//
//  Created by Evgeniy Merkulov on 11.07.18.
//  Copyright © 2018 Evgeniy Merkulov. All rights reserved.
//

#import "FstViewController.h"
#import "UIColor+Main.h"

@interface FstViewController ()
@property NSInteger pageNumber;
@end

@implementation FstViewController
-(void)changeTitle:(NSTimer*)timer
{
    CGRect frame = self.scrollView.frame;
    frame.origin.x = frame.size.width * self.pageNumber;
    frame.origin.y = 0;
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width*self.pageNumber, 0) animated:YES];
    self.pageNumber++;
    if(self.pageNumber==3)
        self.pageNumber=0;
}
-(void)viewDidDisappear:(BOOL)animated
{
    [self.timer invalidate];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   self.timer=[NSTimer scheduledTimerWithTimeInterval:5.0
                                     target:self
                                   selector:@selector(changeTitle:)
                                   userInfo:nil
                                    repeats:YES];
    UIButton *regBnt=[[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height-60, self.view.frame.size.width/2,60)];
    [regBnt setTitle:NSLocalizedString(@"РЕГИСТРАЦИЯ", @"РЕГИСТРАЦИЯ") forState:UIControlStateNormal];
    [regBnt setBackgroundColor:[UIColor orange]];
    [self.view addSubview:regBnt];
    
    UIButton *loginBnt=[[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-60, self.view.frame.size.width/2,60)];
    [loginBnt setTitle:NSLocalizedString(@"ВОЙТИ", @"ВОЙТИ") forState:UIControlStateNormal];
    [loginBnt setTitleColor:[UIColor orange] forState:UIControlStateNormal];
    [loginBnt setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:loginBnt];
    
    [loginBnt addTarget:nil action:@selector(login) forControlEvents:UIControlEventTouchDown];
    [regBnt addTarget:nil action:@selector(reg) forControlEvents:UIControlEventTouchDown];

    NSArray *titles=@[@"Все мастера, салоны красоты твоего города",@"Огромная база мастеров: цены, отзывы и фотографии работ ",@"Теперь поиск мастера не займет больше пяти минут"];
    self.pageController.numberOfPages=titles.count;
    _scrollView.pagingEnabled=YES;
    _scrollView.delegate=self;
    _scrollView.showsHorizontalScrollIndicator=NO;
    for(int i=0; i<titles.count;i++)
    {
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(30+i*self.width,10, self.width-60, 100)];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setTextColor:[UIColor whiteColor]];
        [label setNumberOfLines:3];
        [label setText:[titles objectAtIndex:i]];
        [_scrollView addSubview:label];
        [_scrollView setContentSize:CGSizeMake((i+1)*self.width, 0)];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageWidth = self.scrollView.frame.size.width; // you need to have a **iVar** with getter for scrollView
    float fractionalPage = self.scrollView.contentOffset.x / pageWidth;
    NSInteger page = lround(fractionalPage);
    self.pageController.currentPage = page; // you need to have a **iVar** with getter for pageControl
}

- (IBAction)skip:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *myVC = (UIViewController *)[storyboard instantiateViewControllerWithIdentifier:@"Main"];
    [self presentViewController:myVC animated:YES completion:nil];
    //pushViewController:myVC animated:YES];
 
}

-(void)reg{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    UIViewController *myVC = (UIViewController *)[storyboard instantiateViewControllerWithIdentifier:@"RegViewController"];
    [self.navigationController pushViewController:myVC animated:YES];
    self.navigationItem.title = @"";
    
}

-(void)login{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    UIViewController *myVC = (UIViewController *)[storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self.navigationController pushViewController:myVC animated:YES];
    self.navigationItem.title = @"";
    
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
