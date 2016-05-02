//
//  MyBikeDetailsViewController.m
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/13/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import "MyBikeDetailsViewController.h"

#import "GlobalInstance.h"
#import "APIURLsNdKeys.h"
#import "MyBikeDetailsCell.h"
#import "NSDictionary+BikeDetails.h"

#import "MBProgressHUD.h"
#import "TSMessage.h"
#import "AFHTTPSessionManager.h"
#import "AFHTTPRequestOperation.h"

#import "UIImageView+AFNetworking.h"


#import "UserRegViewController.h"
#import "RFQViewController.h"

#import <QuartzCore/QuartzCore.h>

@implementation BikeImageCell
@end

@implementation UIView (Animation)

-(void)addSubviewWithBounce:(UIView*)theView
{
    theView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    
    [self addSubview:theView];
    
    [UIView animateWithDuration:0.3/1.5 animations:^{
        theView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3/2 animations:^{
            theView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3/2 animations:^{
                theView.transform = CGAffineTransformIdentity;
            }];
        }];
    }];
}
@end


@implementation MyBikeDetailsViewController{
    SingleBikeDetails* sbd;
    int whichCell;
    int catCount;
    int specCount;
    NSMutableArray* specArray;
    
    NSMutableArray* bikeImagesArray;
    UIActivityIndicatorView* activityInd;
    
    UIView* uiview;
}

@synthesize bike_id;

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    catCount = 0;
    specCount = 0;
    whichCell = 0;
    self.bikedetailTable.allowsSelection = NO;
    bikeImagesArray = [[NSMutableArray alloc] init];
    
    
    self.headerView.layer.masksToBounds = NO;
    CGRect shadowFrame = self.headerView.layer.bounds;
    CGPathRef shadowPath = [UIBezierPath bezierPathWithRect:shadowFrame].CGPath;
    CALayer *viewLayer = self.headerView.layer;
    viewLayer.shadowPath = shadowPath;
    viewLayer.shadowOffset = CGSizeMake(4, 2);
    viewLayer.shadowColor = [[UIColor lightGrayColor] CGColor];
    viewLayer.shadowRadius = 1;
    viewLayer.shadowOpacity = 0.70;
    
    
    activityInd = [GlobalInstance sharedInstance].activityView;
    CGRect frame = activityInd.frame;
    frame.origin.x = self.view.frame.size.width / 2 - frame.size.width / 2;
    frame.origin.y = self.imageCollection.frame.size.height / 2 - frame.size.height / 2;
    activityInd.frame = frame;
    //activityInd.center = self.lblBikeName.center;
    //activityInd.autoresizingMask = [.FlexibleWidth, .FlexibleHeight];
    [self.imageCollection addSubview:activityInd];
    
    
    [self getMyBikeDetailsData];
    
//    [self.imgBikeImage setUserInteractionEnabled:YES];
//    
//    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleLeftSwipe)];
//    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleRightSwipe)];
//    
//    // Setting the swipe direction.
//    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
//    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
//    
//    // Adding the swipe gesture on image view
//    [self.imgBikeImage addGestureRecognizer:swipeLeft];
//    [self.imgBikeImage addGestureRecognizer:swipeRight];
 
}

- (void)handleLeftSwipe
{
    NSLog(@"Left Swipe");
}

- (void)handleRightSwipe
{
    NSLog(@"Left Swipe");
}

