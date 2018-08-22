//
//  TabBar.h
//  brronline
//
//  Created by Evgeniy Merkulov on 06.11.17.
//  Copyright © 2017 Evgeniy Merkulov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarButton.h"

@protocol TabBarDelegate<NSObject>

@optional
- (void)tapTabBar:(UIButton*)button;
 @end

@interface TabBar : UIView
@property NSMutableArray *buttons;
-(void)setPosition:(int)index;
-(void)setSelectPosition:(int)index;
- (id)initWithFrame:(CGRect)frame titles:(NSArray*)titles;

@property (nonatomic, retain)id <TabBarDelegate> delegate;
@property NSArray *titles;
@property int selectIndex;
@end
