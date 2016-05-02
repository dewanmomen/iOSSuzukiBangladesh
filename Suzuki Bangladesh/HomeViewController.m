//
//  HomeViewController.m
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 3/29/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import "HomeViewController.h"
#import "MBProgressHUD.h"
//#import "SWRevealViewController.h"
#import "HomeScreeCollectionViewCell.h"

#import "NotificationListViewController.h"

#import "UIBarButtonItem+Badge.h"

#import "GlobalInstance.h"
#import "APIURLsNdKeys.h"
#import "NSDictionary+BikeList.h"

#import "MBProgressHUD.h"
#import "TSMessage.h"
#import "AFHTTPSessionManager.h"
#import "AFHTTPRequestOperation.h"
#import "UIImageView+AFNetworking.h"

#import "NavigationController.h"
#import "MyBikeListViewController.h"
#import "RFSViewController.h"
#import "SparePartsListViewController.h"
#import "NewsNdEventListViewController.h"
#import "PromotionViewController.h"

#import "NSDictionary+MediaURLs.h"

@implementation HomeViewController{
    NSMutableArray* galleryImageArray;
    NSMutableArray* featuredImageArray;
    
    NSArray* bikeArray;
    NSArray* searchedBikeArray;
    
    BOOL isSearched;
    int selectedIndex;
    
    Bike* seletedBikeObj;
    
    UIActivityIndicatorView* activityIndSlider;
    UIActivityIndicatorView* activityIndFind;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.title = @"Stream";
    
    //_sidebarButton.target = self.revealViewController;
    //_sidebarButton.action = @selector(revealToggle:);
    
    //[self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    galleryImageArray = [[NSMutableArray alloc] init];
    featuredImageArray = [[NSMutableArray alloc] init];
    isSearched = NO;
    
    [self setUpTheNavBar];
    [self setUpTheView];
    
    activityIndSlider = [GlobalInstance sharedInstance].activityView;
    CGRect frame = activityIndSlider.frame;
    frame.origin.x = self.view.frame.size.width / 2 - frame.size.width / 2;
    frame.origin.y = self.scrollViewForImageSlider.frame.size.height / 2 - frame.size.height / 2;
    activityIndSlider.frame = frame;
    [self.scrollViewForImageSlider addSubview:activityIndSlider];
    
    activityIndFind = [GlobalInstance sharedInstance].activityView;
    CGRect frame2 = activityIndFind.frame;
    frame2.origin.x = self.view.frame.size.width / 2 - frame.size.width / 2;
    frame2.origin.y = self.collectionViewforHorizontalScrollingImageList.frame.size.height / 2 - frame.size.height / 2;
    activityIndFind.frame = frame2;
    [self.collectionViewforHorizontalScrollingImageList addSubview:activityIndFind];
    
    [self getMyBikeListData];
    
}

-(UIImage*) downloadImage:(NSString*) imageLink{
    
    NSURL *url = [NSURL URLWithString:imageLink];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    __block UIImage* image;
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFImageResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        image = responseObject;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [TSMessage showNotificationInViewController:self
                                              title:@"Image Download Failed !"
                                           subtitle:[error localizedDescription]
                                               type:TSMessageNotificationTypeError];
    }];
    
    [operation start];
    
    return image;
}