- (void) getMyBikeDetailsData{
    NSDictionary *parameters = @{key_getMyBikeDetails_authKey: [GlobalInstance sharedInstance].auth_key, key_getMyBikeDetails_bike_id: bike_id};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [manager POST:[APIURLsNdKeys getMyBikeDetailsURL] parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        [[GlobalInstance sharedInstance] setBikeDetailsJSON:responseObject];
        
        sbd = [[GlobalInstance sharedInstance].bikeDetailsJSON bikeDetails];
        
        
        BikeBasic* bb = sbd.basic;
        [self.lblBikeName setText:bb.bike_name];
        [self.lblBikeCC setText:bb.bike_cc];
        
        specArray = [[NSMutableArray alloc] init];
        [specArray addObject:sbd.engine.specs];
        [specArray addObject:sbd.electrical.specs];
        [specArray addObject:sbd.suspension.specs];
        [specArray addObject:sbd.tyre.specs];
        [specArray addObject:sbd.brake.specs];
        [specArray addObject:sbd.dimensions.specs];
        
        self.navigationItem.title = ((BikeBasic*)sbd.basic).bike_name;
        
        //NSLog(@"Bike Array size: %i", [allBikes count]);
        self.bikedetailTable.delegate = self;
        self.bikedetailTable.dataSource = self;
        [self.bikedetailTable reloadData];
        self.navigationController.title = ((BikeBasic*)sbd.basic).bike_name;
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        [activityInd startAnimating];
        NSArray* bikeLargeImages = sbd.images;
        NSMutableArray* requestArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < [bikeLargeImages count]; i++) {
            
            NSURL *url = [NSURL URLWithString:((BikeImage*)[bikeLargeImages objectAtIndex:i]).large_image_link];
            
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            
            AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
            operation.responseSerializer = [AFImageResponseSerializer serializer];
            
            [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                [bikeImagesArray addObject:responseObject];
                //[bikeImagesArray addObject:responseObject];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                [TSMessage showNotificationInViewController:self
                                                      title:@"Image Downloading Failed !"
                                                   subtitle:[error localizedDescription]
                                                       type:TSMessageNotificationTypeError];
            }];
            
            [requestArray addObject:operation];
        }
        
        NSArray *batches = [AFURLConnectionOperation batchOfRequestOperations:requestArray progressBlock:^(NSUInteger numberOfFinishedOperations, NSUInteger totalNumberOfOperations) {
        } completionBlock:^(NSArray *operations) {
            NSLog(@"bike details collection count: %lu", bikeImagesArray.count);
            self.imageCollection.delegate = self;
            self.imageCollection.dataSource = self;
            [self.imageCollection reloadData];
            [activityInd stopAnimating];
        }];
        
        [[NSOperationQueue mainQueue] addOperations:batches waitUntilFinished:NO];
        
        float startingX = (([UIScreen mainScreen].bounds.size.width - 20) / 2) - (([bikeLargeImages count] * 25) / 2);
        for (int i = 0; i < [bikeLargeImages count]; i++) {
            NSLog(@"starting X: %f", startingX);
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(startingX, 0, 25, 15)];
            [label setFont:[UIFont fontWithName:font_font_awesome_yay size:14.0]];
            [label setText:@"\uf21c"];
            [label setTextAlignment:NSTextAlignmentCenter];
            BikeImage* bi = [bikeLargeImages objectAtIndex:i];
            NSLog(@"color code: %@", bi.image_color);
            [label setTextColor:[self colorFromHexString:bi.image_color]];
            [self.colorLabelView addSubview:label];
            startingX += 25.0;
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        [TSMessage showNotificationWithTitle:@"Error Retrieving Data"
                                    subtitle:[error localizedDescription]
                                        type:TSMessageNotificationTypeError];
    }];
    
}

