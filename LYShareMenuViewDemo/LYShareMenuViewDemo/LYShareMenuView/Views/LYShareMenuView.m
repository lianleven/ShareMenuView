//
//  LYShareMenuView.m
//  LianLeven
//
//  Created by LianLeven on 15/10/5.
//  Copyright © 2015年 lichangwen. All rights reserved.
//

#import "LYShareMenuView.h"
@class LYShareMenuItemView;


static CGFloat const kShareMenuViewHeight = 260;
static CGFloat const kCancelbuttonHeight = 50;
// 每行有4个
#define kShareMenuRowItemCount 4
//总共有2列
#define kShareMenuPerColum 2
#define paddingX  (([[UIScreen mainScreen] bounds].size.width - kShareMenuRowItemCount * kShareItemWidth)/(kShareMenuRowItemCount + 1))
#define paddingY 10
@interface LYShareMenuView ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *backgroundMenuView;/**< 菜单背景 */

@property (nonatomic, strong) UIScrollView  *shareMenuScrollView;/**< 背景滚动视图 */
@property (nonatomic, strong) UIPageControl *shareMenuPageControl;/**< 分页指示View */
@property (nonatomic, strong) UIButton *cancelButton;/**< 取消按钮 */


@property (nonatomic, strong) NSMutableArray *collectItemMenuView;

@end

@implementation LYShareMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    if (self) {
        self.alpha = 0;
        self.backgroundColor = [[UIColor colorWithWhite:0.890 alpha:1.000] colorWithAlphaComponent:0.5];
        [self setup_];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder: aDecoder];
    if (self) {
        
        [self setup_];
    }
    return self;
}
- (void)setup_{
    
    self.alpha = 0;
    self.backgroundColor = [[UIColor groupTableViewBackgroundColor] colorWithAlphaComponent:0.5];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissShareMenuView:)];
    tapGesture.delegate = self;
    [self addGestureRecognizer:tapGesture];
    
    [self addSubview:self.backgroundMenuView];
    [self.backgroundMenuView addSubview:self.shareMenuPageControl];
    [self.backgroundMenuView addSubview:self.shareMenuScrollView];
    [self.backgroundMenuView addSubview:self.cancelButton];
    
}
- (void)shareMenuItemButtonClicked:(UIButton *)sender {
    [self dismissShareMenuView];
    if ([self.delegate respondsToSelector:@selector(shareMenuView:didSelecteShareMenuItem:atIndex:)]) {
        NSInteger index = sender.tag;
        if (index < self.shareMenuItems.count) {
            [self.delegate shareMenuView:self didSelecteShareMenuItem:self.shareMenuItems[index] atIndex:index];
        }
    }
}
#pragma mark - UIScrollView delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //每页宽度
    CGFloat pageWidth = scrollView.frame.size.width;
    //根据当前的坐标与页宽计算当前页码
    NSInteger currentPage = floor((scrollView.contentOffset.x - pageWidth/2)/pageWidth)+1;
    [self.shareMenuPageControl setCurrentPage:currentPage];
}
#pragma mark - show and dismiss
- (void)show{
    [self showShareMenuView];
}
- (void)showShareMenuView{
    typeof(self) __weak weakSelf = self;
    [UIView animateWithDuration:.2 animations:^{
        weakSelf.alpha = 1;
        weakSelf.backgroundMenuView.frame = CGRectMake(0, CGRectGetHeight(self.frame) - kShareMenuViewHeight, CGRectGetWidth(self.frame), kShareMenuViewHeight);
    } completion:^(BOOL finished) {
        if (weakSelf.collectItemMenuView.count) {
            for (LYShareMenuItemView *itemView in weakSelf.collectItemMenuView) {
                [itemView itemViewAnimation];
            }
        }
    }];
}
- (void)dismissShareMenuView{
    [UIView animateWithDuration:.2 animations:^{
        self.backgroundMenuView.frame = CGRectMake(0, CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), kShareMenuViewHeight);
        self.alpha = 0;
    }];
}
/**
 *  手势取消
 */
- (void)dismissShareMenuView:(UIGestureRecognizer *)gestureRecognizer{
    [self dismissShareMenuView];
    
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    CGPoint point = [gestureRecognizer locationInView:self.backgroundMenuView];
    if (point.y > 0) {
        return NO;
    }
    return YES;
}



