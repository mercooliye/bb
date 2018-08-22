#import "ARView.h"
#import "ARFormElement.h"

@interface ARLabel : UILabel <ARIView, ARFormElement> {

}

@property (nonatomic, assign) UIEdgeInsets edgeInsets;

@property (nonatomic, readonly) BOOL isActive;
@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *normalShadowColor;
@property (nonatomic, assign) CGSize normalShadowOffset;
@property (nonatomic, strong) UIColor *activeColor;
@property (nonatomic, strong) UIColor *activeShadowColor;
@property (nonatomic, assign) CGSize activeShadowOffset;

+(ARLabel *)labelWithFrame:(CGRect)frame
                      size:(NSUInteger)size
                      bold:(BOOL)bold
                     color:(UIColor *)color
               shadowColor:(UIColor *)shadowColor
              shadowOffset:(CGSize)shadowOffset;

+(ARLabel *)labelWithFrame:(CGRect)frame
                      text:(NSString *)text
                     color:(UIColor *)color;

+(ARLabel *)labelWithFrame:(CGRect)frame
                      size:(NSUInteger)size
                      bold:(BOOL)bold
                     color:(UIColor *)color;
+(ARLabel *)labelWithFrame:(CGRect)frame
                      font:(UIFont *)font
                     color:(UIColor *)color;
+(CGSize)sizeForText:(NSString *)text
                font:(UIFont *)font
             maxSize:(CGSize)maxSize
          edgeInsets:(UIEdgeInsets)edgeInsets;

+(CGSize)sizeForText:(NSString *)text
                font:(UIFont *)font
               width:(NSInteger)width
          edgeInsets:(UIEdgeInsets)edgeInsets;

+(CGSize)sizeForLabel:(ARLabel *)label
                width:(NSInteger)width;

- (id)initWithFrame:(CGRect)frame
               size:(NSUInteger)size
               bold:(BOOL)bold
              color:(UIColor *)color
        shadowColor:(UIColor *)shadowColor
       shadowOffset:(CGSize)shadowOffset;
- (id)initWithFrame:(CGRect)frame
               size:(NSUInteger)size
               bold:(BOOL)bold
              color:(UIColor *)color;
- (id)initWithFrame:(CGRect)frame
               font:(UIFont *)font
              color:(UIColor *)color;

-(void)setActive:(BOOL)isActive;

-(void)setupSize:(NSUInteger)size
            bold:(BOOL)bold
           color:(UIColor *)color
     shadowColor:(UIColor *)shadowColor
    shadowOffset:(CGSize)shadowOffset;

-(void)fit;
-(void)fitHeight;
-(void)fitWidth;
-(void)fitSizeForMaxWidth:(NSInteger)maxWidth;




@end
