//
//  DetailInfoViewController.m
//  beautybox
//
//  Created by Evgeniy Merkulov on 06.08.2018.
//  Copyright © 2018 Evgeniy Merkulov. All rights reserved.
//

#import "DetailInfoViewController.h"

@interface DetailInfoViewController ()

@end

@implementation DetailInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.textView.text=self.text;
    self.textView.editable=NO;
    [self.textView sizeToFit];
}

-(void)viewWillAppear:(BOOL)animated
{
    [UIView animateWithDuration:.2 animations:^(void) {
        [self.view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.0]];
        [self.view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]];
    }];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [UIView animateWithDuration:.2 animations:^(void) {
        [self.view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]];
        [self.view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.0]];
    }];
}


- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
