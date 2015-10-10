//
//  LYShareItemMenuView.h
//  LianLeven
//
//  Created by LianLeven on 15/10/6.
//  Copyright © 2015年 lichangwen. All rights reserved.
//

#define kShareItemWidth  60
#define kShareItemHeight  90
#import <UIKit/UIKit.h>
#import "LYShareMenuItem.h"
@interface LYShareMenuItemView : UIView

@property (nonatomic, strong) UIButton *shareItemButton;
@property (nonatomic, strong) UILabel  *shareItemDesLabel;/**< 描述 */

- (void)configureWithShareItem:(LYShareMenuItem *)shareMenuItem;
- (void)itemViewAnimation;

@end
