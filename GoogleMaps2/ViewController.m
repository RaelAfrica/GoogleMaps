//
//  ViewController.m
//  GoogleMaps2
//
//  Created by Rael Kenny on 1/13/17.
//  Copyright © 2017 Rael Kenny. All rights reserved.
//

#import "ViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "WebViewController.h"


@interface ViewController () <GMSMapViewDelegate,UISearchBarDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:40.7084
                                                            longitude:-74.0149
                                                                 zoom:15];
    
  //  GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    
    self.mapView.myLocationEnabled = YES;
    
    self.mapView.camera = camera;
    self.mapView.delegate = self;
    self.searchBar.delegate = self;
    //self.view = self.mapView;
    
    [self hardcodedPins];
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self callSearch];
}


-(void)hardcodedPins {
    
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(40.7084, -74.0149);
    marker.title = @"Turn To Tech";
    marker.snippet = @"Mobile Bootcamp";
    marker.appearAnimation = kGMSMarkerAnimationPop;
    marker.map = self.mapView;
    marker.infoWindowAnchor = CGPointMake(0.5, -0.25);
    
    GMSMarker *marker2 = [[GMSMarker alloc] init];
    marker2.position = CLLocationCoordinate2DMake(40.7033, -74.0110);
    marker2.title = @"Dead Rabbit";
    marker2.snippet = @"Cocktail Bar";
    marker2.appearAnimation = kGMSMarkerAnimationPop;
    marker2.map = self.mapView;
    marker2.infoWindowAnchor = CGPointMake(0.5, -0.25);
    
    GMSMarker *marker3 = [[GMSMarker alloc] init];
    marker3.position = CLLocationCoordinate2DMake(40.7104, -74.0120);
    marker3.title = @"Eataly";
    marker3.snippet = @"Italian Market";
    marker3.appearAnimation = kGMSMarkerAnimationPop;
    marker3.map = self.mapView;
    marker3.infoWindowAnchor = CGPointMake(0.5, -0.25);
    
}


-(void)callSearch {
    [self.mapView clear];
    
    double currentLat = self.mapView.camera.target.latitude;
    double currentLon = self.mapView.camera.target.longitude;
    
    //prepare the URL we'll get the data from.
    NSString *searchURL = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%f,%f&radius=1000&keyword=%@&key=AIzaSyAKL1E0VIg_zx6agc4SAUxnJ4N4tIQ4nEU",currentLat, currentLon,self.searchBar.text];
    
    //create a session to get data.
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURL *url = [NSURL URLWithString:searchURL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    request.HTTPMethod = @"GET";
    
    //we’ll convert the returned JSON data into a NSDictionary object. Then, we will check if any error has occurred during conversion, and if not we’ll extract the array from that dictionary
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData * data, NSURLResponse *  response, NSError * error) {
        
        if (error) { //if error occurs, then display its description on the console.
            NSLog(@"Error %@", error.localizedDescription);
        } else {
            NSError *jError;
            
            NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jError]; //parse data  
            
            //dictionary -> array -> dictionary
            NSArray *results = [jsonDictionary objectForKey:@"results"];
            
            for (NSDictionary *result in results) {
                //iterate through results Array
                NSString *placeName = [result objectForKey:@"name"];
                NSLog(@"%@", placeName);
                NSDictionary *geometry = [result objectForKey:@"geometry"];
                NSDictionary *location = [geometry objectForKey:@"location"];
                NSNumber *longitude = [location objectForKey:@"lng"];
                NSNumber *latitude = [location objectForKey:@"lat"];
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    //create instance of GMSMarker *marker?
                    GMSMarker *marker = [[GMSMarker alloc]init];
                    //position
                    marker.position = CLLocationCoordinate2DMake([latitude doubleValue], [longitude doubleValue]);
                    marker.title = [result objectForKey:@"Name"];
                    marker.snippet = [result objectForKey:self.searchBar.text];
                   marker.map = self.mapView;
                });
            }
            
        }
    }]
    resume];
}


-(UIView*) mapView: (GMSMapView*)mapView
  markerInfoWindow:(GMSMarker *)marker {
    
    RKAnnotation *infoWindow = [[[NSBundle mainBundle]loadNibNamed:@"RKAnnotation" owner:self options:nil]objectAtIndex:0];
    infoWindow.title.text = marker.title;
    infoWindow.subTitle.text = marker.snippet;
    infoWindow.imageView.image = [UIImage imageNamed:@"79a6cc671eb7205ea4903436e08851c4-map"];
    
    return infoWindow;
}



-(void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker {
    
    WebViewController *webVC = [[WebViewController alloc]init];
    [self presentViewController:webVC animated:YES completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeMapType:(UISegmentedControl *)sender {
    
    NSUInteger selectedMapType = sender.selectedSegmentIndex;
    
    switch (selectedMapType) {
        case 0:
            self.mapView.mapType = kGMSTypeNormal;
            break;
        case 1:
            self.mapView.mapType = kGMSTypeHybrid;
            break;
        case 2:
            self.mapView.mapType = kGMSTypeSatellite;
            break;
            
        default:
            self.mapView.mapType = kGMSTypeNormal;
            break;
    }
}

-(BOOL)prefersStatusBarHidden {
    return YES;
}



@end
