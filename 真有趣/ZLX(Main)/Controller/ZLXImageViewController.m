//
//  ZLXImageViewController.m
//  真有趣
//
//  Created by Lixin Zhou on 2016/9/28.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXImageViewController.h"
#import <CTAssetsPickerController/CTAssetsPickerController.h>
#import <SVProgressHUD/SVProgressHUD.h>
@interface ZLXImageViewController ()<CTAssetsPickerControllerDelegate>
- (IBAction)ExitButton;
- (IBAction)ChangeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *ImageView;
@property (nonatomic,weak) UIScrollView *scrollView;
@end

@implementation ZLXImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    self.scrollView = scrollView;
    scrollView.backgroundColor = [UIColor purpleColor];
    [self.view insertSubview:scrollView atIndex:0];
   }
- (void) viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.scrollView.frame = self.view.bounds;
}
- (IBAction)ExitButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)ChangeImageView {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status != PHAuthorizationStatusAuthorized) return ;
            dispatch_async(dispatch_get_main_queue(), ^{
                CTAssetsPickerController *picker = [[CTAssetsPickerController alloc] init];
                picker.showsSelectionIndex = YES;
                /** 隐藏不需要显示的相册*/
                picker.showsEmptyAlbums = NO;
                /** 选择特定的相册*/
//                picker.assetCollectionSubtypes = @[@(1),@(2),@(3)];
                picker.delegate = self;
                [self presentViewController:picker animated:YES completion:nil];
            });
        
    }];
}
#pragma mark 监听代理方法
- (void) assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray<PHAsset *> *)assets{
    [picker dismissViewControllerAnimated:YES completion:nil];
    /** 加载图片*/
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.resizeMode = PHImageRequestOptionsResizeModeFast;
    options.deliveryMode = 1;
    //显示图片
    for (NSInteger i = 0; i < assets.count; i ++) {
        PHAsset *asset = assets[i];
        CGSize size = CGSizeMake(asset.pixelWidth / [UIScreen mainScreen].scale, asset.pixelHeight / [UIScreen mainScreen].scale);
        //请求图片
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.image = result;
            [self.scrollView addSubview:imageView];
            imageView.frame = CGRectMake((i % 3) *(100 + 10), (i / 3) * (100 + 10), 100, 100);
                self.scrollView.contentSize = CGSizeMake(0, (((i + 1) / 3) * (100 + 10)) + 110);
        }];
    }
}
- (BOOL) assetsPickerController:(CTAssetsPickerController *)picker shouldSelectAsset:(PHAsset *)asset{
    NSInteger max = 100;
    if (picker.selectedAssets.count < max) {
        return YES;
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请注意" message:[NSString stringWithFormat:@"最多只能选择%zd张图片",(long)max] preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"明白了" style:0 handler:nil]];
    [picker presentViewController:alert animated:YES completion:nil];
    return NO;
}
@end
