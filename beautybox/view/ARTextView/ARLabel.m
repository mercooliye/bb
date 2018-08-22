#import "ARLabel.h"

@interface ARLabel()
-(void)setupSize:(NSUInteger)size
            bold:(BOOL)bold
           color:(UIColor *)color
     shadowColor:(UIColor *)shadowColor
    shadowOffset:(CGSize)shadowOffset;
@end

@implementation ARLabel


+(ARLabel *)labelWithFrame:(CGRect)frame
                      size:(NSUInteger)size
                      bold:(BOOL)bold
                     color:(UIColor *)color
               shadowColor:(UIColor *)shadowColor
              shadowOffset:(CGSize)shadowOffset
{
    return [[ARLabel alloc] initWithFrame:frame
                                     size:size
                                     bold:bold
                                    color:color
                              shadowColor:shadowColor
                             shadowOffset:(CGSize)shadowOffset];
}

+(ARLabel *)labelWithFrame:(CGRect)frame
                      size:(NSUInteger)size
                      bold:(BOOL)bold
                     color:(UIColor *)color
{
    return [[ARLabel alloc] initWithFrame:frame
                                     size:size
                                     bold:bold
                                    color:color];
}

+(ARLabel *)labelWithFrame:(CGRect)frame
                      text:(NSString *)text
                     color:(UIColor *)color
{
    
    int fontSize = 80;
    int minFontSize = 8;
    
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //paragraphStyle.lineSpacing = 0;
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    //NSDictionary *attributes = @{NSParagraphStyleAttributeName: paragraphStyle};
    //NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:text
    //                                                                     attributes:attributes];

    CGSize constraintSize = CGSizeMake(frame.size.width, MAXFLOAT);

    NSInteger w = frame.size.width;
    NSInteger h = frame.size.height;
    ARLabel *label = [[ARLabel alloc] initWithFrame:frame
                                     size:fontSize
                                     bold:NO
                                    color:color];
    label.numberOfLines = (([text rangeOfCharacterFromSet:[NSCharacterSet whitespaceCharacterSet]]).location == NSNotFound)?1:0;
    label.textAlignment = NSTextAlignmentCenter;
    CGRect textRect;
    do {
        UIFont *font = [UIFont systemFontOfSize:fontSize];
        textRect = [text boundingRectWithSize:constraintSize
                                      options:label.numberOfLines?NSStringDrawingUsesFontLeading|NSStringDrawingUsesDeviceMetrics:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesDeviceMetrics
                                          attributes:@{NSFontAttributeName:font, NSParagraphStyleAttributeName: paragraphStyle}
                                             context:nil];
        
        if (textRect.size.height <= h && textRect.size.width <= w) {
            break;
        }
        fontSize -= 2;
    } while (fontSize >= minFontSize);
    
    label.font = [UIFont systemFontOfSize:fontSize];
    CGRect rect = CGRectMake(0, 0, textRect.size.width-textRect.origin.x+20, textRect.size.height-textRect.origin.y+20);
    rect = [ARLabel normalizeRect:rect];
    label.frame = rect;
    label.text = text;
    
    return label;
}

+(CGRect)normalizeRect:(CGRect)rect
{
    int x = ceil(rect.origin.x);
    if (x%2 != 0) x += 1;
    int y = ceil(rect.origin.y);
    if (y%2 != 0) y += 1;
    int w = ceil(rect.size.width);
    if (w%2 != 0) w += 1;
    int h = ceil(rect.size.height);
    if (h%2 != 0) h += 1;
    
    return CGRectMake(x, y, w, h);
}

+(ARLabel *)labelWithFrame:(CGRect)frame
                      font:(UIFont *)font
                     color:(UIColor *)color
{
    return [[ARLabel alloc] initWithFrame:frame
                                     font:font
                                    color:color];
}


- (id)initWithFrame:(CGRect)frame
               size:(NSUInteger)size
               bold:(BOOL)bold
              color:(UIColor *)color
        shadowColor:(UIColor *)shadowColor
       shadowOffset:(CGSize)shadowOffset
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSize:size bold:bold color:color shadowColor:shadowColor shadowOffset:shadowOffset];
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
               size:(NSUInteger)size
               bold:(BOOL)bold
              color:(UIColor *)color
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSize:size bold:bold color:color shadowColor:nil shadowOffset:CGSizeZero];
        self.edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
               font:(UIFont *)font
              color:(UIColor *)color
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.autoresizingMask = UIViewAutoresizingNone;
        self.textColor = color;
        self.shadowColor = [UIColor clearColor];
        self.shadowOffset = CGSizeZero;
        self.font = font;
        
        self.normalColor = color;
        self.normalShadowColor = color;
        self.normalShadowOffset = CGSizeZero;
        
        self.activeColor = color;
        self.activeShadowColor = color;
        self.activeShadowOffset = CGSizeZero;
        
        self.edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return self;
}

