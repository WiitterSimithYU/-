//
//  ZLXFriendGroupNheaderView.m
//  真有趣
//
//  Created by Lixin Zhou on 2016/10/13.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXFriendGroupNheaderView.h"
#import "ZLXFriendGroupModel.h"
@interface ZLXFriendGroupNheaderView ()
//名称按钮
@property (nonatomic,weak) UIButton *nameView;
//个数label
@property (nonatomic,weak) UILabel *countView;
@end
@implementation ZLXFriendGroupNheaderView
//创建自定义的头部视图
+ (instancetype) headerViewWithTableView:(UITableView *)tableView{
    static NSString *reuseID = @"Group";
    ZLXFriendGroupNheaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseID];
    if (headerView == nil) {
        headerView = [[self alloc] initWithReuseIdentifier:reuseID];
    }
    return headerView;
}
//创建子控件
- (instancetype) initWithReuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        //名称按钮
        UIButton *nameView = [[UIButton alloc] init];
        [nameView setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:UIControlStateNormal];
        [nameView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.nameView = nameView;
        [self.contentView addSubview:nameView];
        nameView.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        nameView.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        nameView.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [nameView setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg"] forState:UIControlStateNormal];
        [nameView setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg_highlighted"] forState:UIControlStateHighlighted];
        [nameView addTarget:self action:@selector(nameClick) forControlEvents:UIControlEventTouchUpInside];
        //button图片的缩放
        self.nameView.imageView.contentMode = UIViewContentModeCenter;
        //超出部分不剪裁
        self.nameView.imageView.clipsToBounds = NO;
        //个数的label
        UILabel *countView = [[UILabel alloc] init];
        countView.textAlignment = NSTextAlignmentRight;
        countView.font = [UIFont systemFontOfSize:15];
        countView.textColor = [UIColor lightGrayColor];
        self.countView = countView;
        [self.contentView addSubview:countView];
    }
    return self;
}
//子控件赋值
- (void) setFriendGroup:(ZLXFriendGroupModel *)friendGroup{
    _friendGroup = friendGroup;
    self.countView.text = [NSString stringWithFormat:@"%zd/%lu",friendGroup.online,friendGroup.friends.count];
    [self.nameView setTitle:friendGroup.name forState:UIControlStateNormal];
    if (self.friendGroup.isExpend) {
        self.nameView.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    }else{
        self.nameView.imageView.transform = CGAffineTransformMakeRotation(0);
    }
}
- (void) layoutSubviews{
    [super layoutSubviews];
    self.countView.frame = CGRectMake(self.bounds.size.width - 150 - 10, 0, 150, 44);
    self.nameView.frame = self.bounds;
}
- (CGSize) textName:(NSString *) textName textFont:(CGFloat) textFont nameMax:(CGSize) nameMax{
    return  [textName boundingRectWithSize:nameMax options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:textFont]} context:nil].size;
}
- (void) nameClick{
    self.friendGroup.expend = !self.friendGroup.isExpend;
    if (self.friendGroup.isExpend) {
        self.nameView.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    }else{
        self.nameView.imageView.transform = CGAffineTransformMakeRotation(0);
    }
    if ([self.delegate respondsToSelector:@selector(headerViewDidClickedNameBtn:)]) {
        [self.delegate headerViewDidClickedNameBtn:self];
    }
}
@end
