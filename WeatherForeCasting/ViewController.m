//
//  ViewController.m
//  WeatherForeCasting
//
//  Created by rhole on 29/04/14.
//  Copyright (c) 2014 Rajanikant. All rights reserved.
//

#import "ViewController.h"
#import "SimpleTableViewPagerViewController.h"

@interface ViewController (){
    UIView *reportView;
    NSMutableArray *arr_List_City;
    UITextField *textField;
    UITableView *tableView_City;
}
@property (strong, nonatomic) IBOutlet UIView *backView;


@end

@implementation ViewController

#pragma mark -
#pragma mark -Button Methods
- (IBAction)button_Curr_City_Clicked:(id)sender {
    SimpleTableViewPagerViewController *simplePTVC = [[SimpleTableViewPagerViewController alloc] initWithNumberOfPages:1];
    simplePTVC.isCurrCity=YES;
    simplePTVC.titleStrings = [NSArray arrayWithObjects:@"",nil];
    simplePTVC.pageControlBackgroundColor = [UIColor lightGrayColor];

    [self.navigationController pushViewController:simplePTVC animated:YES];

}

- (IBAction)button_Any_City_Clicked:(id)sender {

    [self createViewForCities];
    
}
-(void)button_Add_Clicked:(id)sender{

    if([textField.text length]>0)
    {
        [arr_List_City addObject:textField.text];
        textField.text=@"";
        [tableView_City reloadData];
        [textField resignFirstResponder];
    }
    
}

-(void)button_Done_Clicked:(id)sender{
    
    if(arr_List_City.count>0)
    {
    SimpleTableViewPagerViewController *simplePTVC = [[SimpleTableViewPagerViewController alloc] initWithNumberOfPages:arr_List_City.count];

    
    simplePTVC.titleStrings = arr_List_City;
    simplePTVC.pageControlBackgroundColor = [UIColor lightGrayColor];
    simplePTVC.data=arr_List_City;
    [self.navigationController pushViewController:simplePTVC animated:NO];
    }
}
-(void)button_Back_Clicked:(id)sender{

    [reportView removeFromSuperview];
    
}

#pragma mark -
#pragma mark -Create View For Multiple Cities
-(void)createViewForCities{
    
    //Create Background View
    
    reportView = [[UIView alloc] initWithFrame:self.backView.frame];
    reportView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pattern.png"]];
    [self.view addSubview:reportView];
    
    //Create BackButton
    UIButton *button_Back =[UIButton buttonWithType:UIButtonTypeCustom];
    [button_Back setFrame:CGRectMake(20, 10, 40, 40)];
    [button_Back setBackgroundImage:[UIImage imageNamed:@"back_list"] forState:UIControlStateNormal];
    [button_Back addTarget:self action:@selector(button_Back_Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [reportView addSubview:button_Back];
    
     //Create Button_Done
    UIButton *button_Done =[UIButton buttonWithType:UIButtonTypeCustom];
    [button_Done setFrame:CGRectMake(250, 6, 50, 50)];
    [button_Done setBackgroundImage:[UIImage imageNamed:@"checkInOn"] forState:UIControlStateNormal];
    [button_Done addTarget:self action:@selector(button_Done_Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [reportView addSubview:button_Done];
    
    float startX=22;
    UILabel *label_City=[[UILabel alloc]initWithFrame:CGRectMake(startX,90,280, 25)];
    label_City.font = [UIFont systemFontOfSize:14.0f];
    label_City.text=@"Enter City Name";
    label_City.textAlignment=NSTextAlignmentLeft;
    [label_City setNumberOfLines:0];
    [label_City setBackgroundColor:[UIColor clearColor]];
    label_City.textColor=[UIColor whiteColor];
    [reportView addSubview:label_City];
    

    textField= [[UITextField alloc] init];
    textField.frame=CGRectMake(startX,120,236, 30);
    textField.backgroundColor = [UIColor whiteColor];
    textField.textColor = [UIColor blackColor];
    textField.autoresizingMask=UIViewAutoresizingFlexibleWidth;
    textField.font = [UIFont systemFontOfSize:14.0f];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.returnKeyType = UIReturnKeyDone;
    textField.textAlignment = NSTextAlignmentLeft;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.tag=0;
    textField.delegate=self;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [reportView addSubview:textField];
    
     //Create Button add for user to add city names
    UIButton *button_Add =[UIButton buttonWithType:UIButtonTypeCustom];
    [button_Add setFrame:CGRectMake(266, 120, 30, 30)];
    [button_Add setBackgroundImage:[UIImage imageNamed:@"add.jpg"] forState:UIControlStateNormal];
    [button_Add addTarget:self action:@selector(button_Add_Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [reportView addSubview:button_Add];
    
    
    tableView_City=[[UITableView alloc]initWithFrame:CGRectMake(20, 200, 280, 250) style:UITableViewStylePlain];
    tableView_City.delegate=self;
    tableView_City.layer.borderColor=[UIColor blackColor].CGColor;
    tableView_City.layer.borderWidth=5;
    tableView_City.dataSource=self;
    tableView_City.backgroundColor=[UIColor clearColor];
    [reportView addSubview:tableView_City];
}
#pragma mark -
#pragma mark -UIViewcontroller Methods

-(void)viewWillAppear:(BOOL)animated{
     [reportView removeFromSuperview];
    [arr_List_City removeAllObjects];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
     arr_List_City=[[NSMutableArray alloc]init];
    
    //Create Background View
     self.backView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pattern.png"]];


	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark -UITableView Delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

        return 40;
  
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
      return arr_List_City.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
    
        
        static NSString *cellIdentifier=@"Cell";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if(cell==nil)
        {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:cellIdentifier];
            
        }
        for(UIView *v in [cell.contentView subviews])
        {
      
                [v removeFromSuperview];
        }
        
        cell.textLabel.text=[arr_List_City objectAtIndex:indexPath.row];
        cell.textLabel.textColor=[UIColor whiteColor];
        cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pattern.png"]];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
      
        
        return cell;
    
    
}
#pragma mark -
#pragma mark Text Field Delegate

/* Editing began */
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
 
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
 
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField1{
    if([textField.text length]>0)
    {
        [arr_List_City addObject:textField.text];
        textField.text=@"";
        [tableView_City reloadData];
       
    }
    return [textField resignFirstResponder];
}

@end
