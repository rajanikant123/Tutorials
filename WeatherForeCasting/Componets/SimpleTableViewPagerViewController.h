

#import "TableViewPagerViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface SimpleTableViewPagerViewController : TableViewPagerViewController<CLLocationManagerDelegate>{

    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    UIView *reportView;
    NSMutableArray *arr_City;
    UIActivityIndicatorView *spinner;
}
@property (nonatomic, strong) NSArray *data;

@property ( assign) BOOL isCurrCity;
@end