- (void) getMyBikeListData{
    NSDictionary *parameters = @{key_getMyBikeList_authKey: [GlobalInstance sharedInstance].auth_key};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [manager POST:[APIURLsNdKeys getMyBikeListURL] parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [[GlobalInstance sharedInstance] setBikeListJSON:responseObject];
        bikeArray = [[GlobalInstance sharedInstance].bikeListJSON bikeList];
        [self.bikeModelTable setSeparatorColor:[UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0]];
        self.bikeModelTable.delegate = self;
        self.bikeModelTable.dataSource = self;
        [self.bikeModelTable reloadData];
        [activityIndFind startAnimating];
        NSMutableArray* requestArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < [bikeArray count]; i++) {
            
            NSURL *url = [NSURL URLWithString:((Bike*)[bikeArray objectAtIndex:i]).thumble_img];
            //((Bike*)[bikeArray objectAtIndex:i]).thumble_img
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            
            AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
            operation.responseSerializer = [AFImageResponseSerializer serializer];
            
            [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                [featuredImageArray addObject:responseObject];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                [TSMessage showNotificationInViewController:self
                                                      title:@"Image Downloading Failed !"
                                                   subtitle:[error localizedDescription]
                                                       type:TSMessageNotificationTypeError];
            }];
            
            [requestArray addObject: operation];
        }
        
        NSArray *batches = [AFURLConnectionOperation batchOfRequestOperations:requestArray progressBlock:^(NSUInteger numberOfFinishedOperations, NSUInteger totalNumberOfOperations) {
        } completionBlock:^(NSArray *operations) {
            NSLog(@"feature size: %i", featuredImageArray.count);
            self.collectionViewforHorizontalScrollingImageList.delegate = self;
            self.collectionViewforHorizontalScrollingImageList.dataSource = self;
            [self.collectionViewforHorizontalScrollingImageList reloadData];
            [activityIndFind stopAnimating];
            
        }];
        
        [[NSOperationQueue mainQueue] addOperations:batches waitUntilFinished:NO];
        
        NSDictionary *parameters2 = @{key_home_gallery_auth_key: [GlobalInstance sharedInstance].auth_key};
        [manager POST:[APIURLsNdKeys homeGalleryURL] parameters:parameters2 success:^(NSURLSessionDataTask *task, id responseObject) {
            
            [[GlobalInstance sharedInstance] setHomeGalleryJSON:responseObject];
            NSArray* galleryArray = [[GlobalInstance sharedInstance].homeGalleryJSON getGalleryURL];
            [activityIndSlider startAnimating];
            NSMutableArray* requestArray = [[NSMutableArray alloc] init];
            for (int i = 0; i < [galleryArray count]; i++) {
                
                NSURL *url = [NSURL URLWithString:[galleryArray objectAtIndex:i]];
                //[galleryArray objectAtIndex:i]
                NSURLRequest *request = [NSURLRequest requestWithURL:url];
                
                AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
                operation.responseSerializer = [AFImageResponseSerializer serializer];
                
                [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                    [galleryImageArray addObject:responseObject];
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
                NSLog(@"gallery size: %i", galleryImageArray.count);
                [self getImageSliderReady];
                [activityIndSlider stopAnimating];
            }];
            
            [[NSOperationQueue mainQueue] addOperations:batches waitUntilFinished:NO];
            
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            /*[TSMessage showNotificationInViewController:self
             title:@"Hi Xia"
             subtitle:@""
             type:TSMessageNotificationTypeSuccess];*/
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            [TSMessage showNotificationInViewController:self
                                                  title:@"Error Retrieving Data"
                                               subtitle:[error localizedDescription]
                                                   type:TSMessageNotificationTypeError];
            
        }];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        [TSMessage showNotificationInViewController:self
                                              title:@"Error Retrieving Data"
                                           subtitle:[error localizedDescription]
                                               type:TSMessageNotificationTypeError];
        
    }];
    
}

- (void)setUpTheNavBar{
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:font_suzuki_regular size:21]}];
    
    [self.sideBarMenu setTitleTextAttributes:@{
                                               NSFontAttributeName: [UIFont fontWithName:font_font_awesome_yay size:18.0],
                                               NSForegroundColorAttributeName: [UIColor whiteColor]
                                               } forState:UIControlStateNormal];
    [self.sideBarMenu setTitle:@"\uf0c9"];
    
    [self.navBarNotifButton setTitleTextAttributes:@{
                                                     NSFontAttributeName: [UIFont fontWithName:font_font_awesome_yay size:18.0],
                                                     NSForegroundColorAttributeName: [UIColor whiteColor]
                                                     } forState:UIControlStateNormal];
    [self.navBarNotifButton setTitle:@"\uf0a2"];
    
    [self.navBarMapButton setTitleTextAttributes:@{
                                                   NSFontAttributeName: [UIFont fontWithName:font_font_awesome_yay size:18.0],
                                                   NSForegroundColorAttributeName: [UIColor whiteColor]
                                                   } forState:UIControlStateNormal];
    [self.navBarMapButton setTitle:@"\uf041"];
    
    self.navBarNotifButton.badgeBGColor = [UIColor greenColor];//[UIColor colorWithRed:253/255.0 green:176/255.0 blue:15/255.0 alpha:1.0];
    self.navBarNotifButton.badgeTextColor = [UIColor whiteColor];
    self.navBarNotifButton.badgeFont = [UIFont fontWithName:font_suzuki_regular size:11.0];
    self.navBarNotifButton.badgePadding = 1.0;
    self.navBarNotifButton.badgeOriginX = 12.0;
    self.navBarNotifButton.badgeOriginY = 2.0;
    self.navBarNotifButton.badgeValue = @"14";
    
}

