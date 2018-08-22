//
//  TabBarViewController.m
//  amidstyle
//
//  Created by Evgeniy Merkulov on 24.01.18.
//  Copyright © 2018 Evgeniy Merkulov. All rights reserved.
//

#import "TabBarViewController.h"
#import "UIColor+Main.h"
#import "MainViewController.h"
#import "Api.h"
#import "FstViewController.h"


#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.delegate=self;
    UITabBar *tab=self.tabBar;
    tab.barTintColor=[UIColor whiteColor];
    
    float size=9.0f;
    if(IS_IPHONE_5)
        size=7.5f;
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor orange], NSForegroundColorAttributeName,
                                                       [UIFont fontWithName:@"ProximaNova-Bold" size:size],NSFontAttributeName,
                                                       nil] forState:UIControlStateSelected];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor blackColor], NSForegroundColorAttributeName,
                                                       [UIFont fontWithName:@"ProximaNova-Bold" size:size],NSFontAttributeName,
                                                       nil] forState:UIControlStateNormal];
    
    
    
    tab.items[0].image=[[UIImage imageNamed:@"home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tab.items[0].selectedImage=[[UIImage imageNamed:@"home_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //tab.items[0].title=NSLocalizedString(@"Главная", @"Главная");
    tab.items[0].imageInsets=UIEdgeInsetsMake(5, 0, -5, 0);

    
    tab.items[1].image=[[UIImage imageNamed:@"mess"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tab.items[1].selectedImage=[[UIImage imageNamed:@"mess_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //tab.items[1].title=NSLocalizedString(@"Услуги", @"Услуги");
    tab.items[1].imageInsets=UIEdgeInsetsMake(5, 0, -5, 0);

    tab.items[2].image=[[UIImage imageNamed:@"fav"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tab.items[2].selectedImage=[[UIImage imageNamed:@"fav_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //tab.items[2].title=NSLocalizedString(@"Избранное", @"Избранное");
    tab.items[2].imageInsets=UIEdgeInsetsMake(5, 0, -5, 0);

    tab.items[3].image=[[UIImage imageNamed:@"prof"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tab.items[3].selectedImage=[[UIImage imageNamed:@"prof_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //tab.items[3].title=NSLocalizedString(@"Профиль", @"Профиль");
    tab.items[3].imageInsets=UIEdgeInsetsMake(5, 0, -5, 0);

    
    for(int i=0;i<tab.items.count;i++)
    {
        tab.items[i].title=[tab.items[i].title uppercaseString];
    }

    
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if(tabBarController.selectedIndex==0)
    {
        
    }
    else
    {
        if(!TOKEN)
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
            UINavigationController *myVC = (UINavigationController *)[storyboard instantiateViewControllerWithIdentifier:@"main"];
            [viewController presentViewController:myVC animated:YES completion:nil];
        }
    }
}
- (void)viewWillLayoutSubviews {
    
    const float t_height=55;
    CGRect tabFrame = self.tabBar.frame;
    tabFrame.size.height = t_height;
    tabFrame.origin.y = self.view.frame.size.height - t_height;
    self.tabBar.frame = tabFrame;
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
