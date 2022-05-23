//
//  ViewController.h
//  LocationFinder
//
//  Created by Joshua Asbury on 18/12/2021.
//

#import <Cocoa/Cocoa.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : NSViewController <CLLocationManagerDelegate>

@property (strong) IBOutlet NSTextField *locationLabel;
@property (strong) IBOutlet NSButtonCell *getLocationButton;

@end

