//
//  ViewController.m
//  LocationFinder
//
//  Created by Joshua Asbury on 18/12/2021.
//

#import "ViewController.h"

@implementation ViewController {
    CLLocationManager *locationManager;
}

- (instancetype)init {
    if (self = [super init]) {
        locationManager = [CLLocationManager new];
        locationManager.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self updateUIForStatus:locationManager.authorizationStatus];
    [locationManager startUpdatingLocation];
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    [self updateUIForStatus:locationManager.authorizationStatus];
}

- (void)updateUIForStatus:(CLAuthorizationStatus)status {
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            [self.locationLabel setStringValue:@"Permission required."];
            [self.getLocationButton setTitle:@"Request permission"];
            self.getLocationButton.enabled = YES;
            break;
        case kCLAuthorizationStatusRestricted:
            [self.locationLabel setStringValue:@"Parental controls preventing location access."];
            [self.getLocationButton setTitle:@"Get My Location"];
            self.getLocationButton.enabled = NO;
            break;
        case kCLAuthorizationStatusDenied:
            [self.locationLabel setStringValue:@"Location permission denied. Update in System Preferences."];
            [self.getLocationButton setTitle:@"Open Location preferences"];
            self.getLocationButton.enabled = YES;
            break;
        case kCLAuthorizationStatusAuthorized:
            [self.locationLabel setStringValue:@"Location not yet fetched."];
            [self.getLocationButton setTitle:@"Get My Location"];
            self.getLocationButton.enabled = NO;
            break;
    }
}

- (void)updateLabelWithLocation:(CLLocation *)location {
    NSString *value = [NSString stringWithFormat:@"Latitude: %.2f Longitude: %.2f Accuracy: %.2f",
                       location.coordinate.latitude,
                       location.coordinate.longitude,
                       location.horizontalAccuracy];
    [self.locationLabel setStringValue:value];
}

- (IBAction)buttonPressed:(NSButtonCell *)sender {
    switch (locationManager.authorizationStatus) {
        case kCLAuthorizationStatusNotDetermined:
//            [locationManager requestWhenInUseAuthorization];
            [locationManager startUpdatingLocation];
            break;
            
        case kCLAuthorizationStatusDenied:
            [NSWorkspace.sharedWorkspace openURL:[NSURL URLWithString:@"x-apple.systempreferences:com.apple.preference.security?Privacy_Location"]];
            break;
            
        case kCLAuthorizationStatusAuthorized:
            [locationManager requestLocation];
            break;
            
        default:
            break;
    }
}

- (void)locationManagerDidChangeAuthorization:(CLLocationManager *)manager {
    [self updateUIForStatus:manager.authorizationStatus];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    [self updateLabelWithLocation:[locations lastObject]];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"%@", error.debugDescription);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    NSLog(@"Here");
}

@end
