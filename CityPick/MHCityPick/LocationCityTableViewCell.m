//
//  LocationCityTableViewCell.m
//  CityPick
//
//  Created by login on 16/1/29.
//  Copyright © 2016年 login. All rights reserved.
//

#import "LocationCityTableViewCell.h"

@implementation LocationCityTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.currentCity = [[UIButton alloc]initWithFrame:CGRectMake(20, 10, 200, 30)];
        self.currentCity.backgroundColor = [UIColor whiteColor];
        [self.currentCity.layer setCornerRadius:5];
        [self.currentCity addTarget:self action:@selector(buttonTitle:) forControlEvents:UIControlEventTouchUpInside];
        self.currentCity.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.currentCity setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.contentView addSubview:self.currentCity];
    }
    return self;
}

- (void)buttonTitle:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(clickLocationCityTableViewCell:)]) {
        [self.delegate clickLocationCityTableViewCell:button];
    }else
    {
        NSLog(@"定位当前城市代理不响应");
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