- (void)reloadMenuData {
    if (!_shareMenuItems.count)
        return;
    
    [self.shareMenuScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for (LYShareMenuItem *shareMenuItem in self.shareMenuItems) {
        NSInteger index = [self.shareMenuItems indexOfObject:shareMenuItem];
        NSInteger page = index / (kShareMenuRowItemCount * kShareMenuPerColum);
        
        //算Item的布局
        CGFloat margin_left = (index % kShareMenuRowItemCount) * (kShareItemWidth + paddingX) + paddingX + (page * CGRectGetWidth(self.bounds));
        CGFloat margin_top = ((index / kShareMenuRowItemCount) - kShareMenuPerColum * page) * (kShareItemHeight + paddingY/5.0) + paddingY;
        
        LYShareMenuItemView *shareMenuItemView = [[LYShareMenuItemView alloc] init];
        shareMenuItemView.frame = CGRectMake(margin_left, margin_top, kShareItemWidth, kShareItemHeight);
        shareMenuItemView.shareItemButton.tag = index;
        [shareMenuItemView.shareItemButton addTarget:self action:@selector(shareMenuItemButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [shareMenuItemView configureWithShareItem:shareMenuItem];
        
        [self.shareMenuScrollView addSubview:shareMenuItemView];
        if (!self.collectItemMenuView) {
            self.collectItemMenuView = [NSMutableArray new];
        }
        [self.collectItemMenuView addObject:shareMenuItemView];
    }
    
    self.shareMenuPageControl.numberOfPages = (self.shareMenuItems.count / (kShareMenuRowItemCount * 2) + (self.shareMenuItems.count % (kShareMenuRowItemCount * 2) ? 1 : 0));
    [self.shareMenuScrollView setContentSize:CGSizeMake(((self.shareMenuItems.count / (kShareMenuRowItemCount * 2) + (self.shareMenuItems.count % (kShareMenuRowItemCount * 2) ? 1 : 0)) * CGRectGetWidth(self.bounds)), CGRectGetHeight(self.shareMenuScrollView.bounds))];
}
#pragma mark - getter/setter

- (void)setShareMenuItems:(NSArray *)shareMenuItems{
    _shareMenuItems = shareMenuItems;
    [self reloadMenuData];
}

- (UIView *)backgroundMenuView{
    if (!_backgroundMenuView) {
        _backgroundMenuView = [[UIView alloc] init];
        _backgroundMenuView.backgroundColor = [UIColor clearColor];
        _backgroundMenuView.frame = CGRectMake(0, CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), kShareMenuViewHeight);
        
    }
    return _backgroundMenuView;
}
- (UIScrollView *)shareMenuScrollView{
    if (!_shareMenuScrollView) {
        UIScrollView *shareMenuScrollView = [[UIScrollView alloc] init];
        shareMenuScrollView.frame = CGRectMake(0, 0, CGRectGetWidth(self.backgroundMenuView.frame), CGRectGetHeight(self.backgroundMenuView.frame) - kCancelbuttonHeight - paddingY * 2);
        
        shareMenuScrollView.delegate = self;
        shareMenuScrollView.canCancelContentTouches = NO;
        shareMenuScrollView.delaysContentTouches = YES;
        shareMenuScrollView.backgroundColor = [UIColor whiteColor];
        shareMenuScrollView.showsHorizontalScrollIndicator = NO;
        shareMenuScrollView.showsVerticalScrollIndicator = NO;
        [shareMenuScrollView setScrollsToTop:NO];
        shareMenuScrollView.pagingEnabled = YES;
        _shareMenuScrollView = shareMenuScrollView;
    }
    return _shareMenuScrollView;
}
- (UIPageControl *)shareMenuPageControl{
    if (!_shareMenuPageControl) {
        UIPageControl *shareMenuPageControl = [[UIPageControl alloc] init];
        shareMenuPageControl.frame = CGRectMake(0, CGRectGetMaxY(self.shareMenuScrollView.frame), CGRectGetWidth(self.shareMenuScrollView.frame), paddingY);
        shareMenuPageControl.backgroundColor = self.shareMenuScrollView.backgroundColor;
        shareMenuPageControl.hidesForSinglePage = YES;
        shareMenuPageControl.defersCurrentPageDisplay = YES;
        shareMenuPageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:1.000 green:0.235 blue:0.324 alpha:1.000];
        shareMenuPageControl.pageIndicatorTintColor = [UIColor grayColor];
        _shareMenuPageControl = shareMenuPageControl;
    }
    return _shareMenuPageControl;
}
- (UIButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.frame = CGRectMake(0, CGRectGetHeight(self.backgroundMenuView.frame) - kCancelbuttonHeight, CGRectGetWidth(self.backgroundMenuView.frame), kCancelbuttonHeight);
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor colorWithRed:1.000 green:0.235 blue:0.324 alpha:1.000] forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:18];
        [_cancelButton addTarget:self action:@selector(dismissShareMenuView) forControlEvents:UIControlEventTouchUpInside];
        _cancelButton.backgroundColor = [UIColor whiteColor];
    }
    return _cancelButton;
}

@end



