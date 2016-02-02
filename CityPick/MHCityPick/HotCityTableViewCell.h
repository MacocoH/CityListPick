//
//  HotCityTableViewCell.h
//  CityPick
//
//  Created by login on 16/2/1.
//  Copyright © 2016年 login. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HotCityTableViewCellDelegate <NSObject>
/**
 *  点击热门城市
 *
 *  @param button 点击button
 */
- (void)clickHotCityTableViewCell:(UIButton *)button;
@end

@interface HotCityTableViewCell : UITableViewCell
/**
 *  热门城市数组
 */
@property(nonatomic,copy)NSArray<NSString *> *hotCityArray;
@property(nonatomic,assign)id<HotCityTableViewCellDelegate>delegate;
/**
 *  获取cell高度
 *
 *  @return cell高度
 */
+ (CGFloat)getCellHeight;
@end
