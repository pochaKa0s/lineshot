//
//  ViewController.m
//  lineshot
//
//  Created by 坂本 拓也 on 2014/10/02.
//  Copyright (c) 2014年 坂本 拓也. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
- (IBAction)cameraTap:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (![QBImagePickerController isAccessible]) {
        NSLog(@"Error: Source is not accessible.");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cameraTap:(id)sender {
    
    QBImagePickerController *imagePickerController = [[QBImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsMultipleSelection = YES;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:imagePickerController];
    [self presentViewController:navigationController animated:YES completion:NULL];

    
}

- (void)dismissImagePickerController
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}


- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didSelectAsset:(ALAsset *)asset
{
    NSLog(@"一枚だけ");
    [self dismissImagePickerController];
}

- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didSelectAssets:(NSArray *)assets
{
    [self dismissImagePickerController];
    
    // こっから飛ぶ

    SecondViewController *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SecondView"];
    secondViewController.assets = assets;
    
    [self presentViewController:secondViewController animated:YES completion:nil];

}

- (void)qb_imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController
{
    NSLog(@"*** qb_imagePickerControllerDidCancel:");
    [self dismissImagePickerController];
}
@end
