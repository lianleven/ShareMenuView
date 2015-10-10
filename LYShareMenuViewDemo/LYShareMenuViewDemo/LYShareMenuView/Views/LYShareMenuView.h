//
//  LYShareMenuView.h
//  LianLeven
//
//  Created by LianLeven on 15/10/5.
//  Copyright © 2015年 lichangwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYShareItemMenuView.h"
@class LYShareMenuView;
@protocol LYShareMenuViewDelegate <NSObject>

@optional

- (void)shareMenuView:(LYShareMenuView *)shareMenuView didSelecteShareMenuItem:(LYShareMenuItem *)shareMenuItem atIndex:(NSInteger)index;

@end

@interface LYShareMenuView : UIView

@property (nonatomic, weak) id <LYShareMenuViewDelegate> delegate;
@property (nonatomic, strong) NSArray *shareMenuItems;

- (void)show;
@end


