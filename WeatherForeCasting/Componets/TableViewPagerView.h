

#import <UIKit/UIKit.h>
#import "TableViewPagerPageControl.h"

#define PAGECONTROL_DEFAULT_HEIGHT 36
@protocol TableViewPagerViewChanged <NSObject>

- (void)pageChangedToTableView:(UITableView *)tableview withPageIndex:(NSUInteger)pageIndex;

@end

@interface TableViewPagerView : UIView <UIScrollViewDelegate>

@property (nonatomic, unsafe_unretained) id <TableViewPagerViewChanged> delegate;

@property (nonatomic, strong, readonly) TableViewPagerPageControl *pageControl;
@property (nonatomic, strong, readonly) UIScrollView *scrollView;

// specify the content of the pageControl
@property (nonatomic, strong) NSMutableArray *titleDefaultLabelStrings;
@property (nonatomic, strong) NSMutableArray *titleViews; //overrides titleDetaultLabelStrings
@property (nonatomic, strong) UIView *leftArrowView;
@property (nonatomic, strong) UIView *rightArrowView;

@property (nonatomic, strong) UIColor *pageControlBackgroundColor;
@property (nonatomic, strong) UIColor *scrollingBackgroundColor;
@property (nonatomic, strong) UIColor *fixedBackgroundColor; // overrides scrollingBackgroundColor
@property (nonatomic, strong) UIColor *titleDefaultLabelColor;
@property (nonatomic, strong) UIColor *arrowDefaultColor;

@property (nonatomic) BOOL hidePageControl;
@property (nonatomic) float pageControlHeight;

- (void)initializeLayout;
- (void)pageControlChangePage:(BOOL)animated;

@end