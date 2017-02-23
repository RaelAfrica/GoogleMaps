//
//  ViewController.h
//  GoogleMaps2
//
//  Created by Rael Kenny on 1/13/17.
//  Copyright © 2017 Rael Kenny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKAnnotation.h"
@import GoogleMaps;

@interface ViewController : UIViewController

@property (nonatomic, strong) IBOutlet GMSMapView *mapView;
@property (nonatomic, strong) IBOutlet UISearchBar *searchBar;


@end

