//
//  LYShareItemMenuView.m
//  LianLeven
//
//  Created by LianLeven on 15/10/6.
//  Copyright © 2015年 lichangwen. All rights reserved.
//

#import "LYShareItemMenuView.h"
@implementation LYShareMenuItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder: aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup{
    
    CGRect rect = self.frame;
    rect.size = CGSizeMake(kShareItemWidth, kShareItemHeight);
    self.frame = rect;
    CGFloat padding = 5.0f;
    self.shareItemButton.frame = CGRectMake(0, 0, kShareItemWidth - padding, kShareItemWidth - padding);
    self.shareItemDesLabel.frame = CGRectMake(0, CGRectGetMaxY(self.shareItemButton.frame) + padding, kShareItemWidth, kShareItemHeight - kShareItemWidth - padding);
    [self addSubview:self.shareItemButton];
    [self addSubview:self.shareItemDesLabel];
    self.shareItemButton.transform = CGAffineTransformMakeScale(0.5, 0.5);
    self.shareItemDesLabel.transform = CGAffineTransformMakeScale(1.4, 1.4);
}

- (void)configureWithShareItem:(LYShareMenuItem *)shareMenuItem{
    if (shareMenuItem && shareMenuItem.imageName.length > 0) {
        [self.shareItemButton setBackgroundImage:[UIImage imageNamed:shareMenuItem.imageName] forState:UIControlStateNormal];
    }
    self.shareItemDesLabel.text = shareMenuItem.title;
}
- (void)itemViewAnimation{
    [UIView animateWithDuration:.2 animations:^{
        self.shareItemButton.transform = CGAffineTransformMakeScale(1.2, 1.2);
        self.shareItemDesLabel.transform = CGAffineTransformMakeScale(0.7, 0.7);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            self.shareItemButton.transform = CGAffineTransformIdentity;
            self.shareItemDesLabel.transform = CGAffineTransformIdentity;
        }];
        
    }];
}

#pragma mark - getter/setter

- (UIButton *)shareItemButton{
    if (!_shareItemButton) {
        _shareItemButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _shareItemButton.layer.cornerRadius = 4;
        _shareItemButton.layer.masksToBounds = YES;
    }
    return _shareItemButton;
}
- (UILabel *)shareItemDesLabel{
    if (!_shareItemDesLabel) {
        _shareItemDesLabel = [[UILabel alloc] init];
        _shareItemDesLabel.font = [UIFont systemFontOfSize:14];
        _shareItemDesLabel.textColor = [UIColor colorWithRed:0.259 green:0.259 blue:0.259 alpha:1];
        _shareItemDesLabel.backgroundColor = [UIColor clearColor];
        _shareItemDesLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _shareItemDesLabel;
}

@end
