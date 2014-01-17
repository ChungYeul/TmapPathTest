//
//  ViewController.m
//  TmapPathTest
//
//  Created by SDT-1 on 2014. 1. 17..
//  Copyright (c) 2014년 T. All rights reserved.
//

#import "ViewController.h"
#import "TMapView.h"
#define TOOLBAR_HEIGHT 64

@interface ViewController ()
@property (strong, nonatomic) TMapView *mapView;
@property (strong, nonatomic) TMapMarkerItem *startMarker, *endMarker;
@property (weak, nonatomic) IBOutlet UISegmentedControl *transportType;

@end

@implementation ViewController
- (IBAction)transportTypeChanged:(id)sender {
    [self showPath];
}

- (void)showPath {
    TMapPathData *path = [[TMapPathData alloc] init];
    TMapPolyLine *line = [path findPathDataWithType:(int)self.transportType.selectedSegmentIndex startPoint:[self.startMarker getTMapPoint] endPoint:[self.endMarker getTMapPoint]];
    if (nil != line) {
        [self.mapView showFullPath:@[line]];
        
        [self.mapView bringMarkerToFront:self.startMarker];
        [self.mapView bringMarkerToFront:self.endMarker];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [self showPath];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //
    CGRect rect = CGRectMake(0, TOOLBAR_HEIGHT, self.view.frame.size.width, self.view.frame.size.height - TOOLBAR_HEIGHT);
    self.mapView = [[TMapView alloc] initWithFrame:rect];
    [self.mapView setSKPMapApiKey:@"82add192-7843-36bc-b1fd-175e2c70faad"];
    [self.view addSubview:self.mapView];
    
    //
    self.startMarker = [[TMapMarkerItem alloc] init];
    [self.startMarker setIcon:[UIImage imageNamed:@"yellow_pin.png"]];
    TMapPoint *startPoint = [self.mapView convertPointToGpsX:50 andY:50];
    [self.startMarker setTMapPoint:startPoint];
    [self.mapView addCustomObject:self.startMarker ID:@"START"];
    
    //
    self.endMarker = [[TMapMarkerItem alloc] init];
    [self.endMarker setIcon:[UIImage imageNamed:@"red_pin.png"]];
    TMapPoint *endPoint = [self.mapView convertPointToGpsX:300 andY:300];
    [self.endMarker setTMapPoint:endPoint];
    [self.mapView addCustomObject:self.endMarker ID:@"END"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
