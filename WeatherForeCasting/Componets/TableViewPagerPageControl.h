

#import <UIKit/UIKit.h>

@interface TableViewPagerPageControl : UIPageControl

@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIView *rightView;
@property (nonatomic, strong) UIView *centerView;
@property (nonatomic) BOOL showTitles;

@end