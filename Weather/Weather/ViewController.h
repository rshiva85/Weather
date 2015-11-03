//
//  ViewController.h
//  Weather
//
//  Created by SIVA KUMAR (YPAYCASH\30085) on 02/11/15.
//  Copyright (c) 2015 Payblox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, NSXMLParserDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableCities;
@property (strong, nonatomic) NSXMLParser *parserCities;


@end

