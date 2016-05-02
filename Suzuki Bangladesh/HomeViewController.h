//
//  HomeViewController.h
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 3/29/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"

#import "GlobalInstance.h"

@interface HomeViewController : UIViewController<UIScrollViewDelegate,UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource>{
    BOOL pageControlBeingUsed;
}

//@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
- (IBAction)sideBarButtonMenuShow:(id)sender;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewForImageSlider;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewforHorizontalScrollingImageList;
@property (weak, nonatomic) IBOutlet UILabel *findBikeIcon;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrScrollViewHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrFirstVerticalViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrFirstVerticalViewLeadingSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrFirstVertialViewTopSpaceFromSuperView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrSecondVerticalViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrSecondVerticalViewTrailingSpace;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrSecondVerticalViewTopSpaceFromSuperView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrHorizontalViewTopSpaceFromScrollViewImageSlider;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrPageControlTopSpaceFromScrollForImageSliderTop;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrBottomMostViewHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrCollectionViewTopSpaceFromHorizontalView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrFeaturedViewTopSpaceFromHorizontalView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *navBarNotifButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *navBarMapButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideBarMenu;


- (IBAction)navBarNotifButtonAction:(id)sender;
- (IBAction)navBarMapAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *typeUIView;
@property (weak, nonatomic) IBOutlet UILabel *typeDown;
@property (weak, nonatomic) IBOutlet UILabel *typeText;


@property (weak, nonatomic) IBOutlet UIView *modelUIView;
@property (weak, nonatomic) IBOutlet UILabel *modelIcon;

@property (weak, nonatomic) IBOutlet UILabel *modelText;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrTypeUIViewWidth;


@property (weak, nonatomic) IBOutlet UITableView *bikeModelTable;


@property (weak, nonatomic) IBOutlet UIImageView *imgBtnMyBike;
@property (weak, nonatomic) IBOutlet UIImageView *imgBtnSpare;
@property (weak, nonatomic) IBOutlet UIImageView *imgBtnRfs;
@property (weak, nonatomic) IBOutlet UIImageView *imgBtnNewsEvents;
@property (weak, nonatomic) IBOutlet UIImageView *imgBtnPromotion;
@property (weak, nonatomic) IBOutlet UIImageView *imgBtnInviteFriends;




@end
