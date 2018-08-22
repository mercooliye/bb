//
//  TabBar.m
//  brronline
//
//  Created by Evgeniy Merkulov on 06.11.17.
//  Copyright © 2017 Evgeniy Merkulov. All rights reserved.
//

#import "TabBar.h"
#import "UIColor+Main.h"

@implementation TabBar
@synthesize buttons;
@synthesize delegate;
@synthesize titles;

- (id)initWithFrame:(CGRect)frame titles:(NSArray*)titles
{
    self = [super initWithFrame:frame];
    buttons=[[NSMutableArray alloc]init];
     float width4=frame.size.width/titles.count;
    
    for(int i=0;i<titles.count;i++)
    {
        
        TabBarButton *button=[[TabBarButton alloc] initWithFrame:CGRectMake(width4*i, 0, width4, frame.size.height)];
        [button setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
        [self addSubview:button];
        button.tag=i;
        [button addTarget:nil action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
        if(i==0)
            [button selecting];
        [buttons addObject:button];
        
        float widthLine=0.5;
        UIView *bottomLine=[[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, 7)];
        [bottomLine setBackgroundColor:[UIColor colorWithWhite:235.0f / 255.0f alpha:1.0f]];
        [self addSubview:bottomLine];
        //UIView *line=[[UIView alloc] initWithFrame:CGRectMake(width4*i, 0, widthLine, frame.size.height)];
        //[line setBackgroundColor:[UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1.0]];
        //[self addSubview:line];
        
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    buttons=[[NSMutableArray alloc]init];
    if(!titles)
        titles=@[@"Фото",@"Обо мне",@"Лента"];
    float width4=frame.size.width/titles.count;

    for(int i=0;i<titles.count;i++)
    {

        TabBarButton *button=[[TabBarButton alloc] initWithFrame:CGRectMake(width4*i, 0, width4, frame.size.height)];
        [button setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
        [self addSubview:button];
        button.tag=i;
        [button addTarget:nil action:@selector(tap:) forControlEvents:UIControlEventTouchDown];
        if(i==0)
        [button selecting];
        [buttons addObject:button];
        
        float widthLine=0.5;
        UIView *line=[[UIView alloc] initWithFrame:CGRectMake(width4*i, 0, widthLine, frame.size.height)];
        [line setBackgroundColor:[UIColor orange]];
        [self addSubview:line];

    }
    
    return self;
}

-(void)setPosition:(int)index
{
    self.selectIndex=index;
    [self tap:[buttons objectAtIndex:index]];
}

-(void)setSelectPosition:(int)index
{
    for(TabBarButton *btn in buttons)
    {
        [btn unselecting];
    }
    [[buttons objectAtIndex:index] selecting];
}
-(void)tap:(TabBarButton*)button
{
    self.selectIndex=(int)button.tag;

    for(TabBarButton *btn in buttons)
    {
        [btn unselecting];
    }
    [button selecting];

    if (delegate && [delegate respondsToSelector:@selector(tapTabBar:)])
    {
        [delegate performSelector:@selector(tapTabBar:) withObject:button];
    }
}

@end