- (void)setUpTheView{
    
    [self.imgBtnMyBike setUserInteractionEnabled:YES];
    [self.imgBtnMyBike addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goThere:)]];
    
    [self.imgBtnSpare setUserInteractionEnabled:YES];
    [self.imgBtnSpare addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goThere:)]];
    
    [self.imgBtnRfs setUserInteractionEnabled:YES];
    [self.imgBtnRfs addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goThere:)]];
    
    [self.imgBtnNewsEvents setUserInteractionEnabled:YES];
    [self.imgBtnNewsEvents addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goThere:)]];
    
    [self.imgBtnPromotion setUserInteractionEnabled:YES];
    [self.imgBtnPromotion addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goThere:)]];
    
    [self.imgBtnInviteFriends setUserInteractionEnabled:YES];
    [self.imgBtnInviteFriends addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goThere:)]];
    
    
    [self.findBikeIcon setFont:[UIFont fontWithName:font_font_awesome_yay size:16.0]];
    [self.findBikeIcon setText:@"\uf21c"];
    
    [self.typeDown setFont:[UIFont fontWithName:font_font_awesome_yay size:14.0]];
    [self.modelIcon setFont:[UIFont fontWithName:font_font_awesome_yay size:14.0]];
    [self.typeDown setText:@"\uf105"];
    [self.modelIcon setText:@"\uf107"];
    
    float mainScreenWidth = [[UIScreen mainScreen]bounds].size.width;
    float mainScreenHeight = [[UIScreen mainScreen]bounds].size.height - (self.navigationController.navigationBar.frame.origin.y + self.navigationController.navigationBar.bounds.size.height);
    
    self.constrTypeUIViewWidth.constant = mainScreenWidth / 3.5;
    [self.modelUIView setHidden:YES];
    
    float scrollHeight = (mainScreenHeight - [UIApplication sharedApplication].statusBarFrame.size.height) /3.0;//mainScreenWidth * 0.578;
    float oneThirdOfScreenWidth = mainScreenWidth / 3.0;
    
    self.constrScrollViewHeight.constant = scrollHeight;
    
    self.constrFirstVerticalViewHeight.constant = scrollHeight;//oneThirdOfScreenWidth * 2.0;
    self.constrFirstVerticalViewLeadingSpace.constant = oneThirdOfScreenWidth;
    //this evil line
    self.constrFirstVertialViewTopSpaceFromSuperView.constant = scrollHeight; //+ self.navigationController.navigationBar.frame.size.height + self.navigationController.navigationBar.frame.origin.y; //+ [UIApplication sharedApplication].statusBarFrame.size.height;
    
    self.constrSecondVerticalViewHeight.constant = self.constrFirstVerticalViewHeight.constant;
    self.constrSecondVerticalViewTrailingSpace.constant = oneThirdOfScreenWidth;
    self.constrSecondVerticalViewTopSpaceFromSuperView.constant = self.constrFirstVertialViewTopSpaceFromSuperView.constant;
    
    self.constrHorizontalViewTopSpaceFromScrollViewImageSlider.constant = self.constrFirstVerticalViewHeight.constant / 2.0;//oneThirdOfScreenWidth;
    
    self.constrPageControlTopSpaceFromScrollForImageSliderTop.constant = scrollHeight - (self.pageControl.bounds.size.height + 10.0);
    
    self.constrCollectionViewTopSpaceFromHorizontalView.constant = self.constrHorizontalViewTopSpaceFromScrollViewImageSlider.constant - 1.0;
    
    self.constrFeaturedViewTopSpaceFromHorizontalView.constant = self.constrCollectionViewTopSpaceFromHorizontalView.constant;
    
    self.constrBottomMostViewHeight.constant = [UIApplication sharedApplication].statusBarFrame.size.height;
    
    /* NSLog(@"nav height %f and y %f", self.navigationController.navigationBar.frame.size.height, self.navigationController.navigationBar.frame.origin.y);
     NSLog(@"scrolly %f", self.scrollViewForImageSlider.frame.origin.y);
     NSLog(@"slider width: %f and height: %f", self.scrollViewForImageSlider.bounds.size.width, self.scrollViewForImageSlider.bounds.size.height);
     
     NSLog(@"status bar height %f", [UIApplication sharedApplication].statusBarFrame.size.height);
     */
    
    [self.typeUIView setUserInteractionEnabled:YES];
    [self.typeUIView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showBikeModelTable)]];
}

