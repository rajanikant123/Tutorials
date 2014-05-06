//
//  WeatherCell.h
//  WeatherForeCasting
//
//  Created by rhole on 05/05/14.
//  Copyright (c) 2014 Rajanikant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lable_temp;
@property (strong, nonatomic) IBOutlet UILabel *label_min_max;
@property (strong, nonatomic) IBOutlet UILabel *label_humidity;
@property (strong, nonatomic) IBOutlet UILabel *label_wind;
@property (strong, nonatomic) IBOutlet UILabel *label_cloud;
@property (strong, nonatomic) IBOutlet UILabel *label_text;
@property (strong, nonatomic) IBOutlet UIImageView *weather_img;

@end
