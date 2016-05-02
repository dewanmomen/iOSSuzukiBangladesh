//
//  SlideMenuViewController.m
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 3/29/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import "SlideMenuViewController.h"
#import "GlobalInstance.h"
#import "MenuCell.h"
#import "NavigationController.h"
#import "NSDictionary+MediaURLs.h"
#import "HomeViewController.h"
#import "QuizViewController.h"
#import "MyBikeListViewController.h"
#import "LogInViewController.h"
#import "RFSViewController.h"
#import "SparePartsListViewController.h"
#import "NewsNdEventListViewController.h"
#import "PromotionViewController.h"
#import "ChangePasswordViewController.h"

@implementation SlideMenuViewController{
    NSArray *menuItemsWhenLoggedIn;
    NSArray *menuItemsWhenNotLoggedIn;
    NSArray *menuItemsWhenNotLoggedInIcon;
    NSArray *menuItemsWhenLoggedInIcon;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    menuItemsWhenLoggedIn = @[@"Home", @"My Bike", @"Spare Parts", @"Request Service", @"News and Events", @"Promotions", @"Quizz", @"SOS", @"Invite Friends", @"Social Media Facebook", @"Change Password", @"Logout"];
    
    menuItemsWhenLoggedInIcon = @[@"\uf015", @"\uf21c", @"\uf013", @"\uf085", @"\uf1ea", @"\uf0a1", @"\uf044", @"\uf095", @"\uf234", @"\uf082", @"\uf023", @"\uf08b"];
    
    
    
    menuItemsWhenNotLoggedIn = @[@"Home", @"My Bike", @"Spare Parts", @"Request Service", @"News and Events", @"Promotions", @"Quizz", @"SOS", @"Invite Friends", @"Social Media Facebook", @"Login"];
    
    menuItemsWhenNotLoggedInIcon = @[@"\uf015", @"\uf21c", @"\uf013", @"\uf085", @"\uf1ea", @"\uf0a1", @"\uf044", @"\uf095", @"\uf234", @"\uf082", @"\uf090"];
    
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([GlobalInstance sharedInstance].isLoggedin) {
        return [menuItemsWhenLoggedIn count];
    } else {
        return [menuItemsWhenNotLoggedIn count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"menuCell";
    MenuCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if ([GlobalInstance sharedInstance].isLoggedin) {
        [cell.title setText:[menuItemsWhenLoggedIn objectAtIndex:indexPath.row]];
        [cell.icon setFont:[UIFont fontWithName:font_font_awesome_yay size:14.0]];
        [cell.icon setText:[menuItemsWhenLoggedInIcon objectAtIndex:indexPath.row]];
    } else {
        [cell.title setText:[menuItemsWhenNotLoggedIn objectAtIndex:indexPath.row]];
        [cell.icon setFont:[UIFont fontWithName:font_font_awesome_yay size:14.0]];
        [cell.icon setText:[menuItemsWhenNotLoggedInIcon objectAtIndex:indexPath.row]];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BOOL shouldGo = NO;
    NavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
    
    if ([GlobalInstance sharedInstance].isLoggedin) {
        if (indexPath.row == 0) {
            HomeViewController *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"homeScene"];
            navigationController.viewControllers = @[homeViewController];
            shouldGo = YES;
        } else if (indexPath.row == 1) {
            MyBikeListViewController *myBikeListViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"myBikeListScene"];
            navigationController.viewControllers = @[myBikeListViewController];
            shouldGo = YES;
            
        }else if (indexPath.row == 2){
            SparePartsListViewController *spareViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"spareListScene"];
            navigationController.viewControllers = @[spareViewController];
            shouldGo = YES;
        }else if (indexPath.row == 3){
            RFSViewController *rfsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RFSScene"];
            navigationController.viewControllers = @[rfsViewController];
            shouldGo = YES;
        }else if (indexPath.row == 4) {
            NewsNdEventListViewController *newsNdEventViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"newsNdEventListScene"];
            navigationController.viewControllers = @[newsNdEventViewController];
            shouldGo = YES;
        }else if(indexPath.row == 5){
            PromotionViewController *promoViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"promotionScene"];
            navigationController.viewControllers = @[promoViewController];
            shouldGo = YES;
        }else if (indexPath.row == 6) {
            QuizViewController *quizViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"quizScene"];
            navigationController.viewControllers = @[quizViewController];
            shouldGo = YES;
            
        }
        else if(indexPath.row == 7){
            
            [self callWithString:@"123"];
        }else if(indexPath.row == 8){
            
            MediaLinks* ml = [[GlobalInstance sharedInstance].mediaJSON getMediaLinks];
            
            NSString* message = [NSString stringWithFormat:@"%@\r%@\r%@\r%@", @"Welcome to Suzuki Bangladesh Official Mobile App", ml.play_store, ml.app_store, ml.fb];
            
            //NSString *msg = [NSString stringWithFormat:@"%@\n%@\n%@", str1, str2, str3];
            NSMutableArray *sharingItems = [NSMutableArray new];
            
            [sharingItems addObject:message];
            
            UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:sharingItems applicationActivities:nil];
            
            [self presentViewController:activityController animated:YES completion:nil];
            
        }else if (indexPath.row == 9){
            NSURL *url = [NSURL URLWithString:@"fb://profile/anamulht"];
            
            if ([[UIApplication sharedApplication] canOpenURL:url]){
                [[UIApplication sharedApplication] openURL:url];
            }
            else {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://facebook.com/anamulht"]];
            }
        }else if (indexPath.row == 10){
            ChangePasswordViewController *cpViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"changePassScene"];
            navigationController.viewControllers = @[cpViewController];
            shouldGo = YES;
        }else if(indexPath.row == 11){
            
        }
    } else {
        if (indexPath.row == 0) {
            HomeViewController *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"homeScene"];
            navigationController.viewControllers = @[homeViewController];
            shouldGo = YES;
        }else if (indexPath.row == 1) {
            MyBikeListViewController *myBikeListViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"myBikeListScene"];
            navigationController.viewControllers = @[myBikeListViewController];
            shouldGo = YES;
            
        }else if (indexPath.row == 2){
            SparePartsListViewController *spareViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"spareListScene"];
            navigationController.viewControllers = @[spareViewController];
            shouldGo = YES;
        }else if (indexPath.row == 3){
            RFSViewController *rfsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RFSScene"];
            navigationController.viewControllers = @[rfsViewController];
            shouldGo = YES;
        }else if (indexPath.row == 4) {
            NewsNdEventListViewController *newsNdEventViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"newsNdEventListScene"];
            navigationController.viewControllers = @[newsNdEventViewController];
            shouldGo = YES;
        }else if(indexPath.row == 5){
            PromotionViewController *promoViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"promotionScene"];
            navigationController.viewControllers = @[promoViewController];
            shouldGo = YES;
        } else if (indexPath.row == 6) {
            QuizViewController *quizViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"quizScene"];
            navigationController.viewControllers = @[quizViewController];
            shouldGo = YES;
            
        }else if(indexPath.row == 7){
            [self callWithString:@"123"];
        }else if(indexPath.row == 8){
            
            MediaLinks* ml = [[GlobalInstance sharedInstance].mediaJSON getMediaLinks];
            
            NSString* message = [NSString stringWithFormat:@"%@\r%@\r%@\r%@", @"Welcome to Suzuki Bangladesh Official Mobile App", ml.play_store, ml.app_store, ml.fb];
            
            //NSString *msg = [NSString stringWithFormat:@"%@\n%@\n%@", str1, str2, str3];
            NSMutableArray *sharingItems = [NSMutableArray new];
            
            [sharingItems addObject:message];
            
            UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:sharingItems applicationActivities:nil];
            
            [self presentViewController:activityController animated:YES completion:nil];
            
        }else if (indexPath.row == 9){
            NSURL *url = [NSURL URLWithString:@"fb://profile/anamulht"];
            
            if ([[UIApplication sharedApplication] canOpenURL:url]){
                [[UIApplication sharedApplication] openURL:url];
            }
            else {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://facebook.com/anamulht"]];
            }
        }else if (indexPath.row == 10){
            LogInViewController *loginViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"logInScene"];
            navigationController.viewControllers = @[loginViewController];
            shouldGo = YES;
        }
    }
    
    if(shouldGo)
        self.frostedViewController.contentViewController = navigationController;
    [self.frostedViewController hideMenuViewController];
}


- (void)callWithString:(NSString *)phoneString {
    [self callWithURL:[NSURL URLWithString:[NSString
                                            stringWithFormat:@"tel:%@",phoneString]]];
}

- (void)callWithURL:(NSURL *)url {
    static UIWebView *webView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        webView = [UIWebView new];
    });
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
}

@end
