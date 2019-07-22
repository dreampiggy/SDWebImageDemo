/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "DetailViewController.h"
#import <SDWebImage/SDWebImage.h>
#import "UIImageView+Extends.h"

@interface TestImageView : UIImageView

@end

@interface TestItem : UIControl

@property (nonatomic, strong) TestImageView *imageView;

- (void)setImageUrl:(NSString *)url;

@end

@interface DetailViewController ()

@property (strong, nonatomic) NSArray *urls;
@property (strong, nonatomic) TestItem *imageView;
@property (strong, nonatomic) TestItem *imageView2;
@property (strong, nonatomic) TestItem *imageView3;
@property (strong, nonatomic) TestItem *imageView4;

@end

@implementation DetailViewController

- (void)test {
    CGFloat itemWidth = ([[UIScreen mainScreen] bounds].size.width - 10 * 5) / 4.0;
    CGFloat itemHeight = itemWidth / 80.0 * 110.0;
    
    self.imageView = [[TestItem alloc] init];
    self.imageView.frame = CGRectMake(10, 64, itemWidth, itemHeight);
    [self.view addSubview:self.imageView];
    
    self.imageView2 = [[TestItem alloc] init];
    self.imageView2.frame = CGRectMake((itemWidth + 10) * 1 + 10, 64, itemWidth, itemHeight);
    [self.view addSubview:self.imageView2];
    self.imageView3 = [[TestItem alloc] init];
    self.imageView3.frame = CGRectMake((itemWidth + 10) * 2 + 10, 64, itemWidth, itemHeight);
    [self.view addSubview:self.imageView3];
    self.imageView4 = [[TestItem alloc] init];
    self.imageView4.frame = CGRectMake((itemWidth + 10) * 3 + 10, 64, itemWidth, itemHeight);
    [self.view addSubview:self.imageView4];
    
    [self.imageView setImageUrl:_urls[0]];
    [self.imageView2 setImageUrl:_urls[1]];
    [self.imageView3 setImageUrl:_urls[2]];
    [self.imageView4 setImageUrl:_urls[3]];
}

- (void)configureView {
    [self test];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _urls = @[@"http://img03.netvan.cn/ynmcc-app/files/new_home/homeFloorNew/20190708174912685.png", @"http://img03.netvan.cn/ynmcc-app/files/new_home/homeFloorNew/20190708175011728.png", @"http://img03.netvan.cn/ynmcc-app/files/new_home/homeFloorNew/20190703105133214.gif", @"http://img03.netvan.cn/ynmcc-app/files/new_home/homeFloorNew/20190708175045577.png"];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 400, 50, 50);
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(doRefresh) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    [self configureView];
}

- (void)doRefresh {
    [self.imageView removeFromSuperview];
    [self.imageView2 removeFromSuperview];
    [self.imageView3 removeFromSuperview];
    [self.imageView4 removeFromSuperview];
    
    [self test];
}

@end

@implementation TestImageView

- (CGSize)intrinsicContentSize {
    return CGSizeMake(UIViewNoIntrinsicMetric, UIViewNoIntrinsicMetric);
}

@end

@implementation TestItem

- (void)setImageUrl:(NSString *)imageUrl {
    _imageView = [[TestImageView alloc] init];
    [self addSubview:_imageView];
    
    if ([imageUrl hasSuffix:@".gif"]) {//加载Gif图片
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
    } else {
        [self.imageView setImageWithDefaultImage:nil ImageURL:imageUrl];
//            [self sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:placeholdImage];
    }
    
    CGFloat itemWidth = ([[UIScreen mainScreen] bounds].size.width - 10 * 5) / 4.0;
    CGFloat itemHeight = itemWidth / 80.0 * 110.0;
    self.imageView.frame = CGRectMake(0, 0, itemWidth, itemHeight);
}


@end
