//
//  ZLXSeeBigPictureViewController.m
//  真有趣
//
//  Created by Lixin Zhou on 2016/9/26.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXSeeBigPictureViewController.h"
#import "ZLXTopicModel.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
@interface ZLXSeeBigPictureViewController ()
- (IBAction)BackBtn:(UIButton *)sender;
//@property (nonatomic,weak) UIScrollView *scrollview;
- (IBAction)SaveButton:(UIButton *)sender;
@property (nonatomic,strong) UIImageView *imageView;
/** 当前APP的自定义相册*/
- (PHAssetCollection *) createdCollection;
@end
@implementation ZLXSeeBigPictureViewController
//- (UIStatusBar *) s
//- (BOOL) prefersStatusBarHidden{
//    return YES;
//}
//- (UIScrollView *) scrollview{
//    if (_scrollview == nil) {
//        UIScrollView *scrollview = [[UIScrollView alloc] init];
////        self.scrollview = _scrollview;
//        self.scrollview = scrollview;
//        scrollview.frame = self.view.bounds;
//        [self.view insertSubview:scrollview atIndex:0];
//        scrollview.backgroundColor = [UIColor purpleColor];
//    }
//    return _scrollview;
//}
- (void)viewDidLoad {
    UIScrollView *scrollview = [[UIScrollView alloc] init];
    scrollview.frame = self.view.bounds;
    //    scrollview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    scrollview.frame = [UIScreen mainScreen].bounds;
    [self.view insertSubview:scrollview atIndex:0];
    scrollview.backgroundColor = [UIColor blackColor];
    UIImageView *imageView = [[UIImageView alloc] init];
    self.imageView = imageView;
    [scrollview addSubview:imageView];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
    imageView.width = scrollview.width;
    imageView.height = imageView.width * self.topic.height / self.topic.width;
    imageView.x = 0;
    if (imageView.height > [UIScreen mainScreen].bounds.size.height) {//如果超过屏幕高度
        imageView.y = 0;
    }else{
        imageView.centery = scrollview.height * 0.5;
    }
    scrollview.contentSize = CGSizeMake(0, imageView.height);
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!image) return ;
        //        self.SaveBtn.enabled = YES;
    }];
}
/** 会调用很多次*/
//- (void) viewDidLayoutSubviews{
//// self.scrollview.frame = self.view
//    [super viewDidLayoutSubviews];
//    self.scrollview.frame = self.view.bounds;
//
//}
- (void) back{
    [self dismissViewControllerAnimated:self completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)BackBtn:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (!error) {
        [SVProgressHUD showSuccessWithStatus:@"保存成功!"];
    }else{
        [SVProgressHUD showErrorWithStatus:@"保存失败!"];
    }
}
/** This method can only be called from inside of -[PHPhotoLibrary performChanges:completionHandler:] or -[PHPhotoLibrary performChangesAndWait:error:]'
 错误信息
 */
- (IBAction)SaveButton:(UIButton *)sender {
    /** 这个函数直接把下载下来的图片保存到系统相册里*/
    // UIImageWriteToSavedPhotosAlbum(self.imageView.image,self,@selector(image:didFinishSavingWithError:contextInfo:),nil);
    //    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
    //        [PHAssetChangeRequest creationRequestForAssetFromImage:self.imageView.image];
    //    } completionHandler:^(BOOL success, NSError * _Nullable error) {
    //        if (!error) {
    //            [SVProgressHUD showSuccessWithStatus:@"保存成功!"];
    //        }else{
    //            [SVProgressHUD showErrorWithStatus:@"保存失败!"];
    //
    //        }
    //    }];
    /** 保存到相机胶卷*/
    //    NSError *error = nil;
    //    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
    //        [PHAssetChangeRequest creationRequestForAssetFromImage:self.imageView.image];
    //    } error:&error];
    //    if (error) {
    //        [SVProgressHUD showErrorWithStatus:@"保存失败!"];
    //    }else{
    //        [SVProgressHUD showSuccessWithStatus:@"保存成功!"];
    //    }
    /** 自定义相册名称*/
    //    NSError *error = nil;
    //    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
    //        //获取软件的名称
    ////        NSString *APPName = [NSBundle mainBundle].infoDictionary[@"CFBundleName"];
    //        NSString *title = [NSBundle mainBundle].infoDictionary[(__bridge NSString *)kCFBundleNameKey];//第二种办法获得APP的名称
    //        NSLog(@"%@",title);
    //        //创建一个【自定义相册】
    //        [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:title];
    //    } error:&error];
    //创建自定义相册
    //    [self]
    //    self.createdCollection;
    //保存图片到相机胶卷
    NSError *error = nil;
    __block PHObjectPlaceholder *placeholder = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        placeholder = [PHAssetChangeRequest creationRequestForAssetFromImage:self.imageView.image].placeholderForCreatedAsset;
    } error:&error];
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败!"];
        return;
    }
    //添加图片到自定义相册
    PHAssetCollection *createdCollection = self.createdCollection;
    if (createdCollection == nil) {
        [SVProgressHUD showErrorWithStatus:@"创建相册失败!"];
    };
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:createdCollection];
        //       [request addAssets:@[placeholder]];
        /** 保证最新保存的图片出现在*/
        [request insertAssets:@[placeholder] atIndexes:[NSIndexSet indexSetWithIndex:0]];
    } error:&error];
    //最后的判断
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败!"];
    }else{
        [SVProgressHUD showSuccessWithStatus:@"保存成功!"];
    }
}
/** 创建自定义相册*/
- (PHAssetCollection *) createdCollection{
    /** 判断是否已经创建了自定义相册*/
    //获得软件名称
    NSString *title = [NSBundle mainBundle].infoDictionary[(__bridge NSString *)kCFBundleNameKey];
    //抓取所有自定义相册
    PHFetchResult<PHAssetCollection *> *collections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    //查找对应的相册
    for (PHAssetCollection *collection in collections) {
        if ([collection.localizedTitle isEqualToString:title]) {
            return collection;
        }
    }
    //如果当前相册没有被创建
    //    PHAssetCollection *createdCollection = nil;
    //    if (createdCollection == nil) {
    NSError *error = nil;
    __block NSString *createdCollectionID = nil;
    //创建一个自定义的相册
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        createdCollectionID = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:title].placeholderForCreatedAssetCollection.localIdentifier;
    } error:&error];
    if (error) return nil;
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[createdCollectionID] options:nil].firstObject;
}
- (BOOL) prefersStatusBarHidden{
    return YES;
}
@end
