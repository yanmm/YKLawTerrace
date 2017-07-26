//
//  ImageBrowseVC.m
//  DemoTableAutoHeight
//
//  Created by zhangshaoyu on 15/7/10.
//  Copyright (c) 2015年 zhangshaoyu. All rights reserved.
//

#import "ImageBrowseVC.h"

#define WidthView (self.mainScrollView.frame.size.width)
#define HeightView (self.mainScrollView.frame.size.height)

@interface ImageBrowseVC () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) NSMutableArray *mainArray;

@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) NSInteger currentTotal;
@property (nonatomic, assign) NSInteger defaultTotal;

@end

@implementation ImageBrowseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStyleDone target:self action:@selector(imageDelete:)];
    
    [self setUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 创建视图

- (void)setUI
{
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.mainScrollView];
    self.mainScrollView.delegate = self;
    self.mainScrollView.pagingEnabled = YES;
    self.mainScrollView.bounces = YES;
    self.mainScrollView.showsVerticalScrollIndicator = NO;
    self.mainScrollView.showsHorizontalScrollIndicator = NO;
    self.mainScrollView.backgroundColor = [UIColor blackColor];
    self.mainScrollView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    
    [self resetUI];
}

- (void)resetUI
{
    RemoveSubViews(self.mainScrollView);
    
    for (int i = 0; i < self.currentTotal; i++)
    {
        CGRect rect = CGRectMake((i * WidthView), 0.0, WidthView, HeightView);
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:rect];
        [self.mainScrollView addSubview:imageview];
        imageview.contentMode = UIViewContentModeScaleAspectFit;
        imageview.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;

        UIImage *image = self.mainArray[i];
        imageview.image = image;
    }
    
    self.mainScrollView.contentSize = CGSizeMake((self.currentTotal * WidthView), HeightView);
    
    [self setNavigationTitle];
    
    self.mainScrollView.contentOffset = CGPointMake((self.currentIndex * WidthView), 0.0);
}

void RemoveSubViews(UIView *view)
{
    if (view)
    {
        NSInteger count = view.subviews.count;
        count -= 1;
        for (NSInteger i = count; i >= 0; i--)
        {
            UIView *subview = view.subviews[i];
            [subview removeFromSuperview];
        }
    }
}

- (void)setNavigationTitle
{
    NSString *title = [[NSString alloc] initWithFormat:@"%ld/%ld", ((long)self.currentIndex + 1), (long)self.currentTotal];
    if (0 == self.currentTotal)
    {
        title = @"0/0";
    }
    self.title = title;
}

#pragma mark - 响应事件

- (void)imageDelete:(UIBarButtonItem *)button
{
    if (0 == self.currentTotal)
    {
        return;
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定删除？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self.mainArray removeObjectAtIndex:self.currentIndex];
        
        NSInteger index = self.currentTotal - 1;
        
        self.currentTotal = self.mainArray.count;
        
        if (self.ImageDelete && (self.defaultTotal != self.currentTotal))
        {
            self.ImageDelete(self.currentIndex);
        }
        
        if (0 == self.currentIndex)
        {
            self.currentIndex = 0;
        }
        else if (index == self.currentIndex)
        {
            self.currentIndex = self.currentTotal - 1;
        }
        
        [self resetUI];
        
        if (0 == self.currentTotal) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - setter

- (void)setImageArray:(NSArray *)imageArray
{
    _imageArray = imageArray;
    
    self.mainArray = [[NSMutableArray alloc] initWithArray:_imageArray];
    
    self.currentTotal = self.mainArray.count;
    self.defaultTotal = self.currentTotal;
    
    [self resetUI];
}

- (void)setImageIndex:(NSInteger)imageIndex
{
    _imageIndex = imageIndex;
    
    self.currentIndex = _imageIndex;
    
    [self resetUI];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.mainScrollView)
    {
        NSInteger currentPage = self.mainScrollView.contentOffset.x / WidthView;
        self.currentIndex = currentPage;
        
        [self setNavigationTitle];
    }
}

@end
