#import "ARView.h"
#import <QuartzCore/QuartzCore.h>

@implementation ARView

-(void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

-(CGPoint)origin
{
    return self.frame.origin;
}

-(void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

-(CGSize)size
{
    return self.frame.size;
}

-(void)setX:(float)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

-(float)x
{
    return self.frame.origin.x;
}

-(void)setY:(float)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

-(float)y
{
    return self.frame.origin.y;
}

-(void)setWidth:(float)w
{
    CGRect frame = self.frame;
    frame.size.width = w;
    self.frame = frame;
}

-(float)width
{
    return self.frame.size.width;
}

-(void)setHeight:(float)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

-(float)height
{
    return self.frame.size.height;
}

-(float)bottom
{
    return self.y + self.height;
}


+(ARView *)wrapper:(UIView *)view
{
    ARView *wrapper = [[ARView alloc] initWithFrame:CGRectZero];
    wrapper.autoresizesSubviews = YES;
    wrapper.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    if (view){
        wrapper.size = view.frame.size;
        [wrapper addSubview:view];
    }
    
    return wrapper;
}

+(ARView *)wrapperWithPadding:(id <ARIView>)view
                          top:(NSInteger)top
                        right:(NSInteger)right
                       bottom:(NSInteger)bottom
                         left:(NSInteger)left
{
    ARView *wrapper = [[ARView alloc] initWithFrame:CGRectZero];
    wrapper.tag = 100;
    wrapper.autoresizesSubviews = YES;
    wrapper.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    if (view){
        wrapper.height = view.height + top + bottom;
        wrapper.width = view.width + left + right;
        view.x = left;
        view.y = top;
        [wrapper addSubview:(UIView *)view];

    }
    
    return wrapper;
}

-(void)setBorderWidth:(float)width
{
    self.layer.borderWidth = width;
}

-(float)borderWidth
{
    return self.layer.borderWidth;
}

-(void)setBorderColor:(UIColor *)color
{
    self.layer.borderColor = [color CGColor];
}

-(UIColor *)borderColor
{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

-(void)setCornerRadius:(float)radius
{
    if (radius > 0) self.layer.masksToBounds = YES;
    self.layer.cornerRadius = radius;
}

-(float)cornerRadius
{
    return self.layer.cornerRadius;
}

@end
