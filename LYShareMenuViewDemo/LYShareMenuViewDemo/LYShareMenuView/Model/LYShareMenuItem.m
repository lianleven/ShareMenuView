//
//  LYShareMenuItem.m
//  LianLeven
//
//  Created by LianLeven on 15/10/6.
//  Copyright © 2015年 lichangwen. All rights reserved.
//

#import "LYShareMenuItem.h"

@implementation LYShareMenuItem

+ (instancetype)shareMenuItemWithImageName:(NSString *)imageName itemTitle:(NSString *)itemTitle{
    
    return [[LYShareMenuItem alloc] initShareMenuItemWithImageName:imageName itemTitle:itemTitle];
}

- (instancetype)initShareMenuItemWithImageName:(NSString *)imageName itemTitle:(NSString *)itemTitle{
    self = [super init];
    if (self) {
        self.imageName = imageName;
        self.title = itemTitle;
        
    }
    return self;
}
@end
