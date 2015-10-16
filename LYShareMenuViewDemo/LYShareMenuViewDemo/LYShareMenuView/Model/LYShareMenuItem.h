//
//  LYShareMenuItem.h
//  LianLeven
//
//  Created by LianLeven on 15/10/6.
//  Copyright © 2015年 lichangwen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYShareMenuItem : NSObject

@property (nonatomic, copy) NSString *imageName;/**< 每一项的图片名 */
@property (nonatomic, copy) NSString *title;/**< 每一项的标题 */


+ (instancetype)shareMenuItemWithImageName:(NSString *)imageName itemTitle:(NSString *)itemTitle;
- (instancetype)initShareMenuItemWithImageName:(NSString *)imageName itemTitle:(NSString *)itemTitle;

@end
