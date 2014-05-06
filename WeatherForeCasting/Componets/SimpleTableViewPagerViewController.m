

#import "SimpleTableViewPagerViewController.h"
#import <AddressBookUI/AddressBookUI.h>
#import <AddressBook/AddressBook.h>
#import <MapKit/MapKit.h>
#import "WeatherCell.h"
@interface SimpleTableViewPagerViewController ()
{
    
}
@property (strong, nonatomic) IBOutlet UIView *view_Back;
@end
@implementation SimpleTableViewPagerViewController

@synthesize data = _data;
@synthesize isCurrCity;

#pragma mark -
#pragma mark -UIViewcontroller Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.frame = CGRectMake((self.view.frame.size.width/2)-45, (self.view.frame.size.height/2)-45, 90, 90);
    [self.view addSubview:spinner];
    [spinner startAnimating];
    
    if(isCurrCity)
    {
        [self getCurrentCity];
    }
    else{
        if(self.data.count==1)
        [self.tableViewPagerView.pageControl.rightView removeFromSuperview];
        
        [self fetchData];
        
    }
  
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - Paging view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(arr_City.count>0)
        return 14;
    else
        return 0;
}

-(UIView *)pageIndex:(NSUInteger)pageIndex tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(10, 5, tableView.frame.size.width-20, 40.0f)];
    tableHeaderView.backgroundColor = [UIColor clearColor];
    
    UILabel *headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5,tableView.frame.size.width-20, 40.0f)];
    headerLabel.backgroundColor = [UIColor ColorWithHexString:@"#efefef"];
    headerLabel.alpha = 0.5;
    headerLabel.shadowColor = [UIColor ColorWithHexString:@"#ffffff"];
    [headerLabel setShadowOffset:CGSizeMake( 0.0f, 1.0f)];
    
    NSDate *date;
    NSString * timeStampString =[NSString stringWithFormat:@"%@",[[[[arr_City objectAtIndex:pageIndex] objectForKey:@"list"] objectAtIndex:section] objectForKey:@"dt"]];
    NSTimeInterval _interval=[timeStampString doubleValue];
    date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateStyle:NSDateFormatterLongStyle];
    NSString *newDateString = [dateFormatter2 stringFromDate:date];
    
    headerLabel.textAlignment = NSTextAlignmentLeft;
    headerLabel.text =[NSString stringWithFormat:@"           %@",newDateString];
    
    [tableHeaderView addSubview:headerLabel];
    
    UIImageView *dateImageView = [[UIImageView alloc]init];
    dateImageView.backgroundColor = [UIColor clearColor];
    [dateImageView setFrame:CGRectMake(15, 7, 35, 35)];
    dateImageView.image = [UIImage imageNamed:@"calendarred"];
    [tableHeaderView addSubview:dateImageView];
    
    
    return tableHeaderView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 50.0f;
}
- (NSInteger)pageIndex:(NSUInteger)pageIndex tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(arr_City.count>0)
        return 1;
    else
        return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (UITableViewCell *)pageIndex:(NSUInteger)pageIndex tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier=@"cell";
    WeatherCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        // Load the top-level objects from the custom cell XIB.
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"WeatherCell" owner:self options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
    }
    

    if([[[[[[[arr_City objectAtIndex:pageIndex] objectForKey:@"list"] objectAtIndex:indexPath.section] objectForKey:@"weather"] objectAtIndex:0 ] objectForKey:@"main"] isEqualToString:@"Rain"])
    {
        cell.weather_img.image=[UIImage imageNamed:@"Weather_Rain_Cloud.jpg"];
    }
    
    cell.label_humidity.text=[NSString stringWithFormat:@"humidity :%@%@", [[[[arr_City objectAtIndex:pageIndex] objectForKey:@"list"] objectAtIndex:indexPath.section] objectForKey:@"humidity"],@"%"  ];
    
    cell.label_text.text=[[[[[[arr_City objectAtIndex:pageIndex] objectForKey:@"list"] objectAtIndex:indexPath.section] objectForKey:@"weather"] objectAtIndex:0 ] objectForKey:@"main"] ;
 
  
    cell.lable_temp.text=[NSString stringWithFormat:@"%f .c",([[[[[[arr_City objectAtIndex:pageIndex] objectForKey:@"list"] objectAtIndex:indexPath.section] objectForKey:@"temp"] objectForKey:@"day"] floatValue ]-273.15)];
    cell.label_min_max.text=[NSString stringWithFormat:@"Min t: %.2f .c/ Max t: %.2f .c",[[[[[[arr_City objectAtIndex:pageIndex] objectForKey:@"list"] objectAtIndex:indexPath.section] objectForKey:@"temp"] objectForKey:@"day"] floatValue ]-273.15,[[[[[[arr_City objectAtIndex:pageIndex] objectForKey:@"list"] objectAtIndex:indexPath.section] objectForKey:@"temp"] objectForKey:@"day"] floatValue ]-273.15];
    return cell;
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    //    CLLocation *currentLocation = newLocation;
//    NSLog(@"=%@=",newLocation);
    NSString *fromLatitude = [NSString stringWithFormat:@"%f",newLocation.coordinate.latitude];
    NSString * fromLongitude = [NSString stringWithFormat:@"%f",newLocation.coordinate.longitude];
    
    CLLocationDegrees lat = [fromLatitude floatValue];
    CLLocationDegrees lon = [fromLongitude floatValue];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:lat longitude:lon];
    
    
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (error == nil && [placemarks count] > 0) {
            placemark = [placemarks lastObject];
//            NSLog(@"=%@",placemark.locality);
            
            [locationManager stopUpdatingLocation];
            
            [self fetchDatafromGPS:lat andLag:lon];
            
        } else {
            NSLog(@"%@", error.debugDescription);
        }
    } ];
}
#pragma mark - Fetching Data
-(void)getCurrentCity{
    
    locationManager = [[CLLocationManager alloc] init];
    geocoder = [[CLGeocoder alloc] init];
    locationManager.distanceFilter = 80.0;
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [locationManager startUpdatingLocation];
    
    [self.tableViewPagerView.pageControl.rightView removeFromSuperview];
    
}
-(void)fetchData{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    arr_City =[[NSMutableArray alloc]init];
    for(int j=0;j<self.data.count;j++)
    {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/forecast/daily?q=%@&cnt=14&APPID=9e7df3ee12b966cae6888f18e7cce731",[self.data objectAtIndex:j]]]];
        
        
        [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            if (!error) {
                NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:kNilOptions
                                                                       error:&error];
                
                [arr_City addObject:json];
                
                if(self.data.count==arr_City.count)
                {
                    
                    for(int i=0;i<self.data.count;i++)
                    {
                        UITableView *tableViewPage = [self tableViewForPageIndex:i];
                        [tableViewPage reloadData];
                    }
                    
                }
                
                [spinner stopAnimating];
            }
            
        }];
    }
}
-(void)fetchDatafromGPS:(float)lat andLag:(float)log{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    arr_City =[[NSMutableArray alloc]init];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/forecast/daily?lat=%f&lon=%f&cnt=14&mode=json",lat,log]]];
    
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (!error) {
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:kNilOptions
                                                                   error:&error];
            
            [arr_City addObject:json];
            
            UITableView *tableViewPage = [self tableViewForPageIndex:0];
            [tableViewPage reloadData];
            
            self.data = [NSArray arrayWithObjects:
                         [[json objectForKey:@"city"] objectForKey:@"name"],
                         nil];
            
            for(UILabel *lbl in self.tableViewPagerView.titleViews){
                lbl.text=[[json objectForKey:@"city"] objectForKey:@"name"];
            }
            [spinner stopAnimating];
        }
        
    }];
}


@end
