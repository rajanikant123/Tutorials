

#import "TableViewPagerPageControl.h"

@implementation TableViewPagerPageControl

@synthesize leftView = _leftView;
@synthesize rightView = _rightView;
@synthesize centerView = _centerView;
@synthesize showTitles = _showTitles;

- (void)setupViewHierachy {
    
    float height = self.frame.size.height;
    float width = self.frame.size.width;
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, height)];
    self.rightView = [[UIView alloc] initWithFrame:CGRectMake(width - 20, 0, 20, height)]; 
    self.centerView = [[UIView alloc] initWithFrame:CGRectMake(20, 0, width - 40, height)]; 
    
    self.leftView.backgroundColor = [UIColor clearColor];
    self.rightView.backgroundColor = [UIColor clearColor];
    self.centerView.backgroundColor = [UIColor clearColor];
    
    self.leftView.autoresizesSubviews = YES;
    self.rightView.autoresizesSubviews = YES;
    self.centerView.autoresizesSubviews = YES;
    
    // Used to hide the three dots if showTitles is set to YES
    self.leftView.tag = 900;
    self.rightView.tag = 901;
    self.centerView.tag = 902;
    
    self.leftView.userInteractionEnabled = NO;
    self.rightView.userInteractionEnabled = NO;
    self.centerView.userInteractionEnabled = NO;
    
    [self addSubview:self.leftView];
    [self addSubview:self.rightView];
    [self addSubview:self.centerView];
}


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self setupViewHierachy];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {    
        [self setupViewHierachy];
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.showTitles) {
        NSArray *subviews = self.subviews;
        
        // hides the three dots
        for (UIView *v in subviews) {
            if (v.tag < 900 || v.tag >= 1000) {
                v.hidden = YES;
            }
        }
    } 

}

@end
