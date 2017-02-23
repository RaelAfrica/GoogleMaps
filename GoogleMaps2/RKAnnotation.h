//
//  RKAnnotation.h
//  GoogleMaps2
//
//  Created by Rael Kenny on 1/13/17.
//  Copyright © 2017 Rael Kenny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RKAnnotation : UIView

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;

@end
