//
//  TabBarButton.h
//  brronline
//
//  Created by Evgeniy Merkulov on 06.11.17.
//  Copyright © 2017 Evgeniy Merkulov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabBarButton : UIButton
@property UIView *line;
-(void)unselecting;
-(void)selecting;
@property UIColor *selectColor;
@property UIColor *unselectColor;
@end