- (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [specArray count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [((NSMutableArray*)[specArray objectAtIndex:section]) count];
}

- (CGFloat)tableView:(UITableView*)tableView
heightForHeaderInSection:(NSInteger)section {

        return 44.0f;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (whichCell == 0) {
//        return 10;
//    }else if(whichCell == 1){
//        return 24;
//    }else{
//        return 40;
//    }
    return 40;
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"inside cellforrowatindex");
    //NSLog(@"from cellforrowatindex %i", count);
    float screenWidth = [[UIScreen mainScreen]bounds].size.width;
    
    NSString *CellIdentifier;
    if (whichCell == 0) {
        CellIdentifier = @"seperator_cell";
        BDSeperatorCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        whichCell = 1;
        return cell;
    } else if (whichCell == 1) {
        CellIdentifier = @"category_cell";
        BDCategoryCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        if(catCount == 0){
            [cell.category setText:sbd.engine.category_name];
        }else if (catCount == 1){
            [cell.category setText:sbd.electrical.category_name];
        }else if (catCount == 2){
            [cell.category setText:sbd.suspension.category_name];
        }else if (catCount == 3){
            [cell.category setText:sbd.tyre.category_name];
        }else if (catCount == 4){
            [cell.category setText:sbd.brake.category_name];
        }else{
            [cell.category setText:sbd.dimensions.category_name];
        }
        CGRect frame = cell.category.bounds;
        frame.size.width = screenWidth / 4.0;
        cell.category.bounds = frame;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        whichCell = 9;
        return cell;
    }else if (whichCell == 9) {
        CellIdentifier = @"seperator_cell";
        BDSeperatorCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        whichCell = 2;
        return cell;
    } else{
        CellIdentifier = @"spec_cell";
        BDSpecCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        NSMutableArray* spec;
        if (catCount == 0){
            spec = sbd.engine.specs;
        }else if(catCount == 1){
            spec = sbd.electrical.specs;
        }else if(catCount == 2){
            spec = sbd.suspension.specs;
        }else if(catCount == 3){
            spec = sbd.tyre.specs;
        }
        else if (catCount == 4){
            spec = sbd.brake.specs;
        }else{
            spec = sbd.dimensions.specs;
        }
        
        if (specCount < [spec count]) {
            BikeSpecification* bs = [spec objectAtIndex:specCount];
            [cell.spec_title setText:bs.specification_title];
            [cell.spec_value setText:bs.specification_value];
            if(specCount % 2 == 0){
                [cell.spec_title setBackgroundColor:[UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0]];
                [cell.spec_value setBackgroundColor:[UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0]];
            }else{
                [cell.spec_title setBackgroundColor:[UIColor whiteColor]];
                [cell.spec_value setBackgroundColor:[UIColor whiteColor]];

            }
            specCount += 1;
        }else{
            catCount += 1;
            specCount = 0;
            whichCell = 0;
        }
        
        cell.constrSpecTitleWidth.constant = screenWidth / 4.0;
        return cell;
    }
    //return nil;
}*/

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //NSLog(@"section %i", section);
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 44)];
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, tableView.frame.size.width / 3.0, 24)];
    [label setFont:[UIFont fontWithName:font_suzuki_bold size:14.0]];
    [label setBackgroundColor:[UIColor colorWithRed:105/255.0 green:128/255.0 blue:145/255.0 alpha:1.0]];
    [label setTextColor:[UIColor whiteColor]];
    [label setTextAlignment:NSTextAlignmentCenter];
    NSMutableArray* array = [specArray objectAtIndex:section];
    NSLog(@"section array: %@", [array description]);
    BikeSpecification* bs = [array objectAtIndex:0];
    NSString *string =bs.specification_category;//((BikeSpecification*)[((NSMutableArray*)[specArray objectAtIndex:section]) objectAtIndex:1]).specification_category;
    /* Section header is in 0th index... */
    [label setText:string];
    [view addSubview:label];
    //[view setBackgroundColor:[UIColor colorWithRed:166/255.0 green:177/255.0 blue:186/255.0 alpha:1.0]]; //your background color...
    return view;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableArray* specs = [specArray objectAtIndex:indexPath.section];
    BikeSpecification* bs = [specs objectAtIndex:indexPath.row];
    
    NSString* CellIdentifier = @"spec_cell";
    BDSpecCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    [cell.spec_title setText:bs.specification_title];
    [cell.spec_value setText:[@": " stringByAppendingString:bs.specification_value]];
    
    cell.constrSpecTitleWidth.constant = [[UIScreen mainScreen]bounds].size.width / 3.0;
    
    if(indexPath.row % 2 == 0){
        [cell.spec_title setBackgroundColor:[UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0]];
        [cell.spec_value setBackgroundColor:[UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0]];
    }else{
        [cell.spec_title setBackgroundColor:[UIColor whiteColor]];
        [cell.spec_value setBackgroundColor:[UIColor whiteColor]];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.imageCollection.bounds.size.width, self.imageCollection.bounds.size.height);
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [bikeImagesArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BikeImageCell *cell = nil;
    NSString *CellIdentifier = nil;
    CellIdentifier = @"imageSlideCell";
    cell=(BikeImageCell *) [self.imageCollection dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.imgBikeImage.image = [bikeImagesArray objectAtIndex:indexPath.row];
    
    [cell.imgBikeImage setClipsToBounds:YES];
    
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
    
    NSLog(@"click details image");
    uiview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    [uiview addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)]];
    
    [uiview setBackgroundColor:[UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:.95]];
    
    UIImageView* bikeImageView = [[UIImageView alloc] initWithFrame:uiview.frame];
    bikeImageView.contentMode=UIViewContentModeScaleAspectFit;
    
    UIImage *originalImage = [bikeImagesArray objectAtIndex:indexPath.row];
    
    UIImage *imageToDisplay = [UIImage imageWithCGImage:[originalImage CGImage]
                        scale:[originalImage scale]
                  orientation: UIImageOrientationRight];
    bikeImageView.image = imageToDisplay;

    [uiview addSubview:bikeImageView];
    
    [self.view addSubviewWithBounce:uiview];
    
}



- (IBAction)quoteButton:(id)sender {
    
    //UserRegViewController* userReg = (UserRegViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@ "userRegScene"];
    
    RFQViewController* rfq = (RFQViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@ "RFQScene"];
    rfq.bike_id = ((BikeBasic*)sbd.basic).bike_id;
    rfq.bike_name =((BikeBasic*)sbd.basic).bike_name;
    rfq.bike_cc =((BikeBasic*)sbd.basic).bike_cc;
    [self.navigationController pushViewController:rfq animated:YES];
}

- (void)tapDetected:(UITapGestureRecognizer *)tapRecognizer
{
    [UIView transitionWithView:uiview
                      duration:0.6
                       options:UIViewAnimationOptionCurveEaseIn
                    animations:^{
                        [uiview removeFromSuperview];
                    }
                    completion:^(BOOL finished){
                        
                    }];

}
@end
