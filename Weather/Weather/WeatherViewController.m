//
//  WeatherViewController.m
//  Weather
//
//  Created by SIVA KUMAR (YPAYCASH\30085) on 02/11/15.
//  Copyright (c) 2015 Payblox. All rights reserved.
//

#import "WeatherViewController.h"

@interface WeatherViewController ()

@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    float temperature = [[[_weatherDataDictionary objectForKey:@"main"] valueForKey:@"temp"] floatValue] - 273.15;
    
    _lblCityName.text = _cityName;
    _lblTemperature.text =[NSString stringWithFormat:@"%.00f%@", temperature ,@"\u00B0"];
    _lblWeatherDescription.text = [[[_weatherDataDictionary objectForKey:@"weather"] firstObject] valueForKey:@"description"];
    _lblHumidity.text = [NSString stringWithFormat:@"Humidity : %@ %%", [[_weatherDataDictionary objectForKey:@"main"] valueForKey:@"humidity"]];
    _lblWindSpeed.text = [NSString stringWithFormat:@"Wind Speed : %@ Kmph", [[_weatherDataDictionary objectForKey:@"wind"] valueForKey:@"speed"]];
    
    
    _lblCityName.adjustsFontSizeToFitWidth = YES;
}
- (IBAction)onClickClose:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
