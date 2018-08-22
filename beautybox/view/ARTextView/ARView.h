#import <UIKit/UIKit.h>

@protocol ARIView

@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) float x;
@property (nonatomic, assign) float y;
@property (nonatomic, assign) float width;
@property (nonatomic, assign) float height;
@property (nonatomic, readonly) float bottom;

@end

@interface ARView : UIView <ARIView>

@property (nonatomic, assign) float borderWidth;
@property (nonatomic, assign) float cornerRadius;
@property (nonatomic, strong) UIColor *borderColor;

+(ARView *)wrapper:(UIView *)view;

+(ARView *)wrapperWithPadding:(id <ARIView>)view
                          top:(NSInteger)top
                        right:(NSInteger)right
                       bottom:(NSInteger)bottom
                         left:(NSInteger)left;
@end
