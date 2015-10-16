//
//  ViewController.m
//  LYShareMenuViewDemo
//
//  Created by LianLeven on 15/10/6.
//  Copyright © 2015年 lichangwen. All rights reserved.
//

#import "LYShareViewController.h"
#import "LYShareMenuView.h"
@interface LYShareViewController ()<LYShareMenuViewDelegate>

@property (nonatomic, strong) LYShareMenuView *shareMenuView;

@end

@implementation LYShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //[self.view addSubview:self.shareMenuView];
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [window addSubview:self.shareMenuView];
    //配置item
    NSMutableArray *array = NSMutableArray.new;
    for (int i = 0; i < 20; i++) {
        LYShareMenuItem *item = nil;
        switch (i%3) {
            case 0:{
                item = [LYShareMenuItem shareMenuItemWithImageName:@"friend_pr" itemTitle:@"朋友圈"];
                break;
            }
            case 1:{
                item = [LYShareMenuItem shareMenuItemWithImageName:@"qzone_pr" itemTitle:@"QQ空间"];
                break;
            }
            case 2:{
                item = [LYShareMenuItem shareMenuItemWithImageName:@"weibo_pr" itemTitle:@"weibo"];
                break;
            }
            default:
                break;
        }
        
        [array addObject:item];
    }
    self.shareMenuView.shareMenuItems = [array copy];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)shareMenuView:(LYShareMenuView *)shareMenuView didSelecteShareMenuItem:(LYShareMenuItem *)shareMenuItem atIndex:(NSInteger)index{
    NSString *message;
    switch (index%3) {
        case 0:{
            message = @"分享于朋友圈";
            break;
        }
        case 1:{
            message = @"分享于QQ空间";
            break;
        }
        case 2:{
            message = @"分享于微博";
            break;
        }
        default:
            break;
    }
    message = [[@(index) stringValue] stringByAppendingFormat:@".%@",message];
    [[[UIAlertView alloc] initWithTitle:message
                               message:nil
                              delegate:nil
                     cancelButtonTitle:nil
                     otherButtonTitles:@"确定",nil] show];
}

- (IBAction)share:(UIBarButtonItem *)sender {
    [self.shareMenuView show];
}
#pragma mark - getter
- (LYShareMenuView *)shareMenuView{
    if (!_shareMenuView) {
        _shareMenuView = [[LYShareMenuView alloc] init];
        _shareMenuView.delegate = self;
    }
    return _shareMenuView;
}
@end
