//
//  TabBarButton.m
//  brronline
//
//  Created by Evgeniy Merkulov on 06.11.17.
//  Copyright © 2017 Evgeniy Merkulov. All rights reserved.
//

#import "TabBarButton.h"
#import "UIColor+Main.h"

@implementation TabBarButton
@synthesize line;
@synthesize unselectColor, selectColor;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    unselectColor =[UIColor clearColor];
    selectColor=[UIColor orange];
    float lineHeight=4;
    line=[[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height-lineHeight, frame.size.width, lineHeight)];
    [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self.titleLabel setTextColor:[UIColor blackColor]];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self addSubview:line];
    [self unselecting];
    
    return self;
}
-(void)unselecting
{
    [self setBackgroundColor:[UIColor whiteColor]];
    [line setBackgroundColor:unselectColor];
}

-(void)selecting
{
    //[self setBackgroundColor:[UIColor colorWithRed:0.99 green:0.99 blue:0.99 alpha:1.0]];
    [line setBackgroundColor:selectColor];
}
@end