-(void)setupSize:(NSUInteger)size
            bold:(BOOL)bold
           color:(UIColor *)color
     shadowColor:(UIColor *)shadowColor
    shadowOffset:(CGSize)shadowOffset
{
    self.backgroundColor = [UIColor clearColor];
    self.autoresizingMask = UIViewAutoresizingNone;
    self.textColor = color;
    self.shadowColor = shadowColor;
    self.shadowOffset = shadowOffset;
    self.font = bold?[UIFont boldSystemFontOfSize:size]:[UIFont systemFontOfSize:size];
    
    self.normalColor = color;
    self.normalShadowColor = shadowColor;
    self.normalShadowOffset = shadowOffset;
    
    self.activeColor = color;
    self.activeShadowColor = shadowColor;
    self.activeShadowOffset = shadowOffset;
}

-(void)setActive:(BOOL)isActive{
    _isActive = isActive;
    
    self.textColor = _isActive?self.activeColor:self.normalColor;
    self.shadowColor = _isActive?self.activeShadowColor:self.normalColor;
    self.shadowOffset = _isActive?self.activeShadowOffset:self.normalShadowOffset;
}

-(void)fitHeight
{
    CGSize size = [ARLabel sizeLabel:self];
    int h = size.height;
    if (h%2 != 0) h += 1;
    self.height = h;
}

-(void)fitWidth
{
    CGSize size = [ARLabel sizeForText:self.text font:self.font maxSize:CGSizeMake(SHRT_MAX, self.height) edgeInsets:self.edgeInsets];
    int w = size.width;
    if (w%2 != 0) w += 1;
    self.width = w;
}

-(void)fit
{
    CGSize size = [ARLabel sizeLabel:self];
    NSInteger h = size.height + self.edgeInsets.bottom + self.edgeInsets.top;
    if (h%2 != 0) h += 1;
    NSInteger w = size.width + self.edgeInsets.left + self.edgeInsets.right;
    if (w%2 != 0) w += 1;
    self.size = CGSizeMake(w, h);
}

-(void)fitSizeForMaxWidth:(NSInteger)maxWidth
{
    CGSize size = [ARLabel sizeForText:self.text font:self.font maxSize:CGSizeMake(maxWidth, SHRT_MAX) edgeInsets:self.edgeInsets];
    [self setSize:size];
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
    
}

+(CGSize)sizeForText:(NSString *)text
                font:(UIFont *)font
             maxSize:(CGSize)maxSize
          edgeInsets:(UIEdgeInsets)edgeInsets
{
    if (!text.length) return CGSizeZero;
    
    NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:text
                                                                   attributes:@{ NSFontAttributeName: font }];
    
    CGRect rect = [attrText boundingRectWithSize:maxSize
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                         context:nil];
    
    int height = ceil(rect.size.height) + edgeInsets.bottom + edgeInsets.top;
    if (height%2 != 0) height += 1;
    
    int width = ceil(rect.size.width) + edgeInsets.left + edgeInsets.right;
    if (width%2 != 0) width += 1;
    
    rect.size.height = height;
    rect.size.width = width;
    
    return rect.size;
}

+(CGSize)sizeForText:(NSString *)text
                font:(UIFont *)font
               width:(NSInteger)width
          edgeInsets:(UIEdgeInsets)edgeInsets
{
    return [ARLabel sizeForText:text font:font maxSize:CGSizeMake(width, SHRT_MAX) edgeInsets:edgeInsets];
}

+(CGSize)sizeForLabel:(ARLabel *)label
                width:(NSInteger)width
{
    return [ARLabel sizeForText:label.text
                           font:label.font
                        maxSize:CGSizeMake(width-label.edgeInsets.left - label.edgeInsets.right,label.height-label.edgeInsets.top - label.edgeInsets.bottom)
                     edgeInsets:label.edgeInsets];

}

+(CGSize)sizeLabel:(ARLabel *)label
{
    return [ARLabel sizeForText:label.text font:label.font width:label.frame.size.width - label.edgeInsets.left - label.edgeInsets.right edgeInsets:label.edgeInsets];
}

- (void)drawTextInRect:(CGRect)rect
{
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.edgeInsets)];
}

@end
