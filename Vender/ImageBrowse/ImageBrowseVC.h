//
//  ImageBrowseVC.h
//  DemoTableAutoHeight
//
//  Created by zhangshaoyu on 15/7/10.
//  Copyright (c) 2015年 zhangshaoyu. All rights reserved.
//  图片浏览（可删除操作）

#import <UIKit/UIKit.h>

@interface ImageBrowseVC : UIViewController

/// 图片源数组
@property (nonatomic, strong) NSArray *imageArray;

/// 图片当前页码
@property (nonatomic, assign) NSInteger imageIndex;

/// 图片删除回调
@property (nonatomic, copy) void (^ImageDelete)(NSInteger *index);

@end

/*
 使用说明

 // 初始化图片浏览器
 ImageBrowseVC *browseVC = [[ImageBrowseVC alloc] init];
 // 图片浏览器图片数组
 browseVC.imageArray = images;
 // 图片浏览器当前显示第几张图片
 browseVC.imageIndex = indexImg;
 // 图片浏览器浏览回调（删除图片后图片数组）
 browseVC.ImageDelete = ^(NSArray *array){
    NSLog(@"array %@", array);
 
    // 如果有引用其他属性，注意弱引用（避免循环引用，导致内存未释放）
 };
 // 图片浏览器跳转
 [self.navigationController pushViewController:browseVC animated:YES];

 */
