#import "ARTextView.h"

@implementation ARTextView

@synthesize prevView;
@synthesize nextView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

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
    int v = y;
    if (v%2 != 0) v += 1;
    
    CGRect frame = self.frame;
    frame.origin.y = v;
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

-(void)setFormElementForm:(id)form
{
    if ([form conformsToProtocol:@protocol(UITextViewDelegate)]){
        self.delegate = form;
    }
}




@end
