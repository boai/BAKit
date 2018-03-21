
/*!
 *  @header BAKit.h
 *          BABaseProject
 *
 *  @brief  BAKit
 *
 *  @author 博爱
 *  @copyright    Copyright © 2016年 博爱. All rights reserved.
 *  @version    V1.0
 */

//                            _ooOoo_
//                           o8888888o
//                           88" . "88
//                           (| -_- |)
//                            O\ = /O
//                        ____/`---'\____
//                      .   ' \\| |// `.
//                       / \\||| : |||// \
//                     / _||||| -:- |||||- \
//                       | | \\\ - /// | |
//                     | \_| ''\---/'' | |
//                      \ .-\__ `-` ___/-. /
//                   ___`. .' /--.--\ `. . __
//                ."" '< `.___\_<|>_/___.' >'"".
//               | | : `- \`.;`\ _ /`;.`/ - ` : | |
//                 \ \ `-. \_ __\ /__ _/ .-` / /
//         ======`-.____`-.___\_____/___.-`____.-'======
//                            `=---='
//
//         .............................................
//                  佛祖镇楼                  BUG辟易
//          佛曰:
//                  写字楼里写字间，写字间里程序员；
//                  程序人员写程序，又拿程序换酒钱。
//                  酒醒只在网上坐，酒醉还来网下眠；
//                  酒醉酒醒日复日，网上网下年复年。
//                  但愿老死电脑间，不愿鞠躬老板前；
//                  奔驰宝马贵者趣，公交自行程序员。
//                  别人笑我忒疯癫，我笑自己命太贱；
//                  不见满街漂亮妹，哪个归得程序员？

/*
 
 *********************************************************************************
 *
 * 在使用BAKit的过程中如果出现bug请及时以以下任意一种方式联系我，我会及时修复bug
 *
 * QQ     : 可以添加SDAutoLayout群 497140713 在这里找到我(博爱1616【137361770】)
 * 微博    : 博爱1616
 * Email  : 137361770@qq.com
 * GitHub : https://github.com/boai
 * 博客园  : http://www.cnblogs.com/boai/
 * 博客    : http://boai.github.io
 
 *********************************************************************************
 
 */

#import "BANavigationController.h"

@interface BANavigationController ()<UINavigationControllerDelegate>

@property (nonatomic, strong) id popDelegate;

@end

@implementation BANavigationController

- (void)viewDidLoad {
    [super viewDidLoad];

    _popDelegate = self.interactivePopGestureRecognizer.delegate;
    // 实现滑动返回功能
    // 清空滑动返回手势代理
    self.interactivePopGestureRecognizer.delegate = nil;
    self.delegate = self;

    [BAKit_Helper ba_helperSetNaviBarBarTintColor:BAKit_Color_Black tintColor:BAKit_Color_White font:BAKit_Font_systemFontOfSize_18 fontColor:BAKit_Color_White isNeedBottomLine:YES navigationController:self];
}

/*! 当用户刷时,导航控制器的navigationBar会隐藏或显示 */
- (void)setNavigationBarHidden:(BOOL)navigationBarHidden
{
    if (navigationBarHidden)
    {
        self.hidesBarsOnSwipe = YES;
    }
    else
    {
        self.hidesBarsOnSwipe = NO;
    }

}

// 导航控制器跳转完成的时候调用
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //    BALog(@"%@", self.viewControllers[0]);
    if (viewController == self.viewControllers[0])
    {
        // 显示根控制器
        // 返回滑动返回手势代理
        self.interactivePopGestureRecognizer.delegate = _popDelegate;
    }
    else
    {
        // 实现滑动返回功能
        // 清空滑动返回手势代理
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 设置非根控制器导航条内容
    if (self.viewControllers.count)
    {
        viewController.hidesBottomBarWhenPushed = YES;
        
//        UIBarButtonItem *left = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"nav-back"] highImage:nil target:self action:@selector(backToPre) forControlEvents:UIControlEventTouchUpInside];
//        // 设置导航条的按钮
//        viewController.navigationItem.leftBarButtonItem = left;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)backToPre
{
    [self popViewControllerAnimated:YES];
}

- (void)backToRoot
{
    [self popToRootViewControllerAnimated:YES];
}

- (void)customNavBackButtonMethod
{
    [self backToPre];
}

/**
 *  导航控制器 统一管理状态栏颜色
 *  @return 状态栏颜色
 */
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

/*! 
 
 iOS加载启动图的时候隐藏statusbar
 
 只需需要在info.plist中加入Status bar is initially hidden 设置为YES就好
 
 */


/*! 另一种简单写法，看个人喜好（此写法是系统navi，返回按钮带字）
 - (void)viewDidLoad {
 [super viewDidLoad];
 //    if( ([[UIDevice currentDevice].systemVersion floatValue]>=7.0)) {
 //        self.edgesForExtendedLayout=UIRectEdgeNone;//下移64
 //        self.navigationBar.translucent = NO;
 //    }
 self.navigationBar.barTintColor = [UIColor redColor];
 //返回按钮颜色
 UIImage *backButtonImage = [[UIImage imageNamed:@"navigator_btn_back"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
 [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
 
 self.navigationBar.tintColor = [UIColor whiteColor];
 self.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:17.0],NSFontAttributeName ,nil];
 }
 -(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
 if (self.viewControllers.count) {
 viewController.hidesBottomBarWhenPushed = YES;
 }
 [super pushViewController:viewController animated:animated];
 }
 */

@end
