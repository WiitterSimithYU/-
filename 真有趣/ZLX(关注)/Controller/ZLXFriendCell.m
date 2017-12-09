//
//  ZLXFriendCell.m
//  真有趣
//
//  Created by Lixin Zhou on 2016/10/13.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXFriendCell.h"
#import "ZLXFriendModel.h"
#import "EMBuddy.h"
@implementation ZLXFriendCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
+ (instancetype) cellWithFriendWith:(UITableView *)tableview{
        static NSString *reuseID = @"friend";
        ZLXFriendCell *cell = [tableview dequeueReusableCellWithIdentifier:reuseID];
        if (cell == nil) {
            cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseID];
        }
    return cell;
}
//- (void) setFriends:(ZLXFriendModel *)friends{
//    _friends = friends;
//    self.textLabel.text = friends.name;
//    self.detailTextLabel.text = friends.intro;
//    //会员
//    self.textLabel.textColor = friends.isVip ? [UIColor redColor] : [UIColor blackColor];
//    self.imageView.image = [UIImage imageNamed:friends.icon];
//}
- (void) setBuddy:(EMBuddy *)Buddy{
    _Buddy = Buddy;
    self.imageView.image = [UIImage imageNamed:@"chatListCellHead"];
//    self.imageView.layer.cornerRadius = 25;
//    self.imageView.layer.masksToBounds = YES;
    self.textLabel.text = Buddy.username;
}
@end
