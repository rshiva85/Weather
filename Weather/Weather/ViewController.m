//
//  ViewController.m
//  Weather
//
//  Created by SIVA KUMAR (YPAYCASH\30085) on 02/11/15.
//  Copyright (c) 2015 Payblox. All rights reserved.
//

#import "ViewController.h"
#import "WeatherViewController.h"

@interface ViewController ()
{
    NSString *CurElementName;
    NSString *strCity;
    
    NSDictionary *weatherDataDictionary;
  
    NSMutableDictionary *dictCity;
    NSMutableArray *arrayTemp;
    
    NSMutableArray *arrayCities;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSURL *url = [NSURL URLWithString:@"http://api.geonames.org/search?username=sivakumar.r&country=IN"];
    NSData *data = [NSData dataWithContentsOfURL:url options:NSUTF8StringEncoding error:nil];
    _parserCities = [[NSXMLParser alloc] initWithData:data];
    _parserCities.delegate = self;
    arrayTemp = [[NSMutableArray alloc] init];
    [_parserCities parse];
}
#pragma mark - XML PARSING
-(void)parserDidEndDocument:(NSXMLParser *)parser{
    //Getting for the fcode=PPLA cities only
    arrayCities = [[NSMutableArray alloc] init];
    for (int i=0; i<arrayTemp.count; i++) {
        if ([[[arrayTemp objectAtIndex:i] valueForKey:@"fcode"] isEqualToString:@"PPLA"]) {
            [arrayCities addObject:[arrayTemp objectAtIndex:i]];
        }
    }
    //Sorting based on the cityname
    NSSortDescriptor *cityNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"toponymName" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:cityNameDescriptor];
    NSArray *sortedArray = [arrayCities sortedArrayUsingDescriptors:sortDescriptors];
    [arrayCities removeAllObjects];
    [arrayCities addObjectsFromArray:sortedArray];
    
    [_tableCities reloadData];
}
-(void)parser:(NSXMLParser*)parser didStartElement:(NSString*)elementName namespaceURI:(NSString*)namespaceURI qualifiedName:(NSString*)qualifiedName attributes:(NSDictionary*)attributeDict{
    if ([CurElementName isEqualToString:@"geoname"]) {
        dictCity = [[NSMutableDictionary alloc]init];
    }
    CurElementName = elementName;
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
        if ([elementName isEqualToString:@"toponymName"])
            [arrayTemp addObject:dictCity];
    CurElementName = nil;
}
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
        if ([CurElementName isEqualToString:@"toponymName"] || [CurElementName isEqualToString:@"lat"] || [CurElementName isEqualToString:@"lng"] || [CurElementName isEqualToString:@"fcode"]) {
            [dictCity setObject:string forKey:CurElementName];
        }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark UITableviewDelegate methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [arrayCities count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [[arrayCities objectAtIndex:indexPath.row] valueForKey:@"toponymName"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *latitude = [[arrayCities objectAtIndex:indexPath.row] valueForKey:@"lat"];
    NSString *longitude = [[arrayCities objectAtIndex:indexPath.row] valueForKey:@"lng"];

    NSURL *urlFetchWeather = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?lat=%@&lon=%@&appid=bd82977b86bf27fb59a04b61b657fb6f",latitude,longitude]];
    
    NSData *weatherData = [NSData dataWithContentsOfURL:urlFetchWeather];
    
    weatherDataDictionary = [NSJSONSerialization JSONObjectWithData:weatherData options:NSJSONReadingAllowFragments error:nil];
    strCity = [[arrayCities objectAtIndex:indexPath.row] valueForKey:@"toponymName"];
    NSLog(@"%@",weatherDataDictionary);  
    
    
    [self performSegueWithIdentifier:@"segueWeather" sender:nil];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    WeatherViewController *weatherVC = (WeatherViewController *) [segue destinationViewController];
    weatherVC.weatherDataDictionary = weatherDataDictionary;
    weatherVC.cityName = strCity;
}
@end
