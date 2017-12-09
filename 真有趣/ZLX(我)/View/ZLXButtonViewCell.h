//
//  ZLXButtonViewCell.h
//  真有趣
//
//  Created by Lixin Zhou on 16/9/12.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZLXButtonModel;
@protocol ZLXButtonModelDelegate <NSObject>

- (void) setupData;

@end

@interface ZLXButtonViewCell : UICollectionViewCell
@property (nonatomic,strong) ZLXButtonModel *model;
@property (nonatomic,weak) id<ZLXButtonModelDelegate> delegate;
@end
