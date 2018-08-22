#import <UIKit/UIKit.h>

@protocol ARFormElement <NSObject>

@optional

-(void)setFormElementForm:(id)form;

@property (nonatomic) UIView *prevView;
@property (nonatomic) UIView *nextView;

@end
