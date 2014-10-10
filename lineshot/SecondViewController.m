//
//  SecondViewController.m
//  lineshot
//
//  Created by 坂本 拓也 on 2014/10/08.
//  Copyright (c) 2014年 坂本 拓也. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(backToHome)];
    
//    UIImage *image = [self gousei:_assets];
    UIImage *image = self.gouseiImage;
    NSLog(@"%f:%f", image.size.width, image.size.height);
    NSLog(@"%f:%f", self.view.bounds.size.width, self.view.bounds.size.height);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image.size.width/2, image.size.height/2)];
    
//    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    [imageView setImage:image];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.contentSize = imageView.bounds.size;
    [scrollView addSubview:imageView];
    [self.view addSubview:scrollView];
    NSLog(@"aaa");
}

- (void)backToHome{
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 画像を合成する
- (UIImage *)gousei:(NSArray *)assets
{
    // 一枚目
    
    NSLog(@"%ld",assets.count);
    
    ALAsset *asset0 = assets[0];
    ALAssetRepresentation *representation0 = [asset0 defaultRepresentation];
    UIImage *image0 = [UIImage imageWithCGImage:[representation0 fullResolutionImage]];
//    return image0;
    
    NSLog(@"image0 width:%f,height:%f",image0.size.width,image0.size.height);

    
    // 二枚目以降を順繰り合成
    for (int i = 1; i < [assets count]; i++) {
        ALAsset *asset = assets[i];
        ALAssetRepresentation *representation = [asset defaultRepresentation];
        UIImage *image = [UIImage imageWithCGImage:[representation fullResolutionImage]];

        // 合成スタート
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(image0.size.width, image0.size.height + image.size.height), NO, 0.0);
        [image0 drawAtPoint:CGPointMake(0, 0)];
        [image drawAtPoint:CGPointMake(0, image0.size.height)];
        image0 = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        NSLog(@"image0 width:%f,height:%f",image0.size.width,image0.size.height);

    }
    
    return image0;
//
//    // 小さくする
//    int imageW = image0.size.width;
//    int imageH = image0.size.height;
//    CGSize resize = CGSizeMake(imageW/2, imageH/2);
//    UIGraphicsBeginImageContext(resize);
//    [image0 drawAtPoint:CGPointMake(0, 0)];
//    UIImage *lastImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    return lastImage;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