- (void)getImageSliderReady{
    self.scrollViewForImageSlider.tag = 1;
    //self.pageControl.tag = 12;
    self.scrollViewForImageSlider.autoresizingMask = UIViewAutoresizingNone;
    [self setupScrollViewForImageSlider:self.scrollViewForImageSlider];
    self.pageControl.numberOfPages= [galleryImageArray count];
    self.pageControl.autoresizingMask=UIViewAutoresizingNone;
    self.scrollViewForImageSlider.delegate = self;
}

- (void)setupScrollViewForImageSlider:(UIScrollView*)scrMain {
    // we have 10 images here.
    // we will add all images into a scrollView & set the appropriate size.
    
    for (int i=0; i< [galleryImageArray count]; i++) {
        // create image
        UIImage *image = [galleryImageArray objectAtIndex:i];//[UIImage imageNamed:[NSString stringWithFormat:@"sti%02i.jpeg",i]];
        // create imageView
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake((i)*scrMain.frame.size.width, 0, scrMain.frame.size.width, scrMain.frame.size.height)];
        // set aspect
        imgV.contentMode=UIViewContentModeScaleToFill;//UIViewContentModeScaleAspectFit;
        // set image
        [imgV setImage:image];
        // apply tag to access in future
        imgV.tag=i+1;
        // add to scrollView
        [imgV setClipsToBounds:YES];
        [scrMain addSubview:imgV];
    }
    // set the content size to 10 image width
    [scrMain setContentSize:CGSizeMake(scrMain.frame.size.width*[galleryImageArray count], scrMain.frame.size.height)];
    // enable timer after each 2 seconds for scrolling.
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(scrollingTimer) userInfo:nil repeats:YES];
    
}

