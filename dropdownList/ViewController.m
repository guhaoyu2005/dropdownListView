//
//  ViewController.m
//  dropdownList
//
//  Created by Haoyu Gu on 2016-03-28.
//  Copyright © 2016 Haoyu Gu. All rights reserved.
//

#import "dropdownList.h"
#import "ViewController.h"

@interface ViewController ()

@property (nonatomic) dropdownList *ddl;

@end

@implementation ViewController
@synthesize ddl;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor grayColor]];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showDDL:(id)sender {
    if (!ddl) {
        ddl = [[dropdownList alloc] initWithData:@[@"a", @"b", @"c"]];
        [ddl setFrame:CGRectMake(10, 150, self.view.frame.size.width , self.view.frame.size.height/2)];
        [self.view addSubview:ddl];
    }
    
    //[ddl setHeaderOffset:CGPointMake(30, 0)];
    [ddl show];
}

- (IBAction)hideDDL:(id)sender {
    [ddl hide];
}

@end
