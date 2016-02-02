//
//  LocationCityTableViewCell.h
//  CityPick
//
//  Created by login on 16/1/29.
//  Copyright © 2016年 login. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LocationCityTableViewCellDelegate <NSObject>
/**
 *  点击定位城市
 *
 *  @param button 点击button
 */
- (void)clickLocationCityTableViewCell:(UIButton *)button;
@end

@interface LocationCityTableViewCell : UITableViewCell
@property(nonatomic,assign)id<LocationCityTableViewCellDelegate>delegate;
/**
 *  当前定位城市
 */
@property(nonatomic,retain)UIButton *currentCity;
@end