- (void)scrollingTimer {
    // access the scroll view with the tag
    UIScrollView *scrMain = (UIScrollView*) [self.view viewWithTag:1];
    // same way, access pagecontroll access
    UIPageControl *pgCtr = (UIPageControl*) [self.view viewWithTag:12];
    // get the current offset ( which page is being displayed )
    CGFloat contentOffset = scrMain.contentOffset.x;
    // calculate next page to display
    int nextPage = (int)(contentOffset/scrMain.frame.size.width) + 1 ;
    // if page is not 10, display it
    if( nextPage!=[galleryImageArray count] )  {
        [scrMain scrollRectToVisible:CGRectMake(nextPage*scrMain.frame.size.width, 0, scrMain.frame.size.width, scrMain.frame.size.height) animated:YES];
        pgCtr.currentPage=nextPage;
        
        CGFloat pageWidth = self.scrollViewForImageSlider.frame.size.width;
        int page = floor((self.scrollViewForImageSlider.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        self.pageControl.currentPage = page;
        
        // else start sliding form 1 :)
    } else {
        [scrMain scrollRectToVisible:CGRectMake(0, 0, scrMain.frame.size.width, scrMain.frame.size.height) animated:YES];
        pgCtr.currentPage=0;
        
        //        CGFloat pageWidth = self.scrollView.frame.size.width;
        //        int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        //        self.pageControl.currentPage = page;
        
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    if(sender.tag == 1){
        if (!pageControlBeingUsed) {
            // Switch the indicator when more than 50% of the previous/next page is visible
            CGFloat pageWidth = self.scrollViewForImageSlider.frame.size.width;
            int page = floor((self.scrollViewForImageSlider.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
            self.pageControl.currentPage = page;
        }
    }
    
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if(scrollView.tag == 1){
        pageControlBeingUsed = NO;
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if(scrollView.tag == 1){
        pageControlBeingUsed = NO;
    }
    
}

- (IBAction)sideBarButtonMenuShow:(id)sender {
    
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController presentMenuViewController];
    
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, self.constrScrollViewHeight.constant);
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (isSearched) {
        return 1;
    } else {
        return [featuredImageArray count];
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeScreeCollectionViewCell *cell = nil;
    NSString *CellIdentifier = nil;
    CellIdentifier = @"homeCollectionCell";
    cell=(HomeScreeCollectionViewCell *) [self.collectionViewforHorizontalScrollingImageList dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (isSearched) {
        cell.imageView.image = [featuredImageArray objectAtIndex:selectedIndex];
        [cell.bikeName setText:[NSString stringWithFormat:@"%@ | %@", seletedBikeObj.bike_name, seletedBikeObj.bike_cc]];
    } else {
        cell.imageView.image = [featuredImageArray objectAtIndex:indexPath.row];
        [cell.bikeName setText:[NSString stringWithFormat:@"%@ | %@", ((Bike*)[((NSArray*)[[GlobalInstance sharedInstance].bikeListJSON bikeList]) objectAtIndex:indexPath.row]).bike_name, ((Bike*)[((NSArray*)[[GlobalInstance sharedInstance].bikeListJSON bikeList]) objectAtIndex:indexPath.row]).bike_cc]];
    }
    
    [cell.imageView setClipsToBounds:YES];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 30.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [bikeArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"newFriendCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    Bike* bike = [bikeArray objectAtIndex:indexPath.row];
    [cell.textLabel setFont:[UIFont fontWithName:font_suzuki_regular size:14.0]];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ | %@", bike.bike_name, bike.bike_cc];
    [cell.textLabel setTextColor:[UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setBackgroundColor:[UIColor clearColor]];
    
    return  cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [UIView transitionWithView:self.modelUIView
                      duration:0.6
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        [self.modelUIView setHidden:YES];
                    }
                    completion:^(BOOL finished){
                        seletedBikeObj = [bikeArray objectAtIndex:indexPath.row];
                        isSearched = YES;
                        [self.typeText setText:seletedBikeObj.bike_name];
                        
                        [UIView transitionWithView:self.collectionViewforHorizontalScrollingImageList
                                          duration:0.5
                                           options:UIViewAnimationOptionTransitionCrossDissolve//UIViewAnimationOptionCurveEaseIn
                                        animations:^{
                                            [self.collectionViewforHorizontalScrollingImageList reloadData];
                                        }
                                        completion:^(BOOL finished){
                                            [self.typeUIView setUserInteractionEnabled:YES];
                                        }];
                        
                        
                        //                        NSPredicate* prdct = [NSPredicate predicateWithFormat:@"SELF.bike_name beginswith[c] %@", @"GS150R"];
                        //                        NSArray* tmpSearched = [bikeArray filteredArrayUsingPredicate:prdct];
                        //                        NSLog(@"bike searc: %i", tmpSearched.count);
                    }];
    
    
}

-(void)showBikeModelTable{
    //NSLog(@"here here");
    [UIView transitionWithView:self.modelUIView
                      duration:0.6
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{
                        [self.modelUIView setHidden:NO];
                    }
                    completion:^(BOOL finished){
                        [self.typeUIView setUserInteractionEnabled:NO];
                    }];
}

-(void)goThere:(UITapGestureRecognizer*)sender{
    
    NSLog(@"%d", ((UIImageView*)sender.view).tag);
    int tag = ((UIImageView*)sender.view).tag;
    BOOL shouldGo = NO;
    NavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
    
    if (tag == 220) {
        MyBikeListViewController *myBikeListViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"myBikeListScene"];
        navigationController.viewControllers = @[myBikeListViewController];
        shouldGo = YES;
    }else if (tag == 221){
        SparePartsListViewController *spareViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"spareListScene"];
        navigationController.viewControllers = @[spareViewController];
        shouldGo = YES;
        
    }else if (tag == 222){
        RFSViewController *rfsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RFSScene"];
        navigationController.viewControllers = @[rfsViewController];
        shouldGo = YES;
        
    }else if (tag == 223){
        NewsNdEventListViewController *newsNdEventViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"newsNdEventListScene"];
        navigationController.viewControllers = @[newsNdEventViewController];
        shouldGo = YES;
        
    }else if (tag == 224){
        PromotionViewController *promoViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"promotionScene"];
        navigationController.viewControllers = @[promoViewController];
        shouldGo = YES;
        
    }else if (tag == 225){
        MediaLinks* ml = [[GlobalInstance sharedInstance].mediaJSON getMediaLinks];
        
        NSString* message = [NSString stringWithFormat:@"%@\r%@\r%@\r%@", @"Welcome to Suzuki Bangladesh Official Mobile App", ml.play_store, ml.app_store, ml.fb];
        
        NSMutableArray *sharingItems = [NSMutableArray new];
        
        [sharingItems addObject:message];
        
        UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:sharingItems applicationActivities:nil];
        
        [self presentViewController:activityController animated:YES completion:nil];
        
    }
    
    if(shouldGo) self.frostedViewController.contentViewController = navigationController;
    
}

- (IBAction)navBarNotifButtonAction:(id)sender {
    
    NotificationListViewController* notificationViewController = (NotificationListViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@ "notificationListScene"];
    [self.navigationController pushViewController:notificationViewController animated:YES];
}

- (IBAction)navBarMapAction:(id)sender {
}
@end
