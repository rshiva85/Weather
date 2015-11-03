//
//  WeatherViewController.h
//  Weather
//
//  Created by SIVA KUMAR (YPAYCASH\30085) on 02/11/15.
//  Copyright (c) 2015 Payblox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherViewController : UIViewController

@property (strong, nonatomic) NSDictionary *weatherDataDictionary;
@property (strong, nonatomic) NSString *cityName;

@property (strong, nonatomic) IBOutlet UILabel *lblCityName;
@property (strong, nonatomic) IBOutlet UILabel *lblTemperature;
@property (strong, nonatomic) IBOutlet UILabel *lblWeatherDescription;
@property (strong, nonatomic) IBOutlet UILabel *lblHumidity;
@property (strong, nonatomic) IBOutlet UILabel *lblWindSpeed;


@end
