//
//  UIViewController+Utils.m
//  beautybox
//
//  Created by Evgeniy Merkulov on 11.07.18.
//  Copyright © 2018 Evgeniy Merkulov. All rights reserved.
//

#import "UIViewController+Utils.h"
#import "UIColor+Main.h"
@implementation UIViewController (Utils)


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


-(double)width
{
    return self.view.frame.size.width;
}

-(double)height
{
    return self.view.frame.size.height;
}
-(void)registerNoteKeyBoard
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}
-(void)openMessage:(NSString*)message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    if(self)
        [self presentViewController:alert animated:YES completion:nil];
    
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if ([scrollView.panGestureRecognizer translationInView:scrollView.superview].y > 0) {
        [self.view endEditing:YES];
        
    } else {
    }
}



-(void)startSpin
{
    if(self.spinner&&self.spinner.superview)
    {
        [self.spinner forceBeginRefreshing];
    }
    else
    {
        self.spinner=[[JTMaterialSpinner alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
        self.spinner.center=self.view.center;
        [self.view addSubview:self.spinner];
        
        self.spinner.circleLayer.lineWidth=2.0;
        self.spinner.circleLayer.strokeColor=[UIColor orange].CGColor;
        [self.spinner forceBeginRefreshing];
    }
    
}
-(void)stopSpin
{
    [self.spinner removeFromSuperview];
}

@end
